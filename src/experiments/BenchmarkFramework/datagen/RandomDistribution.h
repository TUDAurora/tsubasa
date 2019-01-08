/**
 * author: Patrick Damme
 */

#ifndef RANDOMDISTRIBUTION_H
#define	RANDOMDISTRIBUTION_H

#include <string>

#include <cinttypes>

#include "../general/VariationSubject.h"

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

    /**
     * This is the superclass of all random distributions used by data 
     * generators for the generation of, e.g., values and run lengths. Most
     * subclasses are likely to be wrappers for the distributions provided in 
     * by C++11 header <random>. However, the benchmark framework requires some
     * more information which can be obtained by this class's methods.
     */
class RandomDistribution : public VariationSubject {
public:
    virtual ~RandomDistribution() {
        //
    };
    
    /**
     * @return One value generated according to this distribution.
     */
    virtual uint32_t getRndValue() = 0;
    
    /**
     * @return The smallest values that can be returned by method getRndValue().
     */
    // TODO: do we still need this method?
    virtual uint32_t getMinValue() const = 0;
    
    /**
     * @return The largest value that can be returned by method getRndValue().
     */
    // TODO: do we still need this method?
    virtual uint32_t getMaxValue() const = 0;
    
    /**
     * @return A human readable name of the random distribution.
     */
    virtual std::string getName() const = 0;
};

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework

#endif	/* RANDOMDISTRIBUTION_H */

