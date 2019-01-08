/**
 * @file bitpacking_generator.cpp
 * @brief Needs to be compiled with c++17
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */
#include <iostream>
#include <iomanip>
#include <string>

#define TABSIZE 3
#define VECSIZE 256
#define CHUNKSIZE 16384
#define OUT std::cout

void write( uint32_t tabwidth, std::string code ) {
   if( tabwidth == 0 )
      OUT << code;
   else
      OUT << std::setw(tabwidth*TABSIZE) << " " << code;
}

void write_nl( uint32_t tabwidth, std::string code ) {
   if( tabwidth == 0 )
      OUT << code << "\n";
   else
      OUT << std::setw(tabwidth*TABSIZE) << " " << code << "\n";
}

template< typename... Args >
void write_vector_loop( uint32_t tabwidth, Args&&... args ) {
   write_nl( tabwidth, "for ( size_t chunk_inner_pos = 0; chunk_inner_pos < VE_CORE_VPU_VR_ELEMENT_COUNT; ++chunk_inner_pos ) {" );
   ( ( OUT << std::setw( ( tabwidth+1 ) * TABSIZE ) << " " << args << "\n" ), ...);
   write_nl( tabwidth, "}" );
}

void increment_data( uint32_t tabwidth ) {
   write_nl( tabwidth, "data += VE_CORE_VPU_VR_ELEMENT_COUNT;" );
}

void increment_result( uint32_t tabwidth ) {
   write_nl( tabwidth, "result += VE_CORE_VPU_VR_ELEMENT_COUNT;" );
}

void load_init( uint32_t tabwidth ) {
   write_vector_loop( tabwidth, "result_vector[ chunk_inner_pos ] = data[ chunk_inner_pos ];" );
}

void load_OR_SHIFT( uint32_t tabwidth, uint32_t shift ) {
   std::string shiftline = "result_vector[ chunk_inner_pos ] |= ( data[ chunk_inner_pos ] << " + std::to_string( shift ) + " );";
   write_vector_loop( tabwidth, shiftline);
}

void store_result( uint32_t tabwidth ) {
   write_vector_loop( tabwidth, "result[ chunk_inner_pos ] = result_vector[ chunk_inner_pos ];" );
}

void copy( uint32_t tabwidth ) {
   write_vector_loop( tabwidth, "result[ chunk_inner_pos ] = data[ chunk_inner_pos ];" );
}

void store_result( uint32_t tabwidth, uint32_t shift ) {
   std::string str = "result[ chunk_inner_pos ] = result_vector[ chunk_inner_pos ] | ( data[ chunk_inner_pos ] << " + std::to_string( shift ) + " );";
   write_vector_loop( tabwidth, str );
}

void store_result_remainder( uint32_t tabwidth, uint32_t leftshift, uint32_t rightshift ) {
   std::string shift_left = "result[ chunk_inner_pos ] = result_vector[ chunk_inner_pos ] | ( tmp_vector[ chunk_inner_pos ] << " + std::to_string( leftshift ) + " );";
   std::string shift_right = "result_vector[ chunk_inner_pos ] = (tmp_vector[ chunk_inner_pos ] >> " + std::to_string( rightshift ) + " );";
   write_vector_loop( tabwidth, "tmp_vector[ chunk_inner_pos ] = data[ chunk_inner_pos ];", shift_left, shift_right );
}

uint32_t create_chunk( uint32_t tabwidth, uint32_t wordsize, uint32_t bitwidth ) {

   if( bitwidth == wordsize ) {
      copy( tabwidth );
      increment_data( tabwidth );
      increment_result( tabwidth );
      return VECSIZE;
   } else {
      uint32_t processed_values = 0;
      uint32_t set_bit_count = 0;
      load_init( tabwidth );
      increment_data( tabwidth );
      processed_values += VECSIZE;
      set_bit_count += bitwidth;

      while( true ) {
         if( set_bit_count <= ( wordsize - bitwidth ) ) {
            if( set_bit_count == ( wordsize - bitwidth ) ) {
               store_result( tabwidth, set_bit_count );
               increment_data( tabwidth );
               processed_values += VECSIZE;
               increment_result( tabwidth );
               return processed_values;
            } else {
               load_OR_SHIFT( tabwidth, set_bit_count );
               increment_data( tabwidth );
               processed_values += VECSIZE;
               set_bit_count += bitwidth;
            }
         } else {
            store_result_remainder( tabwidth, set_bit_count, wordsize - set_bit_count );
            set_bit_count = ( bitwidth - ( wordsize - set_bit_count ) );
            increment_data( tabwidth );
            processed_values += VECSIZE;
            increment_result( tabwidth );
         }
      }
   }
}

void create_func( uint32_t tabwidth, uint32_t wordsize, uint32_t bitwidth ) {
   write_nl( tabwidth, "template< > template< >" );
   if( tabwidth == 0 )
      OUT << "size_t vertical_bitpacking< ";
   else
      OUT << std::setw( tabwidth * TABSIZE ) << " " << "size_t vertical_bitpacking< ";
   if( wordsize == 32 ) {
      OUT << "uint32_t >::pack< " << ( unsigned ) bitwidth << " >( uint32_t * const data_in, uint32_t * result ) noexcept {\n";
      tabwidth++;
      write_nl( tabwidth, "uint32_t * const result_start_ptr = const_cast< uint32_t * const >( result );" );
      write_nl( tabwidth, "uint32_t * data = const_cast< uint32_t * >( data_in );" );
      write_nl( tabwidth, "uint32_t result_vector[ VE_CORE_VPU_VR_ELEMENT_COUNT ];" );
      write_nl( tabwidth, "uint32_t tmp_vector[ VE_CORE_VPU_VR_ELEMENT_COUNT ];" );
      write_nl( tabwidth, "uint32_t current_vector[ VE_CORE_VPU_VR_ELEMENT_COUNT ];" );
   }else if ( wordsize == 64 ) {
      OUT << "uint64_t >::pack< " << ( unsigned ) bitwidth << " >( uint64_t * const data_in, uint64_t * result ) noexcept {\n";
      tabwidth++;
      write_nl( tabwidth, "uint64_t * const result_start_ptr = const_cast< uint64_t * const >( result );" );
      write_nl( tabwidth, "uint64_t * data = const_cast< uint64_t * >( data_in );" );
      write_nl( tabwidth, "uint64_t result_vector[ VE_CORE_VPU_VR_ELEMENT_COUNT ];" );
      write_nl( tabwidth, "uint64_t tmp_vector[ VE_CORE_VPU_VR_ELEMENT_COUNT ];" );
      write_nl( tabwidth, "uint64_t current_vector[ VE_CORE_VPU_VR_ELEMENT_COUNT ];" );
   } else {
      std::cerr << "Unsupported wordsize.\n";
      exit( 1 );
   }
   uint32_t processed_values = 0;
   uint32_t batch_size = 0;
   size_t batch_no = 1;
   std::cerr << (unsigned) bitwidth << "( " << (unsigned) wordsize << " bit word )\n";
   while( processed_values < CHUNKSIZE ) {
      batch_size = create_chunk( tabwidth, wordsize, bitwidth );
      std::cerr << "   " << (unsigned) batch_size << "\n";
      OUT << std::setw( tabwidth * TABSIZE ) << " " << "//Finished Batch #" << batch_no << " of " << CHUNKSIZE / batch_size << "\n";
      processed_values += batch_size;
      batch_no++;
   }
   write_nl( tabwidth, "return (size_t) (result - result_start_ptr);" );
   tabwidth--;
   write_nl( tabwidth, "}" );
}

int main( void ) {
   for( uint32_t i = 1; i < 33; ++i ) {
      create_func( 0, 32, i );
   }
   for( uint32_t i = 1; i < 65; ++i ) {
      create_func( 0, 64, i );
   }
   return 0;
}