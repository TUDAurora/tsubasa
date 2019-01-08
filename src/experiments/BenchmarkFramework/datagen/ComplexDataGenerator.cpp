/**
 * author: Patrick Damme
 */

/*
 * The implementation variant for obtaining sorted output.
 * 
 * 0 ... output to array, qsort()
 *       -> unsorted: about the same, asc/desc: much much slower
 * 1 ... output to array, array to vector, sort vector, vector to array
 *       -> baseline
 *       -> only this variant is efficient in combination with prefix sums
 * 2 ... output to vector, sort vector, vector to array
 *       -> unsorted: slightly slower, asc/desc: about the same
 * 3 ... output to map/histogram, map to sorted array
 *       -> unsorted: much slower (but depends on the data), asc/desc: slower
 * 
 * ==> 1 seems to be the best
 */
#define SORT_VARIANT 1

/*
 * The implementation variant for applying prefix sums.
 * 
 * 0 ... calculate prefix sums in emit()
 *       -> baseline
 * 1 ... calculate prefix sums afterwards
 *       -> slightly slower
 * 
 * ==> 0 seems to be the best
 */
#define PREFIXSUM_VARIANT 0

#include "ComplexDataGenerator.h"

#include "../../BenchmarkFramework/datagen/DataGenImpossibleException.h"
#include "../../BenchmarkFramework/datagen/RandomDistribution.h"

#include <algorithm>
#if SORT_VARIANT == 3
#include <map>
#endif
#include <vector>

#include <cinttypes>
#include <cstddef>
#if SORT_VARIANT == 0
#include <cstdlib>
#elif SORT_VARIANT == 1 || SORT_VARIANT == 2
#include <cstring>
#endif

using namespace std;
using namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework;

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace DataGenerators { 

ComplexDataGenerator::ComplexDataGenerator(
        size_t countValues,
        std::vector<StreamInfo> streams,
        SortOrder sortOrder
) : DataGenerator(countValues) {
    if(streams.empty())
        throw runtime_error("you must specify at least one stream");
    
    this->streams = streams;
    nextStreamIdx = 0;
    this->sortOrder = sortOrder;
    
    applyPrefixSum = false;
    prefixSumFirstValue = 0;
}

void ComplexDataGenerator::checkIfPossible() const {
    string reason = "";
    
    uint64_t prefixSumUpperBound;
    if(applyPrefixSum) {
        // TODO this is very pessimistic and does not take the runlengths of
        //      the streams into account
        uint32_t maxPossibleValue = 0;
        for(StreamInfo stream : streams) {
            uint32_t maxPossibleValueInStream = stream.valueDistr->getMaxValue();
            if(maxPossibleValueInStream > maxPossibleValue)
                maxPossibleValue = maxPossibleValueInStream;
        }
        prefixSumUpperBound = prefixSumFirstValue + (countValues-1) * maxPossibleValue;
    }
    
    if(applyPrefixSum && sortOrder == SortOrder::SORTORDER_NONE)
        reason = "when applying prefix sums the output cannot be unsorted";
    else if(applyPrefixSum && prefixSumUpperBound >= UINT32_MAX)
        reason = "calculating the prefix sums could cause an 32-bit integer overflow";
    
    if(!reason.empty())
        throw DataGenImpossibleException(reason);
}

#if SORT_VARIANT == 0
int cmpAsc(const void* a, const void* b) {
    const uint32_t aa = *static_cast<const uint32_t*>(a);
    const uint32_t bb = *static_cast<const uint32_t*>(b);

#if 1
    // baseline
    if (aa < bb)
        return -1;
    if (aa > bb)
        return 1;
    return 0;
#else
    // slightly slower
    return (aa - bb) / abs(aa - bb);
#endif
}
int cmpDesc(const void* a, const void* b) {
    const uint32_t aa = *static_cast<const uint32_t*>(a);
    const uint32_t bb = *static_cast<const uint32_t*>(b);

#if 1
    // baseline
    if (aa > bb)
        return -1;
    if (aa < bb)
        return 1;
    return 0;
#else
    //slightly slower
    return (bb - aa) / abs(bb - aa);
#endif
}
#elif SORT_VARIANT == 2
vector<uint32_t> values;
#elif SORT_VARIANT == 3
map<uint32_t, size_t> histogram;
#endif

#if PREFIXSUM_VARIANT == 0
uint32_t lastValue;
bool emitted;
#endif

// TODO uint32_t*& out32 , as in the an-coding branch
inline void ComplexDataGenerator::emit(uint32_t* out32, uint32_t value) {
    uint32_t value2 = value;
    
#if PREFIXSUM_VARIANT == 0
    if(applyPrefixSum) {
        if(!emitted) {
            emitted = true;
            lastValue = prefixSumFirstValue - value;
        }
        value2 = lastValue + value;
        lastValue = value2;
    }
#endif
    
#if SORT_VARIANT == 0 || SORT_VARIANT == 1
    *out32++ = value2;
#elif SORT_VARIANT == 2
    values.push_back(value2);
#elif SORT_VARIANT == 3
    histogram[value2]++;
#endif
}
    
void ComplexDataGenerator::generate(uint32_t* out32) {
#if PREFIXSUM_VARIANT == 0
    emitted = false;
#endif
    
#if SORT_VARIANT == 2
    // TODO: shouldn't this only be done, if the user requested sorting?
    values.reserve(countValues);
#endif
    
    uint32_t* const initOut32 = out32;
    uint32_t* const endOut32 = out32 + countValues;
    
    // ************************************************************************
    // generate the values (respectively the deltas if specified so)
    // ************************************************************************
    
    const size_t countStreams = streams.size();
    while(out32 < endOut32) {
        StreamInfo stream = streams[nextStreamIdx];
        nextStreamIdx++;
        nextStreamIdx %= countStreams;
        if(stream.runlengthDistr == NULL) {
            emit(out32++, stream.valueDistr->getRndValue());
        }
        else {
            const uint32_t valuesLeft = endOut32 - out32;
            const size_t runlength = min(valuesLeft, stream.runlengthDistr->getRndValue());
            if(stream.onlyOneValuePerRun) {
                uint32_t value = stream.valueDistr->getRndValue();
                for(size_t i = 0; i < runlength; i++)
                    // TODO faster with some SIMD stuff?
                    emit(out32++, value);
            }
            else {
                for(size_t i = 0; i < runlength; i++)
                    emit(out32++, stream.valueDistr->getRndValue());
            }
        }
    }
    
    // ************************************************************************
    // calculate the prefix sums if specified so
    // ************************************************************************
    
#if PREFIXSUM_VARIANT == 0
    if(applyPrefixSum)
        *initOut32 = prefixSumFirstValue;
#elif PREFIXSUM_VARIANT == 1
    if(applyPrefixSum) {
        out32 = initOut32;
        *out32++ = prefixSumFirstValue;
        uint32_t sum = prefixSumFirstValue;
        while(out32 < endOut32) {
            sum += *out32;
            *out32++ = sum;
        }
    }
#endif
    
    // ************************************************************************
    // sort the output if specified so
    // ************************************************************************
    
    // Note: If the prefix sums were calculated, then the output is already
    //       sorted in ascending order.
    
#if SORT_VARIANT == 0
    if(sortOrder == SORTORDER_ASC)
        qsort(initOut32, countValues, sizeof(uint32_t), &cmpAsc);
    else if(sortOrder == SORTORDER_DESC)
        qsort(initOut32, countValues, sizeof(uint32_t), &cmpDesc);
#elif SORT_VARIANT == 1
    if(sortOrder == SORTORDER_ASC) {
        if(!applyPrefixSum) {
            vector<uint32_t> values(initOut32, initOut32 + countValues);
            sort(values.begin(), values.end());
#if 0
            // baseline
            out32 = initOut32;
            for(uint32_t v : values)
                *out32++ = v;
#else
            // slightly faster
            memcpy(initOut32, values.data(), countValues * sizeof(uint32_t));
#endif
        }
    }
    else if(sortOrder == SORTORDER_DESC) {
        if(applyPrefixSum) {
            // The output is already sorted in ascending order. Thus, we
            // simply need to reverse it.
            out32 = initOut32;
            uint32_t* endOut32 = out32 + countValues - 1;
            size_t countSwap = countValues / 2;
            for(size_t i = 0; i < countSwap; i++) {
                uint32_t help = *out32;
                *out32++ = *endOut32;
                *endOut32-- = help;
            }
        }
        else {
            vector<uint32_t> values(initOut32, initOut32 + countValues);
            sort(values.rbegin(), values.rend());
#if 0
            // baseline
            out32 = initOut32;
            for(uint32_t v : values)
                *out32++ = v;
#else
            // slightly faster
            memcpy(initOut32, values.data(), countValues * sizeof(uint32_t));
#endif
        }
    }
#elif SORT_VARIANT == 2
    if(sortOrder == SORTORDER_ASC) {
        out32 = initOut32;
        sort(values.begin(), values.end());
#if 0
        for(uint32_t v : values)
            *out32++ = v;
#else
        memcpy(initOut32, values.data(), countValues * sizeof(uint32_t));
#endif
    }
    else if(sortOrder == SORTORDER_DESC) {
        out32 = initOut32;
        sort(values.begin(), values.end());
        reverse(values.begin(), values.end());
#if 0
        for(uint32_t v : values)
            *out32++ = v;
#else
        memcpy(initOut32, values.data(), countValues * sizeof(uint32_t));
#endif
    }
#elif SORT_VARIANT == 3
    if(sortOrder == SORTORDER_ASC) {
        out32 = initOut32;
        for(auto it = histogram.begin(); it != histogram.end(); it++) {
            uint32_t value = it->first;
            size_t count = it->second;
            for(size_t i = 0; i < count; i++)
                *out32++ = value;
        }
    }
    else if(sortOrder == SORTORDER_DESC) {
        out32 = initOut32;
        for(auto it = histogram.rbegin(); it != histogram.rend(); it++) {
            uint32_t value = it->first;
            size_t count = it->second;
            for(size_t i = 0; i < count; i++)
                *out32++ = value;
        }
    }
#endif
}

void ComplexDataGenerator::setProperty(int key, size_t value) {
    switch(key) {
        case KEY_COUNTVALUES:
            setCountValues(value);
            break;
        case KEY_PREFIXSUMFIRSTVALUE:
            setPrefixSumFirstValue(value);
            break;
        default:
            throw "illegal key";
    }
}

string ComplexDataGenerator::getPropertyName(int key) const {
    switch(key) {
        case KEY_COUNTVALUES:
            return "countValues";
        case KEY_PREFIXSUMFIRSTVALUE:
            return "prefixSumFirstValue";
        default:
            throw "illegal key";
    }
}

// names used by the parser

const string ComplexDataGenerator::StreamInfo::NAME_AL = "stream";
const string ComplexDataGenerator::StreamInfo::VALUES = "values";
const string ComplexDataGenerator::StreamInfo::RUNLENGTH = "runlength";
const string ComplexDataGenerator::StreamInfo::ONLYONEVALUEPERRUN = "onevalue";

const string ComplexDataGenerator::NAME_AL = "complexgenerator";
const string ComplexDataGenerator::COUNT = "count";
const string ComplexDataGenerator::STREAM = "stream";
const size_t ComplexDataGenerator::COUNT_STREAMS = 10;
const string ComplexDataGenerator::SORTORDER = "sort";
const string ComplexDataGenerator::PREFIXSUMFIRSTVALUE = "psfv";

#undef SORT_VARIANT
#undef PREFIXSUM_VARIANT

}}} // namespace DresdenDBSystemsGroup::CompressionProject::DataGenerators