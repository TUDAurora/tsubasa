/**
 * author: Patrick Damme
 */

#ifndef DATAGENERATOR_H
#define	DATAGENERATOR_H

#include "../general/VariationSubject.h"

#include <string>

#include <cinttypes>
#include <cstddef>

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

    /**
     * This is the superclass of all data generators that can be used by the
     * framework. A data generator provides the system with uncompressed data,
     * which is the source of all experiments. Note that currently, the 
     * uncompressed data is assumed to be a sequence of (unsigned) 32-bit
     * integers (uint32_t). 
     * The only information about the data which all data generators must be 
     * able to provide is the total number of uncompressed values. Beyond this, 
     * subclasses might offer various parameters for determining how the data 
     * is generated.
     */
class DataGenerator : public VariationSubject {
protected:
    /**
     * The total number of uncompressed values.
     */
    size_t countValues;
    
public:
    DataGenerator(size_t countValues) {
        this->countValues = countValues;
    }
    
    /**
     * Checks if data generation is possible with the current configuration of 
     * the parameters of this data generator. Note that certain combinations of
     * parameters might conflict with each other (see class SimpleDataGenerator
     * for examples).
     * If data generation is not possible, this method throws an instance of
     * class DataGenImpossibleException. Otherwise, it returns normally.
     */
    virtual void checkIfPossible() const = 0;
    
    // TODO: cannot this be a const member function, too? (see DefaultDataGenerator and SimpleDataGenerator)
    //       if so, then some function parameters of type DataGenerator& could be const, too (e.g., Evaluator::executeDataGen)
    /**
     * Generates uncompressed data according to the configuration of the
     * parameters of this data generator.
     * 
     * @param out32 A pointer to the first element of the output array.
     */
    virtual void generate(uint32_t* out32) = 0;
    
    // TODO this method is not needed any more -> can be removed from the
    //      interface, open question: should we also remove the implementation
    //      in SimpleDataGenerator or could it be useful again?
#if 0
    /**
     * Checks whether some given data has the properties specified by the 
     * configuration of the parameters of this data generator. This method can
     * be used to verify that the data generation was correct.
     * If the given data does not exhibit the expected properties, an instance
     * of class DataPropertyViolationException is thrown. Otherwise, this
     * method returns normally.
     * 
     * @param data32 A pointer to the first element of the array containing the
     *        (already existing) data to be checked.
     * @param countData32 The number of elements in data32.
     */
    virtual void checkComplies(const uint32_t* data32, size_t countData32) const = 0;
#endif
    
    /**
     * Return a nice human readable name of this data generator. Usually, the
     * class name should be ok.
     * 
     * @return A human readable name of this data generator.
     */
    virtual std::string getName() const = 0;
    
    /**
     * Returns the total number of values (i.e., 32-bit integers) this data 
     * generator will provide with the next call to method generate(). This 
     * value can be used to allocate a sufficiently large buffer for the data
     * to be generated.
     * 
     * @return The total number of values this data generator will produce.
     */
    size_t getCountValues() const {
        return countValues;
    }
};

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework

#endif	/* DATAGENERATOR_H */

