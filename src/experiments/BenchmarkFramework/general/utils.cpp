/**
 * author: Patrick Damme
 */

#include <iomanip>
#include <string>
#include <sstream>

#include <cinttypes>
#include <cstddef>
#include <ctime>

using namespace std;


namespace DresdenDBSystemsGroup { namespace CompressionProject { namespace BenchmarkFramework { 

string okStr(bool ok) {
    return ok ? "ok" : "not ok";
}

string okSizesStr(size_t expected, size_t found, bool ok) {
    stringstream s;
    s << okStr(ok);
    if (!ok) {
        s << dec << " (expected " << expected << ", found " << found << ")";
    }
    return s.str();
}

string okCanaryStr(bool ok, uint32_t expected, uint32_t found) {
    stringstream s;
    s << okStr(ok);
    if (!ok)
        s << hex
            << " (expected 0x" << setw(8) << setfill('.') << expected
            << ", found 0x" << setw(8) << setfill('.') << found << ")";
    return s.str();
}

const char* datetimeStr() {
    time_t now = time(NULL);
    const size_t BUFSIZE = 19+1;
    char* s = new char[BUFSIZE];
    strftime(s, BUFSIZE, "%Y-%m-%d %H:%M:%S", localtime(&now));
    return s;
}

}}} // namespace DresdenDBSystemsGroup::CompressionProject::BenchmarkFramework