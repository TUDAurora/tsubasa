/**
 * author: Patrick Damme
 */

#ifndef UTILS_H
#define UTILS_H

/**
 * This header provides some general utilities for the tool.
 */

#include <limits>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

#include <cstddef>
#include <cstdint>

/**
 * The value both buffers are filled with in the initialization step and
 * that is written by all variants of the write task.
 * 
 * All bytes of this value must be the same!
 * 
 * The reason is that both buffers
 * must always contain the same data, no matter what tasks have already run at
 * which element size etc.. If the buffers to not contain the same data, then
 * memcmp() can return early, which distorts the measurements.
 */
const uint64_t WRITE_VAL64 = 0x4949494949494949ull;

// ****************************************************************************
// Calculations stuff
// ****************************************************************************

double speedMis(size_t count8, double durationSec) {
    return static_cast<double>(count8) / sizeof(uint32_t) / 1000000 / durationSec;
}

double speedMiBytePerSec(size_t count8, double durationSec) {
    return static_cast<double>(count8) / 1024 / 1024 / durationSec;
}

double speedGiBytePerSec(size_t count8, double durationSec) {
    return speedMiBytePerSec(count8, durationSec) / 1024;
}

// ****************************************************************************
// Parsing stuff
// ****************************************************************************

// Taken from our benchmark framework and simplified.
uint64_t parseIntWithSuffix(const std::string& input) {
    using namespace std;
    
    const size_t inputLen = input.length();
    
    if(inputLen == 0)
        throw invalid_argument("empty input to parseIntWithSuffix()");
    if(input.at(0) == '-')
        throw invalid_argument("negative numbers are not allowed: \"" + input + '"');
    
    vector<pair<string, size_t> > suffixInfos = {
        {"k", 1000},
        {"m", 1000*1000},
        {"g", 1000*1000*1000},
        {"ki", 1024},
        {"mi", 1024*1024},
        {"gi", 1024*1024*1024}
    };
    unsigned factor = 1;
    size_t suffixLen = 0;
    for(pair<string, size_t> curSuffixInfo : suffixInfos) {
        const string curSuffix = curSuffixInfo.first;
        const size_t curSuffixLen = curSuffix.length();
        if(inputLen >= curSuffixLen)
            if(!input.substr(inputLen - curSuffixLen).compare(curSuffix)) {
                factor = curSuffixInfo.second;
                suffixLen = curSuffixLen;
                break;
            }
    }
    
    const size_t digitsLen = inputLen - suffixLen;
    if(digitsLen == 0)
        throw invalid_argument("digit part of the number is empty: \"" + input + '"');
    const string digitsStr = input.substr(0, digitsLen);
    size_t pos;
    unsigned long long n;
    try {
        n = stoull(digitsStr, &pos, 10);
    }
    catch(const invalid_argument& e) {
        throw invalid_argument("invalid number \"" + input + '"');
    }
    catch(const out_of_range& e) {
        throw invalid_argument("too large integer \"" + input + '"');
    }
    
    if(pos < digitsLen)
        throw invalid_argument(string("invalid digit: \"") + digitsStr.at(pos) + "\" in \"" + input + '"');
    if(n > numeric_limits<uint64_t>::max() / factor)
        throw invalid_argument("too large integer \"" + input + '"');
    else
        return static_cast<uint64_t>(n * factor);
}

std::vector<uint64_t> parseIntList(const std::string& listStr) {
    using namespace std;
    
    vector<uint64_t> res;
    
    stringstream listStream(listStr);
    string elemStr;
    while(getline(listStream, elemStr, ','))
        res.push_back(parseIntWithSuffix(elemStr));
    
    return res;
}

#endif /* UTILS_H */