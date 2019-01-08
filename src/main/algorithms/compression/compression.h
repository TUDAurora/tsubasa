/**
 * @file compression.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_COMPRESSION_H
#define GENERAL_COMPRESSION_H

#include "../algorithm.h"
namespace dbtud { namespace nec { namespace main { namespace compression {
      template<typename T>
      class compression : public algorithm< T > {
      public:
         virtual std::string get_name( void ) const = 0;
         virtual void operator()
            (T const *const data, std::size_t const data_count, T *const result, std::size_t const result_count)
         const = 0;
      };

      template<typename T>
      class decompression : public algorithm< T > {
      public:
         virtual std::string get_name( void ) const = 0;
         virtual void operator()
            (T const *const data, std::size_t const data_count, T *const result, std::size_t const result_count)
         const = 0;
      };

      template<typename T>
      class validator : public algorithm< T > {
      public:
         virtual std::string get_name( void ) const = 0;
         virtual bool operator()
            (T const *const data, std::size_t const data_count)
         const = 0;
      };
}}}}
#endif //GENERAL_COMPRESSION_H
