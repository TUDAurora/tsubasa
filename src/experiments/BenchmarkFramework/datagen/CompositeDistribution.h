/**
 * author: Patrick Damme
 */

#ifndef COMPOSITEDISTRIBUTION_H
#define COMPOSITEDISTRIBUTION_H

#include "RandomDistribution.h"

#include <string>
#include <vector>

#include <cinttypes>
#include <cstddef>

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

    /**
     * This class helps in making more complex distributions from "simple"
     * distributions. To generate a value, it first draws a random number x 
     * from its chooser-distribution. Then, it uses its x-th sub-distribution
     * to actually generate the new value.
     */
class CompositeDistribution : public RandomDistribution {
    std::vector<RandomDistribution*> distrs;
    RandomDistribution* chooser;
    uint32_t minValue;
    uint32_t maxValue;
    
public:
    CompositeDistribution(std::vector<RandomDistribution*> distrs, RandomDistribution* chooser);
    
    uint32_t getRndValue();
    
    uint32_t getMinValue() const {
        return minValue;
    }
    
    uint32_t getMaxValue() const {
        return maxValue;
    }
    
    std::string getName() const {
        return "ComplexDistribution";
    }
    
    void setProperty(int key, size_t value);
    
    std::string getPropertyName(int key) const;
    
    static const std::string DISTR;
    static const size_t COUNT_DISTRS;
    static const std::string CHOOSER;
    static const std::string NAME_AL;
};

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework

#endif /* COMPOSITEDISTRIBUTION_H */

