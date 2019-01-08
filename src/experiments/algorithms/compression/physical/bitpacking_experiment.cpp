/**
 * @file bitpacking_experiment.cpp
 * @brief Brief description
 * @author Johannes Pietrzyk + Patrick Damme
 * @todo TODOS?
 */

#include "../../../../main/algorithms/compression/physical/bitpacking.h"
#include "../../../../main/utils/vector.h"
#include "../../../../main/utils/literals.h"
#include "../../../../main/utils/clock.h"

#include "../../../BenchmarkFramework/datagen/BinomialDistribution.h"
#include "../../../BenchmarkFramework/datagen/CompositeDistribution.h"
#include "../../../BenchmarkFramework/datagen/ConstantDistribution.h"
#include "../../../BenchmarkFramework/datagen/UniformDistributionBw.h"
#include "../../../BenchmarkFramework/general/buffers.h"
#include "../../../BenchmarkFramework/datagen/ComplexDataGenerator.h"

#include <cstddef>
#include <cstdlib>
#include <cstdint>
#include <vector>
#include <cinttypes>
#include <iostream>
#include <iomanip>
#include <array>

using namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework;
using namespace DresdenDBSystemsGroup::CompressionProject::DataGenerators;

template< typename T >
void test( void ) {
   // The total number of 32-bit integers to generate.
   const unsigned countValues = 400_MB;//2_GB;
   // The two bit widths to generate.
   const unsigned bw0 = 4;
   const unsigned bw1 = 28;
   // The denominator of the probability.
   const unsigned probDenom = 64 * 1024;
   // The distribution choosing either bw0 or bw1.
   BinomialDistribution* const bd = new BinomialDistribution(
      1,
      1,
      probDenom,
      0
   );
   // The data generator.
   ComplexDataGenerator cg(
      countValues * ( sizeof( T ) / 4 ),
      {
         {
            new CompositeDistribution(
               {
                  // Uniform distribution over all values having
                  // bw0 bits.
                  new UniformDistributionBw(bw0),
                  // Uniform distribution over all values having
                  // bw1 bits.
                  new UniformDistributionBw(bw1),
               },
               bd
            ),
            // All runs have length 1.
            new ConstantDistribution(1),
            true
         }
      },
      // Unsorted data.
      ComplexDataGenerator::SortOrder::SORTORDER_NONE
   );
   // The buffer for the generated data. Must be aligned (to 16 byte?).
   T* const data32 = allocateAlignedBuffer<T>(
      countValues,
      false
   );
   // We vary the numerator of the probability of bw0.
   for(unsigned probNum = 1; probNum <= probDenom; probNum *= 2) {
      // Change the data characteristics.
      bd->setProbNumerator(probNum);
      std::cerr << "Prob Num: " << std::setw( 5 ) << probNum << " / " << probDenom << ": Generating... ";
      // Generate the data.
      cg.generate(( uint32_t* )data32);
      if( sizeof( T ) == 8 ) {
         for( size_t i = 0; i < countValues; ++i ) {
            data32[ i ] &= 0x00000000ffffffff;
         }
      }
      std::cerr << "OK. Measuring ";
      for( size_t i = 0; i < 10; ++i ) {
         std::cout << probNum << ";" << i << ";" << sizeof( T ) * 8 << ";" << bw0 << ";"  << bw1 << ";";
         if( i == 0 )
            std::cerr << "[Stats... ";
         uint64_t clock_stats_start = get_user_clock( );
         {
            for ( size_t rep = 0; rep < 10; ++rep ) {
               vertical_bitpacking< T > test( data32, countValues * sizeof( T ));
            }
         }
         uint64_t clock_stats_end = get_user_clock( );
         if( i == 0 )
            std::cerr << "OK. ";
         std::cout << get_user_time_s( clock_stats_start, clock_stats_end ) / ( ( double ) 10 ) << ";";

         vertical_bitpacking< T > test( data32, countValues * sizeof( T ));

         if( i == 0 )
            std::cerr << "Chunk Checking... ";
         //for testing
         size_t chunk_count = test.get_chunk_count( );
         std::array< size_t, ( sizeof( T ) * 8 + 1 ) > chunks_with_specific_bitwidth{ 0 };

         for( size_t j = 0; j < chunk_count; ++j ) {
            chunks_with_specific_bitwidth[ test.get_chunk_max_bitwidth( j ) ]++;
         }
         std::cout << chunks_with_specific_bitwidth[ 4 ] << ";" << chunks_with_specific_bitwidth[ 28 ] << ";";
         if( i == 0 ) {
            std::cerr << chunks_with_specific_bitwidth[ 4 ] << " *  4 Bit;" << chunks_with_specific_bitwidth[ 28 ]
                      << " * 28 Bit. ";
            std::cerr << "OK. Compressing... ";
         }
         uint64_t clock_compress_start = get_user_clock( );
         for( size_t rep = 0; rep < 10; ++rep )
            test.compress( );
         uint64_t clock_compress_end = get_user_clock( );
         if( i == 0 )
            std::cerr << "OK.]";
         std::cout << get_user_time_s( clock_compress_start, clock_compress_end ) / ( ( double ) 10 )<< ";";
         std::cout << countValues * sizeof( T ) << ";";
         std::cout << test.get_compressed_size_bytes() << "\n";
      }
      std::cerr << " DONE.\n";
   }
   freeAlignedBuffer(data32);
}

int main( void ) {

   std::cout << "ProbNum;Run;WordSize_Bit;LowerBitWidth_Bit;UpperBitWidth_Bit;StatGather_Seconds;4_Bit_Chunk_No;28_Bit_Chunk_No;Compress_Seconds;DataSize_Byte;CompressedSize_Byte\n";
   test< uint32_t >( );
   test< uint64_t >( );

   return 0;
}

