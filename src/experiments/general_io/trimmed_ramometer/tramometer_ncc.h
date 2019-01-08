/**
 * @file tramometer.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_TRAMOMETER_H
#define GENERAL_TRAMOMETER_H

#ifdef NCC_

#   include "../../../main/utils/asm_utils.h"
#   include "../../../main/utils/clock.h"
#   include "../../../main/utils/literals.h"
#   include "../../../main/utils/vector.h"

#   include <cstddef>
#   include <cstdint>

template< typename T >
T aggr_CMPEQ( T const * const first, T const * const second, size_t length ) {
   T result_array[ MVS ];
   T result = 1;
   for( size_t initialize_i = 0; initialize_i < MVS; ++initialize_i ) {
      result_array[ initialize_i ] = ( T ) 1;
   }
#pragma _NEC vreg( result_array )
#pragma _NEC nonouterloop_unroll
   for( size_t outer_i = 0; outer_i < length; outer_i += MVS ) {
      size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
      for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
         result_array[ inner_i ] &= ( first[ inner_i ] == second[ inner_i ] );
      }
   }
   for( size_t aggr_i = 0; aggr_i < MVS; ++aggr_i ) {
      result &= result_array[ aggr_i ];
   }
   return result;
}

template< typename T >
T aggr_OR( T const * const first, size_t length ) {
   T result_array[ MVS ];
   T result = 0;
   for( size_t initialize_i = 0; initialize_i < MVS; ++initialize_i ) {
      result_array[ initialize_i ] = ( T ) 0;
   }
#pragma _NEC vreg( result_array )
#pragma _NEC nonouterloop_unroll
   for( size_t outer_i = 0; outer_i < length; outer_i += MVS ) {
      size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
      for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
         result_array[ inner_i ] |= first[ inner_i ];
      }
   }
   for( size_t aggr_i = 0; aggr_i < MVS; ++aggr_i ) {
      result &= result_array[ aggr_i ];
   }
   return result;
}

template< typename T >
void copy( T const * const first, T * const second ) {
#pragma _NEC nonouterloop_unroll
   for( size_t outer_i = 0; outer_i < length; outer_i += MVS ) {
      size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
      for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
         second[ inner_i ] = first[ inner_i ];
      }
   }
}

template< typename T >
void set( T * const first, T const val ) {
#pragma _NEC nonouterloop_unroll
   for( size_t outer_i = 0; outer_i < length; outer_i += MVS ) {
      size_t inner_upper_bound = outer_i + MVS;
#pragma _NEC shortloop
      for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
         first[ inner_i ] = val;
      }
   }
}
#endif
#endif //GENERAL_TRAMOMETER_H
