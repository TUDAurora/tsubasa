/**
 * @file clock.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_CLOCK_H
#define GENERAL_CLOCK_H

#include "asm_utils.h"

double get_user_time_s( uint64_t start, uint64_t end ) {
   return ( (double)((double)end - (double) start) ) / ( (double)(1400*1000*1000) );
}

/*
void a( uint32_t const * const data, uint32_t * const result ) {
   struct timespec ts, te;
   clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts);
   uint64_t start = ts.tv_sec * 1000 * 1000 * 1000 + ts.tv_nsec;
   uint32_t res = run( data, result );
   clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &te);
   uint64_t stop = te.tv_sec * 1000 * 1000 * 1000 + te.tv_nsec;
   double timeSec = (double)(stop - start) / 1000 / 1000 / 1000;
   std::cout << timeSec << " = " << (unsigned)res << "\n";
}

void b( uint32_t const * const data, uint32_t * const result ) {
   struct timespec ts, te;
   clock_gettime(CLOCK_REALTIME, &ts);
   uint64_t start = ts.tv_sec * 1000 * 1000 * 1000 + ts.tv_nsec;
   uint32_t res = run( data, result );
   clock_gettime(CLOCK_REALTIME, &te);
   uint64_t stop = te.tv_sec * 1000 * 1000 * 1000 + te.tv_nsec;
   double timeSec = (double)(stop - start) / 1000 / 1000 / 1000;
   std::cout << timeSec << " = " << (unsigned)res << "\n";
}

void c( uint32_t const * const data, uint32_t * const result ) {
   auto start = std::chrono::high_resolution_clock::now();
   uint32_t res = run( data, result );
   auto end = std::chrono::high_resolution_clock::now();
   std::cout << std::chrono::duration< double, std::milli >( end -start ).count() << " = " << (unsigned)res << "\n";
}
 */
#endif //GENERAL_CLOCK_H
