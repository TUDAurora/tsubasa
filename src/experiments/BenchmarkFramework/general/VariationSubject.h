/**
 * author: Patrick Damme
 */

#ifndef VARIATIONSUBJECT_H
#define	VARIATIONSUBJECT_H

#include <stdexcept>
#include <string>

#include <cstddef>

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

    /**
     * Classes implementing this interface offer a general setter method for
     * assigning a value to some variable which does not need to be known at
     * compile time. This feature is used for the variation of some data
     * property during an experiment.
     */
class VariationSubject {
    std::string path;
public:
    virtual void setProperty(int key, size_t value) {
        throw std::logic_error("VariationSubject::setProperty() is not overridden by this subclass");
    }
    
    virtual std::string getPropertyName(int key) const {
        throw std::logic_error("VariationSubject::getProperty() is not overridden by this subclass");
    }
    
    void setPath(std::string p){
        this->path = p;
    }
    
    std::string getPath() const{
        return this->path;
    }
};

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework

#endif	/* VARIATIONSUBJECT_H */

