/**
 * author: Patrick Damme
 */

#include "ConstantDistribution.h"

#include <string>

#include <cstddef>

using namespace std;

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

void ConstantDistribution::setProperty(int key, size_t value) {
    switch(key) {
        case KEY_VALUE:
            setValue(value);
            break;
        default:
            throw "illegal key";
    }
}

string ConstantDistribution::getPropertyName(int key) const {
    switch(key) {
        case KEY_VALUE:
            return "value";
        default:
            throw "illegal key";
    }
}

const string ConstantDistribution::VALUE = "value";
const string ConstantDistribution::NAME_AL = "rndconst";

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework