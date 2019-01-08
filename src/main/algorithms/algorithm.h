/**
 * @file nec_algorithm_tester.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_NEC_ALGORITHM_TESTER_H
#define GENERAL_NEC_ALGORITHM_TESTER_H

namespace dbtud { namespace nec { namespace main {
   template< typename T >
   class algorithm {
      public:
         virtual std::string get_name( void ) const = 0;
         virtual void operator()
            (T const * const data, std::size_t const data_count, T * const result, std::size_t const result_count)
         const = 0;

   };
}}}

#endif //GENERAL_NEC_ALGORITHM_TESTER_H
