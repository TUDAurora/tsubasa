/**
 * author: Patrick Damme
 */

#include "simdabstraction.h"
#include "stopwatch.h"
#include "tasks.h"
#include "utils.h"
#include "../../../main/utils/literals.h"

#if defined(__SSE4_1__) || defined(__AVX2__) || defined(__AVX512F__)
#include <immintrin.h>
#endif
#include <iomanip>
#include <iostream>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <vector>

#include <cstdint>
#include <cstddef>

using namespace std;

void printLine(const TaskVariant* tv, const string& lineType, double durationSec, size_t countBuf8, const string& colEnd, size_t* colW) {
    const size_t BITS_PER_BYTE = 8;
    cout 
            << setw(colW[ 0]) << right << countBuf8 << colEnd
            << setw(colW[ 1]) << left << tv->taskStr() << colEnd
            << setw(colW[ 2]) << left << tv->methodStr() << colEnd
            << setw(colW[ 3]) << left << tv->loadModeStr() << colEnd
            << setw(colW[ 4]) << left << tv->storeModeStr() << colEnd
            << setw(colW[ 5]) << right << tv->get_elementSizeBytes() << colEnd
            << setw(colW[ 6]) << right << tv->get_elementSizeBytes() * BITS_PER_BYTE << colEnd
            << setw(colW[ 7]) << right << tv->get_vectorSizeBytes() << colEnd
            << setw(colW[ 7]) << left << tv->bitwidth() << colEnd
            << setw(colW[ 8]) << left << lineType << colEnd
            << setw(colW[ 9]) << right << durationSec << colEnd
            << setw(colW[10]) << right << speedMis(countBuf8, durationSec) << colEnd
            << setw(colW[11]) << right << speedMiBytePerSec(countBuf8, durationSec) << colEnd
            << setw(colW[12]) << right << speedGiBytePerSec(countBuf8, durationSec) << colEnd
            << endl;
}

void printHelpAndExit(const string& execName) {
    cout
            << "Usage" << endl
            << '\t' << execName << " <int countRepetitions> <int{,int} bufferSizeBytes> <t(ab-separated)|h(uman readable)>" << endl
            << "\tPlease also read README.txt" << endl
            << "Examples" << endl
            << '\t' << execName << " 3 1mi,512mi,1gi h" << endl
            << "\tRepeats all measurement 3 times and produces nicely formatted output. First all task variants are executed on buffers of size 1 MiByte, then 512 MiByte, then 1 GiByte." << endl
            << endl
            << '\t' << execName << " 10 1mi,2mi,4mi,8mi,16mi,32mi,64mi,128mi,256mi,512mi,1gi,2gi t > out.tsv" << endl
            << "\tRepeats all measurements 10 times and outputs a tsv-file to out.tsv. The buffer size starts at 1 MiByte and is doubled until it reaches 2 GiByte."
            << endl;
    exit(EXIT_FAILURE);
}

int main(int argc, char** argv) {
    if(argc != 4)
        printHelpAndExit(argv[0]);

    // Parsing the command line arguments.
    size_t countRepetitions;
    vector<uint64_t> bufferSizesBytes{ 16_KB, 32_KB, 512_KB, 1_MB, 4_MB, 8_MB, 16_MB, 32_MB, 128_MB, 1_GB, 4_GB, 8_GB };
    vector< uint64_t >oldstuff;
    bool tsvOutput;
    try {
        unsigned nextArg = 1;
        countRepetitions = parseIntWithSuffix(argv[nextArg++]);
        oldstuff = parseIntList(argv[nextArg++]);
        if(strlen(argv[nextArg]) != 1)
            throw invalid_argument("unknown output mode: \"" + string(argv[nextArg]) + '"');
        else if(argv[nextArg][0] == 't')
            tsvOutput = true;
        else if(argv[nextArg][0] == 'h')
            tsvOutput = false;
        else
            throw invalid_argument("unknown output mode: \"" + string(argv[nextArg]) + '"');
        nextArg++;
    }
    catch(const exception& ex) {
        cout
                << "Exception while parsing the command line arguments" << endl
                << '\t' << ex.what() << endl;
        printHelpAndExit(argv[0]);
    }
    
    // Some stuff regarding the output.
    const string INDIVIDUAL("ind");
    const string AVG("AVG");
    
    string colEnd = tsvOutput ? "\t" : "   ";
    size_t colW[] = {18, 10, 6, 11, 11, 14, 13, 15, 8, 7, 12, 11, 16, 16 };
    if(tsvOutput)
        for(unsigned i = 0; i < 12; i++)
            colW[i] = 0;
    
    // Output headline.
    cout
            << left
            << setw(colW[ 0]) << "buffer size [Byte]" << colEnd
            << setw(colW[ 1]) << "task" << colEnd
            << setw(colW[ 2]) << "method" << colEnd
            << setw(colW[ 3]) << "load mode" << colEnd
            << setw(colW[ 4]) << "store mode" << colEnd
            << setw(colW[ 5]) << "el size [Byte]" << colEnd
            << setw(colW[ 6]) << "el size [Bit]" << colEnd
            << setw(colW[ 7]) << "vec size [Byte]" << colEnd
            << setw(colW[ 8]) << "bitwidth" << colEnd
            << setw(colW[ 9]) << (INDIVIDUAL + '/' + AVG) << colEnd
            << setw(colW[10]) << "duration [s]" << colEnd
            << setw(colW[11]) << "speed [mis]" << colEnd
            << setw(colW[12]) << "speed [MiByte/s]" << colEnd
            << setw(colW[13]) << "speed [GiByte/s]" << colEnd
            << endl;
    
    // The task variants to be executed.
    vector<TaskVariant*> tvs = {
        // Copy
#ifdef NCC_
        new CopyScalar<uint32_t>,
        new CopyScalar<uint64_t>,
#else
#   ifdef __SSE4_1__
        new CopyVector< uint8_t, __m128i, ALIGNED, ALIGNED>,
        new CopyVector< uint8_t, __m128i, UNALIGNED, UNALIGNED>,
        new CopyVector< uint8_t, __m128i, ALIGNED, STREAM>,
        new CopyVector< uint8_t, __m128i, STREAM, ALIGNED>,
        new CopyVector< uint8_t, __m128i, STREAM, STREAM>,
#   endif
#   ifdef __AVX2__
        new CopyVector< uint8_t, __m256i, ALIGNED, ALIGNED>,
        new CopyVector< uint8_t, __m256i, UNALIGNED, UNALIGNED>,
        new CopyVector< uint8_t, __m256i, ALIGNED, STREAM>,
        new CopyVector< uint8_t, __m256i, STREAM, ALIGNED>,
        new CopyVector< uint8_t, __m256i, STREAM, STREAM>,
#   endif
#   ifdef __AVX512F__
        new CopyVector< uint8_t, __m512i, ALIGNED, ALIGNED>,
        new CopyVector< uint8_t, __m512i, UNALIGNED, UNALIGNED>,
        new CopyVector< uint8_t, __m512i, ALIGNED, STREAM>,
        new CopyVector< uint8_t, __m512i, STREAM, ALIGNED>,
        new CopyVector< uint8_t, __m512i, STREAM, STREAM>,
#   endif
#endif
        // Write
#ifdef NCC_
        new WriteScalar<uint32_t>,
        new WriteScalar<uint64_t>,
#else
#   ifdef __SSE4_1__
        new WriteVector< uint8_t, __m128i, ALIGNED>,
        new WriteVector< uint8_t, __m128i, UNALIGNED>,
        new WriteVector< uint8_t, __m128i, STREAM>,
#   endif
#   ifdef __AVX2__
        new WriteVector< uint8_t, __m256i, ALIGNED>,
        new WriteVector< uint8_t, __m256i, UNALIGNED>,
        new WriteVector< uint8_t, __m256i, STREAM>,
#   endif
#   ifdef __AVX512F__
        new WriteVector< uint8_t, __m512i, ALIGNED>,
        new WriteVector< uint8_t, __m512i, UNALIGNED>,
        new WriteVector< uint8_t, __m512i, STREAM>,
#   endif
#endif
        // Compare
#ifdef NCC_
        new CompareScalar<uint32_t>,
        new CompareScalar<uint64_t>,

#else
#   ifdef __SSE4_1__
        new CompareVector< uint8_t, __m128i, ALIGNED>,
        new CompareVector< uint8_t, __m128i, UNALIGNED>,
        new CompareVector< uint8_t, __m128i, STREAM>,
#   endif
#   ifdef __AVX2__
        new CompareVector< uint8_t, __m256i, ALIGNED>,
        new CompareVector< uint8_t, __m256i, UNALIGNED>,
        new CompareVector< uint8_t, __m256i, STREAM>,
#   endif
#   ifdef __AVX512F__
        new CompareVector< uint8_t, __m512i, ALIGNED>,
        new CompareVector< uint8_t, __m512i, UNALIGNED>,
        new CompareVector< uint8_t, __m512i, STREAM>,
#   endif
#endif

// Aggregation(using bitwise OR)
#ifdef NCC_
        new AggOrScalar<uint32_t>,
        new AggOrScalar<uint64_t>,
#else
#   ifdef __SSE4_1__
        new AggOrVector< uint8_t, __m128i, ALIGNED>,
        new AggOrVector< uint8_t, __m128i, UNALIGNED>,
        new AggOrVector< uint8_t, __m128i, STREAM>,
#   endif
#   ifdef __AVX2__
        new AggOrVector< uint8_t, __m256i, ALIGNED>,
        new AggOrVector< uint8_t, __m256i, UNALIGNED>,
        new AggOrVector< uint8_t, __m256i, STREAM>,
#   endif
#   ifdef __AVX512F__
        new AggOrVector< uint8_t, __m512i, ALIGNED>,
        new AggOrVector< uint8_t, __m512i, UNALIGNED>,
        new AggOrVector< uint8_t, __m512i, STREAM>,
#   endif
#endif

// BitWeaving horizontal

#ifdef NCC_
    //         new BitWeaving_H_EQ< uint32_t, 1 >,
//         new BitWeaving_H_EQ< uint32_t, 3 >,
         new BitWeaving_H_EQ< uint32_t, 7 >,
//         new BitWeaving_H_EQ< uint32_t, 15 >,
//         new BitWeaving_H_EQ< uint32_t, 31 >,
//         new BitWeaving_H_EQ< uint64_t, 1 >,
//         new BitWeaving_H_EQ< uint64_t, 3 >,
         new BitWeaving_H_EQ< uint64_t, 7 >,
//         new BitWeaving_H_EQ< uint64_t, 15 >,
//         new BitWeaving_H_EQ< uint64_t, 31 >,
//         new BitWeaving_H_EQ< uint64_t, 63 >,

//         new BitWeaving_H_NEQ< uint32_t, 1 >,
//         new BitWeaving_H_NEQ< uint32_t, 3 >,
         new BitWeaving_H_NEQ< uint32_t, 7 >,
//         new BitWeaving_H_NEQ< uint32_t, 15 >,
//         new BitWeaving_H_NEQ< uint32_t, 31 >,
//         new BitWeaving_H_NEQ< uint64_t, 1 >,
//         new BitWeaving_H_NEQ< uint64_t, 3 >,
           new BitWeaving_H_NEQ< uint64_t, 7 >,
//         new BitWeaving_H_NEQ< uint64_t, 15 >,
//         new BitWeaving_H_NEQ< uint64_t, 31 >,
//         new BitWeaving_H_NEQ< uint64_t, 63 >,
//
//         new BitWeaving_H_LT< uint32_t, 1 >,
//         new BitWeaving_H_LT< uint32_t, 3 >,
         new BitWeaving_H_LT< uint32_t, 7 >,
//         new BitWeaving_H_LT< uint32_t, 15 >,
//         new BitWeaving_H_LT< uint32_t, 31 >,
//         new BitWeaving_H_LT< uint64_t, 1 >,
//         new BitWeaving_H_LT< uint64_t, 3 >,
         new BitWeaving_H_LT< uint64_t, 7 >,
//         new BitWeaving_H_LT< uint64_t, 15 >,
//         new BitWeaving_H_LT< uint64_t, 31 >,
//         new BitWeaving_H_LT< uint64_t, 63 >,
//
//         new BitWeaving_H_LEQ< uint32_t, 1 >,
//         new BitWeaving_H_LEQ< uint32_t, 3 >,
         new BitWeaving_H_LEQ< uint32_t, 7 >,
//         new BitWeaving_H_LEQ< uint32_t, 15 >,
//         new BitWeaving_H_LEQ< uint32_t, 31 >,
//         new BitWeaving_H_LEQ< uint64_t, 1 >,
//         new BitWeaving_H_LEQ< uint64_t, 3 >,
         new BitWeaving_H_LEQ< uint64_t, 7 >,
//         new BitWeaving_H_LEQ< uint64_t, 15 >,
//         new BitWeaving_H_LEQ< uint64_t, 31 >,
//         new BitWeaving_H_LEQ< uint64_t, 63 >,
//
//         new BitWeaving_H_GT< uint32_t, 1 >,
//         new BitWeaving_H_GT< uint32_t, 3 >,
         new BitWeaving_H_GT< uint32_t, 7 >,
//         new BitWeaving_H_GT< uint32_t, 15 >,
//         new BitWeaving_H_GT< uint32_t, 31 >,
//         new BitWeaving_H_GT< uint64_t, 1 >,
//         new BitWeaving_H_GT< uint64_t, 3 >,
         new BitWeaving_H_GT< uint64_t, 7 >,
//         new BitWeaving_H_GT< uint64_t, 15 >,
//         new BitWeaving_H_GT< uint64_t, 31 >,
//         new BitWeaving_H_GT< uint64_t, 63 >,
//
//         new BitWeaving_H_GEQ< uint32_t, 1 >,
//         new BitWeaving_H_GEQ< uint32_t, 3 >,
         new BitWeaving_H_GEQ< uint32_t, 7 >,
//         new BitWeaving_H_GEQ< uint32_t, 15 >,
//         new BitWeaving_H_GEQ< uint32_t, 31 >,
//         new BitWeaving_H_GEQ< uint64_t, 1 >,
//         new BitWeaving_H_GEQ< uint64_t, 3 >,
         new BitWeaving_H_GEQ< uint64_t, 7 >,
//         new BitWeaving_H_GEQ< uint64_t, 15 >,
//         new BitWeaving_H_GEQ< uint64_t, 31 >,
//         new BitWeaving_H_GEQ< uint64_t, 63 >,*//*

#else
#   ifdef __SSE4_1__
       new BitWeaving_H_EQ< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_EQ< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_EQ< uint32_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_EQ< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_EQ< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_EQ< uint64_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_LT< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_LT< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_LT< uint32_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_LT< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_LT< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_LT< uint64_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_GT< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_GT< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_GT< uint32_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_GT< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_GT< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_GT< uint64_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m128i, STREAM,      STREAM>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m128i, STREAM,      STREAM>,

#   endif
#   ifdef __AVX2__
       new BitWeaving_H_EQ< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_EQ< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_EQ< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_EQ< uint32_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_EQ< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_EQ< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_EQ< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_EQ< uint64_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_NEQ< uint32_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_NEQ< uint64_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_LT< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_LT< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_LT< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_LT< uint32_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_LT< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_LT< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_LT< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_LT< uint64_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_LEQ< uint32_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_LEQ< uint64_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_GT< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_GT< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_GT< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_GT< uint32_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_GT< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_GT< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_GT< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_GT< uint64_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_GEQ< uint32_t, 7, __m256i, STREAM,      STREAM>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
       new BitWeaving_H_GEQ< uint64_t, 7, __m256i, STREAM,      STREAM>,

#   endif
#   ifdef __AVX512F__
    new BitWeaving_H_EQ< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_EQ< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_EQ< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_EQ< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_EQ< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_EQ< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_EQ< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_EQ< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_EQ< uint32_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_EQ< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_EQ< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_EQ< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_EQ< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_EQ< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_EQ< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_EQ< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_EQ< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_EQ< uint64_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_NEQ< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_NEQ< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_NEQ< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_NEQ< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_NEQ< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_NEQ< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_NEQ< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_NEQ< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_NEQ< uint32_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_NEQ< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_NEQ< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_NEQ< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_NEQ< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_NEQ< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_NEQ< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_NEQ< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_NEQ< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_NEQ< uint64_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_LT< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_LT< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_LT< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_LT< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_LT< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_LT< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_LT< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_LT< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_LT< uint32_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_LT< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_LT< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_LT< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_LT< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_LT< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_LT< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_LT< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_LT< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_LT< uint64_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_LEQ< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_LEQ< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_LEQ< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_LEQ< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_LEQ< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_LEQ< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_LEQ< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_LEQ< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_LEQ< uint32_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_LEQ< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_LEQ< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_LEQ< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_LEQ< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_LEQ< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_LEQ< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_LEQ< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_LEQ< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_LEQ< uint64_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_GT< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_GT< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_GT< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_GT< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_GT< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_GT< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_GT< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_GT< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_GT< uint32_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_GT< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_GT< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_GT< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_GT< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_GT< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_GT< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_GT< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_GT< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_GT< uint64_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_GEQ< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_GEQ< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_GEQ< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_GEQ< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_GEQ< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_GEQ< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_GEQ< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_GEQ< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_GEQ< uint32_t, 7, __m512i, STREAM,      STREAM>,
    new BitWeaving_H_GEQ< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
    new BitWeaving_H_GEQ< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
    new BitWeaving_H_GEQ< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
    new BitWeaving_H_GEQ< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
    new BitWeaving_H_GEQ< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
    new BitWeaving_H_GEQ< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
    new BitWeaving_H_GEQ< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
    new BitWeaving_H_GEQ< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
    new BitWeaving_H_GEQ< uint64_t, 7, __m512i, STREAM,      STREAM>,

#   endif
#endif


    };
    
    // Determine the maximum buffer size to use.
    uint64_t maxBufferSizeBytes = 0;
    for(uint64_t bufferSizeBytes : bufferSizesBytes)
        if(bufferSizeBytes > maxBufferSizeBytes)
            maxBufferSizeBytes = bufferSizeBytes;
    
    // Allocate two buffers of that size.
    const size_t ALIGNMENT = 64;
    const size_t bufSizeAlloc = maxBufferSizeBytes + offset(UNALIGNED);
#if defined(__SSE4_1__) || defined(__AVX2__) || defined(__AVX512F__)
    uint8_t* bufSrc8 = reinterpret_cast<uint8_t*>(_mm_malloc(bufSizeAlloc, ALIGNMENT));
    uint8_t* bufDst8 = reinterpret_cast<uint8_t*>(_mm_malloc(bufSizeAlloc, ALIGNMENT));
#else
    uint8_t* bufSrc8 = new uint8_t[bufSizeAlloc];
    uint8_t* bufDst8 = new uint8_t[bufSizeAlloc];
#endif
    
    // Initialize the buffers.
    uint64_t* bufSrc64 = reinterpret_cast<uint64_t*>(bufSrc8);
    uint64_t* bufDst64 = reinterpret_cast<uint64_t*>(bufDst8);
    for(unsigned i = 0; i < bufSizeAlloc / sizeof(uint64_t); i++)
        bufSrc64[i] = bufDst64[i] = WRITE_VAL64;
    
    WallClockStopWatch sw;
    unordered_map<size_t, unordered_map<TaskVariant*, vector<double> > > durationsSec;
    // Initialize this structure with empty vectors.
    for(uint64_t bufferSizeBytes : bufferSizesBytes)
        for(TaskVariant* tv : tvs)
            durationsSec[bufferSizeBytes][tv];
    // Execute all task variants on all buffer sizes as many times as specified
    // by the user. Output all individual measurements.
    // The order of the loops was chosen to (hopefully) minimize the impact of
    // occasional "other things going on in the system" on the measurements:
    // - The repetitions are in the outermost loop, such that the measurements
    //   being averaged in the end are as far away from each other as possible
    // - The buffer size is in the middle loop, such that measurements 
    //   subsequent in a typical diagram (usually, we vary the buffer size at
    //   the x-axis) are as far away from each other as possible, which should
    //   make outliers easier to identify visually
    for ( unsigned i = 0; i < countRepetitions; i++ ) {
        for ( uint64_t bufferSizeBytes : bufferSizesBytes ) {
            size_t minireps = 1;
#ifdef NCC_
            if( bufferSizeBytes <= 1_MB )
                minireps = 100000;
            else if( bufferSizeBytes <= 16_MB )
                minireps = 10000;
            else if( bufferSizeBytes < 1_GB )
                minireps = 1000;
            else
                minireps = 100;
#else
            if( bufferSizeBytes <= 1_MB )
                minireps = 1000;
            else if( bufferSizeBytes <= 16_MB )
                minireps = 10;
            else
                minireps = 1;
#endif
            for ( TaskVariant *tv : tvs ) {
                sw.start( );
                for ( unsigned j = 0; j < minireps; ++j ) {
                    tv->doIt( bufDst8, bufSrc8, bufferSizeBytes );
                }
                sw.stop( );
                const double durationSec = sw.duration( ) / (double)minireps;
                durationsSec.at( bufferSizeBytes ).at( tv ).push_back( durationSec );
                printLine( tv, INDIVIDUAL, durationSec, bufferSizeBytes, colEnd, colW );
                sw.reset( );
            }
        }
        if ( tsvOutput )
            cerr << "Done with repetition " << ( i + 1 ) << " / " << countRepetitions << endl;
    }
    // Calculate the average measurements for all combinations of task variant
    // and buffer size. Output the averaged measurements.
    for ( uint64_t bufferSizeBytes : bufferSizesBytes )
        for ( TaskVariant *tv : tvs ) {
            double durationSecSum = 0;
            for ( double durationSec : durationsSec.at( bufferSizeBytes ).at( tv ))
                durationSecSum += durationSec;
            printLine( tv, AVG, durationSecSum / countRepetitions, bufferSizeBytes, colEnd, colW );
        }
    // Release the buffers.
#if defined(__SSE4_1__) || defined(__AVX2__) || defined(__AVX512F__)
    _mm_free(bufSrc8);
    _mm_free(bufDst8);
#else
    delete[] bufSrc8;
    delete[] bufDst8;
#endif
    
    return 0;
}