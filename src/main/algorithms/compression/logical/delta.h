/**
 * @file delta.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_DELTA_H
#define GENERAL_DELTA_H

#include <string>
#include "../compression.h"

namespace dbtud { namespace nec { namespace main { namespace compression {
   template<typename T>
   class delta_compression : public compression<T> {
   public:
      virtual std::string get_name( void ) const override { return std::string{ "Delta Compression" };}
      virtual void operator()
         (T const *const data, std::size_t const data_count, T *const result, std::size_t const result_count)
      const override {
         result[0] = data[0];
         for (std::size_t position = 1; position < data_count; ++position) {
            result[position] = data[position] - data[position - 1];
         }
      }
   };

   template<typename T>
   class delta_decompression : public decompression<T> {
   public:
      virtual std::string get_name( void ) const override { return std::string{ "Delta Decompression" };}
      virtual void operator()
         (T const *const data, std::size_t const data_count, T *const result, std::size_t const result_count)
      const override {
         result[0] = data[0];
         for (std::size_t position = 1; position < data_count; ++position) {
            result[position] = data[position] + data[position + 1];
         }
      }
   };

   template<typename T>
   class delta_validator : public validator<T> {
   public:
      virtual std::string get_name( void ) const override { return std::string{ "Delta Validator" };}
      virtual bool operator()
         (T const *const data, std::size_t const data_count)
      const override {
         T *result_compression = reinterpret_cast< T * >( malloc(data_count * sizeof(T)));
         T *result_decompression = reinterpret_cast< T * >( malloc(data_count * sizeof(T)));
         delta_compression<T> compr;
         delta_decompression<T> decompr;
         compr(data, data_count, result_compression);
         decompr(result_compression, data_count, result_decompression);
         bool result = true;
         for (std::size_t position = 0; position < data_count; ++position) {
            if (data[position] != result_decompression[position]) {
               result = false;
               break;
            }
         }
         free(reinterpret_cast< void * >( result_decompression ));
         free(reinterpret_cast< void * >( result_compression ));
         return result;
      }
   };
}}}}
#endif //GENERAL_DELTA_H
