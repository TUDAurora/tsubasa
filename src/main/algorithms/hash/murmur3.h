/**
 * @file murmur3.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_MURMUR3_H
#define GENERAL_MURMUR3_H
/* adapted from https://github.com/PeterScott/murmur3 */
template< typename T >
class murmur3 {};

template< >
class murmur3< uint32_t > {
   private:
      uint32_t const seed;
   public:
      murmur3( void ) : seed{ 0 } { }
      murmur3( uint32_t _seed ) : seed{ _seed } { }
      inline uint32_t operator()( uint32_t const _key ) const noexcept {
         uint32_t h1 = seed;
         uint32_t k1 = _key;
         k1 *= 0xcc9e2d51;
         k1 = (k1 << 15) | (k1 >> 17);
         k1 *= 0x1b873593;
         h1 ^= k1;
         h1 = (h1 << 13) | (h1 >> 19);
         h1 = h1*5+0xe6546b64;
         h1 ^= 4;
         h1 ^= h1 >> 16;
         h1 *= 0x85ebca6b;
         h1 ^= h1 >> 13;
         h1 *= 0xc2b2ae35;
         h1 ^= h1 >> 16;
         return h1;
      }
      inline uint32_t operator()( uint32_t const _key, uint32_t const _seed ) const noexcept {
         uint32_t h1 = _seed;
         uint32_t k1 = _key;
         k1 *= 0xcc9e2d51;
         k1 = (k1 << 15) | (k1 >> 17);
         k1 *= 0x1b873593;
         h1 ^= k1;
         h1 = (h1 << 13) | (h1 >> 19);
         h1 = h1*5+0xe6546b64;
         h1 ^= 4;
         h1 ^= h1 >> 16;
         h1 *= 0x85ebca6b;
         h1 ^= h1 >> 13;
         h1 *= 0xc2b2ae35;
         h1 ^= h1 >> 16;
         return h1;
      }
};

template< >
class murmur3< uint64_t > {
   private:
      uint64_t const seed;
   public:
      murmur3( void ) : seed{ 0 } { }
      murmur3( uint64_t _seed ) : seed{ _seed } { }
      inline uint32_t operator()( uint32_t const _key ) const noexcept {
         uint32_t h1 = seed;
         uint32_t k1 = _key;
         k1 *= 0xcc9e2d51;
         k1 = (k1 << 15) | (k1 >> 17);
         k1 *= 0x1b873593;
         h1 ^= k1;
         h1 = (h1 << 13) | (h1 >> 19);
         h1 = h1*5+0xe6546b64;
         h1 ^= 4;
         h1 ^= h1 >> 16;
         h1 *= 0x85ebca6b;
         h1 ^= h1 >> 13;
         h1 *= 0xc2b2ae35;
         h1 ^= h1 >> 16;
         return h1;
      }
      inline uint32_t operator()( uint32_t const _key, uint32_t const _seed ) const noexcept {
         uint32_t h1 = _seed;
         uint32_t k1 = _key;
         k1 *= 0xcc9e2d51;
         k1 = (k1 << 15) | (k1 >> 17);
         k1 *= 0x1b873593;
         h1 ^= k1;
         h1 = (h1 << 13) | (h1 >> 19);
         h1 = h1*5+0xe6546b64;
         h1 ^= 4;
         h1 ^= h1 >> 16;
         h1 *= 0x85ebca6b;
         h1 ^= h1 >> 13;
         h1 *= 0xc2b2ae35;
         h1 ^= h1 >> 16;
         return h1;
      }
};
#endif //GENERAL_MURMUR3_H
