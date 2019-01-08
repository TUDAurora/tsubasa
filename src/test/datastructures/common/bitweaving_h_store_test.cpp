/**
 * @file bitweaving_h_store_test.cpp
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */
#include <cstdint>
#include <limits>
#include <cassert>
#include "../../../main/datastructures/common/bitweaving_h_store.h"

#define NUM_BW_TEST_REP 10
#define MAX_NUM_THREADS 8
#define THREAD_CHUNK_MIN_SIZE 840 //lcm [1,2,3,4,5,6,7,8]

template< typename T, uint8_t CodeSize, uint8_t VectorElemCount >
bool run_test( T * const data, T * const result ) {
   T max_value = get_all_ones_mask< T, CodeSize >( );
   std::size_t code_count = ( sizeof( T ) * 8 / ( CodeSize + 1 ) );
   assert( ( max_value + 1 ) % code_count == 0 );
   std::size_t result_size;
   îf( ( max_value + 1 ) > code_count ) {
      result_size = ( ( max_value + 1 ) / code_count );
   } else {
      result_size = code_count;
   }

   T single_data = 0;
   for( std::size_t i = 0; i < code_count; ++i ) {
      single_data |=
   }





   for( T i = 0; i < max_value; ++i ) {

   }
   bitweaving_h_fitting_store< T, CodeSize, VectorElemCount > bw{ data, DATACOUNT_BWH_TEST };
   bw.format( );



   std::mt19937 generator( 808080 );
   std::uniform_int_distribution< T > dist( 0, bw.get_max_value() );
   for( std::size_t i = 0; i < NUM_BW_TEST_REP; ++i ) {
      T predicate = bw.create_predicate( dist( generator ));
      bw.cmp_eq( predicate, result );
      bw.cmp_neq( predicate, result );
      bw.cmp_leq( predicate, result );
      bw.cmp_lt( predicate, result );
      bw.cmp_gt( predicate, result );
      bw.cmp_geq( predicate, result );
   }
   return true;
}

template< typename T, std::size_t DATACOUNT_BWH_TEST >
int test( char * argv ) {
   T * data = ( T * ) malloc( DATACOUNT_BWH_TEST * sizeof( T ) );
   T * result = ( T * ) malloc( DATACOUNT_BWH_TEST * sizeof( T ) ) ;

   std::mt19937 generator( 65536 );
   std::uniform_int_distribution< T > dist( 1, std::numeric_limits< T >::max() );


   for( std::size_t position = 0; position < DATACOUNT_BWH_TEST; ++position ) {
      data[ position ] = dist( generator );
   }

   bool passed = true;


   free( ( void * ) result );
   free( ( void * ) data );
   if( passed )
      return 0;
   else
      return 1;
}

