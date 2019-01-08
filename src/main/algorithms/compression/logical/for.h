/**
 * @file for.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_FOR_H
#define GENERAL_FOR_H

#include <assert.h>
#include <limits>
#include <cstddef>
#include "../compression.h"

namespace dbtud { namespace nec { namespace main { namespace compression {
   template<typename T, std::size_t FrameSize>
   class for_compression : public compression<T> {
   public:
      virtual std::string get_name( void ) const override { return std::string{ "FOR Compression" };}
      virtual void operator()
         (T const *const data, std::size_t const data_count, T *const result, std::size_t const result_count)
      const override {
#ifdef DEBUG
         assert( FrameSize < data_count );
         assert( result_count == data_count + ( data_count/FrameSize ) );
#endif
         std::size_t result_pos = 0;
         for (std::size_t frame_base = 0; frame_base < data_count; frame_base += FrameSize) {
            T min = std::numeric_limits<T>::max();
            for (std::size_t position = 0; position < FrameSize; ++position) {
               T cur = data[frame_base + position];
               if (cur < min)
                  min = cur;
            }
            result[result_pos] = min;
            ++result_pos;
            for (std::size_t position = 0; position < FrameSize; ++position) {
               result[result_pos] = data[position] - min;
               ++result_pos;
            }
         }
      }
   };

   template<typename T, std::size_t FrameSize>
   class for_decompression : public decompression<T> {
   public:
      virtual std::string get_name( void ) const override { return std::string{ "FOR Decompression" };}
      virtual void operator()
         (T const *const data, std::size_t const data_count, T *const result, std::size_t const result_count)
      const override {
         std::size_t data_position = 0;

         for (std::size_t frame_base = 0; frame_base < result_count; frame_base += FrameSize) {
            T min = data[data_position];
            ++data_position;
            for (std::size_t position = 0; position < FrameSize; ++position) {
               result[frame_base + position] = data[data_position] + min;
               ++data_position;
            }
         }
      }
   };

   template<typename T, std::size_t FrameSize>
   class for_validator : public validator<T> {
   public:
      virtual std::string get_name( void ) const override { return std::string{ "FOR Validator" };}
      virtual bool operator()
         (T const *const data, std::size_t const data_count)
      const override {
         std::size_t const result_count = data_count + (data_count / FrameSize);
         T *result_compression = reinterpret_cast< T * >( malloc(result_count * sizeof(T)));
         T *result_decompression = reinterpret_cast< T * >( malloc(data_count * sizeof(T)));
         for_compression<T, FrameSize> compr;
         for_decompression<T, FrameSize> decompr;
         compr(data, data_count, result_compression, result_count);
         decompr(result_compression, result_count, result_decompression, data_count);
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
#endif //GENERAL_FOR_H
void build( T const * const keys ) noexcept {
   size_t hashed_position;
   T key, offset;

   for( size_t keys_position = 0; keys_position < container_size; keys_position++ ) {
      offset = 0;
      key = keys[ keys_position ];
      T hashed_result = hash_fn( key );
      T container_value;
#pragma _NEC vector
      for( ; offset < container_size; offset++ ) {

         hashed_position = ( hashed_result + offset ) % container_size;
         container_value = key_container[ hashed_position ];
         if( container_value == 0 ) {
            key_container[ hashed_position ]       = key;
            key_count_container[ hashed_position ] = 1;
            ++container_distinct_count;
            break;
         } else if( container_value == keys[ keys_position ] ) {
            ++key_count_container[ hashed_position ];
            break;
         }
      }
   }
}


void build( T const * const keys ) noexcept {
   T key, hashed_position, offset_zero, offset_equal;
   bool found, empty;
   //for( size_t keys_position = 0; keys_position < container_size; ++keys_position ) {
   key = keys[ 0 ];
   hashed_position = hash_fn( key );
   found = false;
   empty = false;
   for( offset_zero = 0; offset_zero < container_size; offset_zero++ ) {
      T idx = ( hashed_position + offset_zero ) % container_size;
      if( key_container[ idx ] == 0 ) {
         break;
      }
   }
   for( offset_equal = 0; offset_equal < offset_zero; offset_equal++ ) {
      T idx = ( hashed_position + offset_zero ) % container_size;
      if( key_container[ idx ] == key ) {
         break;
      }
   }
   //}
}