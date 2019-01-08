/**
 * author: Patrick Damme
 */

#ifndef COMPLEXDATAGENERATOR_H
#define COMPLEXDATAGENERATOR_H

#include "../../BenchmarkFramework/datagen/DataGenerator.h"
#include "../../BenchmarkFramework/datagen/RandomDistribution.h"

#include <string>
#include <vector>

#include <cinttypes>
#include <cstddef>

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace DataGenerators { 

class ComplexDataGenerator : public BenchmarkFramework::DataGenerator {
public:
    struct StreamInfo {
        BenchmarkFramework::RandomDistribution* valueDistr;
        BenchmarkFramework::RandomDistribution* runlengthDistr;
        bool onlyOneValuePerRun;
        
        StreamInfo() {
            //
        }
        
        StreamInfo(
                BenchmarkFramework::RandomDistribution* valueDistr,
                BenchmarkFramework::RandomDistribution* runlengthDistr,
                bool onlyOneValuePerRun
        ) {
            this->valueDistr = valueDistr;
            this->runlengthDistr = runlengthDistr;
            this->onlyOneValuePerRun = onlyOneValuePerRun;
        }
        
        StreamInfo(const StreamInfo& other) {
            valueDistr = other.valueDistr;
            runlengthDistr = other.runlengthDistr;
            onlyOneValuePerRun = other.onlyOneValuePerRun;
        }
        
        static const std::string NAME_AL;
        static const std::string VALUES;
        static const std::string RUNLENGTH;
        static const std::string ONLYONEVALUEPERRUN;
    };
    
    enum SortOrder {
        SORTORDER_ASC, SORTORDER_DESC, SORTORDER_NONE
    };
    
private:
    std::vector<StreamInfo> streams;
    size_t nextStreamIdx;
    SortOrder sortOrder;
    
    bool applyPrefixSum;
    uint32_t prefixSumFirstValue;
    
    void emit(uint32_t* out32, uint32_t value);
    
public:
    /**
     * The keys to be used with methods setProperty() and getPropertyName().
     */
    enum propertyKey {
        KEY_COUNTVALUES,
        KEY_PREFIXSUMFIRSTVALUE
    };
    
    void setProperty(int key, size_t value);
    
    std::string getPropertyName(int key) const;
    
    ComplexDataGenerator(
            size_t countValues,
            std::vector<StreamInfo> streams,
            SortOrder sortOrder
    );
    
    void checkIfPossible() const;
    
    void generate(uint32_t* out32);
    
    std::string getName() const {
        return "ComplexDataGenerator";
    }
    
    void setCountValues(size_t countValues) {
        this->countValues = countValues;
    }
    
    void setPrefixSumFirstValue(uint32_t prefixSumFirstValue) {
        this->applyPrefixSum = true;
        this->prefixSumFirstValue = prefixSumFirstValue;
    }
    
    // names used by the parser
    static const std::string NAME_AL;
    static const std::string COUNT;
    static const std::string STREAM;
    // TODO ugly: due to the current state of the parser, we must limit the number
    //      of streams at compile-time
    static const size_t COUNT_STREAMS;
    static const std::string SORTORDER;
    static const std::string PREFIXSUMFIRSTVALUE;
};

}}} // namespace DresdenDBSystemsGroup::CompressionProject::DataGenerators

#endif /* COMPLEXDATAGENERATOR_H */

