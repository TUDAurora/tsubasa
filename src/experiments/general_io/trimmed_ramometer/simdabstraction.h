/**
 * author: Patrick Damme
 */

#ifndef SIMDABSTRACTION_H
#define SIMDABSTRACTION_H

/**
 * This header provides three template structs which allow to use a couple of
 * important SIMD intrinsics by specifying the vector width (more precisely,
 * the vector datatype) as a template parameter. That way, algorithms using
 * these intrinsics can be implemented in a generic/template way for all vector
 * widths.
 * 
 * Throughout this file, X as a part of an identifier stands for the selected
 * vector width in bits.
 */

#if defined(__SSE4_1__) || defined(__AVX2__) || defined(__AVX512F__)
#include <immintrin.h>
#endif

#include <cstddef>
#include <cstdint>

/**
 * Load/store-mode for SIMD L/S-instructions, NONE is used for non-SIMD tasks
 * and for tasks not needing any load or store instructions.
 */
enum LSMode {
    NONE, ALIGNED, UNALIGNED, STREAM
};

size_t offset(LSMode lsMode) {
    return (lsMode == UNALIGNED) ? 1 : 0;
}

// ****************************************************************************
// Declaration of the template structs.
// ****************************************************************************

/**
 * Some simple SIMD intrinsics. The concrete intrinsic used depends only on the
 * vector width.
 */
template<typename __mXi>
struct SIMDInstrs {
    inline static __mXi set1_epi8(uint8_t val);
    inline static __mXi set1(uint32_t val);
    inline static __mXi set1(uint64_t val);
    inline static uint64_t cmpeq_epi32_mask(__mXi vec1, __mXi vec2);
    inline static __mXi or_siX(__mXi vec1, __mXi vec2);
    inline static __mXi xor_siX(__mXi vec1, __mXi vec2);
    inline static __mXi add(uint32_t dummy,__mXi vec1, __mXi vec2);
    inline static __mXi add(uint64_t dummy,__mXi vec1, __mXi vec2);
    inline static __mXi andnot_siX(__mXi vec1, __mXi vec2);
    inline static uint64_t extract_lowest_epi64(__mXi vec);
};

/**
 * SIMD intrinsics for loading. The concrete intrinsic used depends on the
 * vector width and the load/store-mode (aligned, unaligned, stream).
 */
template<typename __mXi, LSMode>
struct SIMDLoad {
    inline static __mXi load(__mXi* ptr);
};

/**
 * SIMD intrinsics for storing. The concrete intrinsic used depends on the
 * vector width and the load/store-mode (aligned, unaligned, stream).
 */
template<typename __mXi, LSMode>
struct SIMDStore {
    inline static void store(__mXi* ptr, __mXi vec);
};

// ****************************************************************************
// Definitions for 128-bit SSE
// ****************************************************************************

#ifdef __SSE4_1__
template<>
__m128i SIMDInstrs<__m128i>::set1_epi8(uint8_t val) {
    return _mm_set1_epi8(val);
}
template<>
__m128i SIMDInstrs<__m128i>::set1(uint32_t val) {
    return _mm_set1_epi32(val);
}
template<>
__m128i SIMDInstrs<__m128i>::set1(uint64_t val) {
    return _mm_set1_epi32(val);
}
template<>
uint64_t SIMDInstrs<__m128i>::cmpeq_epi32_mask(__m128i vec1, __m128i vec2) {
    return _mm_movemask_ps(_mm_castsi128_ps(_mm_cmpeq_epi32(vec1, vec2)));
}
template<>
__m128i SIMDInstrs<__m128i>::or_siX(__m128i vec1, __m128i vec2) {
    return _mm_or_si128(vec1, vec2);
}
template<>
__m128i SIMDInstrs<__m128i>::xor_siX(__m128i vec1, __m128i vec2) {
    return _mm_xor_si128(vec1, vec2);
}
template<>
__m128i SIMDInstrs<__m128i>::add(uint32_t dummy, __m128i vec1, __m128i vec2) {
    return _mm_add_epi32(vec1, vec2);
}
template<>
__m128i SIMDInstrs<__m128i>::add(uint64_t dummy, __m128i vec1, __m128i vec2) {
    return _mm_add_epi64(vec1, vec2);
}
template<>
__m128i SIMDInstrs<__m128i>::andnot_siX(__m128i vec1, __m128i vec2) {
    return _mm_andnot_si128(vec1, vec2);
}
template<>
uint64_t SIMDInstrs<__m128i>::extract_lowest_epi64(__m128i vec) {
    return _mm_extract_epi64(vec, 0);
}
template<>
__m128i SIMDLoad<__m128i, ALIGNED>::load(__m128i* ptr) {
    return _mm_load_si128(ptr);
}
template<>
__m128i SIMDLoad<__m128i, UNALIGNED>::load(__m128i* ptr) {
    return _mm_loadu_si128(ptr);
}
template<>
__m128i SIMDLoad<__m128i, STREAM>::load(__m128i* ptr) {
    return _mm_stream_load_si128(ptr);
}
template<>
void SIMDStore<__m128i, ALIGNED>::store(__m128i* ptr, __m128i vec) {
    _mm_store_si128(ptr, vec);
}
template<>
void SIMDStore<__m128i, UNALIGNED>::store(__m128i* ptr, __m128i vec) {
    _mm_storeu_si128(ptr, vec);
}
template<>
void SIMDStore<__m128i, STREAM>::store(__m128i* ptr, __m128i vec) {
    _mm_stream_si128(ptr, vec);
}
#endif

// ****************************************************************************
// Definitions for 256-bit AVX
// ****************************************************************************

#ifdef __AVX2__
template<>
__m256i SIMDInstrs<__m256i>::set1_epi8(uint8_t val) {
    return _mm256_set1_epi8(val);
}
template<>
__m256i SIMDInstrs<__m256i>::set1(uint32_t val) {
    return _mm256_set1_epi32(val);
}
template<>
__m256i SIMDInstrs<__m256i>::set1(uint64_t val) {
    return _mm256_set1_epi32(val);
}
template<>
uint64_t SIMDInstrs<__m256i>::cmpeq_epi32_mask(__m256i vec1, __m256i vec2) {
    return _mm256_movemask_ps(_mm256_castsi256_ps(_mm256_cmpeq_epi32(vec1, vec2)));
}
template<>
__m256i SIMDInstrs<__m256i>::or_siX(__m256i vec1, __m256i vec2) {
    return _mm256_or_si256(vec1, vec2);
}
template<>
__m256i SIMDInstrs<__m256i>::xor_siX(__m256i vec1, __m256i vec2) {
    return _mm256_xor_si256(vec1, vec2);
}
template<>
__m256i SIMDInstrs<__m256i>::add(uint32_t dummy, __m256i vec1, __m256i vec2) {
    return _mm256_add_epi32(vec1, vec2);
}
template<>
__m256i SIMDInstrs<__m256i>::add(uint64_t dummy, __m256i vec1, __m256i vec2) {
    return _mm256_add_epi64(vec1, vec2);
}
template<>
__m256i SIMDInstrs<__m256i>::andnot_siX(__m256i vec1, __m256i vec2) {
    return _mm256_andnot_si256(vec1, vec2);
}
template<>
uint64_t SIMDInstrs<__m256i>::extract_lowest_epi64(__m256i vec) {
    return _mm256_extract_epi64(vec, 0);
}
template<>
__m256i SIMDLoad<__m256i, ALIGNED>::load(__m256i* ptr) {
    return _mm256_load_si256(ptr);
}
template<>
__m256i SIMDLoad<__m256i, UNALIGNED>::load(__m256i* ptr) {
    return _mm256_loadu_si256(ptr);
}
template<>
__m256i SIMDLoad<__m256i, STREAM>::load(__m256i* ptr) {
    return _mm256_stream_load_si256(ptr);
}
template<>
void SIMDStore<__m256i, ALIGNED>::store(__m256i* ptr, __m256i vec) {
    _mm256_store_si256(ptr, vec);
}
template<>
void SIMDStore<__m256i, UNALIGNED>::store(__m256i* ptr, __m256i vec) {
    _mm256_storeu_si256(ptr, vec);
}
template<>
void SIMDStore<__m256i, STREAM>::store(__m256i* ptr, __m256i vec) {
    _mm256_stream_si256(ptr, vec);
}
#endif

// ****************************************************************************
// Definitions for 512-bit AVX-512
// ****************************************************************************

#ifdef __AVX512F__
template<>
__m512i SIMDInstrs<__m512i>::set1_epi8(uint8_t val) {
    return _mm512_set1_epi8(val);
}
template<>
__m512i SIMDInstrs<__m512i>::set1(uint32_t val) {
    return _mm512_set1_epi32(val);
}
template<>
__m512i SIMDInstrs<__m512i>::set1(uint64_t val) {
    return _mm512_set1_epi32(val);
}
template<>
uint64_t SIMDInstrs<__m512i>::cmpeq_epi32_mask(__m512i vec1, __m512i vec2) {
    return _mm512_cmpeq_epi32_mask(vec1, vec2);
}
template<>
__m512i SIMDInstrs<__m512i>::or_siX(__m512i vec1, __m512i vec2) {
    return _mm512_or_si512(vec1, vec2);
}
template<>
__m512i SIMDInstrs<__m512i>::xor_siX(__m512i vec1, __m512i vec2) {
    return _mm512_xor_si512(vec1, vec2);
}
template<>
__m512i SIMDInstrs<__m512i>::add(uint32_t dummy, __m512i vec1, __m512i vec2) {
    return _mm512_add_epi32(vec1, vec2);
}
template<>
__m512i SIMDInstrs<__m512i>::add(uint64_t dummy, __m512i vec1, __m512i vec2) {
    return _mm512_add_epi64(vec1, vec2);
}
template<>
__m512i SIMDInstrs<__m512i>::andnot_siX(__m512i vec1, __m512i vec2) {
    return _mm512_andnot_si512(vec1, vec2);
}
template<>
uint64_t SIMDInstrs<__m512i>::extract_lowest_epi64(__m512i vec) {
    return _mm_extract_epi64(_mm512_extracti32x4_epi32(vec, 0), 0);
}
template<>
__m512i SIMDLoad<__m512i, ALIGNED>::load(__m512i* ptr) {
    return _mm512_load_si512(ptr);
}
template<>
__m512i SIMDLoad<__m512i, UNALIGNED>::load(__m512i* ptr) {
    return _mm512_loadu_si512(ptr);
}
template<>
__m512i SIMDLoad<__m512i, STREAM>::load(__m512i* ptr) {
    return _mm512_stream_load_si512(ptr);
}
template<>
void SIMDStore<__m512i, ALIGNED>::store(__m512i* ptr, __m512i vec) {
    _mm512_store_si512(ptr, vec);
}
template<>
void SIMDStore<__m512i, UNALIGNED>::store(__m512i* ptr, __m512i vec) {
    _mm512_storeu_si512(ptr, vec);
}
template<>
void SIMDStore<__m512i, STREAM>::store(__m512i* ptr, __m512i vec) {
    _mm512_stream_si512(ptr, vec);
}
#endif

#endif /* SIMDABSTRACTION_H */