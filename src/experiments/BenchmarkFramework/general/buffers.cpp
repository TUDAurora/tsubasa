/**
 * author: Patrick Damme
 */

#include "buffers.h"

#include "utils.h"

#include <iomanip>
//#include <immintrin.h>
#include <limits>
#include <sstream>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <vector>

#include <cinttypes>
#include <cmath>
#include <cstddef>
#include <cstring>

using namespace std;
    
namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework {

unordered_map<const uint8_t*, const BufferData> bufferDataMap;

// TODO: remove this or do it correctly
// TODO more efficient, don't copy byte by byte, use SIMD etc.
void clearCache() {
    const size_t bufferSize = 12 * 1024 * 1024;
    const uint8_t* const in8 = new uint8_t[bufferSize];
    uint8_t* const out8 = new uint8_t[bufferSize];
    for(size_t i = 0; i < bufferSize; i++)
        out8[i] = in8[i];
    delete[] in8;
    delete[] out8;
}

bool checkCanary(const void* alignedPtr, uint32_t* expected, uint32_t* found) {
    const BufferData bd = bufferDataMap.at(reinterpret_cast<const uint8_t*>(alignedPtr));
    if (expected != NULL)
        *expected = bd.canaryValue;
    if (found != NULL)
        *found = *(bd.canaryPtr);
    return *(bd.canaryPtr) == bd.canaryValue;
}

void restoreCanary(const void* alignedPtr) {
    const BufferData bd = bufferDataMap.at(reinterpret_cast<const uint8_t*>(alignedPtr));
    *(bd.canaryPtr) = bd.canaryValue;
}

void freeAlignedBuffer(const void* alignedPtr) {
    const uint8_t* const unalignedPtr = bufferDataMap.at(reinterpret_cast<const uint8_t*>(alignedPtr)).unalignedPtr;
    delete[] unalignedPtr;
    bufferDataMap.erase(reinterpret_cast<const uint8_t*>(alignedPtr));
}



void printBin(uint32_t x, ostream& os, unsigned countDigits) {
    for (int i = countDigits-1; i >= 0; i--) {
        uint32_t mask = 1 << i;
        os << (((x & mask) == mask) ? "I" : ".");
        if (i % 8 == 0 && i > 0)
            os << "-";
    }
}

void printHex(uint32_t x, ostream& os) {
    // TODO use RAII to guarantee that the flags are restored
    ios::fmtflags flagsBefore = os.flags();
    os << setw(8) << setfill('.') << setiosflags(ios::right) << hex << x;
    os.flags(flagsBefore);
}

// TODO make this support different formats, e.g. bin, hex, dec depending on
//      the current format of os
//ostream& operator<<(ostream& os, const __m128i& vec) {
/*    printHex(_mm_extract_epi32(vec, 3), os);
    os << "-";
    printHex(_mm_extract_epi32(vec, 2), os);
    os << "-";
    printHex(_mm_extract_epi32(vec, 1), os);
    os << "-";
    printHex(_mm_extract_epi32(vec, 0), os);*/
//    return os;
//}

// TODO make this support different formats, e.g. bin, hex, dec depending on
//      the current format of os
//ostream& operator<<(ostream& os, const __m256i& vec) {
/*    printHex(_mm256_extract_epi32(vec, 7), os);
    os << "-";
    printHex(_mm256_extract_epi32(vec, 6), os);
    os << "-";
    printHex(_mm256_extract_epi32(vec, 5), os);
    os << "-";
    printHex(_mm256_extract_epi32(vec, 4), os);
    os << "_";
    printHex(_mm256_extract_epi32(vec, 3), os);
    os << "-";
    printHex(_mm256_extract_epi32(vec, 2), os);
    os << "-";
    printHex(_mm256_extract_epi32(vec, 1), os);
    os << "-";
    printHex(_mm256_extract_epi32(vec, 0), os);*/
//    return os;
//}

void printBuffers(
        std::vector<BufferPrintInfo> buffers,
        size_t indent,
        BufferOutputFormat format
) {
    // Assumption: One uint32_t per line for each buffer.
    
    // TODO use RAII to guarantee that the flags are restored even if an
    //      exception is thrown
    ios::fmtflags flagsBefore = cout.flags();
    
    size_t colWidth;
    size_t digitsPerByte;
    switch(format) {
        case BufferOutputFormat::binary:
            colWidth = 32 + 3;
            digitsPerByte = 8;
            break;
        case BufferOutputFormat::hexadecimal:
            colWidth = 2 + 8;
            digitsPerByte = 2;
            break;
        case BufferOutputFormat::decimal:
            colWidth = 10;
            digitsPerByte = 0;
            break;
        default:
            throw runtime_error(
                    string(__PRETTY_FUNCTION__) +
                    ": invalid output format: " + to_string(format)
            );
    }
    
    const size_t countBuffers = buffers.size();

    size_t maxCountBuffer8 = 0;
    for(unsigned bufIdx = 0; bufIdx < countBuffers; bufIdx++)
        if(buffers[bufIdx].countBuffer8 > maxCountBuffer8)
            maxCountBuffer8 = buffers[bufIdx].countBuffer8;
    // +1 due to the extra line saying that it is the end.
    const size_t maxCountLines = roundUpDiv(maxCountBuffer8, sizeof(uint32_t)) + 1;
    
    const string indentStr = string(indent, '\t');

    const string indexWord("index");
    const size_t indexColWidth = std::max(
            static_cast<size_t>(ceil(log10(maxCountLines))),
            indexWord.length()
    );
    cout << indentStr << setw(indexColWidth) << indexWord << setfill(' ') << left;
    for(unsigned i = 0; i < countBuffers; i++)
        cout << '\t' << setw(colWidth) << buffers[i].title;
    cout << endl;
    
    vector<bool> endReached(countBuffers, false);

    const char outOfBoundsChar = '#';
    for(unsigned lineIdx = 0; lineIdx < maxCountLines; lineIdx++) {
        cout << indentStr << setw(indexColWidth) << setfill(' ') << right << dec << lineIdx;
        for(unsigned bufIdx = 0; bufIdx < countBuffers; bufIdx++) {
            if(lineIdx * sizeof(uint32_t) < buffers[bufIdx].countBuffer8) {
                // We have not reached the buffer's end yet.
                
                cout << setfill('.') << right << '\t';
                size_t countRemaining8;
                if((lineIdx+1) * sizeof(uint32_t) > buffers[bufIdx].countBuffer8)
                    // The buffers end is in the current word.
                    countRemaining8 = buffers[bufIdx].countBuffer8 % sizeof(uint32_t);
                else
                    // The buffers end is beyond the current word.
                    countRemaining8 = sizeof(uint32_t);
                uint32_t value = 0;
                // Load the value bytewise in order to prevent a reading buffer
                // overflow.
                // TODO this does not belong here
                const unsigned bitsPerByte = 8;
                for(unsigned byteIdx = 0; byteIdx < countRemaining8; byteIdx++)
                    value |= buffers[bufIdx].buffer8[lineIdx*sizeof(uint32_t)+byteIdx] << (bitsPerByte*byteIdx);
                switch(format) {
                    case BufferOutputFormat::binary: {
                        for(unsigned i = 0; i < sizeof(uint32_t) - countRemaining8; i++)
                            cout << string(digitsPerByte, outOfBoundsChar) << '-';
                        printBin(value, cout, 8 * countRemaining8);
                        break;
                    }
                    case BufferOutputFormat::hexadecimal: {
                        cout
                                << "0x"
                                << string((sizeof(uint32_t) - countRemaining8) * digitsPerByte, outOfBoundsChar)
                                << setw(countRemaining8 * digitsPerByte) << hex << value;
                        break;
                    }
                    case BufferOutputFormat::decimal: {
                        unsigned countDigits = static_cast<unsigned>(ceil(log10(
                                numeric_limits<uint32_t>::max()
                                >>
                                (bitsPerByte * (sizeof(uint32_t) - countRemaining8))
                        )));
                        cout << string(colWidth-countDigits, outOfBoundsChar) << setw(countDigits) << dec << value;
                        break;
                    }
                    default:
                        throw runtime_error(
                                string(__PRETTY_FUNCTION__) +
                                ": invalid output format: " + to_string(format)
                        );
                }
            }
            else if(!endReached[bufIdx]) {
                cout << '\t' << setw(colWidth) << setfill(' ') << left << "(end)";
                endReached[bufIdx] = true;
            }
            else {
                cout << '\t';
                if((colWidth - 1) % 2 == 0)
                    for(unsigned i = 0; i < (colWidth - 1) / 2; i++)
                        cout << "_ ";
                else if((colWidth - 1) % 3 == 0)
                    for(unsigned i = 0; i < (colWidth - 1) / 3; i++)
                        cout << "_  ";
                cout << '_';
            }
        }
        cout << endl;
    }
    
    cout.flags(flagsBefore);
}

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework