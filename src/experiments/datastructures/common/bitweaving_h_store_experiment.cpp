/**
 * @file bitweaving_h_store_experiment.cpp
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */
#include <cstdint>
#include <limits>
#include <cassert>
#include <chrono>
#include <random>
#include <iostream>
#include <iomanip>
#include <string>
#include "../../../main/datastructures/common/bitweaving_h_store.h"

#define HALF_L1_SIZE 4096 // = 16384 / 4
#define L1_SIZE 8192 // = 32768 / 4
#define HALF_L2_SIZE 32768 // = 131072 / 4
#define L2_SIZE 65536 // = 252144 / 4
#define HALF_LLC_SIZE 2097152 // = 8388608 / 4
#define LLC_SIZE 4194304 // = 16777216 / 4
#define BLOB_SIZE 134217728

//#define NUM_BW_EXPERIMENT_REP 10
int NUM_BW_EXPERIMENT_REP;

template< typename T >
void print_description(
   std::size_t id, std::size_t num_threads,
   std::size_t DataCount, uint16_t CodeSize, uint16_t VectorElemCount, std::string op, std::string var );
template< >
void print_description< uint32_t >(
   std::size_t id, std::size_t num_threads,
   std::size_t DataCount, uint16_t CodeSize, uint16_t VectorElemCount, std::string op, std::string var ) {
   std::cout << id << ";" << op << ";" << var << ";32;" << DataCount << ";" << ( unsigned ) CodeSize << ";"
             << VectorElemCount << ";" << num_threads << ";";
}
template< >
void print_description< uint64_t >(
   std::size_t id, std::size_t num_threads,
   std::size_t DataCount, uint16_t CodeSize, uint16_t VectorElemCount, std::string op, std::string var ) {
   std::cout << id << ";" << op << ";" << var << ";64;" << DataCount << ";" << ( unsigned ) CodeSize << ";"
             << VectorElemCount << ";" << num_threads << ";";
}

template< typename T, std::size_t DataCount, uint16_t CodeSize, uint16_t VectorElemCount >
void run_experiment_vectorcount( T const * data_, T const * result_ ) {
   std::size_t minirep;
   switch(DataCount) {
      case BLOB_SIZE:
         minirep = 1; break;
      case LLC_SIZE:
         minirep = 5; break;
      case HALF_LLC_SIZE:
         minirep = 10; break;
      case L2_SIZE:
         minirep = 100; break;
      case HALF_L2_SIZE:
         minirep = 200; break;
      case L1_SIZE:
         minirep = 1000; break;
      case HALF_L1_SIZE:
         minirep = 2000; break;
      default:
         minirep = 1; break;
   }

   T * data = ( T * ) malloc( DataCount * sizeof( T ) );
   T * result = ( T * ) malloc( DataCount * sizeof( T ) );
   data = ( T * ) std::memcpy( ( void * ) data, ( void const * ) data_, DataCount );
   result = ( T * ) std::memcpy( ( void * ) result, ( void const * ) result, DataCount );

   bitweaving_h_fitting_store< T, CodeSize, VectorElemCount > bw{ data, DataCount };
   bw.format( );

   std::mt19937 generator( 808080 );
   std::uniform_int_distribution< T > dist( 0, bw.get_max_value() );
   std::cerr << sizeof(T) << "B " << std::setw( 10 ) << DataCount <<" " << std::setw(2)
             << (unsigned) CodeSize << " " << std::setw(3) << VectorElemCount << " ... " << std::flush;
   std::size_t num_threads = 0;
//   for( std::size_t num_threads = 1; num_threads < 9; ++num_threads ) {
      T predicate = bw.create_predicate( dist( generator ));
      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
         auto start = std::chrono::high_resolution_clock::now( );
         for( std::size_t m = 0; m < minirep; ++m ) {
            bw.cmp_neq_par( predicate, result, num_threads );
         }
         auto end = std::chrono::high_resolution_clock::now( );
         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "eq", "seq" );
         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep << "\n";
      }
//      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
//         auto start = std::chrono::high_resolution_clock::now( );
//         for( std::size_t m = 0; m < minirep; ++m ) {
//            bw.cmp_eq_vec( predicate, result, num_threads );
//         }
//         auto end = std::chrono::high_resolution_clock::now( );
//         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "eq", "vec" );
//         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep << "\n";
//      }
      /*for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
         auto start = std::chrono::high_resolution_clock::now( );
         for( std::size_t m = 0; m < minirep; ++m ) {
            bw.cmp_neq_seq( predicate, result, num_threads );
         }
         auto end = std::chrono::high_resolution_clock::now( );
         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "neq", "seq" );
         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep<< "\n";
      }
//      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
//         auto start = std::chrono::high_resolution_clock::now( );
//         for( std::size_t m = 0; m < minirep; ++m ) {
//            bw.cmp_neq_vec( predicate, result, num_threads );
//         }
//         auto end = std::chrono::high_resolution_clock::now( );
//         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "neq", "vec" );
//         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep<< "\n";
//      }
      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
         auto start = std::chrono::high_resolution_clock::now( );
         for( std::size_t m = 0; m < minirep; ++m ) {
            bw.cmp_leq_seq( predicate, result, num_threads );
         }
         auto end = std::chrono::high_resolution_clock::now( );
         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "leq", "seq" );
         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep<< "\n";
      }
//      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
//         auto start = std::chrono::high_resolution_clock::now( );
//         for( std::size_t m = 0; m < minirep; ++m ) {
//            bw.cmp_leq_vec( predicate, result, num_threads );
//         }
//         auto end = std::chrono::high_resolution_clock::now( );
//         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "leq", "vec" );
//         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep<< "\n";
//      }
      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
         auto start = std::chrono::high_resolution_clock::now( );
         for( std::size_t m = 0; m < minirep; ++m ) {
            bw.cmp_lt_seq( predicate, result, num_threads );
         }
         auto end = std::chrono::high_resolution_clock::now( );
         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "lt", "seq" );
         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep<< "\n";
      }
//      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
//         auto start = std::chrono::high_resolution_clock::now( );
//         for( std::size_t m = 0; m < minirep; ++m ) {
//            bw.cmp_lt_vec( predicate, result, num_threads );
//         }
//         auto end = std::chrono::high_resolution_clock::now( );
//         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "lt", "vec" );
//         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep<< "\n";
//      }
      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
         auto start = std::chrono::high_resolution_clock::now( );
         for( std::size_t m = 0; m < minirep; ++m ) {
            bw.cmp_gt_seq( predicate, result, num_threads );
         }
         auto end = std::chrono::high_resolution_clock::now( );
         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "gt", "seq" );
         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep<< "\n";
      }
//      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
//         auto start = std::chrono::high_resolution_clock::now( );
//         for( std::size_t m = 0; m < minirep; ++m ) {
//            bw.cmp_gt_vec( predicate, result, num_threads );
//         }
//         auto end = std::chrono::high_resolution_clock::now( );
//         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "gt", "vec" );
//         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep << "\n";
//      }
      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
         auto start = std::chrono::high_resolution_clock::now( );
         for( std::size_t m = 0; m < minirep; ++m ) {
            bw.cmp_geq_seq( predicate, result, num_threads );
         }
         auto end = std::chrono::high_resolution_clock::now( );
         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "geq", "seq" );
         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep<< "\n";
      }
//      for ( std::size_t i = 0; i < NUM_BW_EXPERIMENT_REP; ++i ) {
//         auto start = std::chrono::high_resolution_clock::now( );
//         for( std::size_t m = 0; m < minirep; ++m ) {
//            bw.cmp_geq_vec( predicate, result, num_threads );
//         }
//         auto end = std::chrono::high_resolution_clock::now( );
//         print_description< T >( i, num_threads, DataCount, CodeSize, VectorElemCount, "geq", "vec" );
//         std::cout << std::chrono::duration< double, std::milli >( end - start ).count( ) / (double)minirep<< "\n";
//      }
//   }
       */
   std::cerr << "DONE\n";
   free( result );
   free( data );
}

template< typename T, std::size_t DataCount, uint16_t CodeSize >
void run_experiment_codesize( T const * data, T const * result ) {
//   run_experiment_vectorcount< T, DataCount, CodeSize, 2 >( data, result );
//   run_experiment_vectorcount< T, DataCount, CodeSize, 4 >( data, result );
//   run_experiment_vectorcount< T, DataCount, CodeSize, 8 >( data, result );
//   run_experiment_vectorcount< T, DataCount, CodeSize, 16 >( data, result );
//   run_experiment_vectorcount< T, DataCount, CodeSize, 32 >( data, result );
//   run_experiment_vectorcount< T, DataCount, CodeSize, 64 >( data, result );
//   run_experiment_vectorcount< T, DataCount, CodeSize, 128 >( data, result );
//   run_experiment_vectorcount< T, DataCount, CodeSize, 256 >( data, result );
//   run_experiment_vectorcount< T, DataCount, CodeSize, 512 >( data, result );
//   run_experiment_vectorcount< T, DataCount, CodeSize, 1024 >( data, result );
   run_experiment_vectorcount< T, DataCount, CodeSize, 2048 >( data, result );
}


template< std::size_t DataCount >
void run_experiment_datacount_32( void ) {
   uint32_t * data   = ( uint32_t * ) malloc( DataCount * sizeof( uint32_t ) );
   uint32_t * result = ( uint32_t * ) malloc( DataCount * sizeof( uint32_t ) );
   std::mt19937 generator( 65536 );
   std::uniform_int_distribution< uint32_t > dist( 0, std::numeric_limits< uint32_t >::max() );
   for( size_t position = 0; position < DataCount; ++position ) {
      data[ position ] = dist( generator );
      result[ 0 ] = 0;
   }

   run_experiment_codesize< uint32_t, DataCount, 1 >( data, result );
   run_experiment_codesize< uint32_t, DataCount, 3 >( data, result );
   run_experiment_codesize< uint32_t, DataCount, 7 >( data, result );
   run_experiment_codesize< uint32_t, DataCount, 15 >( data, result );
   run_experiment_codesize< uint32_t, DataCount, 31 >( data, result );

   free( result );
   free( data );
}
template< std::size_t DataCount >
void run_experiment_datacount_64( void ) {
   uint64_t * data   = ( uint64_t * ) malloc( DataCount * sizeof( uint64_t ) );
   uint64_t * result = ( uint64_t * ) malloc( DataCount * sizeof( uint64_t ) );
   std::mt19937 generator( 65536 );
   std::uniform_int_distribution< uint64_t > dist( 0, std::numeric_limits< uint64_t >::max() );
   for( size_t position = 0; position < DataCount; ++position ) {
      data[ position ] = dist( generator );
      result[ 0 ] = 0;
   }

   run_experiment_codesize< uint64_t, DataCount, 1 >( data, result );
   run_experiment_codesize< uint64_t, DataCount, 3 >( data, result );
   run_experiment_codesize< uint64_t, DataCount, 7 >( data, result );
   run_experiment_codesize< uint64_t, DataCount, 15 >( data, result );
   run_experiment_codesize< uint64_t, DataCount, 31 >( data, result );
   run_experiment_codesize< uint64_t, DataCount, 63 >( data, result );

   free( result );
   free( data );
}

void run_experiment_datatype_32( void ) {
   run_experiment_datacount_32< HALF_L1_SIZE >( );
   run_experiment_datacount_32< L1_SIZE >( );
   run_experiment_datacount_32< HALF_L2_SIZE >( );
   run_experiment_datacount_32< L2_SIZE >( );
   run_experiment_datacount_32< HALF_LLC_SIZE >( );
   run_experiment_datacount_32< LLC_SIZE >( );
   run_experiment_datacount_32< BLOB_SIZE >( );
}
void run_experiment_datatype_64( void ) {
   run_experiment_datacount_64< HALF_L1_SIZE >( );
   run_experiment_datacount_64< L1_SIZE >( );
   run_experiment_datacount_64< HALF_L2_SIZE >( );
   run_experiment_datacount_64< L2_SIZE >( );
   run_experiment_datacount_64< HALF_LLC_SIZE >( );
   run_experiment_datacount_64< LLC_SIZE >( );
   run_experiment_datacount_64< BLOB_SIZE >( );
}

void run_experiment( void ) {
   std::cout << "#Run;Operation;Variant;BitWidth;DataCount;CodeSize;VectorElemCount;ThreadCount;TimeMs\n";
   std::cerr << "#B " << std::setw( 10 ) << "datacount" << " " << std::setw(2)
             << "CS" << " " << "#VE" << "\n";
   run_experiment_datatype_32( );
   run_experiment_datatype_64( );
}

int main( int argc, char** argv ) {

   if( argc == 1 )
      NUM_BW_EXPERIMENT_REP = 10;
   else
      NUM_BW_EXPERIMENT_REP = std::atoi( argv[ 1 ] );
   run_experiment( );
   return 0;
}

