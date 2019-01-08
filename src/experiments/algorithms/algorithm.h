/**
 * @file algorithm.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_ALGORITHM_H
#define GENERAL_ALGORITHM_H

#include "../../main/algorithms/algorithm.h"
namespace dbtud { namespace nec { namespace experiments {

   template< template< class > class AlgorithmFunctor >
   class algorithm {
      private:
         AlgorithmFunctor< uint8_t > byte_functor;
         AlgorithmFunctor< uint16_t > halfword_functor;
         AlgorithmFunctor< uint32_t > word_functor;
         AlgorithmFunctor< uint64_t > doubleword_functor;
         std::size_t repetition_count;
      public:
         algorithm(
            uint8_t const * const data, std::size_t const count_in_8,
            uint8_t * const result, std::size_t const count_out_8,
            std::size_t repetition = 10 ): repetition_count{ repetition }{

            std::cout << "Testing " << byte_functor.get_name() << "... " << std::flush;

         }
         void run_experiment
            ( uint8_t const * const data, std::size_t const count_in_8,
              uint8_t * const result, std::size_t const count_out_8 )
         const {
            T const * const data, std::size_t const data_count, T * const result, std::size_t const result_count
            for( std::size_t i = 0; i < repetition_count; ++i ) {
               byte_functor( data, count_in_8, result, count_out_8 );
            }
         }
   };
}}}



#endif //GENERAL_ALGORITHM_H
