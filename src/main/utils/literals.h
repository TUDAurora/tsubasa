/**
 * @file literals.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_LITERALS_H
#define GENERAL_LITERALS_H

#include <cstddef>

constexpr std::size_t operator""_b( unsigned long long v ) {
   return v/8;
}

constexpr std::size_t operator""_B( unsigned long long v ) {
   return v;
}
constexpr std::size_t operator""_KB( unsigned long long v ) {
   return ( 1024 * v );
}
constexpr std::size_t operator""_MB( unsigned long long v ) {
   return ( 1024 * 1024 * v );
}

constexpr std::size_t operator""_GB( unsigned long long v ) {
   return ( 1024 * 1024 * 1024 * v );
}

template< typename T >
constexpr std::size_t get_data_count( unsigned long long v ) {
   return v / sizeof( T );
}
#endif //GENERAL_LITERALS_H
