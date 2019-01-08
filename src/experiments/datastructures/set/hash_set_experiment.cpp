/**
 * @file hash_set_test.cpp
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#include <iostream>
#include <iomanip>
#include <time.h>
#include <chrono>
#include <random>
#include <limits>
#include <cstdint>
#include <unordered_map>

#include "../../../main/datastructures/set/hash_set.h"

#define DATACOUNT_HASHSET_EXPERIMENT_L1 8000
#define DATACOUNT_HASHSET_EXPERIMENT_L2 64000
#define DATACOUNT_HASHSET_EXPERIMENT_L3 4096000
#define DATACOUNT_HASHSET_EXPERIMENT_BLOB_400MB 100000000
#define DATACOUNT_HASHSET_EXPERIMENT_BLOB_2GB 500000000

//#define NUM_HASHSET_EXPERIMENT_REP 5
int NUM_HASHSET_EXPERIMENT_REP;



template< uint32_t loadFactor, uint32_t DATACOUNT_HASHSET_EXPERIMENT >
void test_vectorized_elem_build( uint32_t const * const data, uint32_t * const result, uint32_t * const result_count ) {
#pragma _NEC novector
   for( size_t i = 0; i < NUM_HASHSET_EXPERIMENT_REP+1; ++i ) {
      std::cerr << std::setw( 10 ) << DATACOUNT_HASHSET_EXPERIMENT << "  Elemwise Vectorized: Loadfactor: "
                << loadFactor<< " %  [ " << std::setw( 2 ) << i << " / " << std::setw( 2 ) << NUM_HASHSET_EXPERIMENT_REP << " ]: "
                << std::flush;
      const_sized_basic_histogramm< uint32_t > vectorized_histogramm{ DATACOUNT_HASHSET_EXPERIMENT, loadFactor };
      auto start = std::chrono::high_resolution_clock::now( );
      vectorized_histogramm.build_vectorized_elem( data );
      auto end = std::chrono::high_resolution_clock::now( );

      if( i > 0 ) {
         std::cout << "BUILD;AUTOVEC_ELEM;32;" << i << ";" << DATACOUNT_HASHSET_EXPERIMENT << ";"
                   << loadFactor << ";" << vectorized_histogramm.get_size() << ";"
                   << vectorized_histogramm.key_count() << ";"
                   << std::chrono::duration< double, std::milli >( end - start ).count( ) << "\n";
      }
      std::cerr << "Done ( " << std::chrono::duration< double, std::milli >( end - start ).count( ) << " ms )\n";
   }
}
template< uint32_t loadFactor, uint32_t DATACOUNT_HASHSET_EXPERIMENT >
void test_vectorized_batch_build( uint32_t const * const data, uint32_t * const result, uint32_t * const result_count ) {
#pragma _NEC novector
   for( size_t i = 0; i < NUM_HASHSET_EXPERIMENT_REP+1; ++i ) {
      std::cerr << std::setw( 10 ) << DATACOUNT_HASHSET_EXPERIMENT << " Batchwise Vectorized: Loadfactor: "
                << loadFactor<< " %  [ " << std::setw( 2 ) << i << " / " << std::setw( 2 ) << NUM_HASHSET_EXPERIMENT_REP << " ]: "
                << std::flush;
      const_sized_basic_histogramm< uint32_t > vectorized_histogramm{ DATACOUNT_HASHSET_EXPERIMENT, loadFactor };
      auto start = std::chrono::high_resolution_clock::now( );
      vectorized_histogramm.build_vectorized_batch( data );
      auto end = std::chrono::high_resolution_clock::now( );

      if( i > 0 ) {
         std::cout << "BUILD;AUTOVEC_BATCH;32;" << i << ";" << DATACOUNT_HASHSET_EXPERIMENT << ";"
                   << loadFactor << ";" << vectorized_histogramm.get_size() << ";"
                   << vectorized_histogramm.key_count() << ";"
                   << std::chrono::duration< double, std::milli >( end - start ).count( ) << "\n";
      }
      std::cerr << "Done ( " << std::chrono::duration< double, std::milli >( end - start ).count( ) << " ms )\n";
   }
}
template< uint32_t loadFactor, uint32_t DATACOUNT_HASHSET_EXPERIMENT >
void test_scalar_elem_build( uint32_t const * const data, uint32_t * const result, uint32_t * const result_count ) {
#pragma _NEC novector
   for( size_t i = 0; i < NUM_HASHSET_EXPERIMENT_REP+1; ++i ) {
      std::cerr << std::setw( 10 ) << DATACOUNT_HASHSET_EXPERIMENT << "  Elemwise Scalar: Loadfactor: "
                << loadFactor<< " %  [ " << std::setw( 2 ) << i << " / " << std::setw( 2 ) << NUM_HASHSET_EXPERIMENT_REP << " ]: "
                << std::flush;
      const_sized_basic_histogramm< uint32_t > scalar_histogramm{ DATACOUNT_HASHSET_EXPERIMENT, loadFactor };
      auto start = std::chrono::high_resolution_clock::now( );
      scalar_histogramm.build_scalar_elem( data );
      auto end = std::chrono::high_resolution_clock::now( );
      if( i > 0 ) {
         std::cout << "BUILD;SCALAR_ELEM;32;" << i << ";" << DATACOUNT_HASHSET_EXPERIMENT << ";"
                   << loadFactor << ";" << scalar_histogramm.get_size() << ";"
                   << scalar_histogramm.key_count() << ";"
                   << std::chrono::duration< double, std::milli >( end - start ).count( ) << "\n";
      }
      std::cerr << "Done ( " << std::chrono::duration< double, std::milli >( end - start ).count( ) << " ms )\n";
   }
}
template< uint32_t loadFactor, uint32_t DATACOUNT_HASHSET_EXPERIMENT >
void test_scalar_batch_build( uint32_t const * const data, uint32_t * const result, uint32_t * const result_count ) {
#pragma _NEC novector
   for( size_t i = 0; i < NUM_HASHSET_EXPERIMENT_REP+1; ++i ) {
      std::cerr << std::setw( 10 ) << DATACOUNT_HASHSET_EXPERIMENT << " Batchwise Scalar: Loadfactor: "
                << loadFactor<< " %  [ " << std::setw( 2 ) << i << " / " << std::setw( 2 ) << NUM_HASHSET_EXPERIMENT_REP << " ]: "
                << std::flush;
      const_sized_basic_histogramm< uint32_t > scalar_histogramm{ DATACOUNT_HASHSET_EXPERIMENT, loadFactor };
      auto start = std::chrono::high_resolution_clock::now( );
      scalar_histogramm.build_scalar_batch( data );
      auto end = std::chrono::high_resolution_clock::now( );
      if( i > 0 ) {
         std::cout << "BUILD;SCALAR_BATCH;32;" << i << ";" << DATACOUNT_HASHSET_EXPERIMENT << ";"
                   << loadFactor << ";" << scalar_histogramm.get_size() << ";"
                   << scalar_histogramm.key_count() << ";"
                   << std::chrono::duration< double, std::milli >( end - start ).count( ) << "\n";
      }
      std::cerr << "Done ( " << std::chrono::duration< double, std::milli >( end - start ).count( ) << " ms )\n";
   }
}

template< uint32_t DATACOUNT_HASHSET_EXPERIMENT >
void test( )  {
   uint32_t * data = ( uint32_t * ) malloc( DATACOUNT_HASHSET_EXPERIMENT * sizeof( uint32_t ) );
   uint32_t * result = (uint32_t * ) malloc( 1 * sizeof( uint32_t ) ) ;
   uint32_t * result_count = ( uint32_t * ) malloc( 1 * sizeof( uint32_t ) );

   std::mt19937 generator( 65536 );
   std::uniform_int_distribution< uint32_t  > dist( 1, std::numeric_limits< uint32_t >::max() );

   for( size_t position = 0; position < DATACOUNT_HASHSET_EXPERIMENT; ++position ) {
      data[ position ] = dist( generator );
   }
   test_scalar_elem_build< 10, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 20, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 30, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 40, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 50, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 60, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 70, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 80, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 90, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 91, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 92, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 93, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 94, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 95, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 96, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 97, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 98, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_elem_build< 99, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 10, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 20, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 30, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 40, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 50, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 60, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 70, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 80, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 90, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 91, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 92, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 93, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 94, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 95, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 96, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 97, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 98, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_scalar_batch_build< 99, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 10, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 20, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 30, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 40, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 50, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 60, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 70, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 80, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 90, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 91, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 92, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 93, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 94, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 95, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 96, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 97, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 98, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_elem_build< 99, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 10, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 20, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 30, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 40, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 50, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 60, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 70, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 80, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 90, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 91, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 92, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 93, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 94, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 95, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 96, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 97, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 98, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );
   test_vectorized_batch_build< 99, DATACOUNT_HASHSET_EXPERIMENT >( data, result, result_count );

   free( ( void * ) result_count );
   free( ( void * ) result );
   free( ( void * ) data );
}

int main( int argc, char** argv ) {

   if( argc == 1 )
      NUM_HASHSET_EXPERIMENT_REP = 10;
   else
      NUM_HASHSET_EXPERIMENT_REP = std::atoi( argv[ 1 ] );

   std::cout << "#Data:\n" <<
             "#         Generator: " << "std::mt19937\n" <<
             "#              Seed: " << "65536\n" <<
             "#      Distribution: " << "std::uniform_int_distribution< uint32_t >\n" <<
             "#  [ lower, upper ]: " << "[ 1, " << std::numeric_limits< uint32_t > ::max() << " ]\n" <<
             "Phase;Variant;BitWidth;Rep;DataCount;LoadFactor;ContainerSize;DistinctKeysInContainer;TimeMs\n";

   test< DATACOUNT_HASHSET_EXPERIMENT_L1 >( );
   test< DATACOUNT_HASHSET_EXPERIMENT_L2 >( );
   test< DATACOUNT_HASHSET_EXPERIMENT_L3 >( );
   test< DATACOUNT_HASHSET_EXPERIMENT_BLOB_400MB >( );
   test< DATACOUNT_HASHSET_EXPERIMENT_BLOB_2GB >( );

   return 0;
}
