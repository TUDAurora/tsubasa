/**
 * author: Patrick Damme
 */

#ifndef BENCHMARKFRAMEWORK_UTILS_H
#define	BENCHMARKFRAMEWORK_UTILS_H

#include <string>

#include <cinttypes>
#include <cstddef>

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 
    
// TODO this also exists in Algos/general/utils.h
inline size_t roundUpDiv(size_t top, size_t bottom) {
    return (top + bottom - 1) / bottom;
}

inline char boolToChar(bool b) {
    return b ? '1' : '0';
}

std::string okStr(bool ok);

std::string okSizesStr(size_t expected, size_t found, bool ok);

std::string okCanaryStr(bool ok, uint32_t expected, uint32_t found);

inline std::string yesNoStr(bool b) {
    return b ? "yes" : "no";
}

inline std::string everythingOkStr(bool everythingOk) {
    return everythingOk ? "everything ok" : "something was not ok";
}

// TODO this method seems to be unused
inline double speedInMis(size_t sizeOrig, size_t cntIterations, double duration) {
    return static_cast<double>(sizeOrig) * cntIterations / duration / 1000000;
}

// TODO this method seems to be unused
inline float getPercent(size_t part, size_t whole) {
    return static_cast<float>(part) / whole * 100;
}

const char* datetimeStr();

inline uint32_t minValueBw(size_t bw) {
    return (bw == 1) ? 0 : static_cast<uint32_t>(static_cast<uint64_t>(1) << (bw - 1));
}

inline uint32_t maxValueBw(size_t bw) {
    return static_cast<uint32_t>((static_cast<uint64_t>(1) << bw) - 1);
}

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework

#endif	/* BENCHMARKFRAMEWORK_UTILS_H */

