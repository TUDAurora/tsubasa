/**
 * @file hash_set.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_HASH_SET_H
#define GENERAL_HASH_SET_H

#include "../../algorithms/hash/murmur3.h"
#include "../../../utils/vector.h"

template< typename T >
class const_sized_basic_histogramm {
   private:
      T           const ElementCount;
      T           const LoadFactor;
      T           const container_size;
      T           const container_infinity_value;
      size_t            container_distinct_count;
      T        *  const key_container;
      uint64_t *  const key_count_container;
      murmur3< T > const     hash_fn;
   public:
      const_sized_basic_histogramm( uint32_t _ElemCount, uint32_t _LoadFactor):
         ElementCount{ _ElemCount },
         LoadFactor{ _LoadFactor },
         container_size{ ElementCount * 100 / LoadFactor },
         container_infinity_value{ container_size + 1 },
         container_distinct_count{ 0 },
         key_container{ new T[ container_size ]( ) },
         key_count_container{ new uint64_t[ container_size ]( ) } {
//         std::cout << "HASHED_HISTO: LF = " << LoadFactor << "\nCONTAINERSIZE = " << container_size << "\nELEMCOUNT = " << ElementCount << "\n";
      }
      virtual ~const_sized_basic_histogramm( void ) noexcept {
         delete[ ] key_count_container;
         delete[ ] key_container;
      }
      T * get_key_container( void ) const noexcept {
         return key_container;
      }
      T get_size( void ) const noexcept {
         return container_size;
      }
      size_t get_count( void ) const noexcept {
         size_t result = 0;
         for( size_t position = 0; position < container_size; ++position ) {
            result += ( size_t ) key_count_container[ position ];
         }
         return result;
      }
      size_t key_count( void ) const noexcept {
         size_t result = 0;
         for( size_t position = 0; position < container_size; ++position ) {
            if( key_container[ position ] != 0 )
               ++result;
         }
         return result;
      }
      void build_scalar_elem( T const * const keys ) noexcept {
         T key, hashed_position, offset_zero, offset_equal, idx_zero, idx_equal;
         bool found;

#pragma _NEC novector
         for( size_t keys_position = 0; keys_position < ElementCount; ++keys_position ) {
            key = keys[ keys_position ];
            hashed_position = hash_fn( key );
            found = false;
#pragma _NEC novector
            for( offset_zero = 0; offset_zero < container_size; offset_zero++ ) {
               idx_zero = ( hashed_position + offset_zero ) % container_size;
               if( key_container[ idx_zero ] == 0 ) {
                  break;
               }
            }

#pragma _NEC novector
            for( offset_equal = 0; offset_equal < offset_zero; offset_equal++ ) {
               idx_equal = ( hashed_position + offset_equal ) % container_size;
               if( key_container[ idx_equal ] == key ) {
                  found = true;
                  break;
               }
            }
            size_t idx = idx_equal;

            if( !found ) {
               key_container[ idx_zero ] = key;
               idx = idx_zero;
               ++container_distinct_count;
            }
            key_count_container[ idx ]++;
         }
      }
      void build_vectorized_elem( T const * const keys ) noexcept {
         T key, hashed_position, offset_zero, offset_equal, idx_zero, idx_equal;
         bool found;

         for( size_t keys_position = 0; keys_position < ElementCount; ++keys_position ) {
            key = keys[ keys_position ];
            hashed_position = hash_fn( key );
            found = false;
            for( offset_zero = 0; offset_zero < container_size; offset_zero++ ) {
               idx_zero = ( hashed_position + offset_zero ) % container_size;
               if( key_container[ idx_zero ] == 0 ) {
                  break;
               }
            }
            for( offset_equal = 0; offset_equal < offset_zero; offset_equal++ ) {
               idx_equal = ( hashed_position + offset_equal ) % container_size;
               if( key_container[ idx_equal ] == key ) {
                  found = true;
                  break;
               }
            }
            size_t idx = idx_equal;

            if( !found ) {
               key_container[ idx_zero ] = key;
               idx = idx_zero;
               ++container_distinct_count;
            }
            key_count_container[ idx ]++;
         }
      }
      void build_scalar_batch( T const * const keys ) noexcept {
         size_t key_positions[ 256 ];
         size_t hashes_offset[ 256 ];
         size_t hashed_positions[ 256 ];
         T gathered_elements[ 256 ];
         size_t offsets[ 256 ];
#pragma _NEC novector
         for( size_t i = 0; i < 256; ++i ) {
            key_positions[ i ] = i;
            hashed_positions[ i ] = 0;
            offsets[ i ] = 0;
         }
         size_t max_position = 255;
         while( max_position < ElementCount ) {
#pragma _NEC novector
            for ( size_t i = 0; i < 256; ++i ) {
               size_t position = key_positions[ i ];
               T h1 = keys[ position ];
               // BEGIN MurMur3 32 bit
               h1 *= 0xcc9e2d51;
               h1 = ( h1 << 15 ) | ( h1 >> 17 );
               h1 *= 0x1b873593;
               h1 = ( h1 << 13 ) | ( h1 >> 19 );
               h1 = h1 * 5 + 0xe6546b64;
               h1 ^= 4;
               h1 ^= h1 >> 16;
               h1 *= 0x85ebca6b;
               h1 ^= h1 >> 13;
               h1 *= 0xc2b2ae35;
               h1 ^= h1 >> 16;
               // END MurMur3 32 bit
               hashes_offset[ i ] = h1 + offsets[ i ];
               hashed_positions[ i ] = hashes_offset[ i ] % container_size;
               gathered_elements[ i ] = key_container[ hashed_positions[ i ]];
            }
#pragma _NEC novector
            for ( size_t i = 0; i < 256; ++i ) {
               if ( gathered_elements[ i ] == 0 ) {
                  key_container[ hashed_positions[ i ]] = keys[ key_positions[ i ]];
               }
            }
#pragma _NEC novector
            for( size_t i = 0; i < 256; ++i ) {
               if( key_container[ hashed_positions[ i ] ] == keys[ key_positions[ i ] ] ) {
                  key_count_container[ hashed_positions[ i ]]++;
                  offsets[ i ] = 0;
                  key_positions[ i ] = ++max_position;
               } else {
                  offsets[ i ]++;
               }
            }
         }
         size_t processable_elements = 0;
#pragma _NEC novector
         for( size_t i = 0; i < 256; ++i ) {
            if( key_positions[ i ] < ElementCount )
               ++processable_elements;
         }
         while( processable_elements > 0 ) {
#pragma _NEC novector
            for ( size_t i = 0; i < 256; ++i ) {
               size_t position = key_positions[ i ];
               if( position < ElementCount ) {
                  T h1 = keys[ position ];
                  // BEGIN MurMur3 32 bit
                  h1 *= 0xcc9e2d51;
                  h1 = ( h1 << 15 ) | ( h1 >> 17 );
                  h1 *= 0x1b873593;
                  h1 = ( h1 << 13 ) | ( h1 >> 19 );
                  h1 = h1 * 5 + 0xe6546b64;
                  h1 ^= 4;
                  h1 ^= h1 >> 16;
                  h1 *= 0x85ebca6b;
                  h1 ^= h1 >> 13;
                  h1 *= 0xc2b2ae35;
                  h1 ^= h1 >> 16;
                  // END MurMur3 32 bit
                  hashes_offset[ i ] = h1 + offsets[ i ];
                  hashed_positions[ i ] = hashes_offset[ i ] % container_size;
                  gathered_elements[ i ] = key_container[ hashed_positions[ i ]];
               }
            }
#pragma _NEC novector
            for ( size_t i = 0; i < 256; ++i ) {
               if( key_positions[ i ] < ElementCount ) {
                  if ( gathered_elements[ i ] == 0 ) {
                     key_container[ hashed_positions[ i ]] = keys[ key_positions[ i ]];
                  }
               }
            }
#pragma _NEC novector
            for( size_t i = 0; i < 256; ++i ) {
               if( key_positions[ i ] < ElementCount ) {
                  if ( key_container[ hashed_positions[ i ]] == keys[ key_positions[ i ]] ) {
                     key_count_container[ hashed_positions[ i ]]++;
                     offsets[ i ] = 0;
                     key_positions[ i ] = ++max_position;
                  } else {
                     offsets[ i ]++;
                  }
               }
            }
            processable_elements = 0;
#pragma _NEC novector
            for( size_t i = 0; i < 256; ++i ) {
               if( key_positions[ i ] < ElementCount )
                  ++processable_elements;
            }
         }
      }
      void build_vectorized_batch( T const * const keys ) noexcept {
         size_t key_positions[ 256 ];
         size_t hashes_offset[ 256 ];
         size_t hashed_positions[ 256 ];
         T gathered_elements[ 256 ];
         size_t offsets[ 256 ];
#pragma _NEC vreg(key_positions)
#pragma _NEC vreg(gathered_elements)
         for( size_t i = 0; i < 256; ++i ) {
            key_positions[ i ] = i;
            hashed_positions[ i ] = 0;
            offsets[ i ] = 0;
         }
         size_t max_position = 255;
         while( max_position < ElementCount ) {
            for ( size_t i = 0; i < 256; ++i ) {
               size_t position = key_positions[ i ];
               T h1 = keys[ position ];
               // BEGIN MurMur3 32 bit
                  h1 *= 0xcc9e2d51;
                  h1 = ( h1 << 15 ) | ( h1 >> 17 );
                  h1 *= 0x1b873593;
                  h1 = ( h1 << 13 ) | ( h1 >> 19 );
                  h1 = h1 * 5 + 0xe6546b64;
                  h1 ^= 4;
                  h1 ^= h1 >> 16;
                  h1 *= 0x85ebca6b;
                  h1 ^= h1 >> 13;
                  h1 *= 0xc2b2ae35;
                  h1 ^= h1 >> 16;
               // END MurMur3 32 bit
               hashes_offset[ i ] = h1 + offsets[ i ];
               hashed_positions[ i ] = hashes_offset[ i ] % container_size;
               gathered_elements[ i ] = key_container[ hashed_positions[ i ]];
            }
#pragma _NEC ivdep
#pragma _NEC move
            for ( size_t i = 0; i < 256; ++i ) {
               if ( gathered_elements[ i ] == 0 ) {
                  key_container[ hashed_positions[ i ]] = keys[ key_positions[ i ]];
               }
            }
            for( size_t i = 0; i < 256; ++i ) {
               if( key_container[ hashed_positions[ i ] ] == keys[ key_positions[ i ] ] ) {
                  key_count_container[ hashed_positions[ i ]]++;
                  offsets[ i ] = 0;
                  key_positions[ i ] = ++max_position;
               } else {
                  offsets[ i ]++;
               }
            }
         }
         size_t processable_elements = 0;
         for( size_t i = 0; i < 256; ++i ) {
            if( key_positions[ i ] < ElementCount )
               ++processable_elements;
         }
         while( processable_elements > 0 ) {
            for ( size_t i = 0; i < 256; ++i ) {
               size_t position = key_positions[ i ];
               if( position < ElementCount ) {
                  T h1 = keys[ position ];
                  // BEGIN MurMur3 32 bit
                     h1 *= 0xcc9e2d51;
                     h1 = ( h1 << 15 ) | ( h1 >> 17 );
                     h1 *= 0x1b873593;
                     h1 = ( h1 << 13 ) | ( h1 >> 19 );
                     h1 = h1 * 5 + 0xe6546b64;
                     h1 ^= 4;
                     h1 ^= h1 >> 16;
                     h1 *= 0x85ebca6b;
                     h1 ^= h1 >> 13;
                     h1 *= 0xc2b2ae35;
                     h1 ^= h1 >> 16;
                  // END MurMur3 32 bit
                  hashes_offset[ i ] = h1 + offsets[ i ];
                  hashed_positions[ i ] = hashes_offset[ i ] % container_size;
                  gathered_elements[ i ] = key_container[ hashed_positions[ i ]];
               }
            }
#pragma _NEC ivdep
#pragma _NEC move
            for ( size_t i = 0; i < 256; ++i ) {
               if( key_positions[ i ] < ElementCount ) {
                  if ( gathered_elements[ i ] == 0 ) {
                     key_container[ hashed_positions[ i ]] = keys[ key_positions[ i ]];
                  }
               }
            }
//#pragma _NEC ivdep /* THIS PRODUCES AN ERROR!!!*/
            for( size_t i = 0; i < 256; ++i ) {
               if( key_positions[ i ] < ElementCount ) {
                  if ( key_container[ hashed_positions[ i ]] == keys[ key_positions[ i ]] ) {
                     key_count_container[ hashed_positions[ i ]]++;
                     offsets[ i ] = 0;
                     key_positions[ i ] = ++max_position;
                  } else {
                     offsets[ i ]++;
                  }
               }
            }
            processable_elements = 0;
            for( size_t i = 0; i < 256; ++i ) {
               if( key_positions[ i ] < ElementCount )
                  ++processable_elements;
            }
         }
      }



      uint64_t probe( T key ) const noexcept {
         size_t offset = 0;
         size_t hashed_position;
         T loaded_key;
         size_t const base_hash = hash_fn( key );
         while( offset < container_size ) {
            hashed_position = ( base_hash + offset ) % container_size;
            loaded_key = key_container[ hashed_position ];
            if( loaded_key == key )
               return hashed_position;
            ++offset;
         }
         return container_infinity_value;
      }
      uint64_t probe_count_vectorized( T key ) const noexcept {
         size_t offset = 0;
         size_t hashed_position;
         T loaded_key;
         T base_hash = 0xcc9e2d51 * key;
         base_hash = ( base_hash << 15 ) | ( base_hash >> 17 );
         base_hash *= 0x1b873593;
         base_hash = ( base_hash << 13 ) | ( base_hash >> 19 );
         base_hash = base_hash * 5 + 0xe6546b64;
         base_hash ^= 4;
         base_hash ^= base_hash >> 16;
         base_hash *= 0x85ebca6b;
         base_hash ^= base_hash >> 13;
         base_hash *= 0xc2b2ae35;
         base_hash ^= base_hash >> 16;
         for( offset = 0; offset < container_size; offset++ ) {
            hashed_position = ( base_hash + offset ) % container_size;
            loaded_key = key_container[ hashed_position ];
            if( loaded_key == key )
               return key_count_container[ hashed_position ];
            if( loaded_key == 0 )
               return 0;
         }
            return 0;
      }
      size_t get_count( T key ) const noexcept {
         size_t position_in_key_container = probe( key );
         if( position_in_key_container < container_infinity_value )
            return key_count_container[ position_in_key_container ];
         return 0;
      }

      size_t probe(  T const * const probe_keys, size_t const probe_keys_count,
                     T * const probe_result, T * const probe_result_count ) const noexcept {
         size_t offset;
         size_t hashed_position;
         T loaded_key;
         T key;
         size_t result_position = 0;
         for( size_t probe_key_position = 0; probe_key_position < probe_keys_count; ++probe_key_position ) {
            offset = 0;
            key = probe_keys[ probe_key_position ];
            size_t const base_hash = hash_fn( key );
            while( offset < container_size ) {
               hashed_position = ( base_hash + offset ) % container_size;
               loaded_key = key_container[ hashed_position ];
               if( loaded_key == key ) {
                  probe_result[ result_position ] = key;
                  probe_result_count[ result_position++ ] = key_count_container[ hashed_position ];
                  ++result_position;
                  break;
               } else {
                  ++offset;
               }
            }
         }
         return result_position;
      }

};


#endif //GENERAL_HASH_SET_H
