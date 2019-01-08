/**
 * @file bitweaving_h_array.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_BITWEAVING_H_ARRAY_H
#define GENERAL_BITWEAVING_H_ARRAY_H

#include <type_traits>
#include <cassert>
#include <cstdint>
#include <pthread.h>
#include <vector>
#include <tuple>
#include "../../../utils/vector.h"
#include "../../../utils/threading.h"


template< typename T, uint16_t CodeSize >
constexpr T get_delimeter_mask( uint16_t N ) {
   return ( N < ( sizeof( T ) * 8 ) ) ? ( ( T ) 1 ) << ( ( T ) N ) | get_delimeter_mask< T, CodeSize >( N + CodeSize + 1) : 0;
}

template< typename T, uint16_t CodeSize >
constexpr T get_delimeter_mask( void ) {
   return get_delimeter_mask< T, CodeSize >( CodeSize );
}

template< typename T, uint16_t CodeSize >
constexpr T get_inverted_delimeter_mask( void ) {
   return ~( get_delimeter_mask< T, CodeSize >( CodeSize ) );
}

template< typename T, uint16_t CodeSize >
constexpr T get_first_bit_mask( uint16_t N ) {
   return ( N < ( sizeof( T ) * 8 ) ) ? ( ( T ) 1 ) << ( ( T ) N ) | get_first_bit_mask< T, CodeSize >( N + CodeSize + 1 ) : 0;
}

template< typename T, uint16_t CodeSize >
constexpr T get_first_bit_mask( void ) {
   return get_first_bit_mask< T, CodeSize >( (uint16_t)0 );
}

template< typename T, uint16_t CodeSize >
constexpr T get_all_ones_mask( uint16_t N ) {
   return ( N > 0 ) ? ( (  T ) 1 ) << N | get_all_ones_mask< T, CodeSize >( N-1 ) : 1;
}

template< typename T, uint16_t CodeSize >
constexpr T get_all_ones_mask( void ) {
   return get_all_ones_mask< T, CodeSize >( CodeSize - 1 );
}

template< typename T, uint16_t CodeSize, uint16_t VectorElemCount >
class bitweaving_h_fitting_store {
      static_assert( std::is_integral< T >::value, "Type must be arithmetic and no floating point.");
      static_assert( ( ( sizeof( T ) == 4 ) || sizeof( T ) == 8 ), "Type must be either 32-bit or 64-bit.");
      static_assert( ( CodeSize < sizeof( T ) * 8 ), "Code size must be smaller than the Type size." );
      static_assert( ( ( ( sizeof( T ) * 8 ) % ( CodeSize + 1 ) ) == 0 ), "CodeSize must be an integral divisor - 1 of Type size." );

   private:
      typedef  void* (bitweaving_h_fitting_store::*bw_ptr)(void*);
      typedef  void* (*bw_pthread_ptr)(void*);
   protected:
      struct context {
         bitweaving_h_fitting_store * self;
         T predicate;
         T * base_addr;
         std::size_t count;
         T * result;
         context( ) = default;
         context( bitweaving_h_fitting_store * s, T pred, std::pair< T *, std::size_t > chunk, T * const res ) :
            self{ s },
            predicate{ pred },
            base_addr{ chunk.first },
            count{ chunk.second },
            result{ res } { }
      };

   private:
      T           * const                 data;
      std::size_t   const                 data_count;
      T             const                 delimeter_bits_mask = get_delimeter_mask< T, CodeSize >( );
      T             const                 code_bits_mask = get_inverted_delimeter_mask< T, CodeSize >( );
      T             const                 first_bit_mask = get_first_bit_mask< T, CodeSize >( );
      T             const                 max_value = get_all_ones_mask< T, CodeSize >( );
      std::size_t   const                 code_count = ( sizeof( T ) * 8 / ( CodeSize + 1 ) );

      posix_thread                        threads[ MAX_THREAD_COUNT ];
      partition_manager_even_chunks< T >  part_manager_data;
      partition_manager_even_chunks< T >  part_manager_result;
   public:
      bitweaving_h_fitting_store( T * const data_, std::size_t const data_count_ ) :
         data{ data_ },
         data_count{ data_count_ },
         part_manager_data{ data_, data_count_ },
         part_manager_result{ nullptr, data_count_ }{
         for( int32_t i = 0; i < MAX_THREAD_COUNT; ++i ) {
            threads[ i ].set_cpu( i );
         }
      }

      void format( void ) noexcept{
         for( std::size_t i = 0; i < data_count; i += VectorElemCount ) {
            for( std::size_t j = 0; j < VectorElemCount; ++j ) {
               data[ j ] ^= delimeter_bits_mask;
            }
         }
      }

      constexpr T get_max_value() {
         return max_value;
      }

      T create_predicate( T pred ) const noexcept {
         assert( pred <= max_value );
         pred &= max_value;
         T result = pred;
         for( std::size_t i = 1; i < code_count; ++i ) {
            if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
               pred <<= ( CodeSize + 1 );
               result |= pred;
            }
         }
         return result;
      }

      void start_thread_with_pinning( T pred, T * result, std::size_t numthreads, bw_pthread_ptr method ) {
         part_manager_data.set_thread_count( numthreads );
         part_manager_result.set_base_addr( result );
         part_manager_result.set_thread_count( numthreads );
         std::vector< context > contexts( numthreads );
         for( std::size_t i = 0; i < numthreads; ++i ) {
            contexts[ i ] = { this, pred, part_manager_data.get_chunk_with_size( i ), part_manager_result.get_chunk_base_addr( i ) };
            threads[ i ].set_cpu( i );
         }
         for( std::size_t i = 0; i < numthreads; ++i ) {
            pthread_create(   threads[ i ].get_thread_ptr( ),
                              threads[ i ].get_attribute( ),
                              method,
                              ( void * ) &contexts[ i ]
            );
         }
         for( std::size_t i = 0; i < numthreads; ++i ) {
            pthread_join( threads[ i ].get_thread( ), NULL );
         }
      }


      void cmp_neq_seq( T pred, T * const result, std::size_t numthreads ) const noexcept {
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma _NEC novector
//#pragma omp for
            for ( std::size_t j = 0; j < data_count; ++j ) {
               result[ j ] = ( data[ j ] ^ pred ) + code_bits_mask;
            }
//         }
      }
      void * cmp_neq_seq_par( void * ctx_ ) {
         context * ctx = ( context * ) ctx_;
         bitweaving_h_fitting_store * self = ctx->self;
         T predicate = ctx->predicate;
         T const * base_addr = ctx->base_addr;
         std::size_t count = ctx->count;
         T * result = ctx->result;
         T const code_bits_mask = self->code_bits_mask;

         for( std::size_t i = 0; i < count; ++i ) {
            result[ i ] = base_addr[ i ] + predicate;//( base_addr[ i ] ^ predicate ) + code_bits_mask;
         }
         return (void *) nullptr;
      }

      void cmp_neq_par( T pred, T *  result, std::size_t numthreads ) {
         bw_ptr bwptr = &bitweaving_h_fitting_store::cmp_neq_seq_par;
         bw_pthread_ptr method = *( bw_pthread_ptr* ) &bwptr;
         start_thread_with_pinning( pred, result, numthreads, method );
      }

      void cmp_neq_vec( T pred, T * const result, std::size_t numthreads ) const {
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma omp for
//            for ( std::size_t i = 0; i < data_count; i += VectorElemCount ) {
//#pragma _NEC vector
//               for ( std::size_t j = 0; j < VectorElemCount; ++j ) {
//                  result[ i + j ] = ( data[ i + j ] ^ pred ) + code_bits_mask;
//               }
//            }
//         }
      }

      void cmp_eq_seq( T pred, T * const result, std::size_t numthreads ) const noexcept {
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma _NEC novector
//#pragma omp for
            for( std::size_t j = 0; j < data_count; ++j ) {
               result[ j ] = ~( ( data[ j ] ^ pred ) + code_bits_mask );
            }
//         }
      }
      void cmp_eq_vec( T pred, T * const result, std::size_t numthreads ) const noexcept {
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma omp for
//            for ( std::size_t i = 0; i < data_count; i += VectorElemCount ) {
//#pragma _NEC vector
//               for ( std::size_t j = 0; j < VectorElemCount; ++j ) {
//                  result[ i + j ] = ~(( data[ i + j ] ^ pred ) + code_bits_mask );
//               }
//            }
//         }
      }

      void cmp_lt_seq( T pred, T * const result, std::size_t numthreads ) const noexcept {
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma _NEC novector
//#pragma omp for
            for( std::size_t j = 0; j < data_count; ++j ) {
               result[ j ] = pred + ( data[ j ] ^ code_bits_mask );
            }
//         }
      }
      void cmp_lt_vec( T pred, T * const result, std::size_t numthreads ) const noexcept {
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma omp for
//            for ( std::size_t i = 0; i < data_count; i += VectorElemCount ) {
//#pragma _NEC vector
//               for ( std::size_t j = 0; j < VectorElemCount; ++j ) {
//                  result[ i + j ] = pred + ( data[ i + j ] ^ code_bits_mask );
//               }
//            }
//         }
      }

      void cmp_leq_seq( T pred, T * const result, std::size_t numthreads ) const noexcept {
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma _NEC novector
//#pragma omp for
            for( std::size_t j = 0; j < data_count; ++j ) {
               result[ j ] = ( pred + ( data[ j ] ^ code_bits_mask ) ) + first_bit_mask;
            }
//         }
      }
      void cmp_leq_vec( T pred, T * const result, std::size_t numthreads ) const noexcept {
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma omp for
//            for ( std::size_t i = 0; i < data_count; i += VectorElemCount ) {
//#pragma _NEC vector
//               for ( std::size_t j = 0; j < VectorElemCount; ++j ) {
//                  result[ i + j ] = ( pred + ( data[ i + j ] ^ code_bits_mask )) + first_bit_mask;
//               }
//            }
//         }
      }

      void cmp_gt_seq( T pred, T * const result, std::size_t numthreads ) const noexcept {
         T summand = ( pred ^ code_bits_mask );
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma _NEC novector
//#pragma omp for
            for( std::size_t j = 0; j < data_count; ++j ) {
               result[ j ] = data[ j ] + summand;
            }
//         }
      }
      void cmp_gt_vec( T pred, T * const result, std::size_t numthreads ) const noexcept {
//         T summand = ( pred ^ code_bits_mask );
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma omp for
//            for ( std::size_t i = 0; i < data_count; i += VectorElemCount ) {
//#pragma _NEC vector
//               for ( std::size_t j = 0; j < VectorElemCount; ++j ) {
//                  result[ i + j ] = data[ i + j ] + summand;
//               }
//            }
//         }
      }

      void cmp_geq_seq( T pred, T * const result, std::size_t numthreads ) const noexcept {
         T summand = ( pred ^ code_bits_mask );
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma _NEC novector
//#pragma omp for
            for( std::size_t j = 0; j < data_count; ++j ) {
               result[ j ] = ( data[ j ] + summand ) + first_bit_mask;
            }
//         }
      }
      void cmp_geq_vec( T pred, T * const result, std::size_t numthreads ) const noexcept {
//         T summand = ( pred ^ code_bits_mask );
//#pragma omp parallel num_threads(numthreads)
//         {
//#pragma omp for
//            for ( std::size_t i = 0; i < data_count; i += VectorElemCount ) {
//#pragma _NEC vector
//               for ( std::size_t j = 0; j < VectorElemCount; ++j ) {
//                  result[ i + j ] = ( data[ i + j ] + summand ) + first_bit_mask;
//               }
//            }
//         }
      }
};


#endif //GENERAL_BITWEAVING_H_ARRAY_H
