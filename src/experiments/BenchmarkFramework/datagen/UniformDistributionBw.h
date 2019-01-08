/**
 * author: Patrick Damme
 */

#ifndef UNIFORMDISTRIBUTIONBW_H
#define UNIFORMDISTRIBUTIONBW_H

#include "RandomDistribution.h"
#include "UniformDistribution.h"

#include <string>

#include <cinttypes>
#include <cstddef>

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

class UniformDistributionBw : public UniformDistribution<false> {
    
    void checkBw(size_t bw);
    
public:
    enum propertyKey{
        KEY_BW
    };
    
    UniformDistributionBw(size_t bw);
    
    void setBw(size_t bw);
    
    void setProperty(int key, size_t value);
    
    std::string getPropertyName(int key) const;
    
    static const std::string NAME_AL;
    static const std::string BW;
};

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework

#endif /* UNIFORMDISTRIBUTIONBW_H */

