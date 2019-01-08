/**
 * author: Patrick Damme
 */

#ifndef TASKS_H
#define TASKS_H

/**
 * This header provides the implementations for the tasks, i.e. copy, write,
 * compare, and agg(OR) for all variants (scalar, vectorized, system call).
 */
#include "utils.h"
#include "simdabstraction.h"
#include <stdexcept>
#include <string>

#include <cstddef>
#include <cstdint>
#include <cstring>

enum Task {
   COPY, WRITE, COMPARE, AGGOR, BW_EQ, BW_NEQ, BW_GT, BW_GEQ, BW_LT, BW_LEQ
};

enum Method {
   // Note that we could have used something like SYSTEM_CALL to summarize
   // MEMCPY, MEMSET, and MEMCMP. However, it is nice when the user directly
   // knows, which system call it is.
      SCALAR, VECTOR
};

/**
 * Interface for a variant of a task. The decisive part of it is its member
 * function doIt(). Everything else is just there to support easy output.
 */
struct TaskVariant {
   const Task task;
   const Method method;
   const size_t vectorSizeBytes;
   const size_t elementSizeBytes;
   const LSMode myLoadMode;
   const LSMode myStoreMode;
   const uint16_t bwInfo;

   size_t get_elementSizeBytes() const {
      return elementSizeBytes;
   }
   size_t get_vectorSizeBytes() const {
      return vectorSizeBytes;
   }

   TaskVariant(
      Task task,
      Method method,
      size_t vectorSizeBytes_,
      size_t elementSizeBytes,
      LSMode loadMode,
      LSMode storeMode,
      uint16_t bwinf = 0
   ) :
      task(task),
      method(method),
      vectorSizeBytes(vectorSizeBytes_),
      elementSizeBytes(elementSizeBytes),
      myLoadMode(loadMode),
      myStoreMode(storeMode),
      bwInfo(bwinf)
   {
      // nothing to do
   }

   virtual uint64_t doIt(  uint8_t * dst, uint8_t * src, size_t count ) const = 0;

   std::string taskStr() const {
      switch(task) {
         case COPY   : return "copy";
         case WRITE  : return "write";
         case COMPARE: return "compare";
         case AGGOR  : return "agg(or)";
         case BW_EQ  : return "bw_h_eq";
         case BW_NEQ : return "bw_h_neq";
         case BW_LT : return "bw_h_lt";
         case BW_LEQ : return "bw_h_leq";
         case BW_GT : return "bw_h_gt";
         case BW_GEQ : return "bw_h_geq";
         default: throw std::runtime_error("unknown Task");
      }
   }

   uint16_t bitwidth() const {
      return bwInfo;
   }

   std::string methodStr() const {
      switch(method) {
         case SCALAR: return "scalar";
         case VECTOR: return "vector";
         default: throw std::runtime_error("unknown Method");
      }
   }

   static std::string lsModeStr(LSMode lsMode) {
      switch(lsMode) {
         case NONE     : return "-";
         case ALIGNED  : return "aligned";
         case UNALIGNED: return "unaligned";
         case STREAM   : return "stream";
         default: throw std::runtime_error("unknown LSMode");
      }
   }

   std::string loadModeStr() const {
      return lsModeStr(myLoadMode);
   }

   std::string storeModeStr() const {
      return lsModeStr(myStoreMode);
   }
};
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

template<typename T, uint16_t CodeSize >
struct BitWeaving_H {


   T           const delimeter_bits_mask  = get_delimeter_mask< T, CodeSize >( );
   T           const code_bits_mask       = get_inverted_delimeter_mask< T, CodeSize >( );
   T           const first_bit_mask       = get_first_bit_mask< T, CodeSize >( );
   T           const max_value            = get_all_ones_mask< T, CodeSize >( );
   std::size_t const code_count           = ( sizeof( T ) * 8 / ( CodeSize + 1 ) );
   T           predicate;

   BitWeaving_H( void ) {
      T pred = ( T ) WRITE_VAL64;
      pred &= max_value;
      predicate = pred;
      for( std::size_t i = 1; i < code_count; ++i ) {
         if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
            pred <<= ( CodeSize + 1 );
            predicate |= pred;
         }
      }
   }
};

#ifdef GNUCC_

#   if defined(__SSE4_1__) || defined(__AVX2__) || defined(__AVX512F__)
#      include <immintrin.h>
#   endif

// ****************************************************************************
// Copy variants.
// ****************************************************************************

template< typename T, typename __mXi, LSMode loadMode, LSMode storeMode>
struct CopyVector : public TaskVariant {
   CopyVector() : TaskVariant(COPY, VECTOR, sizeof(__mXi), sizeof(T), loadMode, storeMode) {};
   uint64_t doIt( uint8_t * dst, uint8_t * src, size_t count ) const {
      __mXi* const srcX = reinterpret_cast<__mXi*>(src + offset(loadMode));
      __mXi* const dstX = reinterpret_cast<__mXi*>(dst + offset(storeMode));
      const size_t countX = ( count ) / sizeof(__mXi);
#ifdef OMP_
#pragma omp parallel for
#endif
      for ( unsigned i = 0; i < countX; i++ ) {
         SIMDStore< __mXi, storeMode >::store(
            dstX + i,
            SIMDLoad< __mXi, loadMode >::load( srcX + i )
         );
      }
      return 0;
    }
};

// ****************************************************************************
// Write variants.
// ****************************************************************************

template< typename T, typename __mXi, LSMode storeMode>
struct WriteVector : public TaskVariant {
   WriteVector() : TaskVariant(WRITE, VECTOR, sizeof(__mXi), sizeof(T), NONE, storeMode) {};
   uint64_t doIt( uint8_t * dst, uint8_t * src, size_t count ) const {
      __mXi* const dstX = reinterpret_cast<__mXi*>(dst + offset(storeMode));
      const __mXi valX = SIMDInstrs<__mXi>::set1_epi8(static_cast<uint8_t>(WRITE_VAL64));
      const size_t countX = ( count ) / sizeof(__mXi);
#ifdef OMP_
#pragma omp parallel for
#endif
      for ( unsigned i = 0; i < countX; i++ ) {
         SIMDStore< __mXi, storeMode >::store( dstX + i, valX );
      }
      return 0;
   }
};

// ****************************************************************************
// Compare variants.
// ****************************************************************************
// Note that we only use half of the buffers in all compare variants, since
// we read from two buffers.

template< typename T, typename __mXi, LSMode loadMode>
struct CompareVector : public TaskVariant {
   CompareVector() : TaskVariant(COMPARE, VECTOR, sizeof(__mXi), sizeof(T), loadMode, NONE) {};
   uint64_t doIt( uint8_t * dst, uint8_t * src, size_t count ) const {
//      __mXi* const dstX = reinterpret_cast<__mXi*>(dst + offset(loadMode));
      __mXi const dstX = SIMDInstrs<__mXi>::set1_epi8(static_cast<uint8_t>(WRITE_VAL64));
      __mXi* const srcX = reinterpret_cast<__mXi*>(src + offset(loadMode));
      const size_t countX = ( count ) / sizeof(__mXi);

      uint64_t res = -1;
#ifdef OMP_
#pragma omp parallel for
#endif
      for ( unsigned i = 0; i < countX; i++ ) {
         res &= SIMDInstrs< __mXi >::cmpeq_epi32_mask(
//            SIMDLoad< __mXi, loadMode >::load( dstX + i ),
            dstX,
            SIMDLoad< __mXi, loadMode >::load( srcX + i )
         );
      }
      return res;
   }
};

// ****************************************************************************
// Aggregation(using bitwise OR) variants.
// ****************************************************************************

template< typename T, typename __mXi, LSMode loadMode>
struct AggOrVector : public TaskVariant {
   AggOrVector() : TaskVariant(AGGOR, VECTOR, sizeof(__mXi), sizeof(T), loadMode, NONE) {};
   uint64_t doIt( uint8_t * dst, uint8_t * src, size_t count ) const {
      __mXi* const srcX = reinterpret_cast<__mXi*>(src + offset(loadMode));
      const size_t countX = ( count ) / sizeof(__mXi);
      __mXi res = SIMDInstrs<__mXi>::set1_epi8(0);
#ifdef OMP_
#pragma omp parallel for
#endif
      for ( unsigned i = 0; i < countX; i++ ) {
         res = SIMDInstrs< __mXi >::or_siX(
           res,
            SIMDLoad< __mXi, loadMode >::load( srcX + i )
         );
      }
      return SIMDInstrs<__mXi>::extract_lowest_epi64(res);
   }
};

// ****************************************************************************
// Bitweaving horizontal
// @TODO: implement bitvector for camera ready version
// ****************************************************************************

template< typename T, uint16_t CodeSize, typename __mXi, LSMode loadMode, LSMode storeMode>
struct BitWeaving_H_EQ : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_EQ( ) :
      TaskVariant( BW_EQ, VECTOR, sizeof(__mXi), sizeof(T), loadMode, storeMode, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      __mXi* const srcX = reinterpret_cast<__mXi*>(src8 + offset(loadMode));
      __mXi* const dstX = reinterpret_cast<__mXi*>(dst8 + offset(storeMode));
      const __mXi allset = SIMDInstrs<__mXi>::set1_epi8(static_cast<uint8_t>(0xffff));
      const size_t countX = length / 2 / sizeof( __mXi );
      const __mXi pred = SIMDInstrs<__mXi>::set1(static_cast<T>(this->predicate));
      const __mXi cbm = SIMDInstrs<__mXi>::set1(static_cast<T>(this->code_bits_mask));
      T dummy = (T)0;
#ifdef OMP_
#pragma omp parallel for
#endif
      for ( unsigned i = 0; i < countX; i++ ) {
         SIMDStore< __mXi, storeMode >::store(
            dstX + i,
            SIMDInstrs<__mXi>::andnot_siX(
               SIMDInstrs<__mXi>::add(
                  dummy,
                  SIMDInstrs<__mXi>::xor_siX(
                     SIMDLoad< __mXi, loadMode >::load(
                        srcX + i
                     ),
                     pred
                  ),
                  cbm
               ),
               allset
            )
         );
      }
      return (uint64_t)0;
   }
};

template< typename T, uint16_t CodeSize, typename __mXi, LSMode loadMode, LSMode storeMode>
struct BitWeaving_H_NEQ : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_NEQ( ) :
      TaskVariant( BW_NEQ, VECTOR, sizeof(__mXi), sizeof(T), loadMode, storeMode, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      __mXi* const srcX = reinterpret_cast<__mXi*>(src8 + offset(loadMode));
      __mXi* const dstX = reinterpret_cast<__mXi*>(dst8 + offset(storeMode));
      const size_t countX = length / 2 / sizeof( __mXi );
      const __mXi pred = SIMDInstrs<__mXi>::set1(static_cast<T>(this->predicate));
      const __mXi cbm = SIMDInstrs<__mXi>::set1(static_cast<T>(this->code_bits_mask));
      T dummy = (T)0;
#ifdef OMP_
#pragma omp parallel for
#endif
      for ( unsigned i = 0; i < countX; i++ ) {
         SIMDStore< __mXi, storeMode >::store(
            dstX + i,
            SIMDInstrs<__mXi>::add(
               dummy,
               SIMDInstrs<__mXi>::xor_siX(
                  SIMDLoad< __mXi, loadMode >::load(
                     srcX + i
                  ),
                  pred
               ),
               cbm
            )
         );
      }
      return (uint64_t)0;
   }
};

template< typename T, uint16_t CodeSize, typename __mXi, LSMode loadMode, LSMode storeMode>
struct BitWeaving_H_LT : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_LT( ) :
      TaskVariant( BW_LT, VECTOR, sizeof(__mXi), sizeof(T), loadMode, storeMode, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      __mXi* const srcX = reinterpret_cast<__mXi*>(src8 + offset(loadMode));
      __mXi* const dstX = reinterpret_cast<__mXi*>(dst8 + offset(storeMode));
      const size_t countX = length / 2 / sizeof( __mXi );
      const __mXi pred = SIMDInstrs<__mXi>::set1(static_cast<T>(this->predicate));
      const __mXi cbm = SIMDInstrs<__mXi>::set1(static_cast<T>(this->code_bits_mask));
      T dummy = (T)0;
#ifdef OMP_
#pragma omp parallel for
#endif
      for ( unsigned i = 0; i < countX; i++ ) {
         SIMDStore< __mXi, storeMode >::store(
            dstX + i,
            SIMDInstrs<__mXi>::add(
               dummy,
               pred,
               SIMDInstrs<__mXi>::xor_siX(
                  SIMDLoad< __mXi, loadMode >::load(
                     srcX + i
                  ),
                  cbm
               )
            )
         );
      }
      return (uint64_t)0;
   }
};

template< typename T, uint16_t CodeSize, typename __mXi, LSMode loadMode, LSMode storeMode>
struct BitWeaving_H_LEQ : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_LEQ( ) :
      TaskVariant( BW_LEQ, VECTOR, sizeof(__mXi), sizeof(T), loadMode, storeMode, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      __mXi* const srcX = reinterpret_cast<__mXi*>(src8 + offset(loadMode));
      __mXi* const dstX = reinterpret_cast<__mXi*>(dst8 + offset(storeMode));
      const size_t countX = length / 2 / sizeof( __mXi );
      const __mXi pred = SIMDInstrs<__mXi>::set1(static_cast<T>(this->predicate));
      const __mXi cbm = SIMDInstrs<__mXi>::set1(static_cast<T>(this->code_bits_mask));
      const __mXi fbm = SIMDInstrs<__mXi>::set1(static_cast<T>(this->first_bit_mask));
      T dummy = (T)0;
#ifdef OMP_
#pragma omp parallel for
#endif
      for ( unsigned i = 0; i < countX; i++ ) {
         SIMDStore< __mXi, storeMode >::store(
            dstX + i,
            SIMDInstrs<__mXi>::add(
               dummy,
               SIMDInstrs<__mXi>::add(
                  dummy,
                  pred,
                  SIMDInstrs<__mXi>::xor_siX(
                     SIMDLoad< __mXi, loadMode >::load(
                        srcX + i
                     ),
                     cbm
                  )
               ),
               fbm
            )
         );
      }
      return (uint64_t)0;
   }
};

template< typename T, uint16_t CodeSize, typename __mXi, LSMode loadMode, LSMode storeMode>
struct BitWeaving_H_GT : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_GT( ) :
      TaskVariant( BW_GT, VECTOR, sizeof(__mXi), sizeof(T), loadMode, storeMode, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      __mXi* const srcX = reinterpret_cast<__mXi*>(src8 + offset(loadMode));
      __mXi* const dstX = reinterpret_cast<__mXi*>(dst8 + offset(storeMode));
      const size_t countX = length / 2 / sizeof( __mXi );
      const __mXi summand = SIMDInstrs<__mXi>::set1(static_cast<T>(this->predicate ^ this->code_bits_mask));
      T dummy = (T)0;
#ifdef OMP_
#pragma omp parallel for
#endif
      for ( unsigned i = 0; i < countX; i++ ) {
         SIMDStore< __mXi, storeMode >::store(
            dstX + i,
            SIMDInstrs<__mXi>::add(
               dummy,
               SIMDLoad< __mXi, loadMode >::load(
                  srcX + i
               ),
               summand
            )
         );
      }
      return (uint64_t)0;
   }
};

template< typename T, uint16_t CodeSize, typename __mXi, LSMode loadMode, LSMode storeMode>
struct BitWeaving_H_GEQ : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_GEQ( ) :
      TaskVariant( BW_GEQ, VECTOR, sizeof(__mXi), sizeof(T), loadMode, storeMode, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      __mXi* const srcX = reinterpret_cast<__mXi*>(src8 + offset(loadMode));
      __mXi* const dstX = reinterpret_cast<__mXi*>(dst8 + offset(storeMode));
      const size_t countX = length / 2 / sizeof( __mXi );
      const __mXi summand = SIMDInstrs<__mXi>::set1(static_cast<T>(this->predicate ^ this->code_bits_mask));
      const __mXi fbm = SIMDInstrs<__mXi>::set1(static_cast<T>(this->first_bit_mask));
      T dummy = (T)0;
#ifdef OMP_
#pragma omp parallel for
#endif
      for ( unsigned i = 0; i < countX; i++ ) {
         SIMDStore< __mXi, storeMode >::store(
            dstX + i,
            SIMDInstrs<__mXi>::add(
               dummy,
               SIMDInstrs<__mXi>::add(
                  dummy,
                  SIMDLoad< __mXi, loadMode >::load(
                     srcX + i
                  ),
                  summand
               ),
               fbm
            )
         );
      }
      return (uint64_t)0;
   }
};
#endif

#ifdef NCC_
#define MVS 256
// ****************************************************************************
// Copy variants.
// ****************************************************************************

template<typename uintX_t>
struct CopyScalar : public TaskVariant {
    CopyScalar() : TaskVariant(COPY, SCALAR, 256*8, sizeof(uintX_t), NONE, NONE) {};
    uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
       uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
       uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
       const size_t count = length / sizeof( uintX_t );
#ifdef OMP_
#pragma omp parallel for
#endif
#pragma _NEC nonouterloop_unroll
       for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
          size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
          for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
             dst[ inner_i ] = src[ inner_i ];
          }
       }
       return 0;
    }
};

// ****************************************************************************
// Write variants.
// ****************************************************************************

template<typename uintX_t>
struct WriteScalar : public TaskVariant {
WriteScalar() : TaskVariant(WRITE, SCALAR, 256*8, sizeof(uintX_t), NONE, NONE) {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
      uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
      const size_t count = length / sizeof( uintX_t );
      uintX_t valX = ( uintX_t ) WRITE_VAL64;
#ifdef OMP_
#pragma omp parallel for
#endif
#pragma _NEC nonouterloop_unroll
      for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
         size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
         for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
            dst[ inner_i ] = valX;
         }
      }
      return 0;
   }
};

// ****************************************************************************
// Compare variants.
// ****************************************************************************
// Note that we only use half of the buffers in all compare variants, since
// we read from two buffers.

template<typename uintX_t>
struct CompareScalar : public TaskVariant {
   CompareScalar() : TaskVariant(COMPARE, SCALAR, 256*8, sizeof(uintX_t), NONE, NONE) {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      uintX_t dst[ MVS ];
      uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
      const size_t count = length / sizeof( uintX_t ) ;
      uintX_t result_array[ MVS ];
      uintX_t result = 1;
      for( size_t initialize_i = 0; initialize_i < MVS; ++initialize_i ) {
         result_array[ initialize_i ] = ( uintX_t ) 1;
         dst[ initialize_i ] = ( uintX_t ) WRITE_VAL64;
      }
#pragma _NEC vreg( result_array )
#ifdef OMP_
#pragma omp parallel for
#endif
#pragma _NEC nonouterloop_unroll
      for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
//         size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
//         for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
         for( size_t inner_i = 0; inner_i < MVS; ++inner_i ) {
            result_array[ inner_i ] &= ( src[ outer_i + inner_i ] == dst[ inner_i ] );
         }
      }
      for( size_t aggr_i = 0; aggr_i < MVS; ++aggr_i ) {
         result &= result_array[ aggr_i ];
      }
      return (uint64_t)result;
   }
};

// ****************************************************************************
// Aggregation(using bitwise OR) variants.
// ****************************************************************************

template<typename uintX_t>
struct AggOrScalar : public TaskVariant {
   AggOrScalar() : TaskVariant(AGGOR, SCALAR, 256*8, sizeof(uintX_t), NONE, NONE) {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
      uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
      const size_t count = length / sizeof( uintX_t );
      uintX_t result_array[ MVS ];
      uintX_t result = 0;
      for( size_t initialize_i = 0; initialize_i < MVS; ++initialize_i ) {
         result_array[ initialize_i ] = ( uintX_t ) 0;
      }
#pragma _NEC vreg( result_array )
#ifdef OMP_
#pragma omp parallel for
#endif
#pragma _NEC nonouterloop_unroll
      for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
         size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
         for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
            result_array[ inner_i ] |= src[ inner_i ];
         }
      }
      for( size_t aggr_i = 0; aggr_i < MVS; ++aggr_i ) {
         result &= result_array[ aggr_i ];
      }
      return (uint64_t)result;
   }
};

// ****************************************************************************
// Bitweaving horizontal
// ****************************************************************************
template<typename T, uint16_t CodeSize >
struct BitWeaving_H_EQ : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_EQ( ) :
      TaskVariant( BW_EQ, SCALAR, 256*8, sizeof(T), NONE, NONE, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      T * dst = reinterpret_cast< T * >( dst8 );
      T * src = reinterpret_cast< T * >( src8 );
      const size_t count = length / 2 / sizeof( T );
      T pred = this->predicate;
      T cbm = this->code_bits_mask;
#ifdef OMP_
#pragma omp parallel for
#endif
#pragma _NEC nonouterloop_unroll
      for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
         size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
         for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
            dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
         }
      }
      return (uint64_t)0;
   }
};

template<typename T, uint16_t CodeSize >
struct BitWeaving_H_NEQ : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_NEQ( ) :
      TaskVariant( BW_NEQ, SCALAR, 256*8, sizeof(T), NONE, NONE, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      T * dst = reinterpret_cast< T * >( dst8 );
      T * src = reinterpret_cast< T * >( src8 );
      const size_t count = length / 2 / sizeof( T );
      T pred = this->predicate;
      T cbm = this->code_bits_mask;
#ifdef OMP_
#pragma omp parallel for
#endif
#pragma _NEC nonouterloop_unroll
      for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
         size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
         for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
            dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
         }
      }
      return (uint64_t)0;
   }
};

template<typename T, uint16_t CodeSize >
struct BitWeaving_H_LT : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_LT( ) :
      TaskVariant( BW_LT, SCALAR, 256*8, sizeof(T), NONE, NONE, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      T * dst = reinterpret_cast< T * >( dst8 );
      T * src = reinterpret_cast< T * >( src8 );
      const size_t count = length / 2 / sizeof( T );
      T pred = this->predicate;
      T cbm = this->code_bits_mask;
#ifdef OMP_
#pragma omp parallel for
#endif
#pragma _NEC nonouterloop_unroll
      for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
         size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
         for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
            dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
         }
      }
      return (uint64_t)0;
   }
};

template<typename T, uint16_t CodeSize >
struct BitWeaving_H_LEQ : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_LEQ( ) :
      TaskVariant( BW_LEQ, SCALAR, 256*8, sizeof(T), NONE, NONE, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      T * dst = reinterpret_cast< T * >( dst8 );
      T * src = reinterpret_cast< T * >( src8 );
      const size_t count = length / 2 / sizeof( T );
      T pred = this->predicate;
      T cbm = this->code_bits_mask;
      T fbm = this->first_bit_mask;
#ifdef OMP_
#pragma omp parallel for
#endif
#pragma _NEC nonouterloop_unroll
      for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
         size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
         for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
            dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
         }
      }
      return (uint64_t)0;
   }
};

template<typename T, uint16_t CodeSize >
struct BitWeaving_H_GT : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_GT( ) :
      TaskVariant( BW_GT, SCALAR, 256*8, sizeof(T), NONE, NONE, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      T * dst = reinterpret_cast< T * >( dst8 );
      T * src = reinterpret_cast< T * >( src8 );
      const size_t count = length / 2 / sizeof( T );
      T summand = ( this->predicate ^ this->code_bits_mask );
#ifdef OMP_
#pragma omp parallel for
#endif
#pragma _NEC nonouterloop_unroll
      for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
         size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
         for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
            dst[ inner_i ] = src[ inner_i ] + summand;
         }
      }
      return (uint64_t)0;
   }
};

template<typename T, uint16_t CodeSize >
struct BitWeaving_H_GEQ : public TaskVariant, public BitWeaving_H<T,CodeSize> {
   BitWeaving_H_GEQ( ) :
      TaskVariant( BW_GEQ, SCALAR, 256*8, sizeof(T), NONE, NONE, CodeSize ),
      BitWeaving_H< T, CodeSize >() {};
   uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
      T * dst = reinterpret_cast< T * >( dst8 );
      T * src = reinterpret_cast< T * >( src8 );
      const size_t count = length / 2 / sizeof( T );
      T summand = ( this->predicate ^ this->code_bits_mask );
      T fbm = this->first_bit_mask;
#ifdef OMP_
#pragma omp parallel for
#endif
#pragma _NEC nonouterloop_unroll
      for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
         size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
         for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
            dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
         }
      }
      return (uint64_t)0;
   }
};




#endif
#endif /* TASKS_H */