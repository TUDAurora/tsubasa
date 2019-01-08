/**
 * author: Patrick Damme
 */

#include "CompositeDistribution.h"

#include <algorithm>
#include <stdexcept>
#include <string>
#include <vector>

#include <cstddef>

using namespace std;

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

CompositeDistribution::CompositeDistribution(vector<RandomDistribution*> distrs, RandomDistribution* chooser) {
    if(distrs.empty())
        throw runtime_error("you must specify at least one distribution");
    if(chooser->getMaxValue() >= distrs.size())
        throw runtime_error("the chooser might generate too high values");
    
    this->distrs = distrs;
    this->chooser = chooser;
    
    minValue = -1; // the highest value
    maxValue = 0;
    for(RandomDistribution* distr : distrs) {
        minValue = min(minValue, distr->getMinValue());
        maxValue = max(maxValue, distr->getMaxValue());
    }
}
    
uint32_t CompositeDistribution::getRndValue() {
    return distrs[chooser->getRndValue()]->getRndValue();
}

void CompositeDistribution::setProperty(int key, size_t value) {
    throw "illegal key";
}

string CompositeDistribution::getPropertyName(int key) const {
    throw "illegal key";
}

// TODO ugly: due to the current state of the parser, we must limit the number
//      of sub-distributions at compile-time
const string CompositeDistribution::DISTR = "distr";
const size_t CompositeDistribution::COUNT_DISTRS = 10;
const string CompositeDistribution::CHOOSER = "chooser";
const string CompositeDistribution::NAME_AL = "rndcomp";

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework