/**
 * @file asm_utils.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_ASM_UTILS_H
#define GENERAL_ASM_UTILS_H

#include <cstdint>
#include <cstddef>

uint64_t get_user_clock( void ) {
   asm( "smir %s0, %usrcc" );
}

uint32_t clz_asm( uint64_t a ) {
   asm( "ldz %s0, %s0" );
}
uint32_t clz( uint32_t a ) {
   return clz_asm( ( uint64_t ) a ) - 32;
}
uint32_t clz( uint64_t a ) {
   return clz_asm( a );
}


uint64_t get_execution_count( void ) {
   asm( "smir %s0, %pmc00" );
}

uint64_t get_vector_execution_count( void ) {
   asm( "smir %s0, %pmc01" );
}

uint64_t get_floating_point_data_element_count( void ) {
   asm( "smir %s0, %pmc02" );
}

uint64_t get_vector_element_count( void ) {
   asm( "smir %s0, %pmc03" );
}

uint64_t get_vector_execution_clock_count( void ) {
   asm( "smir %s0, %pmc04" );
}

uint64_t get_L1_cache_miss_clock_count( void ) {
   asm( "smir %s0, %pmc05" );
}

uint64_t get_vector_element_count2( void ) {
   asm( "smir %s0, %pmc06" );
}

uint64_t get_vector_arithmetic_execution_clock_count( void ) {
   asm( "smir %s0, %pmc07" );
}

uint64_t get_vector_load_execution_clock_count( void ) {
   asm( "smir %s0, %pmc08" );
}

uint64_t get_port_conflict_clock_count( void ) {
   asm( "smir %s0, %pmc09" );
}

uint64_t get_vector_load_packet_count( void ) {
   asm( "smir %s0, %pmc10" );
}

uint64_t get_vector_load_element_count( void ) {
   asm( "smir %s0, %pmc11" );
}

uint64_t get_vector_load_cache_miss_element_count( void ) {
   asm( "smir %s0, %pmc12" );
}

uint64_t get_fused_multiply_add_element_count( void ) {
   asm( "smir %s0, %pmc13" );
}

uint64_t get_power_throttling_clock_count( void ) {
   asm( "smir %s0, %pmc14" );
}

uint64_t get_thermal_throttling_clock_count( void ) {
   asm( "smir %s0, %pmc15" );
}
#endif //GENERAL_ASM_UTILS_H
