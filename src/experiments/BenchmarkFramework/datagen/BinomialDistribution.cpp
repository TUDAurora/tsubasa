/**
 * author: Patrick Damme
 */

#include "BinomialDistribution.h"

#include <chrono>
#include <random>
#include <stdexcept>
#include <string>

#include <cstddef>

using namespace std;

namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

BinomialDistribution::BinomialDistribution(size_t countTrials, size_t probNumerator, size_t probDenominator, uint32_t offset) {
    unsigned seed = std::chrono::high_resolution_clock::now().time_since_epoch().count();
    this->generator = std::default_random_engine(seed);
        
    this->countTrials = countTrials;
    this->probNumerator = probNumerator;
    this->probDenominator = probDenominator;
    this->offset = offset;
    
    initDistribution();
}

void BinomialDistribution::initDistribution() {
    // we need at least one trial
    if(countTrials == 0)
        throw runtime_error("trials must be greater than zero");
    // valid probability (numerator and denominator)
    if(probNumerator > probDenominator)
        throw runtime_error("probNumerator must not be greater than probDenominator");
    // prevent integer overflow: offset + countTrials
    if(static_cast<uint64_t>(offset) + static_cast<uint64_t>(countTrials) >= (static_cast<uint64_t>(1)<<32))
        throw runtime_error("(offset + countTrials) must be less than 0x100000000, i.e. it must not cause a 32-bit integer overflow");
    
    distribution = binomial_distribution<uint32_t>(countTrials, static_cast<double>(probNumerator) / probDenominator);
}
    
uint32_t BinomialDistribution::getRndValue() {
    return offset + distribution(generator);
}
    
void BinomialDistribution::setCountTrials(size_t countTrials) {
    this->countTrials = countTrials;
    initDistribution();
}

void BinomialDistribution::setProbNumerator(size_t probNumerator) {
    this->probNumerator = probNumerator;
    initDistribution();
}

void BinomialDistribution::setProbDenominator(size_t probDenominator) {
    this->probDenominator = probDenominator;
    initDistribution();
}

void BinomialDistribution::setOffset(uint32_t offset) {
    this->offset = offset;
    initDistribution();
}

void BinomialDistribution::setProperty(int key, size_t value) {
    switch(key) {
        case KEY_COUNTTRIALS:
            setCountTrials(value);
            break;
        case KEY_PROBNUMERATOR:
            setProbNumerator(value);
            break;
        case KEY_PROBDENOMINATOR:
            setProbDenominator(value);
            break;
        case KEY_OFFSET:
            setOffset(value);
            break;
        default:
            throw "illegal key";
    }
}

string BinomialDistribution::getPropertyName(int key) const {
    switch(key) {
        case KEY_COUNTTRIALS:
            return "trials";
        case KEY_PROBNUMERATOR:
            return "probNumerator";
        case KEY_PROBDENOMINATOR:
            return "probDenominator";
        case KEY_OFFSET:
            return "offset";
        default:
            throw "illegal key";
    }
}
    
const string BinomialDistribution::COUNTTRIALS = "trials";
const string BinomialDistribution::PROBNUMERATOR = "probnumerator";
const string BinomialDistribution::PROBDENOMINATOR = "probdenominator";
const string BinomialDistribution::OFFSET = "offset";
const string BinomialDistribution::NAME_AL = "rndbinom";

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework