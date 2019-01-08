/**
 * author: Patrick Damme
 */

#ifndef BUFFERS_H
#define	BUFFERS_H

#include <iostream>
//#include <immintrin.h>
#include <limits>
#include <algorithm>
#include <string>
#include <unordered_map>
#include <vector>

#include <cinttypes>
#include <cstddef>

// TODO couldn't we put all of these utilities to some separate header file
//      outside the framework library, so that it can easily be used in any
//      program?

// TODO this does not really belong here
#define PRINT_VAR(x) \
        std::cerr << #x << " \t" << x << std::endl;

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework {

struct BufferData {
    const uint8_t* const unalignedPtr;
    uint32_t* const canaryPtr;
    const uint32_t canaryValue;

    BufferData(const uint8_t* unalignedPtr, uint32_t* canaryPtr, uint32_t canaryValue) :
    unalignedPtr(unalignedPtr),
    canaryPtr(canaryPtr),
    canaryValue(canaryValue) {
        //
    }
};

extern std::unordered_map<const uint8_t*, const BufferData> bufferDataMap;

void clearCache();

/**
 * Allocates a 64-byte aligned buffer of count elements of type T. Note that T
 * should be one of the uint#_t types from the header <cinttypes>. Other values 
 * for T have not been tested. The buffers allocated by this function must be
 * freed by passing them to the function freeAlignedBuffer().
 * 
 * @param count The number of elements of type T the buffer shall contain.
 * @param zero whether the newly allocated buffer should be zeroed
 * @return A 64-byte aligned pointer to the newly allocated buffer.
 */
// TODO maybe parameter zero should not be true by default, because this is
//      much more inefficient then false; on the other hand, true is better for
//      correctness -> maybe there should be no default...
template<class T>
T* allocateAlignedBuffer(size_t count, bool zero = true) {
    static const size_t alignment = 64;

    const size_t count8 = /*2 * */count * sizeof(T) + alignment - 1 + sizeof(uint32_t);
    // Note that, unlike "new uint8_t[]", "new uint8_t[]()" zeroes the buffer!
    uint8_t* unalignedPtr = zero ? new uint8_t[count8]() : new uint8_t[count8];

    T* alignedPtr;
    const size_t offset = reinterpret_cast<size_t>(unalignedPtr) % alignment;
    if (offset)
        alignedPtr = reinterpret_cast<T*>(reinterpret_cast<size_t>(unalignedPtr) + (alignment - offset));
    else
        alignedPtr = reinterpret_cast<T*>(unalignedPtr);

    uint32_t* const canaryPtr = reinterpret_cast<uint32_t*>(alignedPtr + count);
    // TODO it seems like srand() is never called -> canaries are always the same,
    //      which might hide bugs (at least in the tester)
    const uint32_t canaryValue = rand();
    *canaryPtr = canaryValue;

    const BufferData bd(unalignedPtr, canaryPtr, canaryValue);
    bufferDataMap.emplace(reinterpret_cast<uint8_t*>(alignedPtr), bd);

    return alignedPtr;
}

bool checkCanary(const void* alignedPtr, uint32_t* expected = NULL, uint32_t* found = NULL);

void restoreCanary(const void* alignedPtr);

/**
 * This function must be used to free the buffers allocated by function 
 * allocateAlignedBuffer().
 * 
 * @param alignedPtr A pointer which was returned by function 
 *        allocateAlignedBuffer().
 */
void freeAlignedBuffer(const void* alignedPtr);



void printBin(uint32_t x, std::ostream& os, unsigned countDigits = std::numeric_limits<uint32_t>::digits);

void printHex(uint32_t x, std::ostream& os);

//std::ostream& operator<<(std::ostream& os, const __m128i& vec);

//std::ostream& operator<<(std::ostream& os, const __m256i& vec);

// TODO: a compact binary format would be nice: encode two bits in one
//       character for a narrower output, use some special unicode characters
enum BufferOutputFormat {
    none,
    binary,
    decimal,
    hexadecimal
};

// TODO support individual formats for each buffer, at least at the API level
// TODO optionally index columns between arbitrary buffers
// TODO allow custom column-width in digits -> makes it more reusable
typedef struct _BufferPrintInfo {
    const std::string title;
    const uint8_t* const buffer8;
    const size_t countBuffer8;
} BufferPrintInfo;
void printBuffers(
        std::vector<BufferPrintInfo> buffers,
        size_t indent,
        BufferOutputFormat format
);

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework

#endif	/* BUFFERS_H */

