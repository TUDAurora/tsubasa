/**
 * author: Patrick Damme
 */

#ifndef BINOMIALDISTRIBUTION_H
#define BINOMIALDISTRIBUTION_H

#include "RandomDistribution.h"

#include <random>
#include <string>

#include <cinttypes>
#include <cstddef>

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

    /**
     * This is a binomial distribution. It supports the number of trials and
     * the success probability of one trial as parameters. Additionally, a 
     * specified offset can be added to the generated values.
     */
class BinomialDistribution : public RandomDistribution {
    size_t countTrials;
    // We have to separate numerator and denominator, because the parser and
    // the variation feature do not support floating point numbers yet. Hence,
    // this work-around is the only way to vary the probability in a
    // fine-grained way.
    // TODO change this as soon as the parser and the variation feature support
    //      floating point numbers
    size_t probNumerator;
    size_t probDenominator;
    uint32_t offset;
    
    std::default_random_engine generator;
    std::binomial_distribution<uint32_t> distribution;
    
    void initDistribution();
    
public:
    enum propertyKey{
        KEY_COUNTTRIALS,
        KEY_PROBNUMERATOR,
        KEY_PROBDENOMINATOR,
        KEY_OFFSET
    };
    
    BinomialDistribution(size_t countTrials, size_t probNumerator, size_t probDenominator, uint32_t offset);
    
    uint32_t getRndValue();
    
    uint32_t getMinValue() const {
        return offset;
    }
    
    uint32_t getMaxValue() const {
        return offset + countTrials;
    }
    
    void setCountTrials(size_t countTrials);
    
    void setProbNumerator(size_t probNumerator);

    void setProbDenominator(size_t probDenominator);
    
    void setOffset(uint32_t offset);
    
    std::string getName() const {
        return "BinomialDistribution";
    }
    
    void setProperty(int key, size_t value);
    
    std::string getPropertyName(int key) const;
    
    static const std::string COUNTTRIALS;
    static const std::string PROBNUMERATOR;
    static const std::string PROBDENOMINATOR;
    static const std::string OFFSET;
    static const std::string NAME_AL;

};

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework

#endif /* BINOMIALDISTRIBUTION_H */

