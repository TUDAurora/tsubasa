/**
 * @file bitpacking.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_BITPACKING_H
#define GENERAL_BITPACKING_H
#include "../../../utils/vector.h"
#include "../../../utils/asm_utils.h"

#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <array>


#include <iostream>

template< typename T >
class vertical_bitpacking {
   private:
      size_t const chunk_size = VE_CORE_VPU_VR_BIT_SIZE;
      size_t const vector_size = VE_CORE_VPU_VR_ELEMENT_COUNT;
      size_t const count;
      size_t const chunk_count;
      size_t const chunk_remainder;

      //      size_t const vector_count_per_chunk = chunk_size / vector_size;
      T * packed_data;
      T * chunk_max_bitwidth_array;
      T ** chunk_data_ptr;
      size_t * chunk_result_sizes;
      T ** chunk_result_ptr;
      std::array< T, VE_CORE_VPU_VR_ELEMENT_COUNT > chunk_tmp_bitwidth_array;
      size_t compress_size_8;
   protected:
      /**
       * Actual compression of >>chunk_size<< data elements.
       * @tparam BitWidth
       * @param data
       * @param result Has to be zeroed out!!!
       */
      template< uint8_t BitWidth >
      size_t pack( T * const data, T * result ) noexcept;
      void compress_impl( T bw, T * const data, T * const result ) noexcept;
   public:
      size_t get_compressed_size_bytes( void ) const noexcept {
         return compress_size_8;
      }
      T get_chunk_max_bitwidth( size_t chunk_id ) const noexcept {
         return chunk_max_bitwidth_array[ chunk_id ];
      }
      size_t get_chunk_count( void ) const noexcept {
         return chunk_count;
      }

      ~vertical_bitpacking( ) noexcept {
         free( packed_data );
         free( chunk_max_bitwidth_array );
         free( chunk_data_ptr );
         free( chunk_result_sizes );
         free( chunk_result_ptr );
      }
      /**
       * 1. check all bitwidths of given data
       * 2. calculate all
       * @param data
       * @param count8
       */
      vertical_bitpacking( T * const data, size_t count8 ):
         count{ count8 / sizeof( T ) },
         chunk_count{ count / chunk_size },
         chunk_remainder{ count % chunk_size } {
         chunk_max_bitwidth_array = ( T * ) malloc( chunk_count * sizeof( T ) );
         chunk_data_ptr = ( T ** ) malloc( chunk_count * sizeof( T * ) );
         chunk_result_sizes = ( size_t * ) malloc( chunk_count * sizeof( size_t ) );
         chunk_result_ptr = ( T ** ) malloc( chunk_count * sizeof( T * ) );
//         int a;
//         std::cin >> a;
         // Step1: Determine bitwidths
         {
            size_t base = 0;
            for ( size_t chunk = 0; chunk < chunk_count; ++chunk ) {
               T chunk_tmp_bitwidth = ( T ) 0;
               T chunk_max_bitwidth = ( T ) 0;
               for( size_t i = 0; i < vector_size; ++i )
                  chunk_tmp_bitwidth_array[ i ] = ( T ) 0;

               for ( size_t chunk_outer_pos = 0; chunk_outer_pos < chunk_size; chunk_outer_pos += vector_size ) {
                  size_t chunk_base = base + chunk_outer_pos;
                  for ( size_t chunk_inner_pos = 0; chunk_inner_pos < vector_size; ++chunk_inner_pos ) {
                     chunk_tmp_bitwidth_array[ chunk_inner_pos ] |= data[ chunk_base + chunk_inner_pos ];
                  }
               }
               for( size_t tmp = 0 ; tmp < vector_size; ++tmp ) {
                  chunk_tmp_bitwidth |= chunk_tmp_bitwidth_array[ tmp ];
               }
               chunk_max_bitwidth_array[ chunk ] = ( sizeof( T ) * 8 ) - clz( chunk_tmp_bitwidth );
               base += chunk_size;
            }
         }

         // Step2: Calculate needed memory space for compression
//         std::array< size_t, 2 > tmp{ 0 };
         compress_size_8 = 0;
         {
            for( size_t chunk = 0; chunk < chunk_count; ++chunk ) {
               chunk_data_ptr[ chunk ] = data + chunk * chunk_size;
                  /*if( chunk_max_bitwidth_array[ chunk ] == 4 )
                     tmp[ 0 ]++;
                  else if( chunk_max_bitwidth_array[ chunk ] == 28 )
                     tmp[ 1 ]++;
                  else
                     exit(1);*/

               chunk_result_sizes[ chunk ] = ( chunk_max_bitwidth_array[ chunk ] * chunk_size ) / 8;
               compress_size_8 += chunk_result_sizes[ chunk ];
            }
         }
            /*std::cerr << " 4 Bit: " << tmp[ 0 ] << "\n";
            std::cerr << "28 Bit: " << tmp[ 1 ] << "\n";
            std::cerr << "Chunksize: " << chunk_size << "\n";
            std::cerr << "Compress Size Byte : " << compress_size_8 << "\n";
            std::cerr << "Compress Size Words: " << compress_size_8 / sizeof( T ) << "\n";
            std::cerr << "Remainder: " << compress_size_8 % sizeof( T ) << "\n";
            int a;
            std::cin >> a;*/

         // Step3: Allocate needed memory for compression.
         packed_data = ( T * ) malloc( compress_size_8 ); //* sizeof( T ) );

         // Step4: set pointer to results of all chunks
         {
            chunk_result_ptr[ 0 ] = packed_data;
            for( size_t chunk = 1; chunk < chunk_count; ++chunk ) {
               chunk_result_ptr[ chunk ] = chunk_result_ptr[ chunk - 1 ] + ( chunk_result_sizes[ chunk - 1 ] / sizeof( T ) );
            }
         }
      }

      void compress( void ) {
         for( size_t chunk = 0; chunk < chunk_count; ++chunk ) {
//            std::cerr << "Chunk #" << chunk << "\t" << chunk_max_bitwidth_array[ chunk ] << " Bits.\n";
            compress_impl( chunk_max_bitwidth_array[ chunk ], chunk_data_ptr[ chunk ], chunk_result_ptr[ chunk ] );
         }
      }

};

#include "bitpacking_impl.h"

void vertical_bitpacking< uint32_t >::compress_impl( uint32_t bw, uint32_t * const data, uint32_t * const result ) noexcept {
//   std::cerr << "Compressing 32-Bit value with " << (unsigned) bw << "Bit. Data: " << data << ". Result: " << result << "\n";
   switch( bw ) {
      case  1 : pack<  1 >( data, result ); break;
      case  2 : pack<  2 >( data, result ); break;
      case  3 : pack<  3 >( data, result ); break;
      case  4 : pack<  4 >( data, result ); break;
      case  5 : pack<  5 >( data, result ); break;
      case  6 : pack<  6 >( data, result ); break;
      case  7 : pack<  7 >( data, result ); break;
      case  8 : pack<  8 >( data, result ); break;
      case  9 : pack<  9 >( data, result ); break;
      case 10 : pack< 10 >( data, result ); break;
      case 11 : pack< 11 >( data, result ); break;
      case 12 : pack< 12 >( data, result ); break;
      case 13 : pack< 13 >( data, result ); break;
      case 14 : pack< 14 >( data, result ); break;
      case 15 : pack< 15 >( data, result ); break;
      case 16 : pack< 16 >( data, result ); break;
      case 17 : pack< 17 >( data, result ); break;
      case 18 : pack< 18 >( data, result ); break;
      case 19 : pack< 19 >( data, result ); break;
      case 20 : pack< 20 >( data, result ); break;
      case 21 : pack< 21 >( data, result ); break;
      case 22 : pack< 22 >( data, result ); break;
      case 23 : pack< 23 >( data, result ); break;
      case 24 : pack< 24 >( data, result ); break;
      case 25 : pack< 25 >( data, result ); break;
      case 26 : pack< 26 >( data, result ); break;
      case 27 : pack< 27 >( data, result ); break;
      case 28 : pack< 28 >( data, result ); break;
      case 29 : pack< 29 >( data, result ); break;
      case 30 : pack< 30 >( data, result ); break;
      case 31 : pack< 31 >( data, result ); break;
      case 32 : pack< 32 >( data, result ); break;
   }
}

void vertical_bitpacking< uint64_t >::compress_impl( uint64_t bw, uint64_t * const data, uint64_t *  const result ) noexcept {
   switch( bw ) {
      case  1 : pack<  1 >( data, result ); break;
      case  2 : pack<  2 >( data, result ); break;
      case  3 : pack<  3 >( data, result ); break;
      case  4 : pack<  4 >( data, result ); break;
      case  5 : pack<  5 >( data, result ); break;
      case  6 : pack<  6 >( data, result ); break;
      case  7 : pack<  7 >( data, result ); break;
      case  8 : pack<  8 >( data, result ); break;
      case  9 : pack<  9 >( data, result ); break;
      case 10 : pack< 10 >( data, result ); break;
      case 11 : pack< 11 >( data, result ); break;
      case 12 : pack< 12 >( data, result ); break;
      case 13 : pack< 13 >( data, result ); break;
      case 14 : pack< 14 >( data, result ); break;
      case 15 : pack< 15 >( data, result ); break;
      case 16 : pack< 16 >( data, result ); break;
      case 17 : pack< 17 >( data, result ); break;
      case 18 : pack< 18 >( data, result ); break;
      case 19 : pack< 19 >( data, result ); break;
      case 20 : pack< 20 >( data, result ); break;
      case 21 : pack< 21 >( data, result ); break;
      case 22 : pack< 22 >( data, result ); break;
      case 23 : pack< 23 >( data, result ); break;
      case 24 : pack< 24 >( data, result ); break;
      case 25 : pack< 25 >( data, result ); break;
      case 26 : pack< 26 >( data, result ); break;
      case 27 : pack< 27 >( data, result ); break;
      case 28 : pack< 28 >( data, result ); break;
      case 29 : pack< 29 >( data, result ); break;
      case 30 : pack< 30 >( data, result ); break;
      case 31 : pack< 31 >( data, result ); break;
      case 32 : pack< 32 >( data, result ); break;
      case 33 : pack< 33 >( data, result ); break;
      case 34 : pack< 34 >( data, result ); break;
      case 35 : pack< 35 >( data, result ); break;
      case 36 : pack< 36 >( data, result ); break;
      case 37 : pack< 37 >( data, result ); break;
      case 38 : pack< 38 >( data, result ); break;
      case 39 : pack< 39 >( data, result ); break;
      case 40 : pack< 40 >( data, result ); break;
      case 41 : pack< 41 >( data, result ); break;
      case 42 : pack< 42 >( data, result ); break;
      case 43 : pack< 43 >( data, result ); break;
      case 44 : pack< 44 >( data, result ); break;
      case 45 : pack< 45 >( data, result ); break;
      case 46 : pack< 46 >( data, result ); break;
      case 47 : pack< 47 >( data, result ); break;
      case 48 : pack< 48 >( data, result ); break;
      case 49 : pack< 49 >( data, result ); break;
      case 50 : pack< 50 >( data, result ); break;
      case 51 : pack< 51 >( data, result ); break;
      case 52 : pack< 52 >( data, result ); break;
      case 53 : pack< 53 >( data, result ); break;
      case 54 : pack< 54 >( data, result ); break;
      case 55 : pack< 55 >( data, result ); break;
      case 56 : pack< 56 >( data, result ); break;
      case 57 : pack< 57 >( data, result ); break;
      case 58 : pack< 58 >( data, result ); break;
      case 59 : pack< 59 >( data, result ); break;
      case 60 : pack< 60 >( data, result ); break;
      case 61 : pack< 61 >( data, result ); break;
      case 62 : pack< 62 >( data, result ); break;
      case 63 : pack< 63 >( data, result ); break;
      case 64 : pack< 64 >( data, result ); break;
   }
}

#endif //GENERAL_BITPACKING_H
