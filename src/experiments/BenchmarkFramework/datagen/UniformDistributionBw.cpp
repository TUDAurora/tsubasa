/**
 * author: Patrick Damme
 */

#include "UniformDistributionBw.h"

#include "../general/utils.h"

#include <stdexcept>
#include <string>

#include <cstddef>

using namespace std;

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

UniformDistributionBw::UniformDistributionBw(size_t bw) : 
UniformDistribution<false>(minValueBw(bw), maxValueBw(bw)) {
    checkBw(bw);
}

void UniformDistributionBw::checkBw(size_t bw) {
    if(bw < 1 || bw > 32)
        throw runtime_error("bw must be in [1, 32]");
}

void UniformDistributionBw::setBw(size_t bw) {
    checkBw(bw);
    // we first set max to avoid the case that min > max
    // TODO does not work if bw is decreased
    setMaxInclusive(maxValueBw(bw));
    setMinInclusive(minValueBw(bw));
}

void UniformDistributionBw::setProperty(int key, size_t value) {
    switch(key) {
        case KEY_BW:
            setBw(value);
            break;
        default:
            throw "illegal key";
    }
}

std::string UniformDistributionBw::getPropertyName(int key) const {
    switch(key) {
        case KEY_BW:
            return "bw";
        default:
            throw "illegal key";
    }
}

const std::string UniformDistributionBw::NAME_AL = "rnduniformbw";
const std::string UniformDistributionBw::BW = "bw";

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework