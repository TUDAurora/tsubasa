/**
 * @file hash_set_test.cpp
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#include <iostream>
#include <time.h>
#include <chrono>
#include <random>
#include <limits>
#include <cstdint>
#include <unordered_map>
#include "../../test_utils.h"

#include "../../../main/datastructures/set/hash_set.h"


#define DATACOUNT_HASHSET_TEST_L1 8000
#define DATACOUNT_HASHSET_TEST_L2 64000
#define DATACOUNT_HASHSET_TEST_L3 4096000
#define DATACOUNT_HASHSET_TEST_BLOB_400MB 100000000
#define DATACOUNT_HASHSET_TEST_BLOB_2GB 500000000



template< uint32_t loadFactor, uint32_t DATACOUNT_HASHSET_TEST >
bool test_vectorized_elem_build( uint32_t const * const data, uint32_t * const result, uint32_t * const result_count ) {
   const_sized_basic_histogramm< uint32_t > vectorized_histogramm{ DATACOUNT_HASHSET_TEST, loadFactor };
   vectorized_histogramm.build_vectorized_elem( data );
   std::unordered_map< uint32_t, size_t > stl_histo;
   for( size_t i = 0; i < DATACOUNT_HASHSET_TEST; ++i )
      stl_histo[ data[ i ] ] = stl_histo[ data[ i ] ] + 1;
   size_t checked_key = 0;
   for( size_t i = 0; i < DATACOUNT_HASHSET_TEST; ++i ) {
      size_t vec_count = vectorized_histogramm.probe_count_vectorized( data[ i ] );
      size_t stl_count = stl_histo[ data[ i ] ];
      if( vec_count != stl_count ) {
         std::cout << "LoadFactor = " << (float)(((float)loadFactor)/100.0f) << ".\n"
                   << "Key: " << ( unsigned ) data[ i ]
                   << " STL-Count: " << stl_count
                   << " VEC-Count: " << ( unsigned ) vec_count << "\n";
         std::cout << "WRONG ("<<checked_key << " key)\n";
         return false;
      }
      ++checked_key;
   }
   return true;
}
template< uint32_t loadFactor, uint32_t DATACOUNT_HASHSET_TEST >
bool test_vectorized_batch_build( uint32_t const * const data, uint32_t * const result, uint32_t * const result_count ) {
   const_sized_basic_histogramm< uint32_t > vectorized_histogramm{ DATACOUNT_HASHSET_TEST, loadFactor };
   vectorized_histogramm.build_vectorized_batch( data );
   std::unordered_map< uint32_t, size_t > stl_histo;
   for( size_t i = 0; i < DATACOUNT_HASHSET_TEST; ++i )
      stl_histo[ data[ i ] ] = stl_histo[ data[ i ] ] + 1;
   size_t checked_key = 0;
   for( size_t i = 0; i < DATACOUNT_HASHSET_TEST; ++i ) {
      size_t vec_count = vectorized_histogramm.probe_count_vectorized( data[ i ] );
      size_t stl_count = stl_histo[ data[ i ] ];
      if( vec_count != stl_count ) {
         std::cout << "LoadFactor = " << (float)(((float)loadFactor)/100.0f) << ".\n"
                   << "Key: " << ( unsigned ) data[ i ]
                   << " STL-Count: " << stl_count
                   << " VEC-Count: " << ( unsigned ) vec_count << "\n";
         std::cout << "WRONG ("<<checked_key << " key)\n";
         return false;
      }
      ++checked_key;
   }
   return true;
}
template< uint32_t loadFactor,uint32_t DATACOUNT_HASHSET_TEST >
bool test_scalar_elem_build( uint32_t const * const data, uint32_t * const result, uint32_t * const result_count ) {
   const_sized_basic_histogramm< uint32_t > scalar_histogramm{ DATACOUNT_HASHSET_TEST, loadFactor };
   scalar_histogramm.build_scalar_elem( data );
   std::unordered_map< uint32_t, size_t > stl_histo;
   for( size_t i = 0; i < DATACOUNT_HASHSET_TEST; ++i )
      stl_histo[ data[ i ] ] = stl_histo[ data[ i ] ] + 1;
   size_t checked_key = 0;
   for( size_t i = 0; i < DATACOUNT_HASHSET_TEST; ++i ) {
      size_t vec_count = scalar_histogramm.probe_count_vectorized( data[ i ] );
      size_t stl_count = stl_histo[ data[ i ] ];
      if( vec_count != stl_count ) {
         std::cout << "LoadFactor = " << (float)(((float)loadFactor)/100.0f) << ".\n"
                   << "Key: " << ( unsigned ) data[ i ]
                   << " STL-Count: " << stl_count
                   << " VEC-Count: " << ( unsigned ) vec_count << "\n";
         std::cout << "WRONG ("<<checked_key << " key)\n";
         return false;
      }
      ++checked_key;
   }
   return true;
}
template< uint32_t loadFactor, uint32_t DATACOUNT_HASHSET_TEST >
bool test_scalar_batch_build( uint32_t const * const data, uint32_t * const result, uint32_t * const result_count ) {
   const_sized_basic_histogramm< uint32_t > scalar_histogramm{ DATACOUNT_HASHSET_TEST, loadFactor };
   scalar_histogramm.build_scalar_batch( data );
   std::unordered_map< uint32_t, size_t > stl_histo;
   for( size_t i = 0; i < DATACOUNT_HASHSET_TEST; ++i )
      stl_histo[ data[ i ] ] = stl_histo[ data[ i ] ] + 1;
   size_t checked_key = 0;
   for( size_t i = 0; i < DATACOUNT_HASHSET_TEST; ++i ) {
      size_t vec_count = scalar_histogramm.probe_count_vectorized( data[ i ] );
      size_t stl_count = stl_histo[ data[ i ] ];
      if( vec_count != stl_count ) {
         std::cout << "LoadFactor = " << (float)(((float)loadFactor)/100.0f) << ".\n"
                   << "Key: " << ( unsigned ) data[ i ]
                   << " STL-Count: " << stl_count
                   << " VEC-Count: " << ( unsigned ) vec_count << "\n";
         std::cout << "WRONG ("<<checked_key << " key)\n";
         return false;
      }
      ++checked_key;
   }
   return true;
}

template< uint32_t DATACOUNT_HASHSET_TEST >
int test( char * argv ) {
   uint32_t * data = ( uint32_t * ) malloc( DATACOUNT_HASHSET_TEST * sizeof( uint32_t ) );
   uint32_t * result = ( uint32_t * ) malloc( DATACOUNT_HASHSET_TEST * sizeof( uint32_t ) ) ;
   uint32_t * result_count = ( uint32_t * ) malloc( DATACOUNT_HASHSET_TEST * sizeof( uint32_t ) );

   std::mt19937 generator( 65536 );
   std::uniform_int_distribution< uint32_t  > dist( 1, std::numeric_limits< uint32_t >::max() );


   for( size_t position = 0; position < DATACOUNT_HASHSET_TEST; ++position ) {
      data[ position ] = dist( generator );
   }

   bool passed = true;
   if( std::string{"se"}.compare( argv ) == 0 ) {
      passed &= test_scalar_elem_build< 10, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 20, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 30, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 40, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 50, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 60, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 70, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 80, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 90, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 91, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 92, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 93, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 94, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 95, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 96, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 97, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 98, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_elem_build< 99, DATACOUNT_HASHSET_TEST >( data, result, result_count );
   }else if( std::string{"sb"}.compare( argv ) == 0 ) {
      passed &= test_scalar_batch_build< 10, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 20, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 30, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 40, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 50, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 60, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 70, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 80, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 90, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 91, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 92, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 93, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 94, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 95, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 96, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 97, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 98, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_scalar_batch_build< 99, DATACOUNT_HASHSET_TEST >( data, result, result_count );
   }else if( std::string{"ve"}.compare( argv ) == 0 ) {
      passed &= test_vectorized_elem_build< 10, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 20, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 30, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 40, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 50, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 60, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 70, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 80, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 90, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 91, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 92, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 93, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 94, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 95, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 96, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 97, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 98, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_elem_build< 99, DATACOUNT_HASHSET_TEST >( data, result, result_count );
   }else if( std::string{"vb"}.compare( argv ) == 0 ) {
      passed &= test_vectorized_batch_build< 10, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 20, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 30, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 40, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 50, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 60, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 70, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 80, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 90, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 91, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 92, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 93, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 94, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 95, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 96, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 97, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 98, DATACOUNT_HASHSET_TEST >( data, result, result_count );
      passed &= test_vectorized_batch_build< 99, DATACOUNT_HASHSET_TEST >( data, result, result_count );
   }
   free( ( void * ) result_count );
   free( ( void * ) result );
   free( ( void * ) data );
   if( passed )
      return 0;
   else
      return 1;
}

int main( int argc, char** argv ) {


   if( std::string{"L1"}.compare( argv[ 2 ] ) == 0 ) {
      return test< DATACOUNT_HASHSET_TEST_L1 >( argv[ 1 ] );
   } else if( std::string{"L2"}.compare( argv[ 2 ] ) == 0 ) {
      return test< DATACOUNT_HASHSET_TEST_L2 >( argv[ 1 ] );
   } else if( std::string{"L3"}.compare( argv[ 2 ] ) == 0 ) {
      return test< DATACOUNT_HASHSET_TEST_L3 >( argv[ 1 ] );
   } else if( std::string{"MB"}.compare( argv[ 2 ] ) == 0 ) {
      return test< DATACOUNT_HASHSET_TEST_BLOB_400MB >( argv[ 1 ] );
   } else if( std::string{"GB"}.compare( argv[ 2 ] ) == 0 ) {
      return test< DATACOUNT_HASHSET_TEST_BLOB_2GB >( argv[ 1 ] );
   }
   return 1;
}
