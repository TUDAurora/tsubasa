/**
 * @file rle.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_RLE_H
#define GENERAL_RLE_H
#include <cstddef>
#include "../compression.h"
namespace dbtud { namespace nec { namespace main { namespace compression {
   template<typename T>
   class rle_compression : public compression<T> {
   public:
      virtual std::string get_name( void ) const override { return std::string{ "RLE Compression" };}
      std::size_t compress_count;

      virtual void operator()
         (T const *const data, std::size_t const data_count, T *const result, std::size_t const result_count)
      const override {
#ifdef DEBUG
         assert( result_count == 2*data_count );
#endif
         T run_value = data[0];
         std::size_t run_length = 1;
         std::size_t result_position = 0;
         T *const result_run_value = result;
         result_run_value[0] = run_value;
         T *const result_run_length = result + data_count;
         for (std::size_t position = 1; position < data_count; ++position) {
            T tmp_value = data[position];
            if (tmp_value == run_value) {
               ++run_length;
            } else {
               result_run_length[result_position] = reinterpret_cast< T >( run_length );
               run_length = 1;
               ++result_position;
               result_run_value[result_position] = tmp_value;
            }
         }
         result_run_length[result_position] = reinterpret_cast< T >( run_length );
         compress_count = result_position; //THIS IS NONSENSE, BECAUSE DA MEDOD IS CONT *FACEPALM*
      }
   };

   template<typename T>
   class rle_decompression : public decompression<T> {
   public:
      virtual std::string get_name( void ) const override { return std::string{ "RLE Decompression" };}
      virtual void operator()
         (T const *const data, std::size_t const data_count, T *const result, std::size_t const result_count)
      const override {
         T *const data_run_value = data;
         T *const data_run_length = data + data_count;
         std::size_t result_position = 0;

         for (std::size_t position = 0; position < data_count; ++position) {
            T run_value = data_run_value[position];
            T run_length = data_run_length[position];
            for (std::size_t run_i = 0; run_i < run_length; ++run_i) {
               result[result_position] = run_value;
               ++result_position;
            }
         }
      }
   };

   template<typename T>
   class rle_validator : public validator<T> {
   public:
      virtual std::string get_name( void ) const override { return std::string{ "RLE Validator" };}
      virtual bool operator()
         (T const *const data, std::size_t const data_count)
      const override {
         T *result_compression = reinterpret_cast< T * >( malloc(data_count * 2 * sizeof(T)));
         T *result_decompression = reinterpret_cast< T * >( malloc(data_count * sizeof(T)));
         rle_compression<T> compr;
         compr(data, data_count, result_compression, 2 * data_count);
         T const *const result_compression_run_length = result_compression + data_count;
         rle_decompression<T> decompr;
         decompr(result_compression, compr.compress_count, result_decompression, data_count);
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
#endif //GENERAL_RLE_H
