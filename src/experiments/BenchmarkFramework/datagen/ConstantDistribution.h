/**
 * author: Patrick Damme
 */

#ifndef CONSTANTDISTRIBUTION_H
#define	CONSTANTDISTRIBUTION_H

#include "RandomDistribution.h"

#include <string>

#include <cinttypes>
#include <cstddef>

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

    /**
     * This random distribution always returns the same value.
     */
class ConstantDistribution : public RandomDistribution {
    uint32_t value;
    
public:
    enum propertyKey{
        KEY_VALUE
    };
    
    ConstantDistribution(uint32_t value) {
        this->value = value;
    }
    
    uint32_t getRndValue() {
        return value;
    }
    
    uint32_t getMinValue() const {
        return value;
    }
    
    uint32_t getMaxValue() const {
        return value;
    }
    
    void setValue(uint32_t value) {
        this->value = value;
    }
    
    std::string getName() const {
        return "ConstantDistribution";
    }
    
    void setProperty(int key, size_t value);
    
    std::string getPropertyName(int key) const;
    
    static const std::string VALUE;
    static const std::string NAME_AL;
};

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework

#endif	/* CONSTANTDISTRIBUTION_H */

