NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: simdabstraction.h

FUNCTION NAME: offset
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: simdabstraction.h

FUNCTION NAME: offset
FORMAT LIST

 LINE   LOOP      STATEMENT

    34-           size_t offset(LSMode lsMode) {
    35-               return (lsMode == UNALIGNED) ? 1 : 0;
    36-           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: utils.h

FUNCTION NAME: speedMis
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: utils.h

FUNCTION NAME: speedMis
FORMAT LIST

 LINE   LOOP      STATEMENT

    38-           double speedMis(size_t count8, double durationSec) {
    39-               return static_cast<double>(count8) / sizeof(uint32_t) / 1000000 / durationSec;
    40-           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: utils.h

FUNCTION NAME: speedMiBytePerSec
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: utils.h

FUNCTION NAME: speedMiBytePerSec
FORMAT LIST

 LINE   LOOP      STATEMENT

    42-           double speedMiBytePerSec(size_t count8, double durationSec) {
    43-               return static_cast<double>(count8) / 1024 / 1024 / durationSec;
    44-           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: utils.h

FUNCTION NAME: speedGiBytePerSec
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    47: inl(1212): Source for routine not found.: speedMiBytePerSec


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: utils.h

FUNCTION NAME: speedGiBytePerSec
FORMAT LIST

 LINE   LOOP      STATEMENT

    46-           double speedGiBytePerSec(size_t count8, double durationSec) {
    47-               return speedMiBytePerSec(count8, durationSec) / 1024;
    48-           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: utils.h

FUNCTION NAME: parseIntWithSuffix
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    61: inl(1212): Source for routine not found.: std::invalid_argument::invalid_argument
    62: inl(1212): Source for routine not found.: std::_Xout_of_range
    63: inl(1212): Source for routine not found.: std::operator +<char, std::char_traits<char>, std::allocator<char>>
    65: inl(1212): Source for routine not found.: std::forward<const std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>&>
    75: inl(1212): Source for routine not found.: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::pair
    75: vec( 103): Unvectorized loop.
    75: vec( 110): Vectorization obstructive function reference.: ~pair
    75: vec( 110): Vectorization obstructive function reference.: memcmp
    75: vec( 110): Vectorization obstructive function reference.: forward
    75: vec( 110): Vectorization obstructive function reference.: _Tidy
    75: vec( 110): Vectorization obstructive function reference.: _Copy
    75: vec( 110): Vectorization obstructive function reference.: _Xlength_error
    75: vec( 110): Vectorization obstructive function reference.: erase
    75: vec( 110): Vectorization obstructive function reference.: _Xout_of_range
    75: vec( 110): Vectorization obstructive function reference.: pair
    76: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::erase
    82: inl(1212): Source for routine not found.: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::~pair
    93: inl(1212): Source for routine not found.: strtoull
   103: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::assign
   107: inl(1212): Source for routine not found.: operator delete 
   107: vec( 103): Unvectorized loop.
   107: vec( 110): Vectorization obstructive function reference.: ~pair


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: utils.h

FUNCTION NAME: parseIntWithSuffix
FORMAT LIST

 LINE   LOOP      STATEMENT

    55-           uint64_t parseIntWithSuffix(const std::string& input) {
    56-               using namespace std;
    57-            
    58-               const size_t inputLen = input.length();
    59-            
    60-               if(inputLen == 0)
    61-                   throw invalid_argument("empty input to parseIntWithSuffix()");
    62-               if(input.at(0) == '-')
    63-                   throw invalid_argument("negative numbers are not allowed: \"" + input + '"');
    64-            
    65-               vector<pair<string, size_t> > suffixInfos = {
    66-                   {"k", 1000},
    67-                   {"m", 1000*1000},
    68-                   {"g", 1000*1000*1000},
    69-                   {"ki", 1024},
    70-                   {"mi", 1024*1024},
    71-                   {"gi", 1024*1024*1024}
    72-               };
    73-               unsigned factor = 1;
    74-               size_t suffixLen = 0;
    75- +------>      for(pair<string, size_t> curSuffixInfo : suffixInfos) {
    76- |                 const string curSuffix = curSuffixInfo.first;
    77- |                 const size_t curSuffixLen = curSuffix.length();
    78- |                 if(inputLen >= curSuffixLen)
    79- |                     if(!input.substr(inputLen - curSuffixLen).compare(curSuffix)) {
    80- |                         factor = curSuffixInfo.second;
    81- |                         suffixLen = curSuffixLen;
    82- |                         break;
    83- |                     }
    84- |             }
    85- |          
    86- +------       const size_t digitsLen = inputLen - suffixLen;
    87-               if(digitsLen == 0)
    88-                   throw invalid_argument("digit part of the number is empty: \"" + input + '"');
    89-               const string digitsStr = input.substr(0, digitsLen);
    90-               size_t pos;
    91-               unsigned long long n;
    92-               try {
    93-                   n = stoull(digitsStr, &pos, 10);
    94-               }
    95-               catch(const invalid_argument& e) {
    96-                   throw invalid_argument("invalid number \"" + input + '"');
    97-               }
    98-               catch(const out_of_range& e) {
    99-                   throw invalid_argument("too large integer \"" + input + '"');
   100-               }
   101-            
   102-               if(pos < digitsLen)
   103-                   throw invalid_argument(string("invalid digit: \"") + digitsStr.at(pos) + "\" in \"" + input + '"');
   104-               if(n > numeric_limits<uint64_t>::max() / factor)
   105-                   throw invalid_argument("too large integer \"" + input + '"');
   106-               else
   107- +======>          return static_cast<uint64_t>(n * factor);
   108-           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: utils.h

FUNCTION NAME: parseIntList
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   113: inl(1212): Source for routine not found.: std::forward<const std::allocator<unsigned long>&>
   115: inl(1212): Source for routine not found.: std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>>::basic_stringstream
   116: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
   117: inl(1212): Source for routine not found.: std::move<std::basic_istream<char, std::char_traits<char>>&>
   117: vec( 103): Unvectorized loop.
   117: vec( 110): Vectorization obstructive function reference.: push_back
   117: vec( 110): Vectorization obstructive function reference.: move
   117: vec( 110): Vectorization obstructive function reference.: getline
   117: vec( 110): Vectorization obstructive function reference.: fail
   117: vec( 110): Vectorization obstructive function reference.: parseIntWithSuffix
   118: inl(1212): Source for routine not found.: parseIntWithSuffix
   120: inl(1212): Source for routine not found.: std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>>::~basic_stringstream


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: utils.h

FUNCTION NAME: parseIntList
FORMAT LIST

 LINE   LOOP      STATEMENT

   110-           std::vector<uint64_t> parseIntList(const std::string& listStr) {
   111-               using namespace std;
   112-            
   113-               vector<uint64_t> res;
   114-            
   115-               stringstream listStream(listStr);
   116-               string elemStr;
   117- +------>      while(getline(listStream, elemStr, ','))
   118- +------           res.push_back(parseIntWithSuffix(elemStr));
   119-            
   120-               return res;
   121-           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: ramometer.cpp

FUNCTION NAME: printLine
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    28: inl(1212): Source for routine not found.: std::setw


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: ramometer.cpp

FUNCTION NAME: printLine
FORMAT LIST

 LINE   LOOP      STATEMENT

    26:           void printLine(const TaskVariant* tv, const string& lineType, double durationSec, size_t countBuf8, const string& colEnd, size_t* colW) {
    27:               const size_t BITS_PER_BYTE = 8;
    28:               cout
    29-                       << setw(colW[ 0]) << right << countBuf8 << colEnd
    30-                       << setw(colW[ 1]) << left << tv->taskStr() << colEnd
    31-                       << setw(colW[ 2]) << left << tv->methodStr() << colEnd
    32-                       << setw(colW[ 3]) << left << tv->loadModeStr() << colEnd
    33-                       << setw(colW[ 4]) << left << tv->storeModeStr() << colEnd
    34-                       << setw(colW[ 5]) << right << tv->get_elementSizeBytes() << colEnd
    35-                       << setw(colW[ 6]) << right << tv->get_elementSizeBytes() * BITS_PER_BYTE << colEnd
    36-                       << setw(colW[ 7]) << left << tv->bitwidth() << colEnd
    37-                       << setw(colW[ 8]) << left << lineType << colEnd
    38-                       << setw(colW[ 9]) << right << durationSec << colEnd
    39-                       << setw(colW[10]) << right << speedMis(countBuf8, durationSec) << colEnd
    40-                       << setw(colW[11]) << right << speedMiBytePerSec(countBuf8, durationSec) << colEnd
    41-                       << setw(colW[12]) << right << speedGiBytePerSec(countBuf8, durationSec) << colEnd
    42-                       << endl;
    43:           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: ramometer.cpp

FUNCTION NAME: printHelpAndExit
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    46: inl(1212): Source for routine not found.: std::operator <<<std::char_traits<char>>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: ramometer.cpp

FUNCTION NAME: printHelpAndExit
FORMAT LIST

 LINE   LOOP      STATEMENT

    45:           void printHelpAndExit(const string& execName) {
    46:               cout
    47-                       << "Usage" << endl
    48-                       << '\t' << execName << " <int countRepetitions> <int{,int} bufferSizeBytes> <t(ab-separated)|h(uman readable)>" << endl
    49-                       << "\tPlease also read README.txt" << endl
    50-                       << "Examples" << endl
    51-                       << '\t' << execName << " 3 1mi,512mi,1gi h" << endl
    52-                       << "\tRepeats all measurement 3 times and produces nicely formatted output. First all task variants are executed on buffers of size 1 MiByte, then 512 MiByte, then 1 GiByte." << endl
    53-                       << endl
    54-                       << '\t' << execName << " 10 1mi,2mi,4mi,8mi,16mi,32mi,64mi,128mi,256mi,512mi,1gi,2gi t > out.tsv" << endl
    55-                       << "\tRepeats all measurements 10 times and outputs a tsv-file to out.tsv. The buffer size starts at 1 MiByte and is doubled until it reaches 2 GiByte."
    56-                       << endl;
    57:               exit(EXIT_FAILURE);
    58:           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: ramometer.cpp

FUNCTION NAME: main
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    62: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
    66: inl(1212): Source for routine not found.: std::forward<const std::allocator<unsigned long>&>
    71: inl(1212): Source for routine not found.: parseIntWithSuffix
    72: inl(1212): Source for routine not found.: parseIntList
    74: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::insert
    84: inl(1212): Source for routine not found.: std::operator <<<std::char_traits<char>>
    97: vec( 103): Unvectorized loop.
    97: vec( 108): Unvectorizable loop structure.
   101: inl(1212): Source for routine not found.: std::setw
   119: inl(1212): Source for routine not found.: std::forward<const std::allocator<TaskVariant *>&>
   622: vec( 103): Unvectorized loop.
   622: vec( 108): Unvectorizable loop structure.
   628: inl(1212): Source for routine not found.: offset
   640: vec( 103): Unvectorized loop.
   640: vec( 108): Unvectorizable loop structure.
   644: inl(1212): Source for routine not found.: std::unordered_map<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::hash<unsigned long>, std::equal_to<unsigned long>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::unordered_map
   647: vec( 103): Unvectorized loop.
   647: vec( 110): Vectorization obstructive function reference.: operator[]
   648: inl(1212): Source for routine not found.: std::unordered_map<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::hash<unsigned long>, std::equal_to<unsigned long>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::operator []
   672: vec( 103): Unvectorized loop.
   672: vec( 110): Vectorization obstructive function reference.:  
   677: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::lower_bound
   678: inl(1212): Source for routine not found.: printLine
   683: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::operator <<
   688: vec( 110): Vectorization obstructive function reference.: printLine
   688: vec( 110): Vectorization obstructive function reference.: _Xout_of_range
   688: vec( 110): Vectorization obstructive function reference.: lower_bound
   690: vec( 103): Unvectorized loop.
   690: vec( 108): Unvectorizable loop structure.
   699: inl(1212): Source for routine not found.: operator delete[] 
   703: inl(1212): Source for routine not found.: std::unordered_map<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::hash<unsigned long>, std::equal_to<unsigned long>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::~unordered_map


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: ramometer.cpp

FUNCTION NAME: main
FORMAT LIST

 LINE   LOOP      STATEMENT

    60:           int main(int argc, char** argv) {
    61:               if(argc != 4)
    62:                   printHelpAndExit(argv[0]);
    63-           
    64-               // Parsing the command line arguments.
    65:               size_t countRepetitions;
    66:               vector<uint64_t> bufferSizesBytes{ 16_KB, 32_KB, 512_KB, 1_MB, 4_MB, 8_MB, 16_MB, 32_MB, 128_MB, 1_GB, 4_GB, 8_GB };
    67:               vector< uint64_t >oldstuff;
    68:               bool tsvOutput;
    69:               try {
    70:                   unsigned nextArg = 1;
    71:                   countRepetitions = parseIntWithSuffix(argv[nextArg++]);
    72:                   oldstuff = parseIntList(argv[nextArg++]);
    73:                   if(strlen(argv[nextArg]) != 1)
    74:                       throw invalid_argument("unknown output mode: \"" + string(argv[nextArg]) + '"');
    75:                   else if(argv[nextArg][0] == 't')
    76:                       tsvOutput = true;
    77:                   else if(argv[nextArg][0] == 'h')
    78:                       tsvOutput = false;
    79-                   else
    80:                       throw invalid_argument("unknown output mode: \"" + string(argv[nextArg]) + '"');
    81:                   nextArg++;
    82:               }
    83:               catch(const exception& ex) {
    84:                   cout
    85-                           << "Exception while parsing the command line arguments" << endl
    86-                           << '\t' << ex.what() << endl;
    87:                   printHelpAndExit(argv[0]);
    88:               }
    89-            
    90-               // Some stuff regarding the output.
    91:               const string INDIVIDUAL("ind");
    92:               const string AVG("AVG");
    93-            
    94:               string colEnd = tsvOutput ? "\t" : "   ";
    95:               size_t colW[] = {18, 10, 6, 11, 11, 14, 13, 8, 7, 12, 11, 16, 16 };
    96:               if(tsvOutput)
    97: +------>          for(unsigned i = 0; i < 12; i++)
    98: +------               colW[i] = 0;
    99-            
   100-               // Output headline.
   101:               cout
   102-                       << left
   103-                       << setw(colW[ 0]) << "buffer size [Byte]" << colEnd
   104-                       << setw(colW[ 1]) << "task" << colEnd
   105-                       << setw(colW[ 2]) << "method" << colEnd
   106-                       << setw(colW[ 3]) << "load mode" << colEnd
   107-                       << setw(colW[ 4]) << "store mode" << colEnd
   108-                       << setw(colW[ 5]) << "el size [Byte]" << colEnd
   109-                       << setw(colW[ 6]) << "el size [Bit]" << colEnd
   110-                       << setw(colW[ 7]) << "bitwidth" << colEnd
   111-                       << setw(colW[ 8]) << (INDIVIDUAL + '/' + AVG) << colEnd
   112-                       << setw(colW[ 9]) << "duration [s]" << colEnd
   113-                       << setw(colW[10]) << "speed [mis]" << colEnd
   114-                       << setw(colW[11]) << "speed [MiByte/s]" << colEnd
   115-                       << setw(colW[12]) << "speed [GiByte/s]" << colEnd
   116-                       << endl;
   117-            
   118-               // The task variants to be executed.
   119:               vector<TaskVariant*> tvs = {
   120-                   // Copy
   121-           #ifdef NCC_
   122-                   new CopyScalar<uint32_t>,
   123-                   new CopyScalar<uint64_t>,
   124-           #else
   125-           #   ifdef __SSE4_1__
   126-                   new CopyVector< uint8_t, __m128i, ALIGNED, ALIGNED>,
   127-                   new CopyVector< uint8_t, __m128i, UNALIGNED, UNALIGNED>,
   128-                   new CopyVector< uint8_t, __m128i, ALIGNED, STREAM>,
   129-                   new CopyVector< uint8_t, __m128i, STREAM, ALIGNED>,
   130-                   new CopyVector< uint8_t, __m128i, STREAM, STREAM>,
   131-           #   endif
   132-           #   ifdef __AVX2__
   133-                   new CopyVector< uint8_t, __m256i, ALIGNED, ALIGNED>,
   134-                   new CopyVector< uint8_t, __m256i, UNALIGNED, UNALIGNED>,
   135-                   new CopyVector< uint8_t, __m256i, ALIGNED, STREAM>,
   136-                   new CopyVector< uint8_t, __m256i, STREAM, ALIGNED>,
   137-                   new CopyVector< uint8_t, __m256i, STREAM, STREAM>,
   138-           #   endif
   139-           #   ifdef __AVX512F__
   140-                   new CopyVector< uint8_t, __m512i, ALIGNED, ALIGNED>,
   141-                   new CopyVector< uint8_t, __m512i, UNALIGNED, UNALIGNED>,
   142-                   new CopyVector< uint8_t, __m512i, ALIGNED, STREAM>,
   143-                   new CopyVector< uint8_t, __m512i, STREAM, ALIGNED>,
   144-                   new CopyVector< uint8_t, __m512i, STREAM, STREAM>,
   145-           #   endif
   146-           #endif
   147-                   // Write
   148-           #ifdef NCC_
   149-                   new WriteScalar<uint32_t>,
   150-                   new WriteScalar<uint64_t>,
   151-           #else
   152-           #   ifdef __SSE4_1__
   153-                   new WriteVector< uint8_t, __m128i, ALIGNED>,
   154-                   new WriteVector< uint8_t, __m128i, UNALIGNED>,
   155-                   new WriteVector< uint8_t, __m128i, STREAM>,
   156-           #   endif
   157-           #   ifdef __AVX2__
   158-                   new WriteVector< uint8_t, __m256i, ALIGNED>,
   159-                   new WriteVector< uint8_t, __m256i, UNALIGNED>,
   160-                   new WriteVector< uint8_t, __m256i, STREAM>,
   161-           #   endif
   162-           #   ifdef __AVX512F__
   163-                   new WriteVector< uint8_t, __m512i, ALIGNED>,
   164-                   new WriteVector< uint8_t, __m512i, UNALIGNED>,
   165-                   new WriteVector< uint8_t, __m512i, STREAM>,
   166-           #   endif
   167-           #endif
   168-                   // Compare
   169-           #ifdef NCC_
   170-                   new CompareScalar<uint32_t>,
   171-                   new CompareScalar<uint64_t>,
   172-           #else
   173-           #   ifdef __SSE4_1__
   174-                   new CompareVector< uint8_t, __m128i, ALIGNED>,
   175-                   new CompareVector< uint8_t, __m128i, UNALIGNED>,
   176-                   new CompareVector< uint8_t, __m128i, STREAM>,
   177-           #   endif
   178-           #   ifdef __AVX2__
   179-                   new CompareVector< uint8_t, __m256i, ALIGNED>,
   180-                   new CompareVector< uint8_t, __m256i, UNALIGNED>,
   181-                   new CompareVector< uint8_t, __m256i, STREAM>,
   182-           #   endif
   183-           #   ifdef __AVX512F__
   184-                   new CompareVector< uint8_t, __m512i, ALIGNED>,
   185-                   new CompareVector< uint8_t, __m512i, UNALIGNED>,
   186-                   new CompareVector< uint8_t, __m512i, STREAM>,
   187-           #   endif
   188-           #endif
   189-           
   190-                   // Aggregation(using bitwise OR)
   191-           #ifdef NCC_
   192-                   new AggOrScalar<uint32_t>,
   193-                   new AggOrScalar<uint64_t>,
   194-           #else
   195-           #   ifdef __SSE4_1__
   196-                   new AggOrVector< uint8_t, __m128i, ALIGNED>,
   197-                   new AggOrVector< uint8_t, __m128i, UNALIGNED>,
   198-                   new AggOrVector< uint8_t, __m128i, STREAM>,
   199-           #   endif
   200-           #   ifdef __AVX2__
   201-                   new AggOrVector< uint8_t, __m256i, ALIGNED>,
   202-                   new AggOrVector< uint8_t, __m256i, UNALIGNED>,
   203-                   new AggOrVector< uint8_t, __m256i, STREAM>,
   204-           #   endif
   205-           #   ifdef __AVX512F__
   206-                   new AggOrVector< uint8_t, __m512i, ALIGNED>,
   207-                   new AggOrVector< uint8_t, __m512i, UNALIGNED>,
   208-                   new AggOrVector< uint8_t, __m512i, STREAM>,
   209-           #   endif
   210-           #endif
   211-           
   212-                    // BitWeaving horizontal
   213-           #ifdef NCC_
   214-                    new BitWeaving_H_EQ< uint32_t, 1 >,
   215-                    new BitWeaving_H_EQ< uint32_t, 3 >,
   216-                    new BitWeaving_H_EQ< uint32_t, 7 >,
   217-                    new BitWeaving_H_EQ< uint32_t, 15 >,
   218-                    new BitWeaving_H_EQ< uint32_t, 31 >,
   219-                    new BitWeaving_H_EQ< uint64_t, 1 >,
   220-                    new BitWeaving_H_EQ< uint64_t, 3 >,
   221-                    new BitWeaving_H_EQ< uint64_t, 7 >,
   222-                    new BitWeaving_H_EQ< uint64_t, 15 >,
   223-                    new BitWeaving_H_EQ< uint64_t, 31 >,
   224-                    new BitWeaving_H_EQ< uint64_t, 63 >,
   225-           
   226-                    new BitWeaving_H_NEQ< uint32_t, 1 >,
   227-                    new BitWeaving_H_NEQ< uint32_t, 3 >,
   228-                    new BitWeaving_H_NEQ< uint32_t, 7 >,
   229-                    new BitWeaving_H_NEQ< uint32_t, 15 >,
   230-                    new BitWeaving_H_NEQ< uint32_t, 31 >,
   231-                    new BitWeaving_H_NEQ< uint64_t, 1 >,
   232-                    new BitWeaving_H_NEQ< uint64_t, 3 >,
   233-                    new BitWeaving_H_NEQ< uint64_t, 7 >,
   234-                    new BitWeaving_H_NEQ< uint64_t, 15 >,
   235-                    new BitWeaving_H_NEQ< uint64_t, 31 >,
   236-                    new BitWeaving_H_NEQ< uint64_t, 63 >,
   237-           
   238-                    new BitWeaving_H_LT< uint32_t, 1 >,
   239-                    new BitWeaving_H_LT< uint32_t, 3 >,
   240-                    new BitWeaving_H_LT< uint32_t, 7 >,
   241-                    new BitWeaving_H_LT< uint32_t, 15 >,
   242-                    new BitWeaving_H_LT< uint32_t, 31 >,
   243-                    new BitWeaving_H_LT< uint64_t, 1 >,
   244-                    new BitWeaving_H_LT< uint64_t, 3 >,
   245-                    new BitWeaving_H_LT< uint64_t, 7 >,
   246-                    new BitWeaving_H_LT< uint64_t, 15 >,
   247-                    new BitWeaving_H_LT< uint64_t, 31 >,
   248-                    new BitWeaving_H_LT< uint64_t, 63 >,
   249-           
   250-                    new BitWeaving_H_LEQ< uint32_t, 1 >,
   251-                    new BitWeaving_H_LEQ< uint32_t, 3 >,
   252-                    new BitWeaving_H_LEQ< uint32_t, 7 >,
   253-                    new BitWeaving_H_LEQ< uint32_t, 15 >,
   254-                    new BitWeaving_H_LEQ< uint32_t, 31 >,
   255-                    new BitWeaving_H_LEQ< uint64_t, 1 >,
   256-                    new BitWeaving_H_LEQ< uint64_t, 3 >,
   257-                    new BitWeaving_H_LEQ< uint64_t, 7 >,
   258-                    new BitWeaving_H_LEQ< uint64_t, 15 >,
   259-                    new BitWeaving_H_LEQ< uint64_t, 31 >,
   260-                    new BitWeaving_H_LEQ< uint64_t, 63 >,
   261-           
   262-                    new BitWeaving_H_GT< uint32_t, 1 >,
   263-                    new BitWeaving_H_GT< uint32_t, 3 >,
   264-                    new BitWeaving_H_GT< uint32_t, 7 >,
   265-                    new BitWeaving_H_GT< uint32_t, 15 >,
   266-                    new BitWeaving_H_GT< uint32_t, 31 >,
   267-                    new BitWeaving_H_GT< uint64_t, 1 >,
   268-                    new BitWeaving_H_GT< uint64_t, 3 >,
   269-                    new BitWeaving_H_GT< uint64_t, 7 >,
   270-                    new BitWeaving_H_GT< uint64_t, 15 >,
   271-                    new BitWeaving_H_GT< uint64_t, 31 >,
   272-                    new BitWeaving_H_GT< uint64_t, 63 >,
   273-           
   274-                    new BitWeaving_H_GEQ< uint32_t, 1 >,
   275-                    new BitWeaving_H_GEQ< uint32_t, 3 >,
   276-                    new BitWeaving_H_GEQ< uint32_t, 7 >,
   277-                    new BitWeaving_H_GEQ< uint32_t, 15 >,
   278-                    new BitWeaving_H_GEQ< uint32_t, 31 >,
   279-                    new BitWeaving_H_GEQ< uint64_t, 1 >,
   280-                    new BitWeaving_H_GEQ< uint64_t, 3 >,
   281-                    new BitWeaving_H_GEQ< uint64_t, 7 >,
   282-                    new BitWeaving_H_GEQ< uint64_t, 15 >,
   283-                    new BitWeaving_H_GEQ< uint64_t, 31 >,
   284-                    new BitWeaving_H_GEQ< uint64_t, 63 >,
   285-           #else
   286-           #   ifdef __SSE4_1__
   287-               new BitWeaving_H_EQ< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
   288-               new BitWeaving_H_EQ< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   289-               new BitWeaving_H_EQ< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
   290-               new BitWeaving_H_EQ< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   291-               new BitWeaving_H_EQ< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   292-               new BitWeaving_H_EQ< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
   293-               new BitWeaving_H_EQ< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
   294-               new BitWeaving_H_EQ< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
   295-               new BitWeaving_H_EQ< uint32_t, 7, __m128i, STREAM,      STREAM>,
   296-               new BitWeaving_H_EQ< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
   297-               new BitWeaving_H_EQ< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   298-               new BitWeaving_H_EQ< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
   299-               new BitWeaving_H_EQ< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   300-               new BitWeaving_H_EQ< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   301-               new BitWeaving_H_EQ< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
   302-               new BitWeaving_H_EQ< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
   303-               new BitWeaving_H_EQ< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
   304-               new BitWeaving_H_EQ< uint64_t, 7, __m128i, STREAM,      STREAM>,
   305-               new BitWeaving_H_NEQ< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
   306-               new BitWeaving_H_NEQ< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   307-               new BitWeaving_H_NEQ< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
   308-               new BitWeaving_H_NEQ< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   309-               new BitWeaving_H_NEQ< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   310-               new BitWeaving_H_NEQ< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
   311-               new BitWeaving_H_NEQ< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
   312-               new BitWeaving_H_NEQ< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
   313-               new BitWeaving_H_NEQ< uint32_t, 7, __m128i, STREAM,      STREAM>,
   314-               new BitWeaving_H_NEQ< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
   315-               new BitWeaving_H_NEQ< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   316-               new BitWeaving_H_NEQ< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
   317-               new BitWeaving_H_NEQ< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   318-               new BitWeaving_H_NEQ< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   319-               new BitWeaving_H_NEQ< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
   320-               new BitWeaving_H_NEQ< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
   321-               new BitWeaving_H_NEQ< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
   322-               new BitWeaving_H_NEQ< uint64_t, 7, __m128i, STREAM,      STREAM>,
   323-               new BitWeaving_H_LT< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
   324-               new BitWeaving_H_LT< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   325-               new BitWeaving_H_LT< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
   326-               new BitWeaving_H_LT< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   327-               new BitWeaving_H_LT< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   328-               new BitWeaving_H_LT< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
   329-               new BitWeaving_H_LT< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
   330-               new BitWeaving_H_LT< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
   331-               new BitWeaving_H_LT< uint32_t, 7, __m128i, STREAM,      STREAM>,
   332-               new BitWeaving_H_LT< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
   333-               new BitWeaving_H_LT< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   334-               new BitWeaving_H_LT< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
   335-               new BitWeaving_H_LT< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   336-               new BitWeaving_H_LT< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   337-               new BitWeaving_H_LT< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
   338-               new BitWeaving_H_LT< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
   339-               new BitWeaving_H_LT< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
   340-               new BitWeaving_H_LT< uint64_t, 7, __m128i, STREAM,      STREAM>,
   341-               new BitWeaving_H_LEQ< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
   342-               new BitWeaving_H_LEQ< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   343-               new BitWeaving_H_LEQ< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
   344-               new BitWeaving_H_LEQ< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   345-               new BitWeaving_H_LEQ< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   346-               new BitWeaving_H_LEQ< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
   347-               new BitWeaving_H_LEQ< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
   348-               new BitWeaving_H_LEQ< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
   349-               new BitWeaving_H_LEQ< uint32_t, 7, __m128i, STREAM,      STREAM>,
   350-               new BitWeaving_H_LEQ< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
   351-               new BitWeaving_H_LEQ< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   352-               new BitWeaving_H_LEQ< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
   353-               new BitWeaving_H_LEQ< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   354-               new BitWeaving_H_LEQ< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   355-               new BitWeaving_H_LEQ< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
   356-               new BitWeaving_H_LEQ< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
   357-               new BitWeaving_H_LEQ< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
   358-               new BitWeaving_H_LEQ< uint64_t, 7, __m128i, STREAM,      STREAM>,
   359-               new BitWeaving_H_GT< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
   360-               new BitWeaving_H_GT< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   361-               new BitWeaving_H_GT< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
   362-               new BitWeaving_H_GT< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   363-               new BitWeaving_H_GT< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   364-               new BitWeaving_H_GT< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
   365-               new BitWeaving_H_GT< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
   366-               new BitWeaving_H_GT< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
   367-               new BitWeaving_H_GT< uint32_t, 7, __m128i, STREAM,      STREAM>,
   368-               new BitWeaving_H_GT< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
   369-               new BitWeaving_H_GT< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   370-               new BitWeaving_H_GT< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
   371-               new BitWeaving_H_GT< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   372-               new BitWeaving_H_GT< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   373-               new BitWeaving_H_GT< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
   374-               new BitWeaving_H_GT< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
   375-               new BitWeaving_H_GT< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
   376-               new BitWeaving_H_GT< uint64_t, 7, __m128i, STREAM,      STREAM>,
   377-               new BitWeaving_H_GEQ< uint32_t, 7, __m128i, ALIGNED,     ALIGNED>,
   378-               new BitWeaving_H_GEQ< uint32_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   379-               new BitWeaving_H_GEQ< uint32_t, 7, __m128i, STREAM,      ALIGNED>,
   380-               new BitWeaving_H_GEQ< uint32_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   381-               new BitWeaving_H_GEQ< uint32_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   382-               new BitWeaving_H_GEQ< uint32_t, 7, __m128i, STREAM,      UNALIGNED>,
   383-               new BitWeaving_H_GEQ< uint32_t, 7, __m128i, ALIGNED,     STREAM>,
   384-               new BitWeaving_H_GEQ< uint32_t, 7, __m128i, UNALIGNED,   STREAM>,
   385-               new BitWeaving_H_GEQ< uint32_t, 7, __m128i, STREAM,      STREAM>,
   386-               new BitWeaving_H_GEQ< uint64_t, 7, __m128i, ALIGNED,     ALIGNED>,
   387-               new BitWeaving_H_GEQ< uint64_t, 7, __m128i, UNALIGNED,   ALIGNED>,
   388-               new BitWeaving_H_GEQ< uint64_t, 7, __m128i, STREAM,      ALIGNED>,
   389-               new BitWeaving_H_GEQ< uint64_t, 7, __m128i, ALIGNED,     UNALIGNED>,
   390-               new BitWeaving_H_GEQ< uint64_t, 7, __m128i, UNALIGNED,   UNALIGNED>,
   391-               new BitWeaving_H_GEQ< uint64_t, 7, __m128i, STREAM,      UNALIGNED>,
   392-               new BitWeaving_H_GEQ< uint64_t, 7, __m128i, ALIGNED,     STREAM>,
   393-               new BitWeaving_H_GEQ< uint64_t, 7, __m128i, UNALIGNED,   STREAM>,
   394-               new BitWeaving_H_GEQ< uint64_t, 7, __m128i, STREAM,      STREAM>,
   395-           #   endif
   396-           #   ifdef __AVX2__
   397-               new BitWeaving_H_EQ< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
   398-               new BitWeaving_H_EQ< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   399-               new BitWeaving_H_EQ< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
   400-               new BitWeaving_H_EQ< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   401-               new BitWeaving_H_EQ< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   402-               new BitWeaving_H_EQ< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
   403-               new BitWeaving_H_EQ< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
   404-               new BitWeaving_H_EQ< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
   405-               new BitWeaving_H_EQ< uint32_t, 7, __m256i, STREAM,      STREAM>,
   406-               new BitWeaving_H_EQ< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
   407-               new BitWeaving_H_EQ< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   408-               new BitWeaving_H_EQ< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
   409-               new BitWeaving_H_EQ< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   410-               new BitWeaving_H_EQ< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   411-               new BitWeaving_H_EQ< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
   412-               new BitWeaving_H_EQ< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
   413-               new BitWeaving_H_EQ< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
   414-               new BitWeaving_H_EQ< uint64_t, 7, __m256i, STREAM,      STREAM>,
   415-               new BitWeaving_H_NEQ< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
   416-               new BitWeaving_H_NEQ< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   417-               new BitWeaving_H_NEQ< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
   418-               new BitWeaving_H_NEQ< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   419-               new BitWeaving_H_NEQ< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   420-               new BitWeaving_H_NEQ< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
   421-               new BitWeaving_H_NEQ< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
   422-               new BitWeaving_H_NEQ< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
   423-               new BitWeaving_H_NEQ< uint32_t, 7, __m256i, STREAM,      STREAM>,
   424-               new BitWeaving_H_NEQ< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
   425-               new BitWeaving_H_NEQ< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   426-               new BitWeaving_H_NEQ< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
   427-               new BitWeaving_H_NEQ< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   428-               new BitWeaving_H_NEQ< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   429-               new BitWeaving_H_NEQ< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
   430-               new BitWeaving_H_NEQ< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
   431-               new BitWeaving_H_NEQ< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
   432-               new BitWeaving_H_NEQ< uint64_t, 7, __m256i, STREAM,      STREAM>,
   433-               new BitWeaving_H_LT< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
   434-               new BitWeaving_H_LT< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   435-               new BitWeaving_H_LT< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
   436-               new BitWeaving_H_LT< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   437-               new BitWeaving_H_LT< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   438-               new BitWeaving_H_LT< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
   439-               new BitWeaving_H_LT< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
   440-               new BitWeaving_H_LT< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
   441-               new BitWeaving_H_LT< uint32_t, 7, __m256i, STREAM,      STREAM>,
   442-               new BitWeaving_H_LT< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
   443-               new BitWeaving_H_LT< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   444-               new BitWeaving_H_LT< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
   445-               new BitWeaving_H_LT< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   446-               new BitWeaving_H_LT< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   447-               new BitWeaving_H_LT< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
   448-               new BitWeaving_H_LT< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
   449-               new BitWeaving_H_LT< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
   450-               new BitWeaving_H_LT< uint64_t, 7, __m256i, STREAM,      STREAM>,
   451-               new BitWeaving_H_LEQ< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
   452-               new BitWeaving_H_LEQ< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   453-               new BitWeaving_H_LEQ< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
   454-               new BitWeaving_H_LEQ< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   455-               new BitWeaving_H_LEQ< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   456-               new BitWeaving_H_LEQ< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
   457-               new BitWeaving_H_LEQ< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
   458-               new BitWeaving_H_LEQ< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
   459-               new BitWeaving_H_LEQ< uint32_t, 7, __m256i, STREAM,      STREAM>,
   460-               new BitWeaving_H_LEQ< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
   461-               new BitWeaving_H_LEQ< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   462-               new BitWeaving_H_LEQ< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
   463-               new BitWeaving_H_LEQ< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   464-               new BitWeaving_H_LEQ< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   465-               new BitWeaving_H_LEQ< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
   466-               new BitWeaving_H_LEQ< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
   467-               new BitWeaving_H_LEQ< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
   468-               new BitWeaving_H_LEQ< uint64_t, 7, __m256i, STREAM,      STREAM>,
   469-               new BitWeaving_H_GT< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
   470-               new BitWeaving_H_GT< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   471-               new BitWeaving_H_GT< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
   472-               new BitWeaving_H_GT< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   473-               new BitWeaving_H_GT< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   474-               new BitWeaving_H_GT< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
   475-               new BitWeaving_H_GT< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
   476-               new BitWeaving_H_GT< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
   477-               new BitWeaving_H_GT< uint32_t, 7, __m256i, STREAM,      STREAM>,
   478-               new BitWeaving_H_GT< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
   479-               new BitWeaving_H_GT< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   480-               new BitWeaving_H_GT< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
   481-               new BitWeaving_H_GT< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   482-               new BitWeaving_H_GT< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   483-               new BitWeaving_H_GT< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
   484-               new BitWeaving_H_GT< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
   485-               new BitWeaving_H_GT< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
   486-               new BitWeaving_H_GT< uint64_t, 7, __m256i, STREAM,      STREAM>,
   487-               new BitWeaving_H_GEQ< uint32_t, 7, __m256i, ALIGNED,     ALIGNED>,
   488-               new BitWeaving_H_GEQ< uint32_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   489-               new BitWeaving_H_GEQ< uint32_t, 7, __m256i, STREAM,      ALIGNED>,
   490-               new BitWeaving_H_GEQ< uint32_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   491-               new BitWeaving_H_GEQ< uint32_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   492-               new BitWeaving_H_GEQ< uint32_t, 7, __m256i, STREAM,      UNALIGNED>,
   493-               new BitWeaving_H_GEQ< uint32_t, 7, __m256i, ALIGNED,     STREAM>,
   494-               new BitWeaving_H_GEQ< uint32_t, 7, __m256i, UNALIGNED,   STREAM>,
   495-               new BitWeaving_H_GEQ< uint32_t, 7, __m256i, STREAM,      STREAM>,
   496-               new BitWeaving_H_GEQ< uint64_t, 7, __m256i, ALIGNED,     ALIGNED>,
   497-               new BitWeaving_H_GEQ< uint64_t, 7, __m256i, UNALIGNED,   ALIGNED>,
   498-               new BitWeaving_H_GEQ< uint64_t, 7, __m256i, STREAM,      ALIGNED>,
   499-               new BitWeaving_H_GEQ< uint64_t, 7, __m256i, ALIGNED,     UNALIGNED>,
   500-               new BitWeaving_H_GEQ< uint64_t, 7, __m256i, UNALIGNED,   UNALIGNED>,
   501-               new BitWeaving_H_GEQ< uint64_t, 7, __m256i, STREAM,      UNALIGNED>,
   502-               new BitWeaving_H_GEQ< uint64_t, 7, __m256i, ALIGNED,     STREAM>,
   503-               new BitWeaving_H_GEQ< uint64_t, 7, __m256i, UNALIGNED,   STREAM>,
   504-               new BitWeaving_H_GEQ< uint64_t, 7, __m256i, STREAM,      STREAM>,
   505-           #   endif
   506-           #   ifdef __AVX512F__
   507-               new BitWeaving_H_EQ< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
   508-               new BitWeaving_H_EQ< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   509-               new BitWeaving_H_EQ< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
   510-               new BitWeaving_H_EQ< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   511-               new BitWeaving_H_EQ< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   512-               new BitWeaving_H_EQ< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
   513-               new BitWeaving_H_EQ< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
   514-               new BitWeaving_H_EQ< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
   515-               new BitWeaving_H_EQ< uint32_t, 7, __m512i, STREAM,      STREAM>,
   516-               new BitWeaving_H_EQ< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
   517-               new BitWeaving_H_EQ< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   518-               new BitWeaving_H_EQ< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
   519-               new BitWeaving_H_EQ< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   520-               new BitWeaving_H_EQ< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   521-               new BitWeaving_H_EQ< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
   522-               new BitWeaving_H_EQ< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
   523-               new BitWeaving_H_EQ< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
   524-               new BitWeaving_H_EQ< uint64_t, 7, __m512i, STREAM,      STREAM>,
   525-               new BitWeaving_H_NEQ< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
   526-               new BitWeaving_H_NEQ< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   527-               new BitWeaving_H_NEQ< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
   528-               new BitWeaving_H_NEQ< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   529-               new BitWeaving_H_NEQ< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   530-               new BitWeaving_H_NEQ< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
   531-               new BitWeaving_H_NEQ< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
   532-               new BitWeaving_H_NEQ< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
   533-               new BitWeaving_H_NEQ< uint32_t, 7, __m512i, STREAM,      STREAM>,
   534-               new BitWeaving_H_NEQ< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
   535-               new BitWeaving_H_NEQ< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   536-               new BitWeaving_H_NEQ< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
   537-               new BitWeaving_H_NEQ< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   538-               new BitWeaving_H_NEQ< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   539-               new BitWeaving_H_NEQ< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
   540-               new BitWeaving_H_NEQ< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
   541-               new BitWeaving_H_NEQ< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
   542-               new BitWeaving_H_NEQ< uint64_t, 7, __m512i, STREAM,      STREAM>,
   543-               new BitWeaving_H_LT< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
   544-               new BitWeaving_H_LT< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   545-               new BitWeaving_H_LT< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
   546-               new BitWeaving_H_LT< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   547-               new BitWeaving_H_LT< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   548-               new BitWeaving_H_LT< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
   549-               new BitWeaving_H_LT< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
   550-               new BitWeaving_H_LT< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
   551-               new BitWeaving_H_LT< uint32_t, 7, __m512i, STREAM,      STREAM>,
   552-               new BitWeaving_H_LT< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
   553-               new BitWeaving_H_LT< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   554-               new BitWeaving_H_LT< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
   555-               new BitWeaving_H_LT< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   556-               new BitWeaving_H_LT< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   557-               new BitWeaving_H_LT< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
   558-               new BitWeaving_H_LT< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
   559-               new BitWeaving_H_LT< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
   560-               new BitWeaving_H_LT< uint64_t, 7, __m512i, STREAM,      STREAM>,
   561-               new BitWeaving_H_LEQ< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
   562-               new BitWeaving_H_LEQ< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   563-               new BitWeaving_H_LEQ< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
   564-               new BitWeaving_H_LEQ< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   565-               new BitWeaving_H_LEQ< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   566-               new BitWeaving_H_LEQ< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
   567-               new BitWeaving_H_LEQ< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
   568-               new BitWeaving_H_LEQ< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
   569-               new BitWeaving_H_LEQ< uint32_t, 7, __m512i, STREAM,      STREAM>,
   570-               new BitWeaving_H_LEQ< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
   571-               new BitWeaving_H_LEQ< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   572-               new BitWeaving_H_LEQ< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
   573-               new BitWeaving_H_LEQ< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   574-               new BitWeaving_H_LEQ< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   575-               new BitWeaving_H_LEQ< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
   576-               new BitWeaving_H_LEQ< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
   577-               new BitWeaving_H_LEQ< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
   578-               new BitWeaving_H_LEQ< uint64_t, 7, __m512i, STREAM,      STREAM>,
   579-               new BitWeaving_H_GT< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
   580-               new BitWeaving_H_GT< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   581-               new BitWeaving_H_GT< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
   582-               new BitWeaving_H_GT< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   583-               new BitWeaving_H_GT< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   584-               new BitWeaving_H_GT< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
   585-               new BitWeaving_H_GT< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
   586-               new BitWeaving_H_GT< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
   587-               new BitWeaving_H_GT< uint32_t, 7, __m512i, STREAM,      STREAM>,
   588-               new BitWeaving_H_GT< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
   589-               new BitWeaving_H_GT< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   590-               new BitWeaving_H_GT< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
   591-               new BitWeaving_H_GT< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   592-               new BitWeaving_H_GT< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   593-               new BitWeaving_H_GT< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
   594-               new BitWeaving_H_GT< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
   595-               new BitWeaving_H_GT< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
   596-               new BitWeaving_H_GT< uint64_t, 7, __m512i, STREAM,      STREAM>,
   597-               new BitWeaving_H_GEQ< uint32_t, 7, __m512i, ALIGNED,     ALIGNED>,
   598-               new BitWeaving_H_GEQ< uint32_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   599-               new BitWeaving_H_GEQ< uint32_t, 7, __m512i, STREAM,      ALIGNED>,
   600-               new BitWeaving_H_GEQ< uint32_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   601-               new BitWeaving_H_GEQ< uint32_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   602-               new BitWeaving_H_GEQ< uint32_t, 7, __m512i, STREAM,      UNALIGNED>,
   603-               new BitWeaving_H_GEQ< uint32_t, 7, __m512i, ALIGNED,     STREAM>,
   604-               new BitWeaving_H_GEQ< uint32_t, 7, __m512i, UNALIGNED,   STREAM>,
   605-               new BitWeaving_H_GEQ< uint32_t, 7, __m512i, STREAM,      STREAM>,
   606-               new BitWeaving_H_GEQ< uint64_t, 7, __m512i, ALIGNED,     ALIGNED>,
   607-               new BitWeaving_H_GEQ< uint64_t, 7, __m512i, UNALIGNED,   ALIGNED>,
   608-               new BitWeaving_H_GEQ< uint64_t, 7, __m512i, STREAM,      ALIGNED>,
   609-               new BitWeaving_H_GEQ< uint64_t, 7, __m512i, ALIGNED,     UNALIGNED>,
   610-               new BitWeaving_H_GEQ< uint64_t, 7, __m512i, UNALIGNED,   UNALIGNED>,
   611-               new BitWeaving_H_GEQ< uint64_t, 7, __m512i, STREAM,      UNALIGNED>,
   612-               new BitWeaving_H_GEQ< uint64_t, 7, __m512i, ALIGNED,     STREAM>,
   613-               new BitWeaving_H_GEQ< uint64_t, 7, __m512i, UNALIGNED,   STREAM>,
   614-               new BitWeaving_H_GEQ< uint64_t, 7, __m512i, STREAM,      STREAM>,
   615-           #   endif
   616-           #endif
   617-           
   618-               };
   619-            
   620-               // Determine the maximum buffer size to use.
   621:               uint64_t maxBufferSizeBytes = 0;
   622: +------>      for(uint64_t bufferSizeBytes : bufferSizesBytes)
   623: |                 if(bufferSizeBytes > maxBufferSizeBytes)
   624: +------               maxBufferSizeBytes = bufferSizeBytes;
   625-            
   626-               // Allocate two buffers of that size.
   627:               const size_t ALIGNMENT = 64;
   628:               const size_t bufSizeAlloc = maxBufferSizeBytes + offset(UNALIGNED);
   629-           #if defined(__SSE4_1__) || defined(__AVX2__) || defined(__AVX512F__)
   630-               uint8_t* bufSrc8 = reinterpret_cast<uint8_t*>(_mm_malloc(bufSizeAlloc, ALIGNMENT));
   631-               uint8_t* bufDst8 = reinterpret_cast<uint8_t*>(_mm_malloc(bufSizeAlloc, ALIGNMENT));
   632-           #else
   633:               uint8_t* bufSrc8 = new uint8_t[bufSizeAlloc];
   634:               uint8_t* bufDst8 = new uint8_t[bufSizeAlloc];
   635-           #endif
   636-            
   637-               // Initialize the buffers.
   638:               uint64_t* bufSrc64 = reinterpret_cast<uint64_t*>(bufSrc8);
   639:               uint64_t* bufDst64 = reinterpret_cast<uint64_t*>(bufDst8);
   640: +------>      for(unsigned i = 0; i < bufSizeAlloc / sizeof(uint64_t); i++)
   641: +------           bufSrc64[i] = bufDst64[i] = WRITE_VAL64;
   642-            
   643:               WallClockStopWatch sw;
   644:               unordered_map<size_t, unordered_map<TaskVariant*, vector<double> > > durationsSec;
   645-               // Initialize this structure with empty vectors.
   646: +------>      for(uint64_t bufferSizeBytes : bufferSizesBytes)
   647: |+----->          for(TaskVariant* tv : tvs)
   648: ++-----               durationsSec[bufferSizeBytes][tv];
   649-               // Execute all task variants on all buffer sizes as many times as specified
   650-               // by the user. Output all individual measurements.
   651-               // The order of the loops was chosen to (hopefully) minimize the impact of
   652-               // occasional "other things going on in the system" on the measurements:
   653-               // - The repetitions are in the outermost loop, such that the measurements
   654-               //   being averaged in the end are as far away from each other as possible
   655-               // - The buffer size is in the middle loop, such that measurements
   656-               //   subsequent in a typical diagram (usually, we vary the buffer size at
   657-               //   the x-axis) are as far away from each other as possible, which should
   658-               //   make outliers easier to identify visually
   659: +------>      for ( unsigned i = 0; i < countRepetitions; i++ ) {
   660: |+----->          for ( uint64_t bufferSizeBytes : bufferSizesBytes ) {
   661: ||                    size_t minireps = 1;
   662: ||                    if( bufferSizeBytes <= 1_MB )
   663: ||                        minireps = 1000;
   664: ||                    else if( bufferSizeBytes <= 16_MB )
   665: ||                        minireps = 100;
   666: ||                    else if( bufferSizeBytes < 1_GB )
   667: ||                        minireps = 10;
   668- ||                    else
   669: ||                        minireps = 1;
   670: ||+---->              for ( TaskVariant *tv : tvs ) {
   671: |||                       sw.start( );
   672: |||+--->                  for ( unsigned j = 0; j < minireps; ++j ) {
   673: ||||                          tv->doIt( bufDst8, bufSrc8, bufferSizeBytes );
   674: |||+---                   }
   675: |||                       sw.stop( );
   676: |||                       const double durationSec = sw.duration( ) / (double)minireps;
   677: |||                       durationsSec.at( bufferSizeBytes ).at( tv ).push_back( durationSec );
   678: |||                       printLine( tv, INDIVIDUAL, durationSec, bufferSizeBytes, colEnd, colW );
   679: |||                       sw.reset( );
   680: ||+----               }
   681: |+-----           }
   682: |                 if ( tsvOutput )
   683: |                     cerr << "Done with repetition " << ( i + 1 ) << " / " << countRepetitions << endl;
   684: +------       }
   685-               // Calculate the average measurements for all combinations of task variant
   686-               // and buffer size. Output the averaged measurements.
   687: +------>      for ( uint64_t bufferSizeBytes : bufferSizesBytes )
   688: |+----->          for ( TaskVariant *tv : tvs ) {
   689: ||                    double durationSecSum = 0;
   690: ||+---->              for ( double durationSec : durationsSec.at( bufferSizeBytes ).at( tv ))
   691: ||+----                   durationSecSum += durationSec;
   692: ||                    printLine( tv, AVG, durationSecSum / countRepetitions, bufferSizeBytes, colEnd, colW );
   693: ++-----           }
   694-               // Release the buffers.
   695-           #if defined(__SSE4_1__) || defined(__AVX2__) || defined(__AVX512F__)
   696-               _mm_free(bufSrc8);
   697-               _mm_free(bufDst8);
   698-           #else
   699:               delete[] bufSrc8;
   700:               delete[] bufDst8;
   701-           #endif
   702-            
   703:               return 0;
   704:           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: stopwatch.h

FUNCTION NAME: WallClockStopWatch::now const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    90: opt(2321): High Level Optimization halted: ASM code in routine.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: stopwatch.h

FUNCTION NAME: WallClockStopWatch::now const
FORMAT LIST

 LINE   LOOP      STATEMENT

    88-               long now() const {
    89-                   asm( "smir %s0, %usrcc" );
    90-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: stopwatch.h

FUNCTION NAME: WallClockStopWatch::diff const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: stopwatch.h

FUNCTION NAME: WallClockStopWatch::diff const
FORMAT LIST

 LINE   LOOP      STATEMENT

    92-               double diff() const {
    93-                   return ( (double)((double)endTime - (double) startTime) ) / ( (double)(1400*1000*1000) );
    94-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: TaskVariant::taskStr const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    70: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
    80: inl(1212): Source for routine not found.: std::runtime_error::runtime_error


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: TaskVariant::taskStr const
FORMAT LIST

 LINE   LOOP      STATEMENT

    68-              std::string taskStr() const {
    69-                 switch(task) {
    70-                    case COPY   : return "copy";
    71-                    case WRITE  : return "write";
    72-                    case COMPARE: return "compare";
    73-                    case AGGOR  : return "agg(or)";
    74-                    case BW_EQ  : return "bw_h_eq";
    75-                    case BW_NEQ : return "bw_h_neq";
    76-                    case BW_LT : return "bw_h_lt";
    77-                    case BW_LEQ : return "bw_h_leq";
    78-                    case BW_GT : return "bw_h_gt";
    79-                    case BW_GEQ : return "bw_h_geq";
    80-                    default: throw std::runtime_error("unknown Task");
    81-                 }
    82-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: TaskVariant::methodStr const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    90: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
    92: inl(1212): Source for routine not found.: std::runtime_error::runtime_error


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: TaskVariant::methodStr const
FORMAT LIST

 LINE   LOOP      STATEMENT

    88-              std::string methodStr() const {
    89-                 switch(method) {
    90-                    case SCALAR: return "scalar";
    91-                    case VECTOR: return "vector";
    92-                    default: throw std::runtime_error("unknown Method");
    93-                 }
    94-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: TaskVariant::lsModeStr
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    98: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
   102: inl(1212): Source for routine not found.: std::runtime_error::runtime_error


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: TaskVariant::lsModeStr
FORMAT LIST

 LINE   LOOP      STATEMENT

    96-              static std::string lsModeStr(LSMode lsMode) {
    97-                 switch(lsMode) {
    98-                    case NONE     : return "-";
    99-                    case ALIGNED  : return "aligned";
   100-                    case UNALIGNED: return "unaligned";
   101-                    case STREAM   : return "stream";
   102-                    default: throw std::runtime_error("unknown LSMode");
   103-                 }
   104-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: CopyScalar<unsigned int>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   481: opt(1135): Outer loop conditionally executes inner loop.
   484: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: CopyScalar<unsigned int>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   476-               uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   477-                  uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
   478-                  uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
   479-                  const size_t count = length / sizeof( uintX_t );
   480-           #pragma _NEC nonouterloop_unroll
   481- +------>         for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   482- |                   size_t inner_upper_bound = outer_i + MVS;
   483- |         #pragma _NEC shortloop
   484- |V----->            for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   485- ||                     dst[ inner_i ] = src[ inner_i ];
   486- |V-----             }
   487- +------          }
   488-                  return 0;
   489-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: CopyScalar<unsigned long>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   484: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: CopyScalar<unsigned long>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   476-               uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   477-                  uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
   478-                  uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
   479-                  const size_t count = length / sizeof( uintX_t );
   480-           #pragma _NEC nonouterloop_unroll
   481- +------>         for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   482- |                   size_t inner_upper_bound = outer_i + MVS;
   483- |         #pragma _NEC shortloop
   484- |V----->            for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   485- ||                     dst[ inner_i ] = src[ inner_i ];
   486- |V-----             }
   487- +------          }
   488-                  return 0;
   489-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: WriteScalar<unsigned int>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   505: opt(1135): Outer loop conditionally executes inner loop.
   508: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: WriteScalar<unsigned int>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   499-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   500-                 uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
   501-                 uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
   502-                 const size_t count = length / sizeof( uintX_t );
   503-                 uintX_t valX = ( uintX_t ) WRITE_VAL64;
   504-           #pragma _NEC nonouterloop_unroll
   505- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   506- |                  size_t inner_upper_bound = outer_i + MVS;
   507- |         #pragma _NEC shortloop
   508- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   509- ||                    dst[ inner_i ] = valX;
   510- |V-----            }
   511- +------         }
   512-                 return 0;
   513-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: WriteScalar<unsigned long>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   508: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: WriteScalar<unsigned long>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   499-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   500-                 uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
   501-                 uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
   502-                 const size_t count = length / sizeof( uintX_t );
   503-                 uintX_t valX = ( uintX_t ) WRITE_VAL64;
   504-           #pragma _NEC nonouterloop_unroll
   505- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   506- |                  size_t inner_upper_bound = outer_i + MVS;
   507- |         #pragma _NEC shortloop
   508- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   509- ||                    dst[ inner_i ] = valX;
   510- |V-----            }
   511- +------         }
   512-                 return 0;
   513-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: CompareScalar<unsigned int>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   525: vec( 130): Vector register is assigned.: result_array
   531: vec( 124): Iteration count is assumed. Iteration count.: 256
   531: vec( 101): Vectorized loop.
   536: opt(1135): Outer loop conditionally executes inner loop.
   539: vec( 101): Vectorized loop.
   543: vec( 124): Iteration count is assumed. Iteration count.: 256
   543: vec( 101): Vectorized loop.
   544: vec( 126): Idiom detected.: Bit-op


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: CompareScalar<unsigned int>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   525-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   526-                 uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
   527-                 uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
   528-                 const size_t count = length / sizeof( uintX_t ) / 2 ;
   529-                 uintX_t result_array[ MVS ];
   530-                 uintX_t result = 1;
   531- V------>        for( size_t initialize_i = 0; initialize_i < MVS; ++initialize_i ) {
   532- |       V          result_array[ initialize_i ] = ( uintX_t ) 1;
   533- V------         }
   534-           #pragma _NEC vreg( result_array )
   535-           #pragma _NEC nonouterloop_unroll
   536- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   537- |                  size_t inner_upper_bound = outer_i + MVS;
   538- |         #pragma _NEC shortloop
   539- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   540- ||      V             result_array[ inner_i ] &= ( src[ inner_i ] == dst[ inner_i ] );
   541- |V-----            }
   542- +------         }
   543- V------>        for( size_t aggr_i = 0; aggr_i < MVS; ++aggr_i ) {
   544- |       V          result &= result_array[ aggr_i ];
   545- V------         }
   546-                 return (uint64_t)result;
   547-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: CompareScalar<unsigned long>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   525: vec( 130): Vector register is assigned.: result_array
   531: vec( 124): Iteration count is assumed. Iteration count.: 256
   531: vec( 101): Vectorized loop.
   539: vec( 101): Vectorized loop.
   543: vec( 124): Iteration count is assumed. Iteration count.: 256
   543: vec( 101): Vectorized loop.
   544: vec( 126): Idiom detected.: Bit-op


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: CompareScalar<unsigned long>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   525-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   526-                 uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
   527-                 uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
   528-                 const size_t count = length / sizeof( uintX_t ) / 2 ;
   529-                 uintX_t result_array[ MVS ];
   530-                 uintX_t result = 1;
   531- V------>        for( size_t initialize_i = 0; initialize_i < MVS; ++initialize_i ) {
   532- |       V          result_array[ initialize_i ] = ( uintX_t ) 1;
   533- V------         }
   534-           #pragma _NEC vreg( result_array )
   535-           #pragma _NEC nonouterloop_unroll
   536- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   537- |                  size_t inner_upper_bound = outer_i + MVS;
   538- |         #pragma _NEC shortloop
   539- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   540- ||      V             result_array[ inner_i ] &= ( src[ inner_i ] == dst[ inner_i ] );
   541- |V-----            }
   542- +------         }
   543- V------>        for( size_t aggr_i = 0; aggr_i < MVS; ++aggr_i ) {
   544- |       V          result &= result_array[ aggr_i ];
   545- V------         }
   546-                 return (uint64_t)result;
   547-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: AggOrScalar<unsigned int>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   557: vec( 130): Vector register is assigned.: result_array
   563: vec( 124): Iteration count is assumed. Iteration count.: 256
   563: vec( 101): Vectorized loop.
   568: opt(1135): Outer loop conditionally executes inner loop.
   571: vec( 101): Vectorized loop.
   575: vec( 124): Iteration count is assumed. Iteration count.: 256
   575: vec( 101): Vectorized loop.
   576: vec( 126): Idiom detected.: Bit-op


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: AggOrScalar<unsigned int>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   557-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   558-                 uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
   559-                 uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
   560-                 const size_t count = length / sizeof( uintX_t );
   561-                 uintX_t result_array[ MVS ];
   562-                 uintX_t result = 0;
   563- V------>        for( size_t initialize_i = 0; initialize_i < MVS; ++initialize_i ) {
   564- |       V          result_array[ initialize_i ] = ( uintX_t ) 0;
   565- V------         }
   566-           #pragma _NEC vreg( result_array )
   567-           #pragma _NEC nonouterloop_unroll
   568- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   569- |                  size_t inner_upper_bound = outer_i + MVS;
   570- |         #pragma _NEC shortloop
   571- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   572- ||      V             result_array[ inner_i ] |= src[ inner_i ];
   573- |V-----            }
   574- +------         }
   575- V------>        for( size_t aggr_i = 0; aggr_i < MVS; ++aggr_i ) {
   576- |       V          result &= result_array[ aggr_i ];
   577- V------         }
   578-                 return (uint64_t)result;
   579-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: AggOrScalar<unsigned long>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   557: vec( 130): Vector register is assigned.: result_array
   563: vec( 124): Iteration count is assumed. Iteration count.: 256
   563: vec( 101): Vectorized loop.
   571: vec( 101): Vectorized loop.
   575: vec( 124): Iteration count is assumed. Iteration count.: 256
   575: vec( 101): Vectorized loop.
   576: vec( 126): Idiom detected.: Bit-op


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: AggOrScalar<unsigned long>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   557-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   558-                 uintX_t * dst = reinterpret_cast< uintX_t * >( dst8 );
   559-                 uintX_t * src = reinterpret_cast< uintX_t * >( src8 );
   560-                 const size_t count = length / sizeof( uintX_t );
   561-                 uintX_t result_array[ MVS ];
   562-                 uintX_t result = 0;
   563- V------>        for( size_t initialize_i = 0; initialize_i < MVS; ++initialize_i ) {
   564- |       V          result_array[ initialize_i ] = ( uintX_t ) 0;
   565- V------         }
   566-           #pragma _NEC vreg( result_array )
   567-           #pragma _NEC nonouterloop_unroll
   568- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   569- |                  size_t inner_upper_bound = outer_i + MVS;
   570- |         #pragma _NEC shortloop
   571- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   572- ||      V             result_array[ inner_i ] |= src[ inner_i ];
   573- |V-----            }
   574- +------         }
   575- V------>        for( size_t aggr_i = 0; aggr_i < MVS; ++aggr_i ) {
   576- |       V          result &= result_array[ aggr_i ];
   577- V------         }
   578-                 return (uint64_t)result;
   579-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned int, (unsigned short)1>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   164: vec( 103): Unvectorized loop.
   165: opt(1394): Moved invariant if outside of an inner loop.
   166: opt(1019): Feedback of scalar value from one loop pass to another.: pred
   166: vec( 121): Unvectorizable dependency.
   167: vec( 120): Unvectorizable dependency.: *(this).predicate
   169: opt(1512): Loop unrolled.: i


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned int, (unsigned short)1>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned int, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   597: opt(1135): Outer loop conditionally executes inner loop.
   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned int, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned int, (unsigned short)3>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   164: vec( 103): Unvectorized loop.
   165: opt(1394): Moved invariant if outside of an inner loop.
   166: opt(1019): Feedback of scalar value from one loop pass to another.: pred
   166: vec( 121): Unvectorizable dependency.
   167: vec( 120): Unvectorizable dependency.: *(this).predicate
   169: opt(1512): Loop unrolled.: i


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned int, (unsigned short)3>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned int, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned int, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned int, (unsigned short)7>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   164: vec( 103): Unvectorized loop.
   165: opt(1394): Moved invariant if outside of an inner loop.
   166: opt(1019): Feedback of scalar value from one loop pass to another.: pred
   166: vec( 121): Unvectorizable dependency.
   167: vec( 120): Unvectorizable dependency.: *(this).predicate
   169: opt(1512): Loop unrolled.: i


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned int, (unsigned short)7>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned int, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned int, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned int, (unsigned short)15>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   164: vec( 103): Unvectorized loop.
   165: opt(1394): Moved invariant if outside of an inner loop.
   166: opt(1019): Feedback of scalar value from one loop pass to another.: pred
   166: vec( 121): Unvectorizable dependency.
   167: vec( 120): Unvectorizable dependency.: *(this).predicate
   169: opt(1512): Loop unrolled.: i


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned int, (unsigned short)15>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned int, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned int, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned int, (unsigned short)31>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   165: opt(1394): Moved invariant if outside of an inner loop.
   166: opt(1019): Feedback of scalar value from one loop pass to another.: pred
   169: opt(1512): Loop unrolled.: i


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned int, (unsigned short)31>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned int, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned int, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)1>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   164: vec( 103): Unvectorized loop.
   165: opt(1394): Moved invariant if outside of an inner loop.
   166: opt(1019): Feedback of scalar value from one loop pass to another.: pred
   166: vec( 121): Unvectorizable dependency.
   167: vec( 120): Unvectorizable dependency.: *(this).predicate
   169: opt(1512): Loop unrolled.: i


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)1>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)3>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   164: vec( 103): Unvectorized loop.
   165: opt(1394): Moved invariant if outside of an inner loop.
   166: opt(1019): Feedback of scalar value from one loop pass to another.: pred
   166: vec( 121): Unvectorizable dependency.
   167: vec( 120): Unvectorizable dependency.: *(this).predicate
   169: opt(1512): Loop unrolled.: i


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:03 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)3>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)7>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   164: vec( 103): Unvectorized loop.
   165: opt(1394): Moved invariant if outside of an inner loop.
   166: opt(1019): Feedback of scalar value from one loop pass to another.: pred
   166: vec( 121): Unvectorizable dependency.
   167: vec( 120): Unvectorizable dependency.: *(this).predicate
   169: opt(1512): Loop unrolled.: i


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)7>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)15>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   164: vec( 103): Unvectorized loop.
   165: opt(1394): Moved invariant if outside of an inner loop.
   166: opt(1019): Feedback of scalar value from one loop pass to another.: pred
   166: vec( 121): Unvectorizable dependency.
   167: vec( 120): Unvectorizable dependency.: *(this).predicate
   169: opt(1512): Loop unrolled.: i


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)15>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)31>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   164: vec( 103): Unvectorized loop.
   165: opt(1394): Moved invariant if outside of an inner loop.
   166: vec( 121): Unvectorizable dependency.
   167: vec( 120): Unvectorizable dependency.: *(this).predicate


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)31>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)63>::BitWeaving_H
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H<unsigned long, (unsigned short)63>::BitWeaving_H
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-              BitWeaving_H( void ) {
   161-                 T pred = ( T ) WRITE_VAL64;
   162-                 pred &= max_value;
   163-                 predicate = pred;
   164- +------>        for( std::size_t i = 1; i < code_count; ++i ) {
   165- |                  if( ( CodeSize + 1 ) < ( sizeof( T ) * 8 ) ) {
   166- |                     pred <<= ( CodeSize + 1 );
   167- |                     predicate |= pred;
   168- |                  }
   169- +------         }
   170-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)63>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   600: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_EQ<unsigned long, (unsigned short)63>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   590-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   591-                 T * dst = reinterpret_cast< T * >( dst8 );
   592-                 T * src = reinterpret_cast< T * >( src8 );
   593-                 const size_t count = length / sizeof( T );
   594-                 T pred = this->predicate;
   595-                 T cbm = this->code_bits_mask;
   596-           #pragma _NEC nonouterloop_unroll
   597- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   598- |                  size_t inner_upper_bound = outer_i + MVS;
   599- |         #pragma _NEC shortloop
   600- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   601- ||                    dst[ inner_i ] = ~(( src[ inner_i ] ^ pred ) + cbm );
   602- |V-----            }
   603- +------         }
   604-                 return (uint64_t)0;
   605-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned int, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   620: opt(1135): Outer loop conditionally executes inner loop.
   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned int, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned int, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned int, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned int, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned int, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned int, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned int, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned int, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned int, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)63>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   623: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_NEQ<unsigned long, (unsigned short)63>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   613-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   614-                 T * dst = reinterpret_cast< T * >( dst8 );
   615-                 T * src = reinterpret_cast< T * >( src8 );
   616-                 const size_t count = length / sizeof( T );
   617-                 T pred = this->predicate;
   618-                 T cbm = this->code_bits_mask;
   619-           #pragma _NEC nonouterloop_unroll
   620- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   621- |                  size_t inner_upper_bound = outer_i + MVS;
   622- |         #pragma _NEC shortloop
   623- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   624- ||                    dst[ inner_i ] = ( src[ inner_i ] ^ pred ) + cbm;
   625- |V-----            }
   626- +------         }
   627-                 return (uint64_t)0;
   628-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned int, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   643: opt(1135): Outer loop conditionally executes inner loop.
   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned int, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned int, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned int, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned int, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned int, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned int, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned int, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned int, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned int, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)63>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   646: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LT<unsigned long, (unsigned short)63>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   636-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   637-                 T * dst = reinterpret_cast< T * >( dst8 );
   638-                 T * src = reinterpret_cast< T * >( src8 );
   639-                 const size_t count = length / sizeof( T );
   640-                 T pred = this->predicate;
   641-                 T cbm = this->code_bits_mask;
   642-           #pragma _NEC nonouterloop_unroll
   643- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   644- |                  size_t inner_upper_bound = outer_i + MVS;
   645- |         #pragma _NEC shortloop
   646- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   647- ||                    dst[ inner_i ] = pred + ( src[ inner_i ] ^ cbm );
   648- |V-----            }
   649- +------         }
   650-                 return (uint64_t)0;
   651-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned int, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   667: opt(1135): Outer loop conditionally executes inner loop.
   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned int, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned int, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned int, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned int, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned int, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned int, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned int, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned int, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned int, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)63>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   670: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_LEQ<unsigned long, (unsigned short)63>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   659-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   660-                 T * dst = reinterpret_cast< T * >( dst8 );
   661-                 T * src = reinterpret_cast< T * >( src8 );
   662-                 const size_t count = length / sizeof( T );
   663-                 T pred = this->predicate;
   664-                 T cbm = this->code_bits_mask;
   665-                 T fbm = this->first_bit_mask;
   666-           #pragma _NEC nonouterloop_unroll
   667- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   668- |                  size_t inner_upper_bound = outer_i + MVS;
   669- |         #pragma _NEC shortloop
   670- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   671- ||                    dst[ inner_i ] = ( pred + ( src[ inner_i ] ^ cbm ) ) + fbm;
   672- |V-----            }
   673- +------         }
   674-                 return (uint64_t)0;
   675-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned int, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   689: opt(1135): Outer loop conditionally executes inner loop.
   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned int, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned int, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned int, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned int, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned int, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned int, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned int, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned int, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned int, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)63>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   692: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GT<unsigned long, (unsigned short)63>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   683-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   684-                 T * dst = reinterpret_cast< T * >( dst8 );
   685-                 T * src = reinterpret_cast< T * >( src8 );
   686-                 const size_t count = length / sizeof( T );
   687-                 T summand = ( this->predicate ^ this->code_bits_mask );
   688-           #pragma _NEC nonouterloop_unroll
   689- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   690- |                  size_t inner_upper_bound = outer_i + MVS;
   691- |         #pragma _NEC shortloop
   692- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   693- ||                    dst[ inner_i ] = src[ inner_i ] + summand;
   694- |V-----            }
   695- +------         }
   696-                 return (uint64_t)0;
   697-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned int, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    26: inl(1212): Source for routine not found.: std::_Winit::_Winit
   712: opt(1135): Outer loop conditionally executes inner loop.
   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned int, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned int, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned int, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned int, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned int, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned int, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned int, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned int, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned int, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)1>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)1>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)3>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)3>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)7>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)7>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)15>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)15>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)31>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)31>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)63>::doIt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   715: vec( 101): Vectorized loop.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: tasks.h

FUNCTION NAME: BitWeaving_H_GEQ<unsigned long, (unsigned short)63>::doIt const
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-              uint64_t doIt( uint8_t * dst8, uint8_t * src8, size_t length ) const {
   706-                 T * dst = reinterpret_cast< T * >( dst8 );
   707-                 T * src = reinterpret_cast< T * >( src8 );
   708-                 const size_t count = length / sizeof( T );
   709-                 T summand = ( this->predicate ^ this->code_bits_mask );
   710-                 T fbm = this->first_bit_mask;
   711-           #pragma _NEC nonouterloop_unroll
   712- +------>        for( size_t outer_i = 0; outer_i < count; outer_i += MVS ) {
   713- |                  size_t inner_upper_bound = outer_i + MVS;
   714- |         #pragma _NEC shortloop
   715- |V----->           for( size_t inner_i = outer_i; inner_i < inner_upper_bound; ++inner_i ) {
   716- ||                    dst[ inner_i ] = ( src[ inner_i ] + summand ) + fbm;
   717- |V-----            }
   718- +------         }
   719-                 return (uint64_t)0;
   720-              }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::eq
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::eq
FORMAT LIST

 LINE   LOOP      STATEMENT

   438-               static _CONST_FUN bool eq(const _Elem& _Left,
   439-                   const _Elem& _Right) _NOEXCEPT
   440-                   {   // test for element equality
   441-                   return (_Left == _Right);
   442-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::to_char_type
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::to_char_type
FORMAT LIST

 LINE   LOOP      STATEMENT

   454-               static _CONST_FUN _Elem to_char_type(
   455-                   const int_type& _Meta) _NOEXCEPT
   456-                   {   // convert metacharacter to character
   457-                   return ((_Elem)_Meta);
   458-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::to_int_type
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::to_int_type
FORMAT LIST

 LINE   LOOP      STATEMENT

   460-               static _CONST_FUN int_type to_int_type(
   461-                   const _Elem& _Ch) _NOEXCEPT
   462-                   {   // convert character to metacharacter
   463-                   return ((unsigned char)_Ch);
   464-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::eq_int_type
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::eq_int_type
FORMAT LIST

 LINE   LOOP      STATEMENT

   466-               static _CONST_FUN bool eq_int_type(const int_type& _Left,
   467-                   const int_type& _Right) _NOEXCEPT
   468-                   {   // test for metacharacter equality
   469-                   return (_Left == _Right);
   470-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::not_eof
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   475: inl(1212): Source for routine not found.: std::char_traits<char>::eof


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::not_eof
FORMAT LIST

 LINE   LOOP      STATEMENT

   472-               static _CONST_FUN int_type not_eof(
   473-                   const int_type& _Meta) _NOEXCEPT
   474-                   {   // return anything but EOF
   475-                   return (_Meta != eof() ? _Meta : !eof());
   476-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::eof
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/iosfwd

FUNCTION NAME: std::char_traits<char>::eof
FORMAT LIST

 LINE   LOOP      STATEMENT

   478-               static _CONST_FUN int_type eof() _NOEXCEPT
   479-                   {   // return end-of-file metacharacter
   480-                   return (EOF);
   481-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/exception

FUNCTION NAME: std::exception::~exception
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/exception

FUNCTION NAME: std::exception::~exception
FORMAT LIST

 LINE   LOOP      STATEMENT

    41-           	virtual ~exception() _NOEXCEPT
    42-           		{	// destroy the object
    43-           		}


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/exception

FUNCTION NAME: std::exception::what const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/exception

FUNCTION NAME: std::exception::what const
FORMAT LIST

 LINE   LOOP      STATEMENT

    46-           	virtual const char *what() const
    47-           
    48-            #else /* _HAS_TRADITIONAL_STL */
    49-           	virtual const char *what() const _THROW0()
    50-            #endif /* _HAS_TRADITIONAL_STL */
    51-           
    52-           		{	// return pointer to message string
    53-           		return (_Ptr != 0 ? _Ptr : "unknown exception");
    54-           		}


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::assign
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   974: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Tidy
   978: inl(1212): Source for routine not found.: std::forward<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::assign
FORMAT LIST

 LINE   LOOP      STATEMENT

   968-               _Myt& assign(_Myt&& _Right) _NOEXCEPT
   969-                   {   // assign by moving _Right
   970-                   if (this == &_Right)
   971-                       ;
   972-                   else if (get_allocator() != _Right.get_allocator()
   973-                       && this->_BUF_SIZE <= _Right._Myres())
   974-                       *this = _Right;
   975-                   else
   976-                       {   // not same, clear this and steal from _Right
   977-                       _Tidy(true);
   978-                       _Assign_rv(_STD forward<_Myt>(_Right));
   979-                       }
   980-                   return (*this);
   981-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::~basic_string
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1043: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Tidy


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::~basic_string
FORMAT LIST

 LINE   LOOP      STATEMENT

  1041-               ~basic_string() _NOEXCEPT
  1042-                   {   // destroy the string
  1043-                   _Tidy(true);
  1044-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::append
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1119: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Inside
  1120: inl(1212): Source for routine not found.: std::_Xout_of_range


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::append
FORMAT LIST

 LINE   LOOP      STATEMENT

  1116-               _Myt& append(const _Elem *_Ptr, size_type _Count)
  1117-                   {   // append [_Ptr, _Ptr + _Count)
  1118-                   _DEBUG_POINTER_IF(_Count != 0, _Ptr);
  1119-                   if (_Inside(_Ptr))
  1120-                       return (append(*this,
  1121-                           _Ptr - this->_Myptr(), _Count));    // substring
  1122-                   if (npos - this->_Mysize() <= _Count)
  1123-                       _Xlen();    // result too long
  1124-           
  1125-                   size_type _Num;
  1126-                   if (0 < _Count && _Grow(_Num = this->_Mysize() + _Count))
  1127-                       {   // make room and append new stuff
  1128-                       _Traits::copy(this->_Myptr() + this->_Mysize(), _Ptr, _Count);
  1129-                       _Eos(_Num);
  1130-                       }
  1131-                   return (*this);
  1132-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::assign
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1204: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Inside
  1205: inl(1212): Source for routine not found.: std::_Xout_of_range


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::assign
FORMAT LIST

 LINE   LOOP      STATEMENT

  1201-               _Myt& assign(const _Elem *_Ptr, size_type _Count)
  1202-                   {   // assign [_Ptr, _Ptr + _Count)
  1203-                   _DEBUG_POINTER_IF(_Count != 0, _Ptr);
  1204-                   if (_Inside(_Ptr))
  1205-                       return (assign(*this,
  1206-                           _Ptr - this->_Myptr(), _Count));    // substring
  1207-           
  1208-                   if (_Grow(_Count))
  1209-                       {   // make room and assign new stuff
  1210-                       _Traits::copy(this->_Myptr(), _Ptr, _Count);
  1211-                       _Eos(_Count);
  1212-                       }
  1213-                   return (*this);
  1214-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::insert
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1294: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Inside
  1295: inl(1212): Source for routine not found.: std::_Xout_of_range


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:04 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::insert
FORMAT LIST

 LINE   LOOP      STATEMENT

  1290-               _Myt& insert(size_type _Off,
  1291-                   const _Elem *_Ptr, size_type _Count)
  1292-                   {   // insert [_Ptr, _Ptr + _Count) at _Off
  1293-                   _DEBUG_POINTER_IF(_Count != 0, _Ptr);
  1294-                   if (_Inside(_Ptr))
  1295-                       return (insert(_Off, *this,
  1296-                           _Ptr - this->_Myptr(), _Count));    // substring
  1297-                   if (this->_Mysize() < _Off)
  1298-                       _Xran();    // _Off off end
  1299-                   if (npos - this->_Mysize() <= _Count)
  1300-                       _Xlen();    // result too long
  1301-                   size_type _Num;
  1302-                   if (0 < _Count && _Grow(_Num = this->_Mysize() + _Count))
  1303-                       {   // make room and insert new stuff
  1304-                       _Traits::move(this->_Myptr() + _Off + _Count,
  1305-                           this->_Myptr() + _Off,
  1306-                           this->_Mysize() - _Off);    // empty out hole
  1307-                       _Traits::copy(this->_Myptr() + _Off, _Ptr, _Count); // fill hole
  1308-                       _Eos(_Num);
  1309-                       }
  1310-                   return (*this);
  1311-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::erase
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1398: inl(1212): Source for routine not found.: std::_Xout_of_range


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::erase
FORMAT LIST

 LINE   LOOP      STATEMENT

  1395-               _Myt& erase(size_type _Off, size_type _Count)
  1396-                   {   // erase elements [_Off, _Off + _Count)
  1397-                   if (this->_Mysize() < _Off)
  1398-                       _Xran();    // _Off off end
  1399-                   if (this->_Mysize() - _Off <= _Count)
  1400-                       _Eos(_Off); // erase elements [_Off, ...)
  1401-                   else if (0 < _Count)
  1402-                       {   // move elements down
  1403-                       value_type *_Ptr = this->_Myptr() + _Off;
  1404-                       size_type _Newsize = this->_Mysize() - _Count;
  1405-                       _Traits::move(_Ptr, _Ptr + _Count, _Newsize - _Off);
  1406-                       _Eos(_Newsize);
  1407-                       }
  1408-                   return (*this);
  1409-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::reserve
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1841: inl(1212): Source for routine not found.: std::_Xlength_error


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::reserve
FORMAT LIST

 LINE   LOOP      STATEMENT

  1836-               void reserve(size_type _Newcap = 0)
  1837-                   {   // determine new minimum length of allocated storage
  1838-                   if (this->_Mysize() <= _Newcap && this->_Myres() != _Newcap)
  1839-                       {   // change reservation
  1840-                       size_type _Size = this->_Mysize();
  1841-                       if (_Grow(_Newcap, true))
  1842-                           _Eos(_Size);
  1843-                       }
  1844-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Copy
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2225: inl(1212): Source for routine not found.: std::_Allocate<char>
  2231: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Tidy
  2240: inl(1212): Source for routine not found.: std::forward<char *&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Copy
FORMAT LIST

 LINE   LOOP      STATEMENT

  2210-               void _Copy(size_type _Newsize, size_type _Oldlen)
  2211-                   {   // copy _Oldlen elements to newly allocated buffer
  2212-                   size_type _Newres = _Newsize | this->_ALLOC_MASK;
  2213-                   if (max_size() < _Newres)
  2214-                       _Newres = _Newsize; // undo roundup if too big
  2215-                   else if (this->_Myres() / 2 <= _Newres / 3)
  2216-                       ;
  2217-                   else if (this->_Myres() <= max_size() - this->_Myres() / 2)
  2218-                       _Newres = this->_Myres()
  2219-                           + this->_Myres() / 2;   // grow exponentially if possible
  2220-                   else
  2221-                       _Newres = max_size();   // settle for max_size()
  2222-           
  2223-                   _Elem *_Ptr;
  2224-                   _TRY_BEGIN
  2225-                       _Ptr = this->_Getal().allocate(_Newres + 1);
  2226-                   _CATCH_ALL
  2227-                       _Newres = _Newsize; // allocation failed, undo roundup and retry
  2228-                       _TRY_BEGIN
  2229-                           _Ptr = this->_Getal().allocate(_Newres + 1);
  2230-                       _CATCH_ALL
  2231-                       _Tidy(true);    // failed again, discard storage and reraise
  2232-                       _RERAISE;
  2233-                       _CATCH_END
  2234-                   _CATCH_END
  2235-           
  2236-                   if (0 < _Oldlen)
  2237-                       _Traits::copy(_Ptr, this->_Myptr(),
  2238-                           _Oldlen);   // copy existing elements
  2239-                   _Tidy(true);
  2240-                   this->_Getal().construct(&this->_Bx()._Ptr, _Ptr);
  2241-                   this->_Myres() = _Newres;
  2242-                   _Eos(_Oldlen);
  2243-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Inside
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Inside
FORMAT LIST

 LINE   LOOP      STATEMENT

  2265-               bool _Inside(const _Elem *_Ptr)
  2266-                   {   // test if _Ptr points inside string
  2267-                   if (_Ptr == 0 || _Ptr < this->_Myptr()
  2268-                       || this->_Myptr() + this->_Mysize() <= _Ptr)
  2269-                       return (false); // don't ask
  2270-                   else
  2271-                       return (true);
  2272-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Tidy
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2286: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Tidy
FORMAT LIST

 LINE   LOOP      STATEMENT

  2274-               void _Tidy(bool _Built = false,
  2275-                   size_type _Newsize = 0)
  2276-                   {   // initialize buffer, deallocating any storage
  2277-                   if (!_Built)
  2278-                       ;
  2279-                   else if (this->_BUF_SIZE <= this->_Myres())
  2280-                       {   // copy any leftovers to small buffer and deallocate
  2281-                       pointer _Ptr = this->_Bx()._Ptr;
  2282-                       this->_Getal().destroy(&this->_Bx()._Ptr);
  2283-                       if (0 < _Newsize)
  2284-                           _Traits::copy(this->_Bx()._Buf,
  2285-                               _STD addressof(*_Ptr), _Newsize);
  2286-                       this->_Getal().deallocate(_Ptr, this->_Myres() + 1);
  2287-                       }
  2288-                   this->_Myres() = this->_BUF_SIZE - 1;
  2289-                   _Eos(_Newsize);
  2290-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::logic_error::logic_error
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    29: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::logic_error::logic_error
FORMAT LIST

 LINE   LOOP      STATEMENT

    28-               explicit logic_error(const char *_Message)
    29-                   : _Str(_Message)
    30-                   {   // construct from message string
    31-                   }
    32-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::logic_error::~logic_error
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    35: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Tidy


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::logic_error::~logic_error
FORMAT LIST

 LINE   LOOP      STATEMENT

    33-               virtual ~logic_error() _NOEXCEPT
    34-                   {   // destroy the object
    35-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::logic_error::what const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::logic_error::what const
FORMAT LIST

 LINE   LOOP      STATEMENT

    37-               virtual const char *what() const _THROW0()
    38-                   {   // return pointer to message string
    39-                   return (_Str.c_str());
    40-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::invalid_argument::invalid_argument
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    92: inl(1212): Source for routine not found.: std::logic_error::logic_error


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::invalid_argument::invalid_argument
FORMAT LIST

 LINE   LOOP      STATEMENT

    91-               explicit invalid_argument(const string& _Message)
    92-                   : _Mybase(_Message.c_str())
    93-                   {   // construct from message string
    94-                   }
    95-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::invalid_argument::invalid_argument
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    97: inl(1212): Source for routine not found.: std::logic_error::logic_error


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::invalid_argument::invalid_argument
FORMAT LIST

 LINE   LOOP      STATEMENT

    96-               explicit invalid_argument(const char *_Message)
    97-                   : _Mybase(_Message)
    98-                   {   // construct from message string
    99-                   }
   100-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::runtime_error::runtime_error
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   174: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::runtime_error::runtime_error
FORMAT LIST

 LINE   LOOP      STATEMENT

   173-               explicit runtime_error(const string& _Message)
   174-                   : _Str(_Message)
   175-                   {   // construct from message string
   176-                   }
   177-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::runtime_error::runtime_error
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   179: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::runtime_error::runtime_error
FORMAT LIST

 LINE   LOOP      STATEMENT

   178-               explicit runtime_error(const char *_Message)
   179-                   : _Str(_Message)
   180-                   {   // construct from message string
   181-                   }
   182-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::runtime_error::~runtime_error
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   185: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::_Tidy


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::runtime_error::~runtime_error
FORMAT LIST

 LINE   LOOP      STATEMENT

   183-               virtual ~runtime_error() _NOEXCEPT
   184-                   {   // destroy the object
   185-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::runtime_error::what const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/stdexcept

FUNCTION NAME: std::runtime_error::what const
FORMAT LIST

 LINE   LOOP      STATEMENT

   187-               virtual const char *what() const _THROW0()
   188-                   {   // return pointer to message string
   189-                   return (_Str.c_str());
   190-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/typeinfo

FUNCTION NAME: std::bad_cast::bad_cast
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/typeinfo

FUNCTION NAME: std::bad_cast::bad_cast
FORMAT LIST

 LINE   LOOP      STATEMENT

    21-               bad_cast() _THROW0()
    22-                   {   // construct with no message string
    23-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/typeinfo

FUNCTION NAME: std::bad_cast::what const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/typeinfo

FUNCTION NAME: std::bad_cast::what const
FORMAT LIST

 LINE   LOOP      STATEMENT

    28-               virtual const char *what() const _THROW0()
    29-                   {   // report a bad cast
    30-                   return ("bad cast");
    31-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocinfo

FUNCTION NAME: std::_Locinfo::_Getctype const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    75: inl(1212): Source for routine not found.: _Getctyptab


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocinfo

FUNCTION NAME: std::_Locinfo::_Getctype const
FORMAT LIST

 LINE   LOOP      STATEMENT

    72-               _Ctypevec _Getctype() const
    73-                   {   // return ctype stuff
    74-                   _Ctypevec _Vec = {0};
    75-                   _Vec._Table = _CSTD _Getctyptab();
    76-                   _Vec._Delfl = 1;
    77-                   return (_Vec);
    78-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocinfo

FUNCTION NAME: std::_Locinfo::_Getcvt const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocinfo

FUNCTION NAME: std::_Locinfo::_Getcvt const
FORMAT LIST

 LINE   LOOP      STATEMENT

    80-               _Cvtvec _Getcvt() const
    81-                   {   // return codecvt stuff
    82-                   _Cvtvec _Vec = {0};
    83-                   return (_Vec);
    84-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::_Facet_base::~_Facet_base
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::_Facet_base::~_Facet_base
FORMAT LIST

 LINE   LOOP      STATEMENT

    25-               virtual ~_Facet_base() _NOEXCEPT
    26-                   {   // ensure that derived classes can be destroyed properly
    27-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::~locale
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::~locale
FORMAT LIST

 LINE   LOOP      STATEMENT

   430-               ~locale() _NOEXCEPT
   431-                   {   // destroy the object
   432-                   if (_Ptr != 0)
   433-                       delete _Ptr->_Decref();
   434-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::_Getfacet const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   466: inl(1212): Source for routine not found.: std::locale::_Getgloballocale


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::_Getfacet const
FORMAT LIST

 LINE   LOOP      STATEMENT

   458-               const facet *_Getfacet(size_t _Id) const
   459-                   {   // look up a facet in locale object
   460-                   const facet *_Facptr = _Id < _Ptr->_Facetcount
   461-                       ? _Ptr->_Facetvec[_Id] : 0; // null if id off end
   462-                   if (_Facptr != 0 || !_Ptr->_Xparent)
   463-                       return (_Facptr);   // found facet or not transparent
   464-                   else
   465-                       {   // look in current locale
   466-                       locale::_Locimp *_Ptr0 = _Getgloballocale();
   467-                       return (_Id < _Ptr0->_Facetcount
   468-                           ? _Ptr0->_Facetvec[_Id] // get from current locale
   469-                           : 0);   // no entry in current locale
   470-                       }
   471-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::id::id
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::id::id
FORMAT LIST

 LINE   LOOP      STATEMENT

    82-                   id(size_t _Val = 0)
    83-                       : _Id(_Val)
    84-                       {   // construct with specified stamp value
    85-                       }
    86-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::facet::_Incref
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::facet::_Incref
FORMAT LIST

 LINE   LOOP      STATEMENT

   130-                   virtual void _Incref()
   131-                       {   // increment use count
   132-                       _MT_INCR(_Mtx, _Myrefs);
   133-                       }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::facet::_Decref
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::facet::_Decref
FORMAT LIST

 LINE   LOOP      STATEMENT

   135-                   virtual _Facet_base *_Decref()
   136-                       {   // decrement use count
   137-                       if (_MT_DECR(_Mtx, _Myrefs) == 0)
   138-                           return (this);
   139-                       else
   140-                           return (0);
   141-                       }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::facet::facet
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   187: inl(1212): Source for routine not found.: std::_Facet_base::_Facet_base [subobject]


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::facet::facet
FORMAT LIST

 LINE   LOOP      STATEMENT

   185-                   explicit facet(size_t _Initrefs = 0)
   186-                       : _Myrefs((long)_Initrefs)
   187-                       {   // construct
   188-                       }
   189-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::facet::~facet
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::locale::facet::~facet
FORMAT LIST

 LINE   LOOP      STATEMENT

   191-                   virtual ~facet() _NOEXCEPT
   192-                       {   // ensure that derived classes can be destroyed properly
   193-                       }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype_base::ctype_base
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1783: inl(1212): Source for routine not found.: std::locale::facet::facet


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype_base::ctype_base
FORMAT LIST

 LINE   LOOP      STATEMENT

  1782-               ctype_base(size_t _Refs = 0)
  1783-                   : locale::facet(_Refs)
  1784-                   {   // default constructor
  1785-                   }
  1786-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype_base::~ctype_base
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1789: inl(1212): Source for routine not found.: std::locale::facet::~facet


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype_base::~ctype_base
FORMAT LIST

 LINE   LOOP      STATEMENT

  1787-               ~ctype_base() _NOEXCEPT
  1788-                   {   // destroy the object
  1789-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::ctype
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2138: inl(1212): Source for routine not found.: std::ctype_base::ctype_base
  2140: inl(1212): Source for routine not found.: std::ctype<char>::_Init


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::ctype
FORMAT LIST

 LINE   LOOP      STATEMENT

  2137-               ctype(const _Locinfo& _Lobj, size_t _Refs = 0)
  2138-                   : ctype_base(_Refs)
  2139-                   {   // construct from current locale
  2140-                   _Init(_Lobj);
  2141-                   }
  2142-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::_Getcat
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2147: inl(1212): Source for routine not found.: std::_Locinfo::_Locinfo


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::_Getcat
FORMAT LIST

 LINE   LOOP      STATEMENT

  2143-               static size_t _Getcat(const locale::facet **_Ppf = 0,
  2144-                   const locale *_Ploc = 0)
  2145-                   {   // return locale category mask and construct standard facet
  2146-                   if (_Ppf != 0 && *_Ppf == 0)
  2147-                       *_Ppf = new ctype<_Elem>(
  2148-                           _Locinfo(_Ploc->c_str()));
  2149-                   return (_X_CTYPE);
  2150-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::~ctype
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2168: inl(1212): Source for routine not found.: std::ctype<char>::_Tidy
  2169: inl(1212): Source for routine not found.: std::ctype_base::~ctype_base


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::~ctype
FORMAT LIST

 LINE   LOOP      STATEMENT

  2166-               virtual ~ctype() _NOEXCEPT
  2167-                   {   // destroy the object
  2168-                   _Tidy();
  2169-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::_Init
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2177: inl(1212): Source for routine not found.: std::_Locinfo::_Getctype const


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::_Init
FORMAT LIST

 LINE   LOOP      STATEMENT

  2171-               void _Init(const _Locinfo& _Lobj)
  2172-                   {   // initialize from _Lobj
  2173-            #if __BORLANDC__   /* compiler test */
  2174-                   *(size_t *)&table_size = 1 << CHAR_BIT; // force space reservation
  2175-            #endif /* __BORLANDC__ */
  2176-           
  2177-                   _Ctype = _Lobj._Getctype();
  2178-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::_Tidy
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2185: inl(1212): Source for routine not found.: operator delete[] 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::_Tidy
FORMAT LIST

 LINE   LOOP      STATEMENT

  2180-               void _Tidy()
  2181-                   {   // free any allocated storage
  2182-                   if (0 < _Ctype._Delfl)
  2183-                       _CSTD free((void *)_Ctype._Table);
  2184-                   else if (_Ctype._Delfl < 0)
  2185-                       delete[] _Ctype._Table;
  2186-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_tolower const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_tolower const
FORMAT LIST

 LINE   LOOP      STATEMENT

  2188-               virtual _Elem do_tolower(_Elem _Ch) const
  2189-                   {   // convert element to lower case
  2190-                   return ((_Elem)_Tolower((unsigned char)_Ch, &_Ctype));
  2191-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_tolower const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2197: vec( 103): Unvectorized loop.
  2197: vec( 110): Vectorization obstructive function reference.: tolower


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_tolower const
FORMAT LIST

 LINE   LOOP      STATEMENT

  2193-               virtual const _Elem *do_tolower(_Elem *_First,
  2194-                   const _Elem *_Last) const
  2195-                   {   // convert [_First, _Last) in place to lower case
  2196-                   _DEBUG_RANGE((const _Elem *)_First, _Last);
  2197- +------>          for (; _First != _Last; ++_First)
  2198- +------               *_First = (_Elem)_Tolower((unsigned char)*_First, &_Ctype);
  2199-                   return ((const _Elem *)_First);
  2200-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_toupper const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_toupper const
FORMAT LIST

 LINE   LOOP      STATEMENT

  2202-               virtual _Elem do_toupper(_Elem _Ch) const
  2203-                   {   // convert element to upper case
  2204-                   return ((_Elem)_Toupper((unsigned char)_Ch, &_Ctype));
  2205-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_toupper const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2211: vec( 103): Unvectorized loop.
  2211: vec( 110): Vectorization obstructive function reference.: toupper


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_toupper const
FORMAT LIST

 LINE   LOOP      STATEMENT

  2207-               virtual const _Elem *do_toupper(_Elem *_First,
  2208-                   const _Elem *_Last) const
  2209-                   {   // convert [_First, _Last) in place to upper case
  2210-                   _DEBUG_RANGE((const _Elem *)_First, _Last);
  2211- +------>          for (; _First != _Last; ++_First)
  2212- +------               *_First = (_Elem)_Toupper((unsigned char)*_First, &_Ctype);
  2213-                   return ((const _Elem *)_First);
  2214-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_widen const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_widen const
FORMAT LIST

 LINE   LOOP      STATEMENT

  2216-               virtual _Elem do_widen(char _Byte) const
  2217-                   {   // widen char
  2218-                   return (_Byte);
  2219-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_widen const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_widen const
FORMAT LIST

 LINE   LOOP      STATEMENT

  2221-               virtual const _Elem *do_widen(const char *_First,
  2222-                   const char *_Last, _Elem *_Dest) const
  2223-                   {   // widen chars in [_First, _Last)
  2224-                   _DEBUG_RANGE_PTR(_First, _Last, _Dest);
  2225-                   _CSTD memcpy(_Dest, _First, _Last - _First);
  2226-                   return (_Last);
  2227-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_narrow const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_narrow const
FORMAT LIST

 LINE   LOOP      STATEMENT

  2229-               virtual _Elem do_narrow(_Elem _Ch, char) const
  2230-                   {   // narrow char
  2231-                   return (_Ch);
  2232-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_narrow const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::ctype<char>::do_narrow const
FORMAT LIST

 LINE   LOOP      STATEMENT

  2234-               virtual const _Elem *do_narrow(const _Elem *_First,
  2235-                   const _Elem *_Last, char, char *_Dest) const
  2236-                   {   // narrow elements in [_First, _Last) to chars
  2237-                   _DEBUG_RANGE_PTR(_First, _Last, _Dest);
  2238-                   _CSTD memcpy(_Dest, _First, _Last - _First);
  2239-                   return (_Last);
  2240-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::error_category::~error_category
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::error_category::~error_category
FORMAT LIST

 LINE   LOOP      STATEMENT

   187-               virtual ~error_category() _NOEXCEPT
   188-                   {   // destroy the object
   189-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::error_category::default_error_condition const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::error_category::default_error_condition const
FORMAT LIST

 LINE   LOOP      STATEMENT

   492-               error_category::default_error_condition(int _Errval) const _NOEXCEPT
   493-               {   // make error_condition for error code
   494-               return (error_condition(_Errval, *this));
   495-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::error_category::equivalent const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::error_category::equivalent const
FORMAT LIST

 LINE   LOOP      STATEMENT

   498-               error_category::equivalent(int _Errval,
   499-                   const error_condition& _Cond) const _NOEXCEPT
   500-               {   // test if error code same condition
   501-               return (default_error_condition(_Errval) == _Cond);
   502-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::error_category::equivalent const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::error_category::equivalent const
FORMAT LIST

 LINE   LOOP      STATEMENT

   505-               error_category::equivalent(const error_code& _Code,
   506-                   int _Errval) const _NOEXCEPT
   507-               {   // test if conditions same for this category
   508-               return (*this == _Code.category() && _Code.value() == _Errval);
   509-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_System_error::_Makestr
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   562: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::append
   563: inl(1212): Source for routine not found.: std::_Xout_of_range
   564: inl(1212): Source for routine not found.: std::move<std::_Wrap_alloc<std::allocator<char>> &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_System_error::_Makestr
FORMAT LIST

 LINE   LOOP      STATEMENT

   559-               static string _Makestr(error_code _Errcode, string _Message)
   560-                   {   // compose error message
   561-                   if (!_Message.empty())
   562-                       _Message.append(": ");
   563-                   _Message.append(_Errcode.message());
   564-                   return (_Message);
   565-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_System_error::_System_error
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   569: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_System_error::_System_error
FORMAT LIST

 LINE   LOOP      STATEMENT

   568-               _System_error(error_code _Errcode, const string& _Message)
   569-                   : runtime_error(_Makestr(_Errcode, _Message)), _Mycode(_Errcode)
   570-                   {   // construct from error code and message string
   571-                   }
   572-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::system_error::system_error
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   594: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::system_error::system_error
FORMAT LIST

 LINE   LOOP      STATEMENT

   593-               system_error(error_code _Errcode, const char *_Message)
   594-                   : _Mybase(_Errcode, _Message)
   595-                   {   // construct from error code and message string
   596-                   }
   597-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Generic_error_category::_Generic_error_category
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Generic_error_category::_Generic_error_category
FORMAT LIST

 LINE   LOOP      STATEMENT

   638-               _Generic_error_category() _NOEXCEPT
   639-                   {   // default constructor
   640-                   _Addr = _Generic_addr;
   641-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Generic_error_category::name const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Generic_error_category::name const
FORMAT LIST

 LINE   LOOP      STATEMENT

   643-               virtual const char *name() const _NOEXCEPT
   644-                   {   // get name of category
   645-                   return ("generic");
   646-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Generic_error_category::message const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   650: inl(1212): Source for routine not found.: std::_Syserror_map
   651: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Generic_error_category::message const
FORMAT LIST

 LINE   LOOP      STATEMENT

   648-               virtual string message(int _Errcode) const
   649-                   {   // convert to name of error
   650-                   const char *_Name = _Syserror_map(_Errcode);
   651-                   return (string(_Name != 0 ? _Name : "unknown error"));
   652-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Iostream_error_category::_Iostream_error_category
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   661: inl(1212): Source for routine not found.: std::_Generic_error_category::_Generic_error_category


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Iostream_error_category::_Iostream_error_category
FORMAT LIST

 LINE   LOOP      STATEMENT

   660-               _Iostream_error_category() _NOEXCEPT
   661-                   {   // default constructor
   662-                   _Addr = _Iostream_addr;
   663-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Iostream_error_category::name const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Iostream_error_category::name const
FORMAT LIST

 LINE   LOOP      STATEMENT

   665-               virtual const char *name() const _NOEXCEPT
   666-                   {   // get name of category
   667-                   return ("iostream");
   668-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Iostream_error_category::message const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   673: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
   675: inl(1212): Source for routine not found.: std::_Syserror_map


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Iostream_error_category::message const
FORMAT LIST

 LINE   LOOP      STATEMENT

   670-               virtual string message(int _Errcode) const
   671-                   {   // convert to name of error
   672-                   if (_Errcode == (int)io_errc::stream)
   673-                       return ("iostream stream error");
   674-                   else
   675-                       return (_Generic_error_category::message(_Errcode));
   676-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Immortalizer<std::_Iostream_error_category>::~_Immortalizer
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Immortalizer<std::_Iostream_error_category>::~_Immortalizer
FORMAT LIST

 LINE   LOOP      STATEMENT

   718-               ~_Immortalizer() _NOEXCEPT
   719-                   {   // intentionally do nothing
   720-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::ios_base::clear
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   323: inl(1212): Source for routine not found.: std::iostream_category


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::ios_base::clear
FORMAT LIST

 LINE   LOOP      STATEMENT

   315-               void clear(iostate _State, bool _Reraise)
   316-                   {   // set state, possibly reraise exception
   317-                   _Mystate = (iostate)(_State & _Statmask);
   318-                   if ((_Mystate & _Except) == 0)
   319-                       ;
   320-                   else if (_Reraise)
   321-                       _RERAISE;
   322-                   else if (_Mystate & _Except & badbit)
   323-                       _THROW_N(failure, "ios_base::badbit set");
   324-                   else if (_Mystate & _Except & failbit)
   325-                       _THROW_N(failure, "ios_base::failbit set");
   326-                   else
   327-                       _THROW_N(failure, "ios_base::eofbit set");
   328-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::ios_base::fail const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::ios_base::fail const
FORMAT LIST

 LINE   LOOP      STATEMENT

   372-               bool fail() const
   373-                   {   // test if badbit or failbit is set in stream state
   374-                   return (((int)rdstate()
   375-                       & ((int)badbit | (int)failbit)) != 0);
   376-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::ios_base::_Init
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   566: inl(1212): Source for routine not found.: std::ios_base::clear
   567: inl(1212): Source for routine not found.: std::locale::_Init


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:05 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::ios_base::_Init
FORMAT LIST

 LINE   LOOP      STATEMENT

   556-               void _Init()
   557-                   {   // initialize a new ios_base
   558-                   _Ploc = 0;
   559-                   _Stdstr = 0;
   560-                   _Except = goodbit;
   561-                   _Fmtfl = (fmtflags)(skipws | dec);
   562-                   _Prec = 6;
   563-                   _Wide = 0;
   564-                   _Arr = 0;
   565-                   _Calls = 0;
   566-                   clear(goodbit);
   567-                   _Ploc = new locale;
   568-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::ios_base::failure::failure
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   258: inl(1212): Source for routine not found.: std::system_error::system_error


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::ios_base::failure::failure
FORMAT LIST

 LINE   LOOP      STATEMENT

   256-                   explicit failure(const char *_Message,
   257-                       const error_code& _Errcode = make_error_code(io_errc::stream))
   258-                       : system_error(_Errcode, _Message)
   259-                       {   // construct with message
   260-                       }
   261-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>>::~vector
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1093: inl(1212): Source for routine not found.: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::~pair
  1093: vec( 103): Unvectorized loop.
  1093: vec( 110): Vectorization obstructive function reference.: ~pair


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>>::~vector
FORMAT LIST

 LINE   LOOP      STATEMENT

  1091-               ~vector() _NOEXCEPT
  1092-                   {   // destroy the object
  1093- +======>          _Tidy();
  1094-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>>::_Buy
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1747: inl(1212): Source for routine not found.: std::_Xlength_error
  1750: inl(1212): Source for routine not found.: std::_Allocate<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>>::_Buy
FORMAT LIST

 LINE   LOOP      STATEMENT

  1738-               _NOINLINE bool _Buy(size_type _Capacity)
  1739-                   {   // allocate array with _Capacity elements
  1740-                   this->_Myfirst() = pointer();
  1741-                   this->_Mylast() = pointer();
  1742-                   this->_Myend() = pointer();
  1743-           
  1744-                   if (_Capacity == 0)
  1745-                       return (false);
  1746-                   else if (max_size() < _Capacity)
  1747-                       _Xlen();    // result too long
  1748-                   else
  1749-                       {   // nonempty array, allocate storage
  1750-                       this->_Myfirst() = this->_Getal().allocate(_Capacity);
  1751-                       this->_Mylast() = this->_Myfirst();
  1752-                       this->_Myend() = this->_Myfirst() + _Capacity;
  1753-                       }
  1754-                   return (true);
  1755-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>>::_Construct<const std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> *>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   845: inl(1212): Source for routine not found.: std::vector<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>>::_Buy
   848: inl(1212): Source for routine not found.: std::_Uninit_copy<const std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> *, std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> *, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>>
   850: inl(1212): Source for routine not found.: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::~pair
   850: vec( 103): Unvectorized loop.
   850: vec( 110): Vectorization obstructive function reference.: ~pair


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>>::_Construct<const std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> *>
FORMAT LIST

 LINE   LOOP      STATEMENT

   842-                   _NOINLINE void _Construct(_Iter _First, _Iter _Last,
   843-                       forward_iterator_tag)
   844-                   {   // initialize with [_First, _Last), forward iterators
   845-                   if (_Buy(_STD distance(_First, _Last)))
   846-                       {   // nonzero, fill it
   847-                       _TRY_BEGIN
   848-                       this->_Mylast() = _Ucopy(_First, _Last, this->_Myfirst());
   849-                       _CATCH_ALL
   850- +======>              _Tidy();
   851-                       _RERAISE;
   852-                       _CATCH_END
   853-                       }
   854-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>::begin const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>::begin const
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _CONST_FUN const _Elem *begin() const _NOEXCEPT
    37-                   {   // get beginning of list
    38-                   return (_First);
    39-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>::end const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>::end const
FORMAT LIST

 LINE   LOOP      STATEMENT

    41-               _CONST_FUN const _Elem *end() const _NOEXCEPT
    42-                   {   // get end of list
    43-                   return (_Last);
    44-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::pair
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::pair
FORMAT LIST

 LINE   LOOP      STATEMENT

   113-               pair(const pair&) = default;


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::pair<const char (&)[2], int, void>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   221: inl(1212): Source for routine not found.: std::forward<const char (&)[2]>
   222: inl(1212): Source for routine not found.: std::forward<int>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::pair<const char (&)[2], int, void>
FORMAT LIST

 LINE   LOOP      STATEMENT

   218-                   _CONST_FUN pair(_Other1&& _Val1, _Other2&& _Val2)
   219-                       _NOEXCEPT_OP((is_nothrow_constructible<_Ty1, _Other1&&>::value
   220-                           && is_nothrow_constructible<_Ty2, _Other2&&>::value))
   221-                   : first(_STD forward<_Other1>(_Val1)),
   222-                           second(_STD forward<_Other2>(_Val2))
   223-                   {   // construct from moved values
   224-                   }
   225-           
   226-               template<class _Other1,


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::pair<const char (&)[3], int, void>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   221: inl(1212): Source for routine not found.: std::forward<const char (&)[3]>
   222: inl(1212): Source for routine not found.: std::forward<int>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::pair<const char (&)[3], int, void>
FORMAT LIST

 LINE   LOOP      STATEMENT

   218-                   _CONST_FUN pair(_Other1&& _Val1, _Other2&& _Val2)
   219-                       _NOEXCEPT_OP((is_nothrow_constructible<_Ty1, _Other1&&>::value
   220-                           && is_nothrow_constructible<_Ty2, _Other2&&>::value))
   221-                   : first(_STD forward<_Other1>(_Val1)),
   222-                           second(_STD forward<_Other2>(_Val2))
   223-                   {   // construct from moved values
   224-                   }
   225-           
   226-               template<class _Other1,


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<unsigned long, std::allocator<unsigned long>>::push_back
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   977: inl(1212): Source for routine not found.: std::_Xlength_error
   979: inl(1212): Source for routine not found.: std::forward<unsigned long>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<unsigned long, std::allocator<unsigned long>>::push_back
FORMAT LIST

 LINE   LOOP      STATEMENT

   971-               void push_back(value_type&& _Val)
   972-                   {   // insert by moving into element at end
   973-                   if (_Inside(_STD addressof(_Val)))
   974-                       {   // push back an element
   975-                       size_type _Idx = _STD addressof(_Val) - this->_Myfirst();
   976-                       if (this->_Mylast() == this->_Myend())
   977-                           _Reserve(1);
   978-                       _Orphan_range(this->_Mylast(), this->_Mylast());
   979-                       this->_Getal().construct(this->_Mylast(),
   980-                           _STD forward<value_type>(this->_Myfirst()[_Idx]));
   981-                       ++this->_Mylast();
   982-                       }
   983-                   else
   984-                       {   // push back a non-element
   985-                       if (this->_Mylast() == this->_Myend())
   986-                           _Reserve(1);
   987-                       _Orphan_range(this->_Mylast(), this->_Mylast());
   988-                       this->_Getal().construct(this->_Mylast(),
   989-                           _STD forward<value_type>(_Val));
   990-                       ++this->_Mylast();
   991-                       }
   992-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<unsigned long, std::allocator<unsigned long>>::~vector
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1093: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<unsigned long, std::allocator<unsigned long>>::~vector
FORMAT LIST

 LINE   LOOP      STATEMENT

  1091-               ~vector() _NOEXCEPT
  1092-                   {   // destroy the object
  1093-                   _Tidy();
  1094-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<unsigned long, std::allocator<unsigned long>>::_Buy
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1747: inl(1212): Source for routine not found.: std::_Xlength_error
  1750: inl(1212): Source for routine not found.: std::_Allocate<unsigned long>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<unsigned long, std::allocator<unsigned long>>::_Buy
FORMAT LIST

 LINE   LOOP      STATEMENT

  1738-               _NOINLINE bool _Buy(size_type _Capacity)
  1739-                   {   // allocate array with _Capacity elements
  1740-                   this->_Myfirst() = pointer();
  1741-                   this->_Mylast() = pointer();
  1742-                   this->_Myend() = pointer();
  1743-           
  1744-                   if (_Capacity == 0)
  1745-                       return (false);
  1746-                   else if (max_size() < _Capacity)
  1747-                       _Xlen();    // result too long
  1748-                   else
  1749-                       {   // nonempty array, allocate storage
  1750-                       this->_Myfirst() = this->_Getal().allocate(_Capacity);
  1751-                       this->_Mylast() = this->_Myfirst();
  1752-                       this->_Myend() = this->_Myfirst() + _Capacity;
  1753-                       }
  1754-                   return (true);
  1755-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<unsigned long, std::allocator<unsigned long>>::_Reallocate
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1780: inl(1212): Source for routine not found.: std::_Allocate<unsigned long>
  1785: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<unsigned long, std::allocator<unsigned long>>::_Reallocate
FORMAT LIST

 LINE   LOOP      STATEMENT

  1778-               _NOINLINE void _Reallocate(size_type _Count)
  1779-                   {   // move to array of exactly _Count elements
  1780-                   pointer _Ptr = this->_Getal().allocate(_Count);
  1781-           
  1782-                   _TRY_BEGIN
  1783-                   _Umove(this->_Myfirst(), this->_Mylast(), _Ptr);
  1784-                   _CATCH_ALL
  1785-                   this->_Getal().deallocate(_Ptr, _Count);
  1786-                   _RERAISE;
  1787-                   _CATCH_END
  1788-           
  1789-                   size_type _Size = size();
  1790-                   if (this->_Myfirst() != pointer())
  1791-                       {   // destroy and deallocate old array
  1792-                       _Destroy(this->_Myfirst(), this->_Mylast());
  1793-                       this->_Getal().deallocate(this->_Myfirst(),
  1794-                           this->_Myend() - this->_Myfirst());
  1795-                       }
  1796-           
  1797-                   this->_Orphan_all();
  1798-                   this->_Myend() = _Ptr + _Count;
  1799-                   this->_Mylast() = _Ptr + _Size;
  1800-                   this->_Myfirst() = _Ptr;
  1801-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<unsigned long, std::allocator<unsigned long>>::_Construct<const unsigned long *>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   845: inl(1212): Source for routine not found.: std::vector<unsigned long, std::allocator<unsigned long>>::_Buy
   850: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<unsigned long, std::allocator<unsigned long>>::_Construct<const unsigned long *>
FORMAT LIST

 LINE   LOOP      STATEMENT

   842-                   _NOINLINE void _Construct(_Iter _First, _Iter _Last,
   843-                       forward_iterator_tag)
   844-                   {   // initialize with [_First, _Last), forward iterators
   845-                   if (_Buy(_STD distance(_First, _Last)))
   846-                       {   // nonzero, fill it
   847-                       _TRY_BEGIN
   848-                       this->_Mylast() = _Ucopy(_First, _Last, this->_Myfirst());
   849-                       _CATCH_ALL
   850-                       _Tidy();
   851-                       _RERAISE;
   852-                       _CATCH_END
   853-                       }
   854-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ios

FUNCTION NAME: std::basic_ios<char, std::char_traits<char>>::~basic_ios
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    31: inl(1212): Source for routine not found.: std::ios_base::~ios_base [subobject]


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ios

FUNCTION NAME: std::basic_ios<char, std::char_traits<char>>::~basic_ios
FORMAT LIST

 LINE   LOOP      STATEMENT

    29-               virtual ~basic_ios() _NOEXCEPT
    30-                   {   // destroy the object
    31-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ios

FUNCTION NAME: std::basic_ios<char, std::char_traits<char>>::widen const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   118: inl(1212): Source for routine not found.: std::use_facet<std::ctype<char>>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ios

FUNCTION NAME: std::basic_ios<char, std::char_traits<char>>::widen const
FORMAT LIST

 LINE   LOOP      STATEMENT

   116-               _Elem widen(char _Byte) const
   117-                   {   // convert _Byte to character using imbued locale
   118-                   const _Ctype& _Ctype_fac = use_facet< _Ctype >(getloc());
   119-                   return (_Ctype_fac.widen(_Byte));
   120-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ios

FUNCTION NAME: std::basic_ios<char, std::char_traits<char>>::basic_ios
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ios

FUNCTION NAME: std::basic_ios<char, std::char_traits<char>>::basic_ios
FORMAT LIST

 LINE   LOOP      STATEMENT

   172-               basic_ios()
   173-                   {   // default constructor, do nothing
   174-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_istream<char, std::char_traits<char>>::~basic_istream [subobject]
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    77: inl(1212): Source for routine not found.: std::basic_ios<char, std::char_traits<char>>::~basic_ios


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_istream<char, std::char_traits<char>>::~basic_istream [subobject]
FORMAT LIST

 LINE   LOOP      STATEMENT

    76-               virtual ~basic_istream() _NOEXCEPT
    77-                   {   // destroy the object
    78-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_istream<char, std::char_traits<char>>::_Ipfx
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   141: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::flush
   143: inl(1212): Source for routine not found.: std::operator &
   145: inl(1212): Source for routine not found.: std::use_facet<std::ctype<char>>
   148: inl(1212): Source for routine not found.: std::char_traits<char>::to_int_type
   150: inl(1212): Source for routine not found.: std::char_traits<char>::eq_int_type
   150: vec( 103): Unvectorized loop.
   150: vec( 108): Unvectorizable loop structure.
   150: vec( 110): Vectorization obstructive function reference.:  
   150: vec( 110): Vectorization obstructive function reference.: to_int_type
   150: vec( 110): Vectorization obstructive function reference.: to_char_type
   150: vec( 110): Vectorization obstructive function reference.: eq_int_type
   153: inl(1212): Source for routine not found.: std::ios_base::clear
   156: inl(1212): Source for routine not found.: std::char_traits<char>::to_char_type


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_istream<char, std::char_traits<char>>::_Ipfx
FORMAT LIST

 LINE   LOOP      STATEMENT

   136-               _NOINLINE bool _Ipfx(bool _Noskip = false)
   137-                   {   // test stream state and skip whitespace as needed
   138-                   if (this->good())
   139-                       {   // state okay, flush tied stream and skip whitespace
   140-                       if (_Myios::tie() != 0)
   141-                           _Myios::tie()->flush();
   142-           
   143-                       if (!_Noskip && this->flags() & ios_base::skipws)
   144-                           {   // skip whitespace
   145-                           const _Ctype& _Ctype_fac = use_facet< _Ctype >(this->getloc());
   146-           
   147-                           _TRY_IO_BEGIN
   148-                           int_type _Meta = _Myios::rdbuf()->sgetc();
   149-           
   150- +------>                  for (; ; _Meta = _Myios::rdbuf()->snextc())
   151- |                             if (_Traits::eq_int_type(_Traits::eof(), _Meta))
   152- |                                 {   // end of file, quit
   153- |                                 _Myios::setstate(ios_base::eofbit);
   154- |                                 break;
   155- |                                 }
   156- |                             else if (!_Ctype_fac.is(_Ctype::space,
   157- |                                 _Traits::to_char_type(_Meta)))
   158- +------                           break;  // not whitespace, quit
   159-                           _CATCH_IO_END
   160-                           }
   161-           
   162-                       if (this->good())
   163-                           return (true);
   164-                       }
   165-                   _Myios::setstate(ios_base::failbit);
   166-                   return (false);
   167-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_istream<char, std::char_traits<char>>::_Sentry_base::~_Sentry_base
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_istream<char, std::char_traits<char>>::_Sentry_base::~_Sentry_base
FORMAT LIST

 LINE   LOOP      STATEMENT

    95-                   ~_Sentry_base() _NOEXCEPT
    96-                       {   // destroy after unlocking
    97-                       if (_Myistr.rdbuf() != 0)
    98-                           _Myistr.rdbuf()->_Unlock();
    99-                       }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_istream<char, std::char_traits<char>>::sentry::sentry
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   114: inl(1212): Source for routine not found.: std::basic_istream<char, std::char_traits<char>>::_Ipfx


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_istream<char, std::char_traits<char>>::sentry::sentry
FORMAT LIST

 LINE   LOOP      STATEMENT

   111-                   explicit sentry(_Myt& _Istr, bool _Noskip = false)
   112-                       : _Sentry_base(_Istr)
   113-                       {   // construct locking and calling _Ipfx
   114-                       _Ok = this->_Myistr._Ipfx(_Noskip);
   115-                       }
   116-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::~basic_ostream [subobject]
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    94: inl(1212): Source for routine not found.: std::basic_ios<char, std::char_traits<char>>::~basic_ios


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::~basic_ostream [subobject]
FORMAT LIST

 LINE   LOOP      STATEMENT

    93-               virtual ~basic_ostream() _NOEXCEPT
    94-                   {   // destroy the object
    95-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::_Osfx
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   182: inl(1212): Source for routine not found.: std::operator &
   184: inl(1212): Source for routine not found.: std::ios_base::clear


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::_Osfx
FORMAT LIST

 LINE   LOOP      STATEMENT

   179-               void _Osfx()
   180-                   {   // perform any wrapup
   181-                   _TRY_BEGIN
   182-                   if (this->good() && this->flags() & ios_base::unitbuf)
   183-                       if (_Myios::rdbuf()->pubsync() == -1)   // flush stream as needed
   184-                           _Myios::setstate(ios_base::badbit);
   185-                   _CATCH_ALL
   186-                   _CATCH_END
   187-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::operator <<
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   257: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
   261: inl(1212): Source for routine not found.: std::use_facet<std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>>
   267: inl(1212): Source for routine not found.: std::ios_base::clear
   271: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::operator <<
FORMAT LIST

 LINE   LOOP      STATEMENT

   254-               _NOINLINE _Myt& operator<<(unsigned short _Val)
   255-                   {   // insert an unsigned short
   256-                   ios_base::iostate _State = ios_base::goodbit;
   257-                   const sentry _Ok(*this);
   258-           
   259-                   if (_Ok)
   260-                       {   // state okay, use facet to insert
   261-                       const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());
   262-           
   263-                       _TRY_IO_BEGIN
   264-                       if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
   265-                           _Myios::fill(), (unsigned long)_Val).failed())
   266-                           _State |= ios_base::badbit;
   267-                       _CATCH_IO_END
   268-                       }
   269-           
   270-                   _Myios::setstate(_State);
   271-                   return (*this);
   272-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::operator <<
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   302: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
   306: inl(1212): Source for routine not found.: std::use_facet<std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>>
   312: inl(1212): Source for routine not found.: std::ios_base::clear
   316: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::operator <<
FORMAT LIST

 LINE   LOOP      STATEMENT

   299-               _NOINLINE _Myt& operator<<(unsigned int _Val)
   300-                   {   // insert an unsigned int
   301-                   ios_base::iostate _State = ios_base::goodbit;
   302-                   const sentry _Ok(*this);
   303-           
   304-                   if (_Ok)
   305-                       {   // state okay, use facet to insert
   306-                       const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());
   307-           
   308-                       _TRY_IO_BEGIN
   309-                       if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
   310-                           _Myios::fill(), (unsigned long)_Val).failed())
   311-                           _State |= ios_base::badbit;
   312-                       _CATCH_IO_END
   313-                       }
   314-           
   315-                   _Myios::setstate(_State);
   316-                   return (*this);
   317-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::operator <<
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   342: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
   346: inl(1212): Source for routine not found.: std::use_facet<std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>>
   352: inl(1212): Source for routine not found.: std::ios_base::clear
   356: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::operator <<
FORMAT LIST

 LINE   LOOP      STATEMENT

   339-               _NOINLINE _Myt& operator<<(unsigned long _Val)
   340-                   {   // insert an unsigned long
   341-                   ios_base::iostate _State = ios_base::goodbit;
   342-                   const sentry _Ok(*this);
   343-           
   344-                   if (_Ok)
   345-                       {   // state okay, use facet to insert
   346-                       const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());
   347-           
   348-                       _TRY_IO_BEGIN
   349-                       if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
   350-                           _Myios::fill(), _Val).failed())
   351-                           _State |= ios_base::badbit;
   352-                       _CATCH_IO_END
   353-                       }
   354-           
   355-                   _Myios::setstate(_State);
   356-                   return (*this);
   357-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::operator <<
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   424: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
   428: inl(1212): Source for routine not found.: std::use_facet<std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>>
   434: inl(1212): Source for routine not found.: std::ios_base::clear
   438: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::operator <<
FORMAT LIST

 LINE   LOOP      STATEMENT

   421-               _NOINLINE _Myt& operator<<(double _Val)
   422-                   {   // insert a double
   423-                   ios_base::iostate _State = ios_base::goodbit;
   424-                   const sentry _Ok(*this);
   425-           
   426-                   if (_Ok)
   427-                       {   // state okay, use facet to insert
   428-                       const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());
   429-           
   430-                       _TRY_IO_BEGIN
   431-                       if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
   432-                           _Myios::fill(), _Val).failed())
   433-                           _State |= ios_base::badbit;
   434-                       _CATCH_IO_END
   435-                       }
   436-           
   437-                   _Myios::setstate(_State);
   438-                   return (*this);
   439-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::put
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   521: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
   528: inl(1212): Source for routine not found.: std::char_traits<char>::to_int_type
   531: inl(1212): Source for routine not found.: std::ios_base::clear
   535: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::put
FORMAT LIST

 LINE   LOOP      STATEMENT

   518-               _NOINLINE _Myt& put(_Elem _Ch)
   519-                   {   // insert a character
   520-                   ios_base::iostate _State = ios_base::goodbit;
   521-                   const sentry _Ok(*this);
   522-           
   523-                   if (!_Ok)
   524-                       _State |= ios_base::badbit;
   525-                   else
   526-                       {   // state okay, insert character
   527-                       _TRY_IO_BEGIN
   528-                       if (_Traits::eq_int_type(_Traits::eof(),
   529-                           _Myios::rdbuf()->sputc(_Ch)))
   530-                           _State |= ios_base::badbit;
   531-                       _CATCH_IO_END
   532-                       }
   533-           
   534-                   _Myios::setstate(_State);
   535-                   return (*this);
   536-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::flush
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   563: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
   566: inl(1212): Source for routine not found.: std::ios_base::clear
   567: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::flush
FORMAT LIST

 LINE   LOOP      STATEMENT

   559-               _NOINLINE _Myt& flush()
   560-                   {   // flush output stream
   561-                   if (_Myios::rdbuf() != 0)
   562-                       {   // buffer exists, flush it
   563-                       const sentry _Ok(*this);
   564-           
   565-                       if (_Ok && _Myios::rdbuf()->pubsync() == -1)
   566-                           _Myios::setstate(ios_base::badbit); // sync failed
   567-                       }
   568-                   return (*this);
   569-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::_Sentry_base::~_Sentry_base
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::_Sentry_base::~_Sentry_base
FORMAT LIST

 LINE   LOOP      STATEMENT

   111-                   ~_Sentry_base() _NOEXCEPT
   112-                       {   // destroy after unlocking
   113-                       if (_Myostr.rdbuf() != 0)
   114-                           _Myostr.rdbuf()->_Unlock();
   115-                       }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   131: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::flush


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
FORMAT LIST

 LINE   LOOP      STATEMENT

   127-                   explicit sentry(_Myt& _Ostr)
   128-                       : _Sentry_base(_Ostr)
   129-                       {   // construct locking and testing stream
   130-                       if (_Ostr.good() && _Ostr.tie() != 0 && _Ostr.tie() != &_Ostr)
   131-                           _Ostr.tie()->flush();
   132-                       _Ok = _Ostr.good(); // store test only after flushing tie
   133-                       }
   134-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   139: inl(1212): Source for routine not found.: std::uncaught_exception
   141: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::_Osfx


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry
FORMAT LIST

 LINE   LOOP      STATEMENT

   135-                   ~sentry() _NOEXCEPT
   136-                       {   // destroy the object
   137-            #if _HAS_EXCEPTIONS
   138-             #if (!defined(__ve__) || !defined(_REENTRANT))
   139-                       if (!_XSTD uncaught_exception())
   140-             #endif /* (!defined(__ve__) || !defined(_REENTRANT)) */
   141-                           this->_Myostr._Osfx();
   142-           
   143-            #else /* _HAS_EXCEPTIONS */
   144-                       this->_Myostr._Osfx();
   145-            #endif /* _HAS_EXCEPTIONS */
   146-                       }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_iostream<char, std::char_traits<char>>::basic_iostream [subobject]
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   890: inl(1212): Source for routine not found.: std::basic_ios<char, std::char_traits<char>>::basic_ios
   888: inl(1212): Source for routine not found.: std::ios_base::_Init


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_iostream<char, std::char_traits<char>>::basic_iostream [subobject]
FORMAT LIST

 LINE   LOOP      STATEMENT

   887-               explicit basic_iostream(basic_streambuf<_Elem, _Traits> *_Strbuf)
   888-                   : _Myis(_Strbuf, false),
   889-                       _Myos(_Noinit, false)
   890-                   {   // construct from stream buffer pointer
   891-                   }
   892-           
   893-            #if _HAS_RVALUE_REFERENCES


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_iostream<char, std::char_traits<char>>::~basic_iostream [subobject]
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   930: inl(1212): Source for routine not found.: std::basic_ios<char, std::char_traits<char>>::~basic_ios


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/istream

FUNCTION NAME: std::basic_iostream<char, std::char_traits<char>>::~basic_iostream [subobject]
FORMAT LIST

 LINE   LOOP      STATEMENT

   929-               virtual ~basic_iostream() _NOEXCEPT
   930-                   {   // destroy the object
   931-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::basic_streambuf
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    16: inl(1212): Source for routine not found.: std::locale::_Init


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::basic_streambuf
FORMAT LIST

 LINE   LOOP      STATEMENT

    15-               basic_streambuf()
    16-                   : _Plocale(new locale)
    17-                   {   // construct with no buffers
    18-                   _Init();
    19-                   }
    20-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::~basic_streambuf
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    79: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::~basic_streambuf
FORMAT LIST

 LINE   LOOP      STATEMENT

    77-               virtual ~basic_streambuf() _NOEXCEPT
    78-                   {   // destroy the object
    79-                   delete _Plocale;
    80-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::_Lock
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::_Lock
FORMAT LIST

 LINE   LOOP      STATEMENT

   204-               virtual void _Lock()
   205-                   {   // set the thread lock (overridden by basic_filebuf)
   206-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::_Unlock
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::_Unlock
FORMAT LIST

 LINE   LOOP      STATEMENT

   208-               virtual void _Unlock()
   209-                   {   // clear the thread lock (overridden by basic_filebuf)
   210-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::overflow
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::overflow
FORMAT LIST

 LINE   LOOP      STATEMENT

   460-               virtual int_type overflow(int_type = _Traits::eof())
   461-                   {   // put a character to stream (always fail)
   462-                   return (_Traits::eof());
   463-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::pbackfail
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::pbackfail
FORMAT LIST

 LINE   LOOP      STATEMENT

   465-               virtual int_type pbackfail(int_type = _Traits::eof())
   466-                   {   // put a character back to stream (always fail)
   467-                   return (_Traits::eof());
   468-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::showmanyc
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::showmanyc
FORMAT LIST

 LINE   LOOP      STATEMENT

   470-               virtual streamsize showmanyc()
   471-                   {   // return count of input characters
   472-                   return (0);
   473-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::underflow
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::underflow
FORMAT LIST

 LINE   LOOP      STATEMENT

   475-               virtual int_type underflow()
   476-                   {   // get a character from stream, but don't point past it
   477-                   return (_Traits::eof());
   478-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::uflow
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   482: inl(1212): Source for routine not found.: std::char_traits<char>::eq_int_type


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::uflow
FORMAT LIST

 LINE   LOOP      STATEMENT

   480-               virtual int_type uflow()
   481-                   {   // get a character from stream, point past it
   482-                   return (_Traits::eq_int_type(_Traits::eof(), underflow())
   483-                       ? _Traits::eof() : _Traits::to_int_type(*_Gninc()));
   484-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::xsgetn
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   492: vec( 103): Unvectorized loop.
   492: vec( 110): Vectorization obstructive function reference.: eq_int_type
   492: vec( 110): Vectorization obstructive function reference.: to_char_type
   492: vec( 110): Vectorization obstructive function reference.:  
   503: inl(1212): Source for routine not found.: std::char_traits<char>::eq_int_type
   507: inl(1212): Source for routine not found.: std::char_traits<char>::to_char_type


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::xsgetn
FORMAT LIST

 LINE   LOOP      STATEMENT

   486-               virtual streamsize xsgetn(_Elem * _Ptr,
   487-                   streamsize _Count)
   488-                   {   // get _Count characters from stream
   489-                   int_type _Meta;
   490-                   streamsize _Size, _Copied;
   491-           
   492- +------>          for (_Copied = 0; 0 < _Count; )
   493- |                     if (0 < (_Size = _Gnavail()))
   494- |                         {   // copy from read buffer
   495- |                         if (_Count < _Size)
   496- |                             _Size = _Count;
   497- |                         _Traits::copy(_Ptr, gptr(), (size_t)_Size);
   498- |                         _Ptr += _Size;
   499- |                         _Copied += _Size;
   500- |                         _Count -= _Size;
   501- |                         gbump((int)_Size);
   502- |                         }
   503- |                     else if (_Traits::eq_int_type(_Traits::eof(), _Meta = uflow()))
   504- |                         break;  // end of file, quit
   505- |                     else
   506- |                         {   // get a single character
   507- |                         *_Ptr++ = _Traits::to_char_type(_Meta);
   508- |                         ++_Copied;
   509- |                         --_Count;
   510- +------                   }
   511-           
   512-                   return (_Copied);
   513-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::xsputn
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   520: vec( 103): Unvectorized loop.
   520: vec( 110): Vectorization obstructive function reference.:  
   520: vec( 110): Vectorization obstructive function reference.: eq_int_type
   520: vec( 110): Vectorization obstructive function reference.: to_int_type
   531: inl(1212): Source for routine not found.: std::char_traits<char>::to_int_type


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::xsputn
FORMAT LIST

 LINE   LOOP      STATEMENT

   515-               virtual streamsize xsputn(const _Elem *_Ptr,
   516-                   streamsize _Count)
   517-                   {   // put _Count characters to stream
   518-                   streamsize _Size, _Copied;
   519-           
   520- +------>          for (_Copied = 0; 0 < _Count; )
   521- |                     if (0 < (_Size = _Pnavail()))
   522- |                         {   // copy to write buffer
   523- |                         if (_Count < _Size)
   524- |                             _Size = _Count;
   525- |                         _Traits::copy(pptr(), _Ptr, (size_t)_Size);
   526- |                         _Ptr += _Size;
   527- |                         _Copied += _Size;
   528- |                         _Count -= _Size;
   529- |                         pbump((int)_Size);
   530- |                         }
   531- |                     else if (_Traits::eq_int_type(_Traits::eof(),
   532- |                         overflow(_Traits::to_int_type(*_Ptr))))
   533- |                         break;  // single character put failed, quit
   534- |                     else
   535- |                         {   // count character successfully put
   536- |                         ++_Ptr;
   537- |                         ++_Copied;
   538- |                         --_Count;
   539- +------                   }
   540-           
   541-                   return (_Copied);
   542-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::seekoff
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::seekoff
FORMAT LIST

 LINE   LOOP      STATEMENT

   544-               virtual pos_type seekoff(off_type,
   545-                   ios_base::seekdir,
   546-                   ios_base::openmode = ios_base::in | ios_base::out)
   547-                   {   // change position by offset, according to way and mode
   548-                   return (streampos(_BADOFF));
   549-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::seekpos
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::seekpos
FORMAT LIST

 LINE   LOOP      STATEMENT

   551-               virtual pos_type seekpos(pos_type,
   552-                   ios_base::openmode = ios_base::in | ios_base::out)
   553-                   {   // change to specified position, according to mode
   554-                   return (streampos(_BADOFF));
   555-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::setbuf
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::setbuf
FORMAT LIST

 LINE   LOOP      STATEMENT

   557-               virtual _Myt *setbuf(_Elem *, streamsize)
   558-                   {   // offer buffer to external agent (do nothing)
   559-                   return (this);
   560-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::sync
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::sync
FORMAT LIST

 LINE   LOOP      STATEMENT

   562-               virtual int sync()
   563-                   {   // synchronize with external agent (do nothing)
   564-                   return (0);
   565-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::imbue
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/streambuf

FUNCTION NAME: std::basic_streambuf<char, std::char_traits<char>>::imbue
FORMAT LIST

 LINE   LOOP      STATEMENT

   567-               virtual void imbue(const locale&)
   568-                   {   // set locale to argument (do nothing)
   569-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::basic_stringbuf
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    27: inl(1212): Source for routine not found.: std::basic_streambuf<char, std::char_traits<char>>::basic_streambuf
    28: inl(1212): Source for routine not found.: std::operator &


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::basic_stringbuf
FORMAT LIST

 LINE   LOOP      STATEMENT

    25-               explicit basic_stringbuf(const _Mystr& _Str,
    26-                   ios_base::openmode _Mode = ios_base::in | ios_base::out)
    27-                   {   // construct character buffer from string, mode
    28-                   _Init(_Str.c_str(), _Str.size(), _Getstate(_Mode));
    29-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::~basic_stringbuf
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    78: inl(1212): Source for routine not found.: operator delete 
    79: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::~basic_stringbuf
FORMAT LIST

 LINE   LOOP      STATEMENT

    76-               virtual ~basic_stringbuf() _NOEXCEPT
    77-                   {   // destroy the object
    78-                   _Tidy();
    79-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::overflow
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   125: inl(1212): Source for routine not found.: std::char_traits<char>::eq_int_type
   126: inl(1212): Source for routine not found.: std::char_traits<char>::not_eof
   135: inl(1212): Source for routine not found.: std::char_traits<char>::to_char_type
   146: vec( 103): Unvectorized loop.
   146: vec( 108): Unvectorizable loop structure.
   153: inl(1212): Source for routine not found.: std::_Allocate<char>
   183: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::overflow
FORMAT LIST

 LINE   LOOP      STATEMENT

   121-               virtual int_type overflow(int_type _Meta = _Traits::eof())
   122-                   {   // put an element to stream
   123-                   if (_Mystate & _Constant)
   124-                       return (_Traits::eof());    // array nonmutable, fail
   125-                   else if (_Traits::eq_int_type(_Traits::eof(), _Meta))
   126-                       return (_Traits::not_eof(_Meta));   // EOF, return success code
   127-           
   128-                   if (_Mystate & _Append
   129-                       && _Mysb::pptr() != 0 && _Mysb::pptr() < _Seekhigh)
   130-                       _Mysb::setp(_Mysb::pbase(), _Seekhigh, _Mysb::epptr());
   131-           
   132-                   if (_Mysb::pptr() != 0
   133-                       && _Mysb::pptr() < _Mysb::epptr())
   134-                       {   // room in buffer, store it
   135-                       *_Mysb::_Pninc() = _Traits::to_char_type(_Meta);
   136-                       return (_Meta);
   137-                       }
   138-                   else
   139-                       {   // grow buffer and store element
   140-                       size_t _Oldsize = _Mysb::pptr() == 0
   141-                           ? 0 : _Mysb::epptr() - _Mysb::eback();
   142-                       size_t _Newsize = _Oldsize;
   143-                       size_t _Inc = _Newsize / 2 < _MINSIZE
   144-                           ? _MINSIZE : _Newsize / 2;  // grow by 50 per cent
   145-           
   146- +------>              while (0 < _Inc && INT_MAX - _Inc < _Newsize)
   147- +------                   _Inc /= 2;  // increment causes overflow, halve it
   148-                       if (_Inc == 0)
   149-                           return (_Traits::eof());    // buffer can't grow, fail
   150-           
   151-                       _Newsize += _Inc;
   152-           
   153-                       _Elem *_Newptr = _Al.allocate(_Newsize);
   154-                       _Elem *_Oldptr = _Mysb::eback();
   155-           
   156-                       if (0 < _Oldsize)
   157-                           _Traits::copy(_Newptr, _Oldptr, _Oldsize);
   158-           
   159-                       if (_Oldsize == 0)
   160-                           {   // first growth, set up pointers
   161-                           _Seekhigh = _Newptr;
   162-                           _Mysb::setp(_Newptr, _Newptr + _Newsize);
   163-                           if (_Mystate & _Noread)
   164-                               _Mysb::setg(_Newptr, 0, _Newptr);
   165-                           else
   166-                               _Mysb::setg(_Newptr, _Newptr, _Newptr + 1);
   167-                           }
   168-                       else
   169-                           {   // not first growth, adjust pointers
   170-                           _Seekhigh = _Newptr + (_Seekhigh - _Oldptr);
   171-                           _Mysb::setp(_Newptr + (_Mysb::pbase() - _Oldptr),
   172-                               _Newptr + (_Mysb::pptr() - _Oldptr),
   173-                               _Newptr + _Newsize);
   174-                           if (_Mystate & _Noread)
   175-                               _Mysb::setg(_Newptr, 0, _Newptr);
   176-                           else
   177-                               _Mysb::setg(_Newptr,
   178-                                   _Newptr + (_Mysb::gptr() - _Oldptr),
   179-                                   _Mysb::pptr() + 1);
   180-                           }
   181-           
   182-                       if (_Mystate & _Allocated)
   183-                           _Al.deallocate(_Oldptr, _Oldsize);
   184-                       _Mystate |= _Allocated;
   185-           
   186-                       *_Mysb::_Pninc() = _Traits::to_char_type(_Meta);
   187-                       return (_Meta);
   188-                       }
   189-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::pbackfail
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   193: inl(1212): Source for routine not found.: std::char_traits<char>::eq_int_type
   204: inl(1212): Source for routine not found.: std::char_traits<char>::not_eof


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::pbackfail
FORMAT LIST

 LINE   LOOP      STATEMENT

   191-               virtual int_type pbackfail(int_type _Meta = _Traits::eof())
   192-                   {   // put an element back to stream
   193-                   if (_Mysb::gptr() == 0
   194-                       || _Mysb::gptr() <= _Mysb::eback()
   195-                       || (!_Traits::eq_int_type(_Traits::eof(), _Meta)
   196-                       && !_Traits::eq(_Traits::to_char_type(_Meta), _Mysb::gptr()[-1])
   197-                       && _Mystate & _Constant))
   198-                       return (_Traits::eof());    // can't put back, fail
   199-                   else
   200-                       {   // back up one position and store put-back character
   201-                       _Mysb::gbump(-1);
   202-                       if (!_Traits::eq_int_type(_Traits::eof(), _Meta))
   203-                           *_Mysb::gptr() = _Traits::to_char_type(_Meta);
   204-                       return (_Traits::not_eof(_Meta));
   205-                       }
   206-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::underflow
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   213: inl(1212): Source for routine not found.: std::char_traits<char>::to_int_type


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::underflow
FORMAT LIST

 LINE   LOOP      STATEMENT

   208-               virtual int_type underflow()
   209-                   {   // get an element from stream, but don't point past it
   210-                   if (_Mysb::gptr() == 0)
   211-                       return (_Traits::eof());    // no character buffer, fail
   212-                   else if (_Mysb::gptr() < _Mysb::egptr())
   213-                       return (_Traits::to_int_type(*_Mysb::gptr()));  // return buffered
   214-                   else if (_Mystate & _Noread || _Mysb::pptr() == 0
   215-                       || (_Mysb::pptr() <= _Mysb::gptr() && _Seekhigh <= _Mysb::gptr()))
   216-                       return (_Traits::eof());    // can't read, fail
   217-                   else
   218-                       {   // extend read buffer into written area, then return buffered
   219-                       if (_Seekhigh < _Mysb::pptr())
   220-                           _Seekhigh = _Mysb::pptr();
   221-                       _Mysb::setg(_Mysb::eback(), _Mysb::gptr(), _Seekhigh);
   222-                       return (_Traits::to_int_type(*_Mysb::gptr()));
   223-                       }
   224-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::seekoff
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   233: inl(1212): Source for routine not found.: std::operator &


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::seekoff
FORMAT LIST

 LINE   LOOP      STATEMENT

   226-               virtual pos_type seekoff(off_type _Off,
   227-                   ios_base::seekdir _Way,
   228-                   ios_base::openmode _Which = ios_base::in | ios_base::out)
   229-                   {   // change position by _Off, according to _Way, _Mode
   230-                   if (_Mysb::pptr() != 0 && _Seekhigh < _Mysb::pptr())
   231-                       _Seekhigh = _Mysb::pptr();  // update high-water pointer
   232-           
   233-                   if (_Which & ios_base::in && _Mysb::gptr() != 0)
   234-                       {   // position within read buffer
   235-                       if (_Way == ios_base::end)
   236-                           _Off += (off_type)(_Seekhigh - _Mysb::eback());
   237-                       else if (_Way == ios_base::cur
   238-                           && (_Which & ios_base::out) == 0)
   239-                           _Off += (off_type)(_Mysb::gptr() - _Mysb::eback());
   240-                       else if (_Way != ios_base::beg)
   241-                           _Off = _BADOFF;
   242-           
   243-                       if (0 <= _Off && _Off <= _Seekhigh - _Mysb::eback())
   244-                           {   // change read position
   245-                           _Mysb::gbump((int)(_Mysb::eback() - _Mysb::gptr() + _Off));
   246-                           if (_Which & ios_base::out && _Mysb::pptr() != 0)
   247-                               _Mysb::setp(_Mysb::pbase(), _Mysb::gptr(),
   248-                                   _Mysb::epptr());    // change write position to match
   249-                           }
   250-                       else
   251-                           _Off = _BADOFF;
   252-                       }
   253-                   else if (_Which & ios_base::out && _Mysb::pptr() != 0)
   254-                       {   // position within write buffer
   255-                       if (_Way == ios_base::end)
   256-                           _Off += (off_type)(_Seekhigh - _Mysb::eback());
   257-                       else if (_Way == ios_base::cur)
   258-                           _Off += (off_type)(_Mysb::pptr() - _Mysb::eback());
   259-                       else if (_Way != ios_base::beg)
   260-                           _Off = _BADOFF;
   261-           
   262-                       if (0 <= _Off && _Off <= _Seekhigh - _Mysb::eback())
   263-                           _Mysb::pbump((int)(_Mysb::eback()
   264-                               - _Mysb::pptr() + _Off));   // change write position
   265-                       else
   266-                           _Off = _BADOFF;
   267-                       }
   268-           
   269-            #if _HAS_CPP0X
   270-                   else if (_Off != 0)
   271-           
   272-            #else /* _HAS_CPP0X */
   273-                   else
   274-            #endif /* _HAS_CPP0X */
   275-           
   276-                       _Off = _BADOFF; // neither read nor write buffer selected, fail
   277-                   return (pos_type(_Off));
   278-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::seekpos
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   289: inl(1212): Source for routine not found.: std::operator &


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::seekpos
FORMAT LIST

 LINE   LOOP      STATEMENT

   280-               virtual pos_type seekpos(pos_type _Ptr,
   281-                   ios_base::openmode _Mode = ios_base::in | ios_base::out)
   282-                   {   // change position to _Pos, according to _Mode
   283-                   streamoff _Off = (streamoff)_Ptr;
   284-                   if (_Mysb::pptr() != 0 && _Seekhigh < _Mysb::pptr())
   285-                       _Seekhigh = _Mysb::pptr();  // update high-water pointer
   286-           
   287-                   if (_Off == _BADOFF)
   288-                       ;
   289-                   else if (_Mode & ios_base::in && _Mysb::gptr() != 0)
   290-                       {   // position within read buffer
   291-                       if (0 <= _Off && _Off <= _Seekhigh - _Mysb::eback())
   292-                           {   // change read position
   293-                           _Mysb::gbump((int)(_Mysb::eback() - _Mysb::gptr() + _Off));
   294-                           if (_Mode & ios_base::out && _Mysb::pptr() != 0)
   295-                               _Mysb::setp(_Mysb::pbase(), _Mysb::gptr(),
   296-                                   _Mysb::epptr());    // change write position to match
   297-                           }
   298-                       else
   299-                           _Off = _BADOFF;
   300-                       }
   301-                   else if (_Mode & ios_base::out && _Mysb::pptr() != 0)
   302-                       {   // position within write buffer
   303-                       if (0 <= _Off && _Off <= _Seekhigh - _Mysb::eback())
   304-                           _Mysb::pbump((int)(_Mysb::eback()
   305-                               - _Mysb::pptr() + _Off));   // change write position
   306-                       else
   307-                           _Off = _BADOFF;
   308-                       }
   309-                   else
   310-                       _Off = _BADOFF; // neither read nor write buffer selected, fail
   311-                   return (streampos(_Off));
   312-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::_Init
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   323: inl(1212): Source for routine not found.: std::_Allocate<char>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::_Init
FORMAT LIST

 LINE   LOOP      STATEMENT

   314-               void _Init(const _Elem *_Ptr,
   315-                   size_t _Count, _Strstate _State)
   316-                   {   // initialize buffer to [_Ptr, _Ptr + _Count), set state
   317-                   _Seekhigh = 0;
   318-                   _Mystate = _State;
   319-           
   320-                   if (_Count != 0
   321-                       && (_Mystate & (_Noread | _Constant)) != (_Noread | _Constant))
   322-                       {   // finite buffer that can be read or written, set it up
   323-                       _Elem *_Pnew = _Al.allocate(_Count);
   324-                       _Traits::copy(_Pnew, _Ptr, _Count);
   325-                       _Seekhigh = _Pnew + _Count;
   326-           
   327-                       if (!(_Mystate & _Noread))
   328-                           _Mysb::setg(_Pnew, _Pnew,
   329-                               _Pnew + _Count);    // setup read buffer
   330-                       if (!(_Mystate & _Constant))
   331-                           {   // setup write buffer, and maybe read buffer
   332-                           _Mysb::setp(_Pnew,
   333-                               (_Mystate & (_Atend | _Append)) ? _Pnew + _Count : _Pnew,
   334-                               _Pnew + _Count);
   335-                           if (_Mysb::gptr() == 0)
   336-                               _Mysb::setg(_Pnew, 0, _Pnew);
   337-                           }
   338-                       _Mystate |= _Allocated;
   339-                       }
   340-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>>::basic_stringstream [subobject]
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   632: inl(1212): Source for routine not found.: std::basic_ios<char, std::char_traits<char>>::basic_ios
   630: inl(1212): Source for routine not found.: std::basic_iostream<char, std::char_traits<char>>::basic_iostream [subobject]
   631: inl(1212): Source for routine not found.: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::basic_stringbuf


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:06 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>>::basic_stringstream [subobject]
FORMAT LIST

 LINE   LOOP      STATEMENT

   628-               explicit basic_stringstream(const _Mystr& _Str,
   629-                   ios_base::openmode _Mode = ios_base::in | ios_base::out)
   630-                   : _Mybase(&_Stringbuffer),
   631-                       _Stringbuffer(_Str, _Mode)
   632-                   {   // construct character buffer from NTCS
   633-                   }
   634-           
   635-            #if _HAS_RVALUE_REFERENCES


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>>::~basic_stringstream [subobject]
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   680: inl(1212): Source for routine not found.: std::basic_ios<char, std::char_traits<char>>::~basic_ios
   681: inl(1212): Source for routine not found.: std::basic_stringbuf<char, std::char_traits<char>, std::allocator<char>>::~basic_stringbuf


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/sstream

FUNCTION NAME: std::basic_stringstream<char, std::char_traits<char>, std::allocator<char>>::~basic_stringstream [subobject]
FORMAT LIST

 LINE   LOOP      STATEMENT

   679-               virtual ~basic_stringstream() _NOEXCEPT
   680-                   {   // destroy the object
   681-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<unsigned long>::begin const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<unsigned long>::begin const
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _CONST_FUN const _Elem *begin() const _NOEXCEPT
    37-                   {   // get beginning of list
    38-                   return (_First);
    39-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<unsigned long>::end const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<unsigned long>::end const
FORMAT LIST

 LINE   LOOP      STATEMENT

    41-               _CONST_FUN const _Elem *end() const _NOEXCEPT
    42-                   {   // get end of list
    43-                   return (_Last);
    44-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::tuple<>::tuple
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::tuple<>::tuple
FORMAT LIST

 LINE   LOOP      STATEMENT

   230-               _CONST_FUN tuple(const tuple&) _NOEXCEPT
   231-                   {   // copy construct
   232-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Getcat
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1115: inl(1212): Source for routine not found.: std::_Locinfo::_Locinfo


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Getcat
FORMAT LIST

 LINE   LOOP      STATEMENT

  1111-               static size_t _Getcat(const locale::facet **_Ppf = 0,
  1112-                   const locale *_Ploc = 0)
  1113-                   {   // return locale category mask and construct standard facet
  1114-                   if (_Ppf != 0 && *_Ppf == 0)
  1115-                       *_Ppf = new num_put<_Elem, _OutIt>(
  1116-                           _Locinfo(_Ploc->c_str()));
  1117-                   return (_X_NUMERIC);
  1118-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::~num_put
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1125: inl(1212): Source for routine not found.: std::locale::facet::~facet


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::~num_put
FORMAT LIST

 LINE   LOOP      STATEMENT

  1123-               _VIRTUAL ~num_put() _NOEXCEPT
  1124-                   {   // destroy the object
  1125-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::num_put
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1141: inl(1212): Source for routine not found.: std::locale::facet::facet


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::num_put
FORMAT LIST

 LINE   LOOP      STATEMENT

  1140-               num_put(const _Locinfo& _Lobj, size_t _Refs = 0)
  1141-                   : locale::facet(_Refs)
  1142-                   {   // construct from specified locale
  1143-                   _Init(_Lobj);
  1144-                   }
  1145-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1204: inl(1212): Source for routine not found.: std::operator &
  1208: inl(1212): Source for routine not found.: std::use_facet<std::numpunct<char>>
  1209: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
  1211: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::assign
  1221: inl(1212): Source for routine not found.: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Rep const
  1224: inl(1212): Source for routine not found.: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Put const


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1200-               _VIRTUAL _OutIt do_put(_OutIt _Dest,
  1201-                   ios_base& _Iosbase, _Elem _Fill, bool _Val) const
  1202-                   {   // put formatted bool to _Dest
  1203-                   _DEBUG_POINTER(_Dest);
  1204-                   if (!(_Iosbase.flags() & ios_base::boolalpha))
  1205-                       return (do_put(_Dest, _Iosbase, _Fill, (long)_Val));
  1206-                   else
  1207-                       {   // put "false" or "true"
  1208-                       const _Mypunct& _Punct_fac = use_facet< _Mypunct >(_Iosbase.getloc());
  1209-                       _Mystr _Str;
  1210-                       if (_Val)
  1211-                           _Str.assign(_Punct_fac.truename());
  1212-                       else
  1213-                           _Str.assign(_Punct_fac.falsename());
  1214-           
  1215-                       size_t _Fillcount = _Iosbase.width() <= 0
  1216-                           || (size_t)_Iosbase.width() <= _Str.size()
  1217-                               ? 0 : (size_t)_Iosbase.width() - _Str.size();
  1218-           
  1219-                       if ((_Iosbase.flags() & ios_base::adjustfield) != ios_base::left)
  1220-                           {   // put leading fill
  1221-                           _Dest = _Rep(_Dest, _Fill, _Fillcount);
  1222-                           _Fillcount = 0;
  1223-                           }
  1224-                       _Dest = _Put(_Dest, _Str.c_str(), _Str.size()); // put field
  1225-                       _Iosbase.width(0);
  1226-                       return (_Rep(_Dest, _Fill, _Fillcount));    // put trailing fill
  1227-                       }
  1228-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1234: inl(1212): Source for routine not found.: std::operator &


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1230-               _VIRTUAL _OutIt do_put(_OutIt _Dest,
  1231-                   ios_base& _Iosbase, _Elem _Fill, long _Val) const
  1232-                   {   // put formatted long to _Dest
  1233-                   char _Buf[2 * _MAX_INT_DIG], _Fmt[6];
  1234-                   return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
  1235-                       _CSTD sprintf(_Buf, _Ifmt(_Fmt, "ld",
  1236-                           _Iosbase.flags()), _Val)));
  1237-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1243: inl(1212): Source for routine not found.: std::operator &


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1239-               _VIRTUAL _OutIt do_put(_OutIt _Dest,
  1240-                   ios_base& _Iosbase, _Elem _Fill, unsigned long _Val) const
  1241-                   {   // put formatted unsigned long to _Dest
  1242-                   char _Buf[2 * _MAX_INT_DIG], _Fmt[6];
  1243-                   return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
  1244-                       _CSTD sprintf(_Buf, _Ifmt(_Fmt, "lu",
  1245-                           _Iosbase.flags()), _Val)));
  1246-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1253: inl(1212): Source for routine not found.: std::operator &


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1249-               _VIRTUAL _OutIt do_put(_OutIt _Dest,
  1250-                   ios_base& _Iosbase, _Elem _Fill, _LONGLONG _Val) const
  1251-                   {   // put formatted long long to _Dest
  1252-                   char _Buf[2 * _MAX_INT_DIG], _Fmt[8];
  1253-                   return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
  1254-                       _CSTD sprintf(_Buf, _Ifmt(_Fmt, "Ld",
  1255-                           _Iosbase.flags()), _Val)));
  1256-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1262: inl(1212): Source for routine not found.: std::operator &


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1258-               _VIRTUAL _OutIt do_put(_OutIt _Dest,
  1259-                   ios_base& _Iosbase, _Elem _Fill, _ULONGLONG _Val) const
  1260-                   {   // put formatted unsigned long long to _Dest
  1261-                   char _Buf[2 * _MAX_INT_DIG], _Fmt[8];
  1262-                   return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
  1263-                       _CSTD sprintf(_Buf, _Ifmt(_Fmt, "Lu",
  1264-                           _Iosbase.flags()), _Val)));
  1265-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1271: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
  1273: inl(1212): Source for routine not found.: std::operator &
  1284: inl(1212): Source for routine not found.: std::_Xlength_error
  1288: inl(1212): Source for routine not found.: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Fput const


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1268-               _VIRTUAL _OutIt do_put(_OutIt _Dest,
  1269-                   ios_base& _Iosbase, _Elem _Fill, double _Val) const
  1270-                   {   // put formatted double to _Dest
  1271-                   string _Buf;
  1272-                   char _Fmt[8];
  1273-                   bool _Isfixed = (_Iosbase.flags() & ios_base::floatfield)
  1274-                       == ios_base::fixed;
  1275-                   streamsize _Precision = _Iosbase.precision() <= 0 && !_Isfixed
  1276-                       ? 6 : _Iosbase.precision(); // desired precision
  1277-                   size_t _Bufsize = (size_t)_Precision;
  1278-                   if (_Isfixed && 1e10 < _CSTD fabs(_Val))
  1279-                       {   // f or F format
  1280-                       int _Ptwo;
  1281-                       (void)_CSTD frexp(_Val, &_Ptwo);
  1282-                       _Bufsize += _CSTD abs(_Ptwo) * 30103L / 100000L;
  1283-                       }
  1284-                   _Buf.resize(_Bufsize + 50); // add fudge factor
  1285-           
  1286-                   int _Ngen = _CSTD sprintf((char *)_Buf.c_str(),
  1287-                       _Ffmt(_Fmt, 0, _Iosbase.flags()), _Precision, _Val);
  1288-                   return (_Fput(_Dest, _Iosbase, _Fill, _Buf.c_str(), _Ngen));
  1289-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1294: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
  1296: inl(1212): Source for routine not found.: std::operator &
  1307: inl(1212): Source for routine not found.: std::_Xlength_error
  1311: inl(1212): Source for routine not found.: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Fput const


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1291-               _VIRTUAL _OutIt do_put(_OutIt _Dest,
  1292-                   ios_base& _Iosbase, _Elem _Fill, long double _Val) const
  1293-                   {   // put formatted long double to _Dest
  1294-                   string _Buf;
  1295-                   char _Fmt[8];
  1296-                   bool _Isfixed = (_Iosbase.flags() & ios_base::floatfield)
  1297-                       == ios_base::fixed;
  1298-                   streamsize _Precision = _Iosbase.precision() <= 0 && !_Isfixed
  1299-                       ? 6 : _Iosbase.precision(); // desired precision
  1300-                   size_t _Bufsize = (size_t)_Precision;
  1301-                   if (_Isfixed && 1e10 < _CSTD fabsl(_Val))
  1302-                       {   // f or F format
  1303-                       int _Ptwo;
  1304-                       (void)_CSTD frexpl(_Val, &_Ptwo);
  1305-                       _Bufsize += _CSTD abs(_Ptwo) * 30103L / 100000L;
  1306-                       }
  1307-                   _Buf.resize(_Bufsize + 50); // add fudge factor
  1308-           
  1309-                   int _Ngen = _CSTD sprintf((char *)_Buf.c_str(),
  1310-                       _Ffmt(_Fmt, 'L', _Iosbase.flags()), (int)_Precision, _Val);
  1311-                   return (_Fput(_Dest, _Iosbase, _Fill, _Buf.c_str(), _Ngen));
  1312-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1322: inl(1212): Source for routine not found.: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Iput const


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::do_put const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1314-               _VIRTUAL _OutIt do_put(_OutIt _Dest,
  1315-                   ios_base& _Iosbase, _Elem _Fill, const void *_Val) const
  1316-                   {   // put formatted void pointer to _Dest
  1317-           #if defined(__ve__)
  1318-                   char _Buf[2 * _MAX_INT_DIG];
  1319-                   _ULONGLONG _Off = (_ULONGLONG)((char *)_Val - (char *)0);
  1320-                   if (sizeof (void *) == sizeof (unsigned long))
  1321-                       _Off = (unsigned long)_Off;
  1322-                   return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
  1323-                       _CSTD sprintf(_Buf, "%p", _Off)));
  1324-           
  1325-           #else /* !defined(__ve__) */
  1326-            #ifdef _LONGLONG
  1327-                   char _Buf[2 * _MAX_INT_DIG], _Fmt[8];
  1328-                   _ULONGLONG _Off = (_ULONGLONG)((char *)_Val - (char *)0);
  1329-                   if (sizeof (void *) == sizeof (unsigned long))
  1330-                       _Off = (unsigned long)_Off;
  1331-                   return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
  1332-                       _CSTD sprintf(_Buf, _Ifmt(_Fmt, "Lu",
  1333-                           ios_base::hex), _Off)));
  1334-           
  1335-            #else /* _LONGLONG */
  1336-                   char _Buf[2 * _MAX_INT_DIG], _Fmt[6];
  1337-                   unsigned long _Off = (unsigned long)((char *)_Val - (char *)0);
  1338-                   return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
  1339-                       _CSTD sprintf(_Buf, _Ifmt(_Fmt, "lu",
  1340-                           ios_base::hex), _Off)));
  1341-            #endif /* _LONGLONG */
  1342-           #endif /* defined(__ve__) */
  1343-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Fput const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1384: inl(1212): Source for routine not found.: std::operator &
  1404: inl(1212): Source for routine not found.: std::use_facet<std::ctype<char>>
  1406: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
  1409: inl(1212): Source for routine not found.: std::use_facet<std::numpunct<char>>
  1418: vec( 103): Unvectorized loop.
  1418: vec( 108): Unvectorizable loop structure.
  1418: vec( 110): Vectorization obstructive function reference.: _Copy
  1418: vec( 110): Vectorization obstructive function reference.: _Xlength_error
  1418: vec( 110): Vectorization obstructive function reference.: _Xout_of_range
  1421: inl(1212): Source for routine not found.: std::_Xout_of_range
  1436: inl(1212): Source for routine not found.: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Rep const
  1438: inl(1212): Source for routine not found.: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Put const


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Fput const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1375-               _OutIt _Fput(_OutIt _Dest,
  1376-                   ios_base& _Iosbase, _Elem _Fill, const char *_Buf,
  1377-                       size_t _Count) const
  1378-                   {   // put formatted floating-point to _Dest
  1379-                   _DEBUG_POINTER(_Dest);
  1380-                   size_t _Prefix = 0 < _Count && (*_Buf == '+' || *_Buf == '-')
  1381-                       ? 1 : 0;
  1382-           
  1383-                   const char *_Exps;
  1384-                   if ((_Iosbase.flags() & ios_base::floatfield) != ios_base::hexfloat)
  1385-                       _Exps = "eE";
  1386-                   else
  1387-                       {   // correct for hexadecimal floating-point
  1388-                       _Exps = "pP";
  1389-                       if (_Prefix + 2 <= _Count && _Buf[_Prefix] == '0'
  1390-                           && (_Buf[_Prefix + 1] == 'x' || _Buf[_Prefix + 1] == 'X'))
  1391-                           _Prefix += 2;
  1392-                       }
  1393-                   const size_t _Eoff =
  1394-                       _CSTD strcspn(&_Buf[0], _Exps); // find exponent
  1395-                   char _Dp[2] = {"."};
  1396-           #if defined(__ve__)
  1397-                   _Dp[0] = '.';
  1398-           #else /* !defined(__ve__) */
  1399-                   _Dp[0] = _CSTD localeconv()->decimal_point[0];
  1400-           #endif /* defined(__ve__) */
  1401-                   const size_t _Poff =
  1402-                       _CSTD strcspn(&_Buf[0], &_Dp[0]);   // find decimal point
  1403-           
  1404-                   const ctype<_Elem>& _Ctype_fac =
  1405-                       use_facet< ctype<_Elem> >(_Iosbase.getloc());
  1406-                   _Mystr _Groupstring(_Count, _Elem(0));  // reserve space
  1407-                   _Ctype_fac.widen(&_Buf[0], &_Buf[_Count], &_Groupstring[0]);
  1408-           
  1409-                   const _Mypunct& _Punct_fac = use_facet< _Mypunct >(_Iosbase.getloc());
  1410-                   const string _Grouping = _Punct_fac.grouping();
  1411-                   const _Elem _Kseparator = _Punct_fac.thousands_sep();
  1412-           
  1413-                   if (_Poff != _Count)
  1414-                       _Groupstring[_Poff] = _Punct_fac.decimal_point();
  1415-           
  1416-                   size_t _Off = _Poff == _Count ? _Eoff : _Poff;
  1417-                   const char *_Pg = &_Grouping[0];
  1418- +------>          while (*_Pg != CHAR_MAX && '\0' < *_Pg
  1419- |                     && (size_t)*_Pg < _Off - _Prefix)
  1420- |                     {   // add thousands separator
  1421- |                     _Groupstring.insert(_Off -= *_Pg, (size_t)1, _Kseparator);
  1422- |                     if ('\0' < _Pg[1])
  1423- |                         ++_Pg;  // not last group, advance
  1424- +------               }
  1425-           
  1426-                   _Count = _Groupstring.size();
  1427-                   size_t _Fillcount = _Iosbase.width() <= 0
  1428-                       || (size_t)_Iosbase.width() <= _Count
  1429-                           ? 0 : (size_t)_Iosbase.width() - _Count;
  1430-           
  1431-                   ios_base::fmtflags _Adjustfield =
  1432-                       _Iosbase.flags() & ios_base::adjustfield;
  1433-                   if (_Adjustfield != ios_base::left
  1434-                       && _Adjustfield != ios_base::internal)
  1435-                       {   // put leading fill
  1436-                       _Dest = _Rep(_Dest, _Fill, _Fillcount);
  1437-                       _Fillcount = 0;
  1438-                       _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);
  1439-                       }
  1440-                   else if (_Adjustfield == ios_base::internal)
  1441-                       {   // put internal fill
  1442-                       _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);
  1443-                       _Dest = _Rep(_Dest, _Fill, _Fillcount);
  1444-                       _Fillcount = 0;
  1445-                       }
  1446-                   else
  1447-                       _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);
  1448-           
  1449-                   _Dest = _Put(_Dest, &_Groupstring[_Prefix], _Count - _Prefix);
  1450-                   _Iosbase.width(0);
  1451-                   return (_Rep(_Dest, _Fill, _Fillcount));    // put trailing fill
  1452-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Iput const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1495: inl(1212): Source for routine not found.: std::operator &
  1500: inl(1212): Source for routine not found.: std::use_facet<std::ctype<char>>
  1502: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
  1505: inl(1212): Source for routine not found.: std::use_facet<std::numpunct<char>>
  1511: vec( 103): Unvectorized loop.
  1511: vec( 108): Unvectorizable loop structure.
  1511: vec( 110): Vectorization obstructive function reference.: _Copy
  1511: vec( 110): Vectorization obstructive function reference.: _Xlength_error
  1511: vec( 110): Vectorization obstructive function reference.: _Xout_of_range
  1515: inl(1212): Source for routine not found.: std::_Xout_of_range
  1531: inl(1212): Source for routine not found.: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Rep const
  1533: inl(1212): Source for routine not found.: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Put const


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Iput const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1489-               _OutIt _Iput(_OutIt _Dest,
  1490-                   ios_base& _Iosbase, _Elem _Fill, char *_Buf, size_t _Count) const
  1491-                   {   // put formatted integer to _Dest
  1492-                   _DEBUG_POINTER(_Dest);
  1493-                   size_t _Prefix = 0 < _Count && (*_Buf == '+' || *_Buf == '-')
  1494-                       ? 1 : 0;
  1495-                   if ((_Iosbase.flags() & ios_base::basefield) == ios_base::hex
  1496-                       && _Prefix + 2 <= _Count && _Buf[_Prefix] == '0'
  1497-                       && (_Buf[_Prefix + 1] == 'x' || _Buf[_Prefix + 1] == 'X'))
  1498-                       _Prefix += 2;
  1499-           
  1500-                   const ctype<_Elem>& _Ctype_fac =
  1501-                       use_facet< ctype<_Elem> >(_Iosbase.getloc());
  1502-                   _Mystr _Groupstring(_Count, _Elem(0));  // reserve space
  1503-                   _Ctype_fac.widen(&_Buf[0], &_Buf[_Count], &_Groupstring[0]);
  1504-           
  1505-                   const _Mypunct& _Punct_fac = use_facet< _Mypunct >(_Iosbase.getloc());
  1506-                   const string _Grouping = _Punct_fac.grouping();
  1507-                   const char *_Pg = &_Grouping[0];
  1508-                   if (*_Pg != CHAR_MAX && '\0' < *_Pg)
  1509-                       {   // grouping specified, add thousands separators
  1510-                       const _Elem _Kseparator = _Punct_fac.thousands_sep();
  1511- +------>              while (*_Pg != CHAR_MAX && '\0' < *_Pg
  1512- |                         && (size_t)*_Pg < _Count - _Prefix)
  1513- |                         {   // insert thousands separator
  1514- |                         _Count -= *_Pg;
  1515- |                         _Groupstring.insert(_Count, 1, _Kseparator);
  1516- |                         if ('\0' < _Pg[1])
  1517- |                             ++_Pg;  // not last group, advance
  1518- +------                   }
  1519-                       }
  1520-           
  1521-                   _Count = _Groupstring.size();
  1522-                   size_t _Fillcount = _Iosbase.width() <= 0
  1523-                       || (size_t)_Iosbase.width() <= _Count
  1524-                           ? 0 : (size_t)_Iosbase.width() - _Count;
  1525-           
  1526-                   ios_base::fmtflags _Adjustfield =
  1527-                       _Iosbase.flags() & ios_base::adjustfield;
  1528-                   if (_Adjustfield != ios_base::left
  1529-                       && _Adjustfield != ios_base::internal)
  1530-                       {   // put leading fill
  1531-                       _Dest = _Rep(_Dest, _Fill, _Fillcount);
  1532-                       _Fillcount = 0;
  1533-                       _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);
  1534-                       }
  1535-                   else if (_Adjustfield == ios_base::internal)
  1536-                       {   // put internal fill
  1537-                       _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);
  1538-                       _Dest = _Rep(_Dest, _Fill, _Fillcount);
  1539-                       _Fillcount = 0;
  1540-                       }
  1541-                   else
  1542-                       _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);
  1543-           
  1544-                   _Dest = _Put(_Dest, &_Groupstring[_Prefix], _Count - _Prefix);
  1545-                   _Iosbase.width(0);
  1546-                   return (_Rep(_Dest, _Fill, _Fillcount));    // put trailing fill
  1547-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Put const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1552: vec( 103): Unvectorized loop.
  1552: vec( 110): Vectorization obstructive function reference.:  
  1552: vec( 110): Vectorization obstructive function reference.: to_int_type
  1552: vec( 110): Vectorization obstructive function reference.: eq_int_type
  1553: inl(1212): Source for routine not found.: std::char_traits<char>::to_int_type


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Put const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1549-               _OutIt _Put(_OutIt _Dest,
  1550-                   const _Elem *_Ptr, size_t _Count) const
  1551-                   {   // put [_Ptr, _Ptr + _Count) to _Dest
  1552- +------>          for (; 0 < _Count; --_Count, ++_Dest, ++_Ptr)
  1553- +------               *_Dest = *_Ptr;
  1554-                   return (_Dest);
  1555-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Rep const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1560: vec( 103): Unvectorized loop.
  1560: vec( 110): Vectorization obstructive function reference.:  
  1560: vec( 110): Vectorization obstructive function reference.: to_int_type
  1560: vec( 110): Vectorization obstructive function reference.: eq_int_type
  1561: inl(1212): Source for routine not found.: std::char_traits<char>::to_int_type


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Rep const
FORMAT LIST

 LINE   LOOP      STATEMENT

  1557-               _OutIt _Rep(_OutIt _Dest,
  1558-                   _Elem _Ch, size_t _Count) const
  1559-                   {   // put _Count * _Ch to _Dest
  1560- +------>          for (; 0 < _Count; --_Count, ++_Dest)
  1561- +------               *_Dest = _Ch;
  1562-                   return (_Dest);
  1563-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<TaskVariant *, std::allocator<TaskVariant *>>::~vector
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1093: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<TaskVariant *, std::allocator<TaskVariant *>>::~vector
FORMAT LIST

 LINE   LOOP      STATEMENT

  1091-               ~vector() _NOEXCEPT
  1092-                   {   // destroy the object
  1093-                   _Tidy();
  1094-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<TaskVariant *, std::allocator<TaskVariant *>>::_Buy
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1747: inl(1212): Source for routine not found.: std::_Xlength_error
  1750: inl(1212): Source for routine not found.: std::_Allocate<TaskVariant *>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<TaskVariant *, std::allocator<TaskVariant *>>::_Buy
FORMAT LIST

 LINE   LOOP      STATEMENT

  1738-               _NOINLINE bool _Buy(size_type _Capacity)
  1739-                   {   // allocate array with _Capacity elements
  1740-                   this->_Myfirst() = pointer();
  1741-                   this->_Mylast() = pointer();
  1742-                   this->_Myend() = pointer();
  1743-           
  1744-                   if (_Capacity == 0)
  1745-                       return (false);
  1746-                   else if (max_size() < _Capacity)
  1747-                       _Xlen();    // result too long
  1748-                   else
  1749-                       {   // nonempty array, allocate storage
  1750-                       this->_Myfirst() = this->_Getal().allocate(_Capacity);
  1751-                       this->_Mylast() = this->_Myfirst();
  1752-                       this->_Myend() = this->_Myfirst() + _Capacity;
  1753-                       }
  1754-                   return (true);
  1755-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<TaskVariant *, std::allocator<TaskVariant *>>::_Construct<TaskVariant *const *>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   845: inl(1212): Source for routine not found.: std::vector<TaskVariant *, std::allocator<TaskVariant *>>::_Buy
   850: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<TaskVariant *, std::allocator<TaskVariant *>>::_Construct<TaskVariant *const *>
FORMAT LIST

 LINE   LOOP      STATEMENT

   842-                   _NOINLINE void _Construct(_Iter _First, _Iter _Last,
   843-                       forward_iterator_tag)
   844-                   {   // initialize with [_First, _Last), forward iterators
   845-                   if (_Buy(_STD distance(_First, _Last)))
   846-                       {   // nonzero, fill it
   847-                       _TRY_BEGIN
   848-                       this->_Mylast() = _Ucopy(_First, _Last, this->_Myfirst());
   849-                       _CATCH_ALL
   850-                       _Tidy();
   851-                       _RERAISE;
   852-                       _CATCH_END
   853-                       }
   854-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<TaskVariant *>::begin const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<TaskVariant *>::begin const
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _CONST_FUN const _Elem *begin() const _NOEXCEPT
    37-                   {   // get beginning of list
    38-                   return (_First);
    39-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<TaskVariant *>::end const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/initializer_list

FUNCTION NAME: std::initializer_list<TaskVariant *>::end const
FORMAT LIST

 LINE   LOOP      STATEMENT

    41-               _CONST_FUN const _Elem *end() const _NOEXCEPT
    42-                   {   // get end of list
    43-                   return (_Last);
    44-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstddef

FUNCTION NAME: std::equal_to<unsigned long>::operator () const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstddef

FUNCTION NAME: std::equal_to<unsigned long>::operator () const
FORMAT LIST

 LINE   LOOP      STATEMENT

   234-                   _CONST_FUN bool operator()(const _Ty& _Left, const _Ty& _Right) const
   235-                           {       // apply operator== to operands
   236-                           return (_Left == _Right);
   237-                           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_alloc<std::_List_base_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::~_List_alloc
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   599: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_alloc<std::_List_base_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::~_List_alloc
FORMAT LIST

 LINE   LOOP      STATEMENT

   597-               ~_List_alloc() _NOEXCEPT
   598-                   {   // destroy head node
   599-                   _Freeheadnode(_Myhead());
   600-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_alloc<std::_List_base_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::_Buynode0
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   708: inl(1212): Source for routine not found.: std::_Allocate<std::_List_node<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, void *>>
   716: inl(1212): Source for routine not found.: std::forward<std::_List_node<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, void *> *&>
   721: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_alloc<std::_List_base_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::_Buynode0
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-               _Nodeptr _Buynode0(_Nodeptr _Next,
   706-                   _Nodeptr _Prev)
   707-                   {   // allocate a node and set links
   708-                   _Nodeptr _Pnode = _Getal().allocate(1);
   709-           
   710-                   if (_Next == _Nodeptr())
   711-                       {   // point at self
   712-                       _Next = _Pnode;
   713-                       _Prev = _Pnode;
   714-                       }
   715-                   _TRY_BEGIN
   716-                   _Getal().construct(
   717-                       _STD addressof(_Nextnode(_Pnode)), _Next);
   718-                   _Getal().construct(
   719-                       _STD addressof(_Prevnode(_Pnode)), _Prev);
   720-                   _CATCH_ALL
   721-                   _Getal().deallocate(_Pnode, 1);
   722-                   _RERAISE;
   723-                   _CATCH_END
   724-           
   725-                   return (_Pnode);
   726-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_buy<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::_List_buy
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   794: inl(1212): Source for routine not found.: std::forward<const std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_buy<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::_List_buy
FORMAT LIST

 LINE   LOOP      STATEMENT

   793-               _List_buy(const _Alloc& _Al = _Alloc())
   794-                   : _Mybase(_Al)
   795-                   {   // construct from allocator
   796-                   }
   797-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_buy<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::_Buynode<const std::piecewise_construct_t &, std::tuple<const unsigned long &>, std::tuple<>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   810: inl(1212): Source for routine not found.: std::_List_alloc<std::_List_base_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::_Buynode0
   813: inl(1212): Source for routine not found.: std::forward<const std::piecewise_construct_t &>
   817: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_buy<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::_Buynode<const std::piecewise_construct_t &, std::tuple<const unsigned long &>, std::tuple<>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   807-                   _Nodeptr _Buynode(_Nodeptr _Next, _Nodeptr _Prev,
   808-                       _Valty&&... _Val)
   809-                   {   // allocate a node and set links and value
   810-                   _Nodeptr _Pnode = this->_Buynode0(_Next, _Prev);
   811-           
   812-                   _TRY_BEGIN
   813-                   this->_Getal().construct(
   814-                       _STD addressof(this->_Myval(_Pnode)),
   815-                           _STD forward<_Valty>(_Val)...);
   816-                   _CATCH_ALL
   817-                   this->_Getal().deallocate(_Pnode, 1);
   818-                   _RERAISE;
   819-                   _CATCH_END
   820-           
   821-                   return (_Pnode);
   822-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::list
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   930: inl(1212): Source for routine not found.: std::_List_buy<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::_List_buy


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::list
FORMAT LIST

 LINE   LOOP      STATEMENT

   929-               explicit list(const _Alloc& _Al)
   930-                   : _Mybase(_Al)
   931-                   {   // construct empty list, allocator
   932-                   }
   933-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::~list
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1209: inl(1212): Source for routine not found.: std::list<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::clear
  1210: inl(1212): Source for routine not found.: std::_List_buy<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::~_List_buy


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::~list
FORMAT LIST

 LINE   LOOP      STATEMENT

  1207-               ~list() _NOEXCEPT
  1208-                   {   // destroy the object
  1209-                   _Tidy();
  1210-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::clear
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1624: vec( 103): Unvectorized loop.
  1624: vec( 110): Vectorization obstructive function reference.: operator delete
  1624: vec( 110): Vectorization obstructive function reference.: ~pair
  1627: inl(1212): Source for routine not found.: std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::~pair


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::clear
FORMAT LIST

 LINE   LOOP      STATEMENT

  1613-               _NOINLINE void clear() _NOEXCEPT
  1614-                   {   // erase all
  1615-            #if _ITERATOR_DEBUG_LEVEL == 2
  1616-                   this->_Orphan_ptr(0);
  1617-            #endif /* _ITERATOR_DEBUG_LEVEL == 2 */
  1618-           
  1619-                   _Nodeptr _Pnode = this->_Nextnode(this->_Myhead());
  1620-                   this->_Nextnode(this->_Myhead()) = this->_Myhead();
  1621-                   this->_Prevnode(this->_Myhead()) = this->_Myhead();
  1622-                   this->_Mysize() = 0;
  1623-           
  1624- +------>          for (_Nodeptr _Pnext; _Pnode != this->_Myhead(); _Pnode = _Pnext)
  1625- |                     {   // delete an element
  1626- |                     _Pnext = this->_Nextnode(_Pnode);
  1627- |                     this->_Freenode(_Pnode);
  1628- +------               }
  1629-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>>::~vector
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1093: vec( 103): Unvectorized loop.
  1093: vec( 108): Unvectorizable loop structure.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>>::~vector
FORMAT LIST

 LINE   LOOP      STATEMENT

  1091-               ~vector() _NOEXCEPT
  1092-                   {   // destroy the object
  1093- +======>          _Tidy();
  1094-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>>::_Reallocate
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1780: inl(1212): Source for routine not found.: std::_Allocate<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
  1783: inl(1212): Source for routine not found.: std::_Uninit_move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
  1785: inl(1212): Source for routine not found.: operator delete 
  1792: vec( 103): Unvectorized loop.
  1792: vec( 108): Unvectorizable loop structure.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>>::_Reallocate
FORMAT LIST

 LINE   LOOP      STATEMENT

  1778-               _NOINLINE void _Reallocate(size_type _Count)
  1779-                   {   // move to array of exactly _Count elements
  1780-                   pointer _Ptr = this->_Getal().allocate(_Count);
  1781-           
  1782-                   _TRY_BEGIN
  1783-                   _Umove(this->_Myfirst(), this->_Mylast(), _Ptr);
  1784-                   _CATCH_ALL
  1785-                   this->_Getal().deallocate(_Ptr, _Count);
  1786-                   _RERAISE;
  1787-                   _CATCH_END
  1788-           
  1789-                   size_type _Size = size();
  1790-                   if (this->_Myfirst() != pointer())
  1791-                       {   // destroy and deallocate old array
  1792- +======>              _Destroy(this->_Myfirst(), this->_Mylast());
  1793-                       this->_Getal().deallocate(this->_Myfirst(),
  1794-                           this->_Myend() - this->_Myfirst());
  1795-                       }
  1796-           
  1797-                   this->_Orphan_all();
  1798-                   this->_Myend() = _Ptr + _Count;
  1799-                   this->_Mylast() = _Ptr + _Size;
  1800-                   this->_Myfirst() = _Ptr;
  1801-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>>::_Insert_n
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1857: inl(1212): Source for routine not found.: std::_Xlength_error
  1860: inl(1212): Source for routine not found.: std::_Allocate<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
  1865: inl(1212): Source for routine not found.: std::_Uninit_fill_n<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, unsigned long, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
  1868: inl(1212): Source for routine not found.: std::_Uninit_move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
  1875: vec( 103): Unvectorized loop.
  1875: vec( 108): Unvectorizable loop structure.
  1877: vec( 103): Unvectorized loop.
  1877: vec( 108): Unvectorizable loop structure.
  1878: inl(1212): Source for routine not found.: operator delete 
  1885: vec( 103): Unvectorized loop.
  1885: vec( 108): Unvectorizable loop structure.
  1908: vec( 103): Unvectorized loop.
  1908: vec( 108): Unvectorizable loop structure.
  1915: vec( 103): Unvectorized loop.
  1915: vec( 108): Unvectorizable loop structure.
  1927: inl(1212): Source for routine not found.: std::_Move_backward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *>
  1929: vec( 103): Unvectorized loop.
  1929: vec( 108): Unvectorizable loop structure.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>>::_Insert_n
FORMAT LIST

 LINE   LOOP      STATEMENT

  1841-               _NOINLINE iterator _Insert_n(const_iterator _Where,
  1842-                   size_type _Count, const value_type& _Val)
  1843-                   {   // insert _Count * _Val at _Where
  1844-            #if _ITERATOR_DEBUG_LEVEL == 2
  1845-                   if (_VICONT(_Where) != &this->_Get_data()
  1846-                       || _VIPTR(_Where) < this->_Myfirst()
  1847-                       || this->_Mylast() < _VIPTR(_Where))
  1848-                       _DEBUG_ERROR("vector insert iterator outside range");
  1849-            #endif /* _ITERATOR_DEBUG_LEVEL == 2 */
  1850-           
  1851-                   size_type _Off = _VIPTR(_Where) - this->_Myfirst();
  1852-                   if (_Count == 0)
  1853-                       ;
  1854-                   else if (_Unused_capacity() < _Count)
  1855-                       {   // not enough room, reallocate
  1856-                       if (max_size() - size() < _Count)
  1857-                           _Xlen();    // result too long
  1858-           
  1859-                       size_type _Capacity = _Grow_to(size() + _Count);
  1860-                       pointer _Newvec = this->_Getal().allocate(_Capacity);
  1861-                       size_type _Whereoff = _VIPTR(_Where) - this->_Myfirst();
  1862-                       int _Ncopied = 0;
  1863-           
  1864-                       _TRY_BEGIN
  1865-                       _Ufill(_Newvec + _Whereoff, _Count,
  1866-                           _STD addressof(_Val));  // add new stuff
  1867-                       ++_Ncopied;
  1868-                       _Umove(this->_Myfirst(), _VIPTR(_Where),
  1869-                           _Newvec);   // copy prefix
  1870-                       ++_Ncopied;
  1871-                       _Umove(_VIPTR(_Where), this->_Mylast(),
  1872-                           _Newvec + (_Whereoff + _Count));    // copy suffix
  1873-                       _CATCH_ALL
  1874-                       if (1 < _Ncopied)
  1875- +======>                  _Destroy(_Newvec, _Newvec + _Whereoff);
  1876-                       if (0 < _Ncopied)
  1877- +======>                  _Destroy(_Newvec + _Whereoff, _Newvec + _Whereoff + _Count);
  1878-                       this->_Getal().deallocate(_Newvec, _Capacity);
  1879-                       _RERAISE;
  1880-                       _CATCH_END
  1881-           
  1882-                       _Count += size();
  1883-                       if (this->_Myfirst() != pointer())
  1884-                           {   // destroy and deallocate old array
  1885- +======>                  _Destroy(this->_Myfirst(), this->_Mylast());
  1886-                           this->_Getal().deallocate(this->_Myfirst(),
  1887-                               this->_Myend() - this->_Myfirst());
  1888-                           }
  1889-           
  1890-                       this->_Orphan_all();
  1891-                       this->_Myend() = _Newvec + _Capacity;
  1892-                       this->_Mylast() = _Newvec + _Count;
  1893-                       this->_Myfirst() = _Newvec;
  1894-                       }
  1895-                   else if ((size_type)(this->_Mylast() - _VIPTR(_Where))
  1896-                       < _Count)
  1897-                       {   // new stuff spills off end
  1898-                       value_type _Tmp = _Val; // in case _Val is in sequence
  1899-           
  1900-                       _Umove(_VIPTR(_Where), this->_Mylast(),
  1901-                           _VIPTR(_Where) + _Count);   // copy suffix
  1902-           
  1903-                       _TRY_BEGIN
  1904-                       _Ufill(this->_Mylast(),
  1905-                           _Count - (this->_Mylast() - _VIPTR(_Where)),
  1906-                           _STD addressof(_Tmp));  // insert new stuff off end
  1907-                       _CATCH_ALL
  1908- +======>              _Destroy(_VIPTR(_Where) + _Count,
  1909-                           this->_Mylast() + _Count);
  1910-                       _RERAISE;
  1911-                       _CATCH_END
  1912-           
  1913-                       this->_Mylast() += _Count;
  1914-                       _Orphan_range(_VIPTR(_Where), this->_Mylast());
  1915- +======>              _STD fill(_VIPTR(_Where), this->_Mylast() - _Count,
  1916-                           _Tmp);  // insert up to old end
  1917-                       }
  1918-                   else
  1919-                       {   // new stuff can all be assigned
  1920-                       value_type _Tmp = _Val; // in case _Val is in sequence
  1921-           
  1922-                       pointer _Oldend = this->_Mylast();
  1923-                       this->_Mylast() = _Umove(_Oldend - _Count, _Oldend,
  1924-                           this->_Mylast());   // copy suffix
  1925-           
  1926-                       _Orphan_range(_VIPTR(_Where), this->_Mylast());
  1927-                       _Move_backward(_VIPTR(_Where), _Oldend - _Count,
  1928-                           _Oldend);   // copy hole
  1929- +======>              _STD fill(_VIPTR(_Where),
  1930-                           _VIPTR(_Where) + _Count, _Tmp); // insert into hole
  1931-                       }
  1932-                   return (begin() + _Off);
  1933-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Hash
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   186: inl(1212): Source for routine not found.: std::list<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::list
   187: inl(1212): Source for routine not found.: std::forward<const std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>> &>
   190: inl(1212): Source for routine not found.: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>>::_Reallocate
   190: vec( 103): Unvectorized loop.
   190: vec( 108): Unvectorizable loop structure.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Hash
FORMAT LIST

 LINE   LOOP      STATEMENT

   183-               _Hash(const key_compare& _Parg,
   184-                   const allocator_type& _Al)
   185-                   : _Traitsobj(_Parg),
   186-                       _List(_Al),
   187-                       _Vec(_Al)
   188-                   {   // construct empty hash table
   189-                   _Max_bucket_size() = _Bucket_size;
   190-                   _Init();
   191-                   }
   192-               _Hash(const _Myt& _Right, const allocator_type& _Al)
   193- +======>          : _Traitsobj(),
   194-                       _List(_Al),


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::~_Hash
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   294: inl(1212): Source for routine not found.: operator delete 
   294: vec( 103): Unvectorized loop.
   294: vec( 108): Unvectorizable loop structure.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::~_Hash
FORMAT LIST

 LINE   LOOP      STATEMENT

   291-               ~_Hash() _NOEXCEPT
   292-                   {   // destroy hash table
   293- |         //      _List.clear();  // speed orphaning of checked iterators
   294- +======>          }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::lower_bound
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   635: inl(1212): Source for routine not found.: std::_Hash_seq
   636: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_End
   636: vec( 103): Unvectorized loop.
   636: vec( 110): Vectorization obstructive function reference.: _End
   636: vec( 110): Vectorization obstructive function reference.: operator()
   638: inl(1212): Source for routine not found.: std::equal_to<unsigned long>::operator () const


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::lower_bound
FORMAT LIST

 LINE   LOOP      STATEMENT

   633-               iterator lower_bound(const key_type& _Keyval)
   634-                   {   // find leftmost not less than _Keyval in mutable hash table
   635-                   size_type _Bucket = _Hashval(_Keyval);
   636- +------>          for (_Unchecked_iterator _Where = _Begin(_Bucket);
   637- |                     _Where != _End(_Bucket); ++_Where)
   638- |                     if (!_Traitsobj(_Traits::_Kfn(*_Where), _Keyval))
   639- |                         return (_Traitsobj(_Keyval,
   640- +------                       _Traits::_Kfn(*_Where)) ? end() : _Make_iter(_Where));
   641-                   return (end());
   642-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Insertx
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   816: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Check_size
   818: inl(1212): Source for routine not found.: std::_Hash_seq
   822: inl(1212): Source for routine not found.: std::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, bool>::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, bool, void>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Insertx
FORMAT LIST

 LINE   LOOP      STATEMENT

   800-               _Pairib _Insertx(_Unchecked_iterator _Where, size_type _Bucket,
   801-                   _Unchecked_iterator _Plist)
   802-                   {   // insert from beginning of list
   803-            #else /* _GCC44 */
   804-                   _Unchecked_iterator _Plist =
   805-                       _Buynode_if_nil(_STD forward<_Valty>(_Val), _Pnode);
   806-            #endif /* _GCC44 */
   807-           
   808-                   _Unchecked_iterator _Next = _Plist;
   809-           
   810-                   if (_Where != ++_Next)  // move element into place
   811-                       _List._Unchecked_splice(_Where, _Plist, _Next);
   812-           
   813-                   _Insert_bucket(_Plist, _Where, _Bucket);
   814-           
   815-                   _TRY_BEGIN
   816-                   _Check_size();
   817-                   _CATCH_ALL
   818-                   erase(_Make_iter(_Plist));
   819-                   _RERAISE;
   820-                   _CATCH_END
   821-           
   822-                   return (_Pairib(_Make_iter(_Plist), true));
   823-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_End
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_End
FORMAT LIST

 LINE   LOOP      STATEMENT

   855-               _Unchecked_iterator _End(size_type _Bucket)
   856-                   {   // return end iterator for bucket _Bucket
   857-                   if (_Vec_lo(_Bucket) == _Unchecked_end())
   858-                       return (_Unchecked_end());
   859-                   else
   860-                       {   // point past last element
   861-                       _Unchecked_iterator _Ans = _Vec_hi(_Bucket);
   862-                       return (++_Ans);
   863-                       }
   864-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Check_size
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   946: inl(1212): Source for routine not found.: std::_Xlength_error
   946: vec( 103): Unvectorized loop.
   946: vec( 108): Unvectorizable loop structure.
   947: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Reinsert


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Check_size
FORMAT LIST

 LINE   LOOP      STATEMENT

   935-               void _Check_size()
   936-                   {   // grow table as needed
   937-                   if (max_load_factor() < load_factor())
   938-           
   939-                       {   // rehash to bigger table
   940-                       size_type _Newsize = bucket_count();
   941-           
   942-                       if (_Newsize < 512)
   943-                           _Newsize *= 8;  // multiply by 8
   944-                       else if (_Newsize < _Vec.max_size() / 2)
   945-                           _Newsize *= 2;  // multiply safely by 2
   946- +======>              _Init(_Newsize);
   947-                       _Reinsert();
   948-                       }
   949-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Reinsert
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   955: vec( 103): Unvectorized loop.
   955: vec( 110): Vectorization obstructive function reference.: _Insert
   959: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Insert<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>&, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Reinsert
FORMAT LIST

 LINE   LOOP      STATEMENT

   951-               void _Reinsert()
   952-                   {   // insert elements in [begin(), end())
   953-                   _Unchecked_iterator _Last = _Unchecked_end();
   954-                   if (_Unchecked_begin() != _Last)
   955- +------>              for (--_Last; ; )
   956- |                         {   // reinsert elements in [begin(), _Last]
   957- |                         _Unchecked_iterator _First = _Unchecked_begin();
   958- |                         bool _Done = _First == _Last;
   959- |                         _Insert(*_First, _First);
   960- |                         if (_Done)
   961- |                             break;
   962- +------                   }
   963-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Insert<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>&, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   771: inl(1212): Source for routine not found.: std::_Hash_seq
   772: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_End
   773: vec( 103): Unvectorized loop.
   773: vec( 110): Vectorization obstructive function reference.: operator()
   774: inl(1212): Source for routine not found.: std::equal_to<unsigned long>::operator () const
   787: inl(1212): Source for routine not found.: std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::~pair
   788: inl(1212): Source for routine not found.: std::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, bool>::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, bool, void>
   796: inl(1212): Source for routine not found.: std::forward<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::_Insert<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>&, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   765-                   _Pairib _Insert(_Valty _REFREF _Val, _Nodety _Pnode)
   766-                   {   // try to insert existing node with value _Val
   767-                   size_type _Bucket;
   768-                   _Unchecked_iterator _Where;
   769-           
   770-                   _TRY_BEGIN
   771-                   _Bucket = _Hashval(_Traits::_Kfn(_Val));
   772-                   _Where = _End(_Bucket);
   773- +------>          for (; _Where != _Begin(_Bucket); )
   774- |                     if (_Traitsobj(_Traits::_Kfn(_Val),
   775- |                         _Traits::_Kfn(*--_Where)))
   776- |                         ;   // still too high in bucket list
   777- |                     else if (_Multi
   778- |                         || (!_Traits::_Standard
   779- |                             && _Traitsobj(_Traits::_Kfn(*_Where),
   780- |                                 _Traits::_Kfn(_Val))))
   781- |                         {   // found insertion point, back up to it
   782- |                         ++_Where;
   783- |                         break;
   784- |                         }
   785- |                     else
   786- |                         {   // discard new list element and return existing
   787- |                         _Destroy_if_not_nil(_Pnode);
   788- |                         return (_Pairib(_Make_iter(_Where), false));
   789- +------                   }
   790-                   _CATCH_ALL
   791-                   _Destroy_if_not_nil(_Pnode);
   792-                   _RERAISE;
   793-                   _CATCH_END
   794-           
   795-            #if _GCC44 /* compiler test */
   796-                   return (_Insertx(_Where, _Bucket,
   797-                       _Buynode_if_nil(_STD forward<_Valty>(_Val), _Pnode)));
   798-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/unordered_map

FUNCTION NAME: std::unordered_map<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::hash<unsigned long>, std::equal_to<unsigned long>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::unordered_map
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   110: inl(1212): Source for routine not found.: std::forward<std::hash<unsigned long> &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/unordered_map

FUNCTION NAME: std::unordered_map<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::hash<unsigned long>, std::equal_to<unsigned long>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::unordered_map
FORMAT LIST

 LINE   LOOP      STATEMENT

   109-               unordered_map()
   110-                   : _Mybase(key_compare(), allocator_type())
   111-                   {   // construct empty map from defaults
   112-                   }
   113-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/unordered_map

FUNCTION NAME: std::unordered_map<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::hash<unsigned long>, std::equal_to<unsigned long>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::operator []
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   429: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::_Uhash_compare<unsigned long, std::hash<unsigned long>, std::equal_to<unsigned long>>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>, (bool)0>>::lower_bound
   433: inl(1212): Source for routine not found.: std::forward_as_tuple<const unsigned long &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/unordered_map

FUNCTION NAME: std::unordered_map<unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>, std::hash<unsigned long>, std::equal_to<unsigned long>, std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>::operator []
FORMAT LIST

 LINE   LOOP      STATEMENT

   427-               mapped_type& operator[](const key_type& _Keyval)
   428-                   {   // find element matching _Keyval or insert with default mapped
   429-                   iterator _Where = _Mybase::lower_bound(_Keyval);
   430-                   if (_Where == _Mybase::end())
   431-           
   432-            #if _HAS_RVALUE_REFERENCES
   433-                       _Where = _Mybase::emplace(
   434-                           piecewise_construct,
   435-                           _STD forward_as_tuple(_Keyval),
   436-                           tuple<>()).first;
   437-           
   438-            #else /* _HAS_RVALUE_REFERENCES */
   439-                       _Where = _Mybase::insert(
   440-                           pair<key_type, mapped_type>(
   441-                               _Keyval,
   442-                               mapped_type())).first;
   443-            #endif /* _HAS_RVALUE_REFERENCES */
   444-           
   445-                   return (_Where->second);
   446-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<double, std::allocator<double>>::~vector
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1093: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<double, std::allocator<double>>::~vector
FORMAT LIST

 LINE   LOOP      STATEMENT

  1091-               ~vector() _NOEXCEPT
  1092-                   {   // destroy the object
  1093-                   _Tidy();
  1094-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<double, std::allocator<double>>::push_back
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1431: inl(1212): Source for routine not found.: std::_Xlength_error
  1433: inl(1212): Source for routine not found.: std::forward<double &>
  1442: inl(1212): Source for routine not found.: std::forward<const double &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<double, std::allocator<double>>::push_back
FORMAT LIST

 LINE   LOOP      STATEMENT

  1425-               _NOINLINE void push_back(const value_type& _Val)
  1426-                   {   // insert element at end
  1427-                   if (_Inside(_STD addressof(_Val)))
  1428-                       {   // push back an element
  1429-                       size_type _Idx = _STD addressof(_Val) - this->_Myfirst();
  1430-                       if (this->_Mylast() == this->_Myend())
  1431-                           _Reserve(1);
  1432-                       _Orphan_range(this->_Mylast(), this->_Mylast());
  1433-                       this->_Getal().construct(this->_Mylast(),
  1434-                           this->_Myfirst()[_Idx]);
  1435-                       ++this->_Mylast();
  1436-                       }
  1437-                   else
  1438-                       {   // push back a non-element
  1439-                       if (this->_Mylast() == this->_Myend())
  1440-                           _Reserve(1);
  1441-                       _Orphan_range(this->_Mylast(), this->_Mylast());
  1442-                       this->_Getal().construct(this->_Mylast(),
  1443-                           _Val);
  1444-                       ++this->_Mylast();
  1445-                       }
  1446-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<double, std::allocator<double>>::_Reallocate
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1780: inl(1212): Source for routine not found.: std::_Allocate<double>
  1785: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<double, std::allocator<double>>::_Reallocate
FORMAT LIST

 LINE   LOOP      STATEMENT

  1778-               _NOINLINE void _Reallocate(size_type _Count)
  1779-                   {   // move to array of exactly _Count elements
  1780-                   pointer _Ptr = this->_Getal().allocate(_Count);
  1781-           
  1782-                   _TRY_BEGIN
  1783-                   _Umove(this->_Myfirst(), this->_Mylast(), _Ptr);
  1784-                   _CATCH_ALL
  1785-                   this->_Getal().deallocate(_Ptr, _Count);
  1786-                   _RERAISE;
  1787-                   _CATCH_END
  1788-           
  1789-                   size_type _Size = size();
  1790-                   if (this->_Myfirst() != pointer())
  1791-                       {   // destroy and deallocate old array
  1792-                       _Destroy(this->_Myfirst(), this->_Mylast());
  1793-                       this->_Getal().deallocate(this->_Myfirst(),
  1794-                           this->_Myend() - this->_Myfirst());
  1795-                       }
  1796-           
  1797-                   this->_Orphan_all();
  1798-                   this->_Myend() = _Ptr + _Count;
  1799-                   this->_Mylast() = _Ptr + _Size;
  1800-                   this->_Myfirst() = _Ptr;
  1801-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>::pair<TaskVariant *const &, >
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>::pair<TaskVariant *const &, >
FORMAT LIST

 LINE   LOOP      STATEMENT

   Cannot output Format List.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>::pair<std::tuple<TaskVariant *const &>, std::tuple<>, (unsigned long)0, >
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>::pair<std::tuple<TaskVariant *const &>, std::tuple<>, (unsigned long)0, >
FORMAT LIST

 LINE   LOOP      STATEMENT

   Cannot output Format List.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstddef

FUNCTION NAME: std::equal_to<TaskVariant *>::operator () const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstddef

FUNCTION NAME: std::equal_to<TaskVariant *>::operator () const
FORMAT LIST

 LINE   LOOP      STATEMENT

   234-                   _CONST_FUN bool operator()(const _Ty& _Left, const _Ty& _Right) const
   235-                           {       // apply operator== to operands
   236-                           return (_Left == _Right);
   237-                           }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_alloc<std::_List_base_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::~_List_alloc
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   599: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:07 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_alloc<std::_List_base_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::~_List_alloc
FORMAT LIST

 LINE   LOOP      STATEMENT

   597-               ~_List_alloc() _NOEXCEPT
   598-                   {   // destroy head node
   599-                   _Freeheadnode(_Myhead());
   600-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_alloc<std::_List_base_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::_Buynode0
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   708: inl(1212): Source for routine not found.: std::_Allocate<std::_List_node<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, void *>>
   716: inl(1212): Source for routine not found.: std::forward<std::_List_node<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, void *> *&>
   721: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_alloc<std::_List_base_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::_Buynode0
FORMAT LIST

 LINE   LOOP      STATEMENT

   705-               _Nodeptr _Buynode0(_Nodeptr _Next,
   706-                   _Nodeptr _Prev)
   707-                   {   // allocate a node and set links
   708-                   _Nodeptr _Pnode = _Getal().allocate(1);
   709-           
   710-                   if (_Next == _Nodeptr())
   711-                       {   // point at self
   712-                       _Next = _Pnode;
   713-                       _Prev = _Pnode;
   714-                       }
   715-                   _TRY_BEGIN
   716-                   _Getal().construct(
   717-                       _STD addressof(_Nextnode(_Pnode)), _Next);
   718-                   _Getal().construct(
   719-                       _STD addressof(_Prevnode(_Pnode)), _Prev);
   720-                   _CATCH_ALL
   721-                   _Getal().deallocate(_Pnode, 1);
   722-                   _RERAISE;
   723-                   _CATCH_END
   724-           
   725-                   return (_Pnode);
   726-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_buy<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::_List_buy
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   794: inl(1212): Source for routine not found.: std::forward<const std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_buy<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::_List_buy
FORMAT LIST

 LINE   LOOP      STATEMENT

   793-               _List_buy(const _Alloc& _Al = _Alloc())
   794-                   : _Mybase(_Al)
   795-                   {   // construct from allocator
   796-                   }
   797-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_buy<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::_Buynode<const std::piecewise_construct_t &, std::tuple<TaskVariant *const &>, std::tuple<>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   810: inl(1212): Source for routine not found.: std::_List_alloc<std::_List_base_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::_Buynode0
   813: inl(1212): Source for routine not found.: std::forward<const std::piecewise_construct_t &>
   817: inl(1212): Source for routine not found.: operator delete 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::_List_buy<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::_Buynode<const std::piecewise_construct_t &, std::tuple<TaskVariant *const &>, std::tuple<>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   807-                   _Nodeptr _Buynode(_Nodeptr _Next, _Nodeptr _Prev,
   808-                       _Valty&&... _Val)
   809-                   {   // allocate a node and set links and value
   810-                   _Nodeptr _Pnode = this->_Buynode0(_Next, _Prev);
   811-           
   812-                   _TRY_BEGIN
   813-                   this->_Getal().construct(
   814-                       _STD addressof(this->_Myval(_Pnode)),
   815-                           _STD forward<_Valty>(_Val)...);
   816-                   _CATCH_ALL
   817-                   this->_Getal().deallocate(_Pnode, 1);
   818-                   _RERAISE;
   819-                   _CATCH_END
   820-           
   821-                   return (_Pnode);
   822-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::list
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   930: inl(1212): Source for routine not found.: std::_List_buy<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::_List_buy


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::list
FORMAT LIST

 LINE   LOOP      STATEMENT

   929-               explicit list(const _Alloc& _Al)
   930-                   : _Mybase(_Al)
   931-                   {   // construct empty list, allocator
   932-                   }
   933-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::~list
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1209: inl(1212): Source for routine not found.: std::list<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::clear
  1210: inl(1212): Source for routine not found.: std::_List_buy<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::~_List_buy


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::~list
FORMAT LIST

 LINE   LOOP      STATEMENT

  1207-               ~list() _NOEXCEPT
  1208-                   {   // destroy the object
  1209-                   _Tidy();
  1210-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::clear
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1624: vec( 103): Unvectorized loop.
  1624: vec( 110): Vectorization obstructive function reference.: operator delete
  1624: vec( 110): Vectorization obstructive function reference.: ~pair
  1627: inl(1212): Source for routine not found.: std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>::~pair


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/list

FUNCTION NAME: std::list<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::clear
FORMAT LIST

 LINE   LOOP      STATEMENT

  1613-               _NOINLINE void clear() _NOEXCEPT
  1614-                   {   // erase all
  1615-            #if _ITERATOR_DEBUG_LEVEL == 2
  1616-                   this->_Orphan_ptr(0);
  1617-            #endif /* _ITERATOR_DEBUG_LEVEL == 2 */
  1618-           
  1619-                   _Nodeptr _Pnode = this->_Nextnode(this->_Myhead());
  1620-                   this->_Nextnode(this->_Myhead()) = this->_Myhead();
  1621-                   this->_Prevnode(this->_Myhead()) = this->_Myhead();
  1622-                   this->_Mysize() = 0;
  1623-           
  1624- +------>          for (_Nodeptr _Pnext; _Pnode != this->_Myhead(); _Pnode = _Pnext)
  1625- |                     {   // delete an element
  1626- |                     _Pnext = this->_Nextnode(_Pnode);
  1627- |                     this->_Freenode(_Pnode);
  1628- +------               }
  1629-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::~vector
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1093: vec( 103): Unvectorized loop.
  1093: vec( 108): Unvectorizable loop structure.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::~vector
FORMAT LIST

 LINE   LOOP      STATEMENT

  1091-               ~vector() _NOEXCEPT
  1092-                   {   // destroy the object
  1093- +======>          _Tidy();
  1094-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::_Reallocate
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1780: inl(1212): Source for routine not found.: std::_Allocate<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
  1783: inl(1212): Source for routine not found.: std::_Uninit_move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
  1785: inl(1212): Source for routine not found.: operator delete 
  1792: vec( 103): Unvectorized loop.
  1792: vec( 108): Unvectorizable loop structure.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::_Reallocate
FORMAT LIST

 LINE   LOOP      STATEMENT

  1778-               _NOINLINE void _Reallocate(size_type _Count)
  1779-                   {   // move to array of exactly _Count elements
  1780-                   pointer _Ptr = this->_Getal().allocate(_Count);
  1781-           
  1782-                   _TRY_BEGIN
  1783-                   _Umove(this->_Myfirst(), this->_Mylast(), _Ptr);
  1784-                   _CATCH_ALL
  1785-                   this->_Getal().deallocate(_Ptr, _Count);
  1786-                   _RERAISE;
  1787-                   _CATCH_END
  1788-           
  1789-                   size_type _Size = size();
  1790-                   if (this->_Myfirst() != pointer())
  1791-                       {   // destroy and deallocate old array
  1792- +======>              _Destroy(this->_Myfirst(), this->_Mylast());
  1793-                       this->_Getal().deallocate(this->_Myfirst(),
  1794-                           this->_Myend() - this->_Myfirst());
  1795-                       }
  1796-           
  1797-                   this->_Orphan_all();
  1798-                   this->_Myend() = _Ptr + _Count;
  1799-                   this->_Mylast() = _Ptr + _Size;
  1800-                   this->_Myfirst() = _Ptr;
  1801-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::_Insert_n
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1857: inl(1212): Source for routine not found.: std::_Xlength_error
  1860: inl(1212): Source for routine not found.: std::_Allocate<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
  1865: inl(1212): Source for routine not found.: std::_Uninit_fill_n<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, unsigned long, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
  1868: inl(1212): Source for routine not found.: std::_Uninit_move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
  1875: vec( 103): Unvectorized loop.
  1875: vec( 108): Unvectorizable loop structure.
  1877: vec( 103): Unvectorized loop.
  1877: vec( 108): Unvectorizable loop structure.
  1878: inl(1212): Source for routine not found.: operator delete 
  1885: vec( 103): Unvectorized loop.
  1885: vec( 108): Unvectorizable loop structure.
  1908: vec( 103): Unvectorized loop.
  1908: vec( 108): Unvectorizable loop structure.
  1915: vec( 103): Unvectorized loop.
  1915: vec( 108): Unvectorizable loop structure.
  1927: inl(1212): Source for routine not found.: std::_Move_backward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *>
  1929: vec( 103): Unvectorized loop.
  1929: vec( 108): Unvectorizable loop structure.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/vector

FUNCTION NAME: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::_Insert_n
FORMAT LIST

 LINE   LOOP      STATEMENT

  1841-               _NOINLINE iterator _Insert_n(const_iterator _Where,
  1842-                   size_type _Count, const value_type& _Val)
  1843-                   {   // insert _Count * _Val at _Where
  1844-            #if _ITERATOR_DEBUG_LEVEL == 2
  1845-                   if (_VICONT(_Where) != &this->_Get_data()
  1846-                       || _VIPTR(_Where) < this->_Myfirst()
  1847-                       || this->_Mylast() < _VIPTR(_Where))
  1848-                       _DEBUG_ERROR("vector insert iterator outside range");
  1849-            #endif /* _ITERATOR_DEBUG_LEVEL == 2 */
  1850-           
  1851-                   size_type _Off = _VIPTR(_Where) - this->_Myfirst();
  1852-                   if (_Count == 0)
  1853-                       ;
  1854-                   else if (_Unused_capacity() < _Count)
  1855-                       {   // not enough room, reallocate
  1856-                       if (max_size() - size() < _Count)
  1857-                           _Xlen();    // result too long
  1858-           
  1859-                       size_type _Capacity = _Grow_to(size() + _Count);
  1860-                       pointer _Newvec = this->_Getal().allocate(_Capacity);
  1861-                       size_type _Whereoff = _VIPTR(_Where) - this->_Myfirst();
  1862-                       int _Ncopied = 0;
  1863-           
  1864-                       _TRY_BEGIN
  1865-                       _Ufill(_Newvec + _Whereoff, _Count,
  1866-                           _STD addressof(_Val));  // add new stuff
  1867-                       ++_Ncopied;
  1868-                       _Umove(this->_Myfirst(), _VIPTR(_Where),
  1869-                           _Newvec);   // copy prefix
  1870-                       ++_Ncopied;
  1871-                       _Umove(_VIPTR(_Where), this->_Mylast(),
  1872-                           _Newvec + (_Whereoff + _Count));    // copy suffix
  1873-                       _CATCH_ALL
  1874-                       if (1 < _Ncopied)
  1875- +======>                  _Destroy(_Newvec, _Newvec + _Whereoff);
  1876-                       if (0 < _Ncopied)
  1877- +======>                  _Destroy(_Newvec + _Whereoff, _Newvec + _Whereoff + _Count);
  1878-                       this->_Getal().deallocate(_Newvec, _Capacity);
  1879-                       _RERAISE;
  1880-                       _CATCH_END
  1881-           
  1882-                       _Count += size();
  1883-                       if (this->_Myfirst() != pointer())
  1884-                           {   // destroy and deallocate old array
  1885- +======>                  _Destroy(this->_Myfirst(), this->_Mylast());
  1886-                           this->_Getal().deallocate(this->_Myfirst(),
  1887-                               this->_Myend() - this->_Myfirst());
  1888-                           }
  1889-           
  1890-                       this->_Orphan_all();
  1891-                       this->_Myend() = _Newvec + _Capacity;
  1892-                       this->_Mylast() = _Newvec + _Count;
  1893-                       this->_Myfirst() = _Newvec;
  1894-                       }
  1895-                   else if ((size_type)(this->_Mylast() - _VIPTR(_Where))
  1896-                       < _Count)
  1897-                       {   // new stuff spills off end
  1898-                       value_type _Tmp = _Val; // in case _Val is in sequence
  1899-           
  1900-                       _Umove(_VIPTR(_Where), this->_Mylast(),
  1901-                           _VIPTR(_Where) + _Count);   // copy suffix
  1902-           
  1903-                       _TRY_BEGIN
  1904-                       _Ufill(this->_Mylast(),
  1905-                           _Count - (this->_Mylast() - _VIPTR(_Where)),
  1906-                           _STD addressof(_Tmp));  // insert new stuff off end
  1907-                       _CATCH_ALL
  1908- +======>              _Destroy(_VIPTR(_Where) + _Count,
  1909-                           this->_Mylast() + _Count);
  1910-                       _RERAISE;
  1911-                       _CATCH_END
  1912-           
  1913-                       this->_Mylast() += _Count;
  1914-                       _Orphan_range(_VIPTR(_Where), this->_Mylast());
  1915- +======>              _STD fill(_VIPTR(_Where), this->_Mylast() - _Count,
  1916-                           _Tmp);  // insert up to old end
  1917-                       }
  1918-                   else
  1919-                       {   // new stuff can all be assigned
  1920-                       value_type _Tmp = _Val; // in case _Val is in sequence
  1921-           
  1922-                       pointer _Oldend = this->_Mylast();
  1923-                       this->_Mylast() = _Umove(_Oldend - _Count, _Oldend,
  1924-                           this->_Mylast());   // copy suffix
  1925-           
  1926-                       _Orphan_range(_VIPTR(_Where), this->_Mylast());
  1927-                       _Move_backward(_VIPTR(_Where), _Oldend - _Count,
  1928-                           _Oldend);   // copy hole
  1929- +======>              _STD fill(_VIPTR(_Where),
  1930-                           _VIPTR(_Where) + _Count, _Tmp); // insert into hole
  1931-                       }
  1932-                   return (begin() + _Off);
  1933-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Hash
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   186: inl(1212): Source for routine not found.: std::list<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::list
   187: inl(1212): Source for routine not found.: std::forward<const std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>> &>
   190: inl(1212): Source for routine not found.: std::vector<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>::_Reallocate
   190: vec( 103): Unvectorized loop.
   190: vec( 108): Unvectorizable loop structure.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Hash
FORMAT LIST

 LINE   LOOP      STATEMENT

   183-               _Hash(const key_compare& _Parg,
   184-                   const allocator_type& _Al)
   185-                   : _Traitsobj(_Parg),
   186-                       _List(_Al),
   187-                       _Vec(_Al)
   188-                   {   // construct empty hash table
   189-                   _Max_bucket_size() = _Bucket_size;
   190-                   _Init();
   191-                   }
   192-               _Hash(const _Myt& _Right, const allocator_type& _Al)
   193- +======>          : _Traitsobj(),
   194-                       _List(_Al),


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::~_Hash
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   294: inl(1212): Source for routine not found.: operator delete 
   294: vec( 103): Unvectorized loop.
   294: vec( 108): Unvectorizable loop structure.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::~_Hash
FORMAT LIST

 LINE   LOOP      STATEMENT

   291-               ~_Hash() _NOEXCEPT
   292-                   {   // destroy hash table
   293- |         //      _List.clear();  // speed orphaning of checked iterators
   294- +======>          }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::lower_bound
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   635: inl(1212): Source for routine not found.: std::_Hash_seq
   636: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_End
   636: vec( 103): Unvectorized loop.
   636: vec( 110): Vectorization obstructive function reference.: _End
   636: vec( 110): Vectorization obstructive function reference.: operator()
   638: inl(1212): Source for routine not found.: std::equal_to<TaskVariant *>::operator () const


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::lower_bound
FORMAT LIST

 LINE   LOOP      STATEMENT

   633-               iterator lower_bound(const key_type& _Keyval)
   634-                   {   // find leftmost not less than _Keyval in mutable hash table
   635-                   size_type _Bucket = _Hashval(_Keyval);
   636- +------>          for (_Unchecked_iterator _Where = _Begin(_Bucket);
   637- |                     _Where != _End(_Bucket); ++_Where)
   638- |                     if (!_Traitsobj(_Traits::_Kfn(*_Where), _Keyval))
   639- |                         return (_Traitsobj(_Keyval,
   640- +------                       _Traits::_Kfn(*_Where)) ? end() : _Make_iter(_Where));
   641-                   return (end());
   642-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Insertx
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   816: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Check_size
   818: inl(1212): Source for routine not found.: std::_Hash_seq
   822: inl(1212): Source for routine not found.: std::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, bool>::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, bool, void>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Insertx
FORMAT LIST

 LINE   LOOP      STATEMENT

   800-               _Pairib _Insertx(_Unchecked_iterator _Where, size_type _Bucket,
   801-                   _Unchecked_iterator _Plist)
   802-                   {   // insert from beginning of list
   803-            #else /* _GCC44 */
   804-                   _Unchecked_iterator _Plist =
   805-                       _Buynode_if_nil(_STD forward<_Valty>(_Val), _Pnode);
   806-            #endif /* _GCC44 */
   807-           
   808-                   _Unchecked_iterator _Next = _Plist;
   809-           
   810-                   if (_Where != ++_Next)  // move element into place
   811-                       _List._Unchecked_splice(_Where, _Plist, _Next);
   812-           
   813-                   _Insert_bucket(_Plist, _Where, _Bucket);
   814-           
   815-                   _TRY_BEGIN
   816-                   _Check_size();
   817-                   _CATCH_ALL
   818-                   erase(_Make_iter(_Plist));
   819-                   _RERAISE;
   820-                   _CATCH_END
   821-           
   822-                   return (_Pairib(_Make_iter(_Plist), true));
   823-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_End
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_End
FORMAT LIST

 LINE   LOOP      STATEMENT

   855-               _Unchecked_iterator _End(size_type _Bucket)
   856-                   {   // return end iterator for bucket _Bucket
   857-                   if (_Vec_lo(_Bucket) == _Unchecked_end())
   858-                       return (_Unchecked_end());
   859-                   else
   860-                       {   // point past last element
   861-                       _Unchecked_iterator _Ans = _Vec_hi(_Bucket);
   862-                       return (++_Ans);
   863-                       }
   864-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Check_size
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   946: inl(1212): Source for routine not found.: std::_Xlength_error
   946: vec( 103): Unvectorized loop.
   946: vec( 108): Unvectorizable loop structure.
   947: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Reinsert


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Check_size
FORMAT LIST

 LINE   LOOP      STATEMENT

   935-               void _Check_size()
   936-                   {   // grow table as needed
   937-                   if (max_load_factor() < load_factor())
   938-           
   939-                       {   // rehash to bigger table
   940-                       size_type _Newsize = bucket_count();
   941-           
   942-                       if (_Newsize < 512)
   943-                           _Newsize *= 8;  // multiply by 8
   944-                       else if (_Newsize < _Vec.max_size() / 2)
   945-                           _Newsize *= 2;  // multiply safely by 2
   946- +======>              _Init(_Newsize);
   947-                       _Reinsert();
   948-                       }
   949-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Reinsert
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   955: vec( 103): Unvectorized loop.
   955: vec( 110): Vectorization obstructive function reference.: _Insert
   959: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Insert<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>> &, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Reinsert
FORMAT LIST

 LINE   LOOP      STATEMENT

   951-               void _Reinsert()
   952-                   {   // insert elements in [begin(), end())
   953-                   _Unchecked_iterator _Last = _Unchecked_end();
   954-                   if (_Unchecked_begin() != _Last)
   955- +------>              for (--_Last; ; )
   956- |                         {   // reinsert elements in [begin(), _Last]
   957- |                         _Unchecked_iterator _First = _Unchecked_begin();
   958- |                         bool _Done = _First == _Last;
   959- |                         _Insert(*_First, _First);
   960- |                         if (_Done)
   961- |                             break;
   962- +------                   }
   963-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Insert<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>> &, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   771: inl(1212): Source for routine not found.: std::_Hash_seq
   772: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_End
   773: vec( 103): Unvectorized loop.
   773: vec( 110): Vectorization obstructive function reference.: operator()
   774: inl(1212): Source for routine not found.: std::equal_to<TaskVariant *>::operator () const
   787: inl(1212): Source for routine not found.: std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>::~pair
   788: inl(1212): Source for routine not found.: std::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, bool>::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, bool, void>
   796: inl(1212): Source for routine not found.: std::forward<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>> &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xhash

FUNCTION NAME: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::_Insert<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>> &, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   765-                   _Pairib _Insert(_Valty _REFREF _Val, _Nodety _Pnode)
   766-                   {   // try to insert existing node with value _Val
   767-                   size_type _Bucket;
   768-                   _Unchecked_iterator _Where;
   769-           
   770-                   _TRY_BEGIN
   771-                   _Bucket = _Hashval(_Traits::_Kfn(_Val));
   772-                   _Where = _End(_Bucket);
   773- +------>          for (; _Where != _Begin(_Bucket); )
   774- |                     if (_Traitsobj(_Traits::_Kfn(_Val),
   775- |                         _Traits::_Kfn(*--_Where)))
   776- |                         ;   // still too high in bucket list
   777- |                     else if (_Multi
   778- |                         || (!_Traits::_Standard
   779- |                             && _Traitsobj(_Traits::_Kfn(*_Where),
   780- |                                 _Traits::_Kfn(_Val))))
   781- |                         {   // found insertion point, back up to it
   782- |                         ++_Where;
   783- |                         break;
   784- |                         }
   785- |                     else
   786- |                         {   // discard new list element and return existing
   787- |                         _Destroy_if_not_nil(_Pnode);
   788- |                         return (_Pairib(_Make_iter(_Where), false));
   789- +------                   }
   790-                   _CATCH_ALL
   791-                   _Destroy_if_not_nil(_Pnode);
   792-                   _RERAISE;
   793-                   _CATCH_END
   794-           
   795-            #if _GCC44 /* compiler test */
   796-                   return (_Insertx(_Where, _Bucket,
   797-                       _Buynode_if_nil(_STD forward<_Valty>(_Val), _Pnode)));
   798-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/unordered_map

FUNCTION NAME: std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::unordered_map
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   110: inl(1212): Source for routine not found.: std::forward<std::hash<TaskVariant *> &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/unordered_map

FUNCTION NAME: std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::unordered_map
FORMAT LIST

 LINE   LOOP      STATEMENT

   109-               unordered_map()
   110-                   : _Mybase(key_compare(), allocator_type())
   111-                   {   // construct empty map from defaults
   112-                   }
   113-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/unordered_map

FUNCTION NAME: std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::operator []
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   429: inl(1212): Source for routine not found.: std::_Hash<std::_Umap_traits<TaskVariant *, std::vector<double, std::allocator<double>>, std::_Uhash_compare<TaskVariant *, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>, (bool)0>>::lower_bound
   433: inl(1212): Source for routine not found.: std::forward_as_tuple<TaskVariant *const &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/unordered_map

FUNCTION NAME: std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>::operator []
FORMAT LIST

 LINE   LOOP      STATEMENT

   427-               mapped_type& operator[](const key_type& _Keyval)
   428-                   {   // find element matching _Keyval or insert with default mapped
   429-                   iterator _Where = _Mybase::lower_bound(_Keyval);
   430-                   if (_Where == _Mybase::end())
   431-           
   432-            #if _HAS_RVALUE_REFERENCES
   433-                       _Where = _Mybase::emplace(
   434-                           piecewise_construct,
   435-                           _STD forward_as_tuple(_Keyval),
   436-                           tuple<>()).first;
   437-           
   438-            #else /* _HAS_RVALUE_REFERENCES */
   439-                       _Where = _Mybase::insert(
   440-                           pair<key_type, mapped_type>(
   441-                               _Keyval,
   442-                               mapped_type())).first;
   443-            #endif /* _HAS_RVALUE_REFERENCES */
   444-           
   445-                   return (_Where->second);
   446-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::pair<const unsigned long &, >
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::pair<const unsigned long &, >
FORMAT LIST

 LINE   LOOP      STATEMENT

   Cannot output Format List.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::pair<std::tuple<const unsigned long &>, std::tuple<>, (unsigned long)0, >
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>::pair<std::tuple<const unsigned long &>, std::tuple<>, (unsigned long)0, >
FORMAT LIST

 LINE   LOOP      STATEMENT

   Cannot output Format List.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::_Tuple_val<const unsigned long &>::_Tuple_val<const unsigned long &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::_Tuple_val<const unsigned long &>::_Tuple_val<const unsigned long &>
FORMAT LIST

 LINE   LOOP      STATEMENT

   114-                   _CONST_FUN _Tuple_val(_Other&& _Arg)
   115-                   : _Val(_STD forward<_Other>(_Arg))
   116-                   {   // construct with argument
   117-                   }
   118-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::tuple<const unsigned long &>::tuple
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   311: inl(1212): Source for routine not found.: std::_Tuple_val<const unsigned long &>::_Tuple_val<const unsigned long &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::tuple<const unsigned long &>::tuple
FORMAT LIST

 LINE   LOOP      STATEMENT

   308-               _CONST_FUN explicit tuple(const _This& _This_arg,
   309-                   const _Rest&... _Rest_arg)
   310-                   : _Mybase(_Rest_arg...),
   311-                       _Myfirst(_This_arg)
   312-                   {   // construct from one or more copied elements
   313-                   }
   314-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::tuple<const unsigned long &>::tuple<const unsigned long &, void **>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::tuple<const unsigned long &>::tuple<const unsigned long &, void **>
FORMAT LIST

 LINE   LOOP      STATEMENT

   350-                   _CONST_FUN tuple(tuple<_Other...>&& _Right)
   351-                   : _Mybase((typename tuple<_Other...>::_Mybase&&)_Right),
   352-                       _Myfirst(_STD forward<typename tuple<_Other...>::_This_type>
   353-                           (_Right._Myfirst._Val))
   354-                   {   // construct by moving same size tuple
   355-                   }
   356-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, bool>::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, bool, void>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   221: inl(1212): Source for routine not found.: std::forward<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
   222: inl(1212): Source for routine not found.: std::forward<bool>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, bool>::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, bool, void>
FORMAT LIST

 LINE   LOOP      STATEMENT

   218-                   _CONST_FUN pair(_Other1&& _Val1, _Other2&& _Val2)
   219-                       _NOEXCEPT_OP((is_nothrow_constructible<_Ty1, _Other1&&>::value
   220-                           && is_nothrow_constructible<_Ty2, _Other2&&>::value))
   221-                   : first(_STD forward<_Other1>(_Val1)),
   222-                           second(_STD forward<_Other2>(_Val2))
   223-                   {   // construct from moved values
   224-                   }
   225-           
   226-               template<class _Other1,


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::_Tuple_val<TaskVariant *const &>::_Tuple_val<TaskVariant *const &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::_Tuple_val<TaskVariant *const &>::_Tuple_val<TaskVariant *const &>
FORMAT LIST

 LINE   LOOP      STATEMENT

   114-                   _CONST_FUN _Tuple_val(_Other&& _Arg)
   115-                   : _Val(_STD forward<_Other>(_Arg))
   116-                   {   // construct with argument
   117-                   }
   118-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::tuple<TaskVariant *const &>::tuple
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   311: inl(1212): Source for routine not found.: std::_Tuple_val<TaskVariant *const &>::_Tuple_val<TaskVariant *const &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::tuple<TaskVariant *const &>::tuple
FORMAT LIST

 LINE   LOOP      STATEMENT

   308-               _CONST_FUN explicit tuple(const _This& _This_arg,
   309-                   const _Rest&... _Rest_arg)
   310-                   : _Mybase(_Rest_arg...),
   311-                       _Myfirst(_This_arg)
   312-                   {   // construct from one or more copied elements
   313-                   }
   314-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::tuple<TaskVariant *const &>::tuple<TaskVariant *const &, void **>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::tuple<TaskVariant *const &>::tuple<TaskVariant *const &, void **>
FORMAT LIST

 LINE   LOOP      STATEMENT

   350-                   _CONST_FUN tuple(tuple<_Other...>&& _Right)
   351-                   : _Mybase((typename tuple<_Other...>::_Mybase&&)_Right),
   352-                       _Myfirst(_STD forward<typename tuple<_Other...>::_This_type>
   353-                           (_Right._Myfirst._Val))
   354-                   {   // construct by moving same size tuple
   355-                   }
   356-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, bool>::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, bool, void>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   221: inl(1212): Source for routine not found.: std::forward<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/utility

FUNCTION NAME: std::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, bool>::pair<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, bool, void>
FORMAT LIST

 LINE   LOOP      STATEMENT

   218-                   _CONST_FUN pair(_Other1&& _Val1, _Other2&& _Val2)
   219-                       _NOEXCEPT_OP((is_nothrow_constructible<_Ty1, _Other1&&>::value
   220-                           && is_nothrow_constructible<_Ty2, _Other2&&>::value))
   221-                   : first(_STD forward<_Other1>(_Val1)),
   222-                           second(_STD forward<_Other2>(_Val2))
   223-                   {   // construct from moved values
   224-                   }
   225-           
   226-               template<class _Other1,


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::numpunct
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   102: inl(1212): Source for routine not found.: std::locale::facet::facet
   104: inl(1212): Source for routine not found.: std::numpunct<char>::_Init


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::numpunct
FORMAT LIST

 LINE   LOOP      STATEMENT

   101-               numpunct(const _Locinfo& _Lobj, size_t _Refs = 0, bool _Isdef = false)
   102-                   : locale::facet(_Refs)
   103-                   {   // construct from specified locale
   104-                   _Init(_Lobj, _Isdef);
   105-                   }
   106-           


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::_Getcat
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   111: inl(1212): Source for routine not found.: std::_Locinfo::_Locinfo


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::_Getcat
FORMAT LIST

 LINE   LOOP      STATEMENT

   107-               static size_t _Getcat(const locale::facet **_Ppf = 0,
   108-                   const locale *_Ploc = 0)
   109-                   {   // return locale category mask and construct standard facet
   110-                   if (_Ppf != 0 && *_Ppf == 0)
   111-                       *_Ppf = new numpunct<_Elem>(
   112-                           _Locinfo(_Ploc->c_str()), 0, true);
   113-                   return (_X_NUMERIC);
   114-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::~numpunct
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   119: inl(1212): Source for routine not found.: operator delete[] 
   120: inl(1212): Source for routine not found.: std::locale::facet::~facet


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::~numpunct
FORMAT LIST

 LINE   LOOP      STATEMENT

   117-               _VIRTUAL ~numpunct() _NOEXCEPT
   118-                   {   // destroy the object
   119-                   _Tidy();
   120-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::_Init
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   139: inl(1212): Source for routine not found.: localeconv
   140: inl(1212): Source for routine not found.: std::_Locinfo::_Getcvt const
   147: inl(1212): Source for routine not found.: std::_Maklocstr<char>
   152: inl(1212): Source for routine not found.: operator delete[] 


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::_Init
FORMAT LIST

 LINE   LOOP      STATEMENT

   137-               void _Init(const _Locinfo& _Lobj, bool _Isdef = false)
   138-                   {   // initialize from _Lobj
   139-                   const lconv *_Ptr = _Lobj._Getlconv();
   140-                   _Locinfo::_Cvtvec _Cvt = _Lobj._Getcvt();   // conversion information
   141-           
   142-                   _Grouping = 0;
   143-                   _Falsename = 0;
   144-                   _Truename = 0;
   145-           
   146-                   _TRY_BEGIN
   147-                   _Grouping = _MAKLOCSTR(char, _Isdef ? "" : _Ptr->grouping,
   148-                       _Lobj._Getcvt());
   149-                   _Falsename = _MAKLOCSTR(_Elem, _Lobj._Getfalse(), _Cvt);
   150-                   _Truename = _MAKLOCSTR(_Elem, _Lobj._Gettrue(), _Cvt);
   151-                   _CATCH_ALL
   152-                   _Tidy();
   153-                   _RERAISE;
   154-                   _CATCH_END
   155-           
   156-                   if (_Isdef)
   157-                       {   // apply defaults for required facets
   158-           //          _Grouping = _MAKLOCSTR(char, "", _Cvt);
   159-                       _Dp = _MAKLOCCHR(_Elem, '.', _Cvt);
   160-                       _Kseparator = _MAKLOCCHR(_Elem, ',', _Cvt);
   161-                       }
   162-                   else
   163-                       _Getvals((_Elem)0, _Ptr, _Cvt);
   164-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::do_decimal_point const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::do_decimal_point const
FORMAT LIST

 LINE   LOOP      STATEMENT

   166-               _VIRTUAL _Elem do_decimal_point() const
   167-                   {   // return decimal point
   168-                   return (_Dp);
   169-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::do_thousands_sep const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::do_thousands_sep const
FORMAT LIST

 LINE   LOOP      STATEMENT

   171-               _VIRTUAL _Elem do_thousands_sep() const
   172-                   {   // return thousands separator
   173-                   return (_Kseparator);
   174-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::do_grouping const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   178: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::do_grouping const
FORMAT LIST

 LINE   LOOP      STATEMENT

   176-               _VIRTUAL string do_grouping() const
   177-                   {   // return grouping string
   178-                   return (string(_Grouping));
   179-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::do_falsename const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   183: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::do_falsename const
FORMAT LIST

 LINE   LOOP      STATEMENT

   181-               _VIRTUAL string_type do_falsename() const
   182-                   {   // return name for false
   183-                   return (string_type(_Falsename));
   184-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::do_truename const
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   188: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocnum

FUNCTION NAME: std::numpunct<char>::do_truename const
FORMAT LIST

 LINE   LOOP      STATEMENT

   186-               _VIRTUAL string_type do_truename() const
   187-                   {   // return name for true
   188-                   return (string_type(_Truename));
   189-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstddef

FUNCTION NAME: std::_Hash_seq
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   370: vec( 103): Unvectorized loop.
   370: vec( 118): Unvectorizable data type.
   372: opt(1019): Feedback of scalar value from one loop pass to another.: _Val
   373: vec( 121): Unvectorizable dependency.
   374: opt(1512): Loop unrolled.: _Next


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstddef

FUNCTION NAME: std::_Hash_seq
FORMAT LIST

 LINE   LOOP      STATEMENT

   363-           inline size_t _Hash_seq(const unsigned char *_First, size_t _Count)
   364-                   {       // FNV-1a hash function for bytes in [_First, _First + _Count)
   365-                   _STATIC_ASSERT2(sizeof(size_t) == 8, "This code is for 64-bit size_t.");
   366-                   const size_t _FNV_offset_basis = 14695981039346656037ULL;
   367-                   const size_t _FNV_prime = 1099511628211ULL;
   368-           
   369-                   size_t _Val = _FNV_offset_basis;
   370- +------>          for (size_t _Next = 0; _Next < _Count; ++_Next)
   371- |                         {       // fold in another byte
   372- |                         _Val ^= (size_t)_First[_Next];
   373- |                         _Val *= _FNV_prime;
   374- +------                   }
   375-                   return (_Val);
   376-                   }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<char>&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<char>&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<char>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    46: inl(1212): Source for routine not found.: std::_Xbad_alloc


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<char>
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _DECLSPEC_ALLOCATOR _Ty *_Allocate(size_t _Count, _Ty *,
    37-                   bool _Try_aligned_allocation = true)
    38-               {   // allocate storage for _Count elements of type _Ty
    39-               void *_Ptr = 0;
    40-           
    41-               if (_Count == 0)
    42-                   return (static_cast<_Ty *>(_Ptr));
    43-           
    44-               // check overflow of multiply
    45-               if ((size_t)(-1) / sizeof (_Ty) < _Count)
    46-                   _Xbad_alloc();  // report no memory
    47-               const size_t _User_size = _Count * sizeof (_Ty);
    48-           
    49-            #if defined(_M_IX86) || defined(_M_X64)
    50-               if (_Try_aligned_allocation
    51-                   && _BIG_ALLOCATION_THRESHOLD <= _User_size)
    52-                   {   // allocate large block
    53-                   _STATIC_ASSERT2(sizeof (void *) < _BIG_ALLOCATION_ALIGNMENT,
    54-                       "Big allocations should at least match vector register size");
    55-                   const size_t _Block_size = _NON_USER_SIZE + _User_size;
    56-                   if (_Block_size <= _User_size)
    57-                       _Xbad_alloc();  // report no memory
    58-                   const uintptr_t _Ptr_container =
    59-                       reinterpret_cast<uintptr_t>(::operator new(_Block_size));
    60-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr_container != 0);
    61-                   _Ptr = reinterpret_cast<void *>((_Ptr_container + _NON_USER_SIZE)
    62-                       & ~(_BIG_ALLOCATION_ALIGNMENT - 1));
    63-                   static_cast<uintptr_t *>(_Ptr)[-1] = _Ptr_container;
    64-           
    65-            #ifdef _DEBUG
    66-                   static_cast<uintptr_t *>(_Ptr)[-2] = _BIG_ALLOCATION_SENTINEL;
    67-            #endif /* _DEBUG */
    68-                   }
    69-               else
    70-            #endif /* defined(_M_IX86) || defined(_M_X64) */
    71-           
    72-                   {   // allocate normal block
    73-                   _Ptr = ::operator new(_User_size);
    74-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr != 0);
    75-                   }
    76-               return (static_cast<_Ty *>(_Ptr));
    77-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<char *&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<char *&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::_Wrap_alloc<std::allocator<char>> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::_Wrap_alloc<std::allocator<char>> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  2003-                   move(_Ty&& _Arg) _NOEXCEPT
  2004-               {   // forward _Arg as movable
  2005-               return (static_cast<typename remove_reference<_Ty>::type&&>(_Arg));
  2006-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::use_facet<std::ctype<char>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   560: inl(1212): Source for routine not found.: std::locale::_Getfacet const
   566: inl(1212): Source for routine not found.: std::ctype<char>::_Getcat
   569: inl(1212): Source for routine not found.: std::bad_cast::bad_cast
   585: inl(1212): Source for routine not found.: std::locale::facet::_Register


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::use_facet<std::ctype<char>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   547-               const _Facet& use_facet(const locale& _Loc)
   548-           
   549-               {   // get facet reference from locale
   550-            #if _NO_LOCALES
   551-               static _Wrap_facet<_Facet> _Wfac;
   552-               return (*(_Facet *)&_Wfac);
   553-           
   554-            #else /* _NO_LOCALES */
   555-               _BEGIN_LOCK(_LOCK_LOCALE)   // the thread lock, make get atomic
   556-                   const locale::facet *_Psave =
   557-                       _Facetptr<_Facet>::_Psave;  // static pointer to lazy facet
   558-           
   559-                   size_t _Id = _Facet::id;
   560-                   const locale::facet *_Pf = _Loc._Getfacet(_Id);
   561-           
   562-                   if (_Pf != 0)
   563-                       ;   // got facet from locale
   564-                   else if (_Psave != 0)
   565-                       _Pf = _Psave;   // lazy facet already allocated
   566-                   else if (_Facet::_Getcat(&_Psave, &_Loc) == (size_t)(-1))
   567-           
   568-            #if _HAS_EXCEPTIONS
   569-                       _THROW1(_XSTD bad_cast());  // lazy disallowed
   570-           
   571-            #else /* _HAS_EXCEPTIONS */
   572-                       {
   573-                       __builtin_traceback((unsigned long *)__builtin_frame_address(0));
   574-                       abort();    // lazy disallowed
   575-                       }
   576-            #endif /* _HAS_EXCEPTIONS */
   577-           
   578-                   else
   579-                       {   // queue up lazy facet for destruction
   580-                       _Pf = _Psave;
   581-                       _Facetptr<_Facet>::_Psave = _Psave;
   582-           
   583-                       locale::facet *_Pfmod = (_Facet *)_Psave;
   584-                       _Pfmod->_Incref();
   585-                       _Pfmod->_Register();
   586-                       }
   587-           
   588-                   return ((const _Facet&)(*_Pf)); // should be dynamic_cast
   589-               _END_LOCK()
   590-            #endif /* _NO_LOCALES */
   591-               }   // end of use_facet body


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::iostream_category
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   750: inl(1212): Source for routine not found.: std::_Immortalize<std::_Iostream_error_category>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::iostream_category
FORMAT LIST

 LINE   LOOP      STATEMENT

   748-           inline const error_category& iostream_category() _NOEXCEPT
   749-               {   // get iostream_category
   750-               return (_Immortalize<_Iostream_error_category>());
   751-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Immortalize<std::_Iostream_error_category>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   739: inl(1212): Source for routine not found.: std::_Iostream_error_category::_Iostream_error_category


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/system_error

FUNCTION NAME: std::_Immortalize<std::_Iostream_error_category>
FORMAT LIST

 LINE   LOOP      STATEMENT

   737-               _Ty& _Immortalize()
   738-               {   // return a reference to an object that will live forever
   739-               static _Immortalizer<_Ty> _Static;
   740-               return (*reinterpret_cast<_Ty *>(&_Static._Storage));
   741-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::operator &
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::operator &
FORMAT LIST

 LINE   LOOP      STATEMENT

   669-           _BITMASK_OPS(ios_base::_Fmtflags)


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::operator &
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xiosbase

FUNCTION NAME: std::operator &
FORMAT LIST

 LINE   LOOP      STATEMENT

   671-           _BITMASK_OPS(ios_base::_Openmode)


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::_Maklocstr<char>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   691: inl(1212): Source for routine not found.: std::_Xbad_alloc
   693: vec( 103): Unvectorized loop.
   693: vec( 118): Unvectorizable data type.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::_Maklocstr<char>
FORMAT LIST

 LINE   LOOP      STATEMENT

   685-               _Elem *_Maklocstr(const char *_Ptr, _Elem *,
   686-                   const _Locinfo::_Cvtvec&)
   687-               {   // convert C string to _Elem sequence using _Cvtvec
   688-               size_t _Count = _CSTD strlen(_Ptr) + 1;
   689-               _Elem *_Ptrdest = (_Elem *)_CSTD malloc(_Count);
   690-               if (!_Ptrdest)
   691-                   _Xbad_alloc();
   692-           
   693- +------>      for (_Elem *_Ptrnext = _Ptrdest; 0 < _Count; --_Count, ++_Ptrnext, ++_Ptr)
   694- +------           *_Ptrnext = (_Elem)(unsigned char)*_Ptr;
   695-               return (_Ptrdest);
   696-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ios

FUNCTION NAME: std::left
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ios

FUNCTION NAME: std::left
FORMAT LIST

 LINE   LOOP      STATEMENT

   248-           inline ios_base& left(ios_base& _Iosbase)
   249-               {   // set adjustfield to left
   250-               _Iosbase.setf(ios_base::left, ios_base::adjustfield);
   251-               return (_Iosbase);
   252-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ios

FUNCTION NAME: std::right
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ios

FUNCTION NAME: std::right
FORMAT LIST

 LINE   LOOP      STATEMENT

   302-           inline ios_base& right(ios_base& _Iosbase)
   303-               {   // set right in adjustfield
   304-               _Iosbase.setf(ios_base::right, ios_base::adjustfield);
   305-               return (_Iosbase);
   306-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::operator +<char, std::char_traits<char>, std::allocator<char>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2337: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
  2338: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::reserve
  2339: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::append
  2340: inl(1212): Source for routine not found.: std::_Xout_of_range


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::operator +<char, std::char_traits<char>, std::allocator<char>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  2333-               basic_string<_Elem, _Traits, _Alloc> operator+(
  2334-                   const _Elem *_Left,
  2335-                   const basic_string<_Elem, _Traits, _Alloc>& _Right)
  2336-               {   // return NTCS + string
  2337-               basic_string<_Elem, _Traits, _Alloc> _Ans;
  2338-               _Ans.reserve(_Traits::length(_Left) + _Right.size());
  2339-               _Ans += _Left;
  2340-               _Ans += _Right;
  2341-               return (_Ans);
  2342-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::basic_string<char, std::char_traits<char>, std::allocator<char>>&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::basic_string<char, std::char_traits<char>, std::allocator<char>>&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  2003-                   move(_Ty&& _Arg) _NOEXCEPT
  2004-               {   // forward _Arg as movable
  2005-               return (static_cast<typename remove_reference<_Ty>::type&&>(_Arg));
  2006-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    46: inl(1212): Source for routine not found.: std::_Xbad_alloc


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _DECLSPEC_ALLOCATOR _Ty *_Allocate(size_t _Count, _Ty *,
    37-                   bool _Try_aligned_allocation = true)
    38-               {   // allocate storage for _Count elements of type _Ty
    39-               void *_Ptr = 0;
    40-           
    41-               if (_Count == 0)
    42-                   return (static_cast<_Ty *>(_Ptr));
    43-           
    44-               // check overflow of multiply
    45-               if ((size_t)(-1) / sizeof (_Ty) < _Count)
    46-                   _Xbad_alloc();  // report no memory
    47-               const size_t _User_size = _Count * sizeof (_Ty);
    48-           
    49-            #if defined(_M_IX86) || defined(_M_X64)
    50-               if (_Try_aligned_allocation
    51-                   && _BIG_ALLOCATION_THRESHOLD <= _User_size)
    52-                   {   // allocate large block
    53-                   _STATIC_ASSERT2(sizeof (void *) < _BIG_ALLOCATION_ALIGNMENT,
    54-                       "Big allocations should at least match vector register size");
    55-                   const size_t _Block_size = _NON_USER_SIZE + _User_size;
    56-                   if (_Block_size <= _User_size)
    57-                       _Xbad_alloc();  // report no memory
    58-                   const uintptr_t _Ptr_container =
    59-                       reinterpret_cast<uintptr_t>(::operator new(_Block_size));
    60-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr_container != 0);
    61-                   _Ptr = reinterpret_cast<void *>((_Ptr_container + _NON_USER_SIZE)
    62-                       & ~(_BIG_ALLOCATION_ALIGNMENT - 1));
    63-                   static_cast<uintptr_t *>(_Ptr)[-1] = _Ptr_container;
    64-           
    65-            #ifdef _DEBUG
    66-                   static_cast<uintptr_t *>(_Ptr)[-2] = _BIG_ALLOCATION_SENTINEL;
    67-            #endif /* _DEBUG */
    68-                   }
    69-               else
    70-            #endif /* defined(_M_IX86) || defined(_M_X64) */
    71-           
    72-                   {   // allocate normal block
    73-                   _Ptr = ::operator new(_User_size);
    74-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr != 0);
    75-                   }
    76-               return (static_cast<_Ty *>(_Ptr));
    77-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory

FUNCTION NAME: std::_Uninit_copy<const std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> *, std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> *, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   374: vec( 103): Unvectorized loop.
   374: vec( 163): Exception handling obstructs vectorization.
   374: vec( 110): Vectorization obstructive function reference.: pair
   374: vec( 110): Vectorization obstructive function reference.: operator delete
   374: vec( 110): Vectorization obstructive function reference.: forward
   375: inl(1212): Source for routine not found.: std::forward<const std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> &>
   375: opt(1097): This statement prevents loop optimization.
   377: vec( 103): Unvectorized loop.
   377: vec( 110): Vectorization obstructive function reference.: ~pair
   378: inl(1212): Source for routine not found.: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::~pair
   378: opt(1025): Reference to this function inhibits optimization.: std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>::~pair


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory

FUNCTION NAME: std::_Uninit_copy<const std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> *, std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> *, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   367-               _FwdIt _Uninit_copy(_InIt _First, _InIt _Last, _FwdIt _Dest,
   368-                   _WRAP_ALLOC(_Alloc)& _Al, _Nonscalar_ptr_iterator_tag)
   369-               {   // copy [_First, _Last) to raw _Dest, using _Al, arbitrary type
   370-               _DEBUG_RANGE_PTR(_First, _Last, _Dest);
   371-               _FwdIt _Next = _Dest;
   372-           
   373-               _TRY_BEGIN
   374- +------>      for (; _First != _Last; ++_Dest, (void)++_First)
   375- +------           _Al.construct(_Dest, *_First);
   376-               _CATCH_ALL
   377- +------>      for (; _Next != _Dest; ++_Next)
   378- +------           _Al.destroy(_Next);
   379-               _RERAISE;
   380-               _CATCH_END
   381-               return (_Dest);
   382-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const char (&)[2]>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const char (&)[2]>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<int>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<int>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const char (&)[3]>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const char (&)[3]>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<unsigned long>&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<unsigned long>&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::basic_istream<char, std::char_traits<char>>&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::basic_istream<char, std::char_traits<char>>&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  2003-                   move(_Ty&& _Arg) _NOEXCEPT
  2004-               {   // forward _Arg as movable
  2005-               return (static_cast<typename remove_reference<_Ty>::type&&>(_Arg));
  2006-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/string

FUNCTION NAME: std::getline<char, std::char_traits<char>, std::allocator<char>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    73: inl(1212): Source for routine not found.: std::basic_istream<char, std::char_traits<char>>::sentry::sentry
    78: inl(1212): Source for routine not found.: std::_Xout_of_range
    79: inl(1212): Source for routine not found.: std::char_traits<char>::to_int_type
    83: inl(1212): Source for routine not found.: std::char_traits<char>::eq_int_type
    83: vec( 103): Unvectorized loop.
    83: vec( 108): Unvectorizable loop structure.
    83: vec( 110): Vectorization obstructive function reference.:  
    83: vec( 110): Vectorization obstructive function reference.: to_int_type
    83: vec( 110): Vectorization obstructive function reference.: _Copy
    83: vec( 110): Vectorization obstructive function reference.: _Xlength_error
    83: vec( 110): Vectorization obstructive function reference.: to_char_type
    83: vec( 110): Vectorization obstructive function reference.: eq_int_type
   102: inl(1212): Source for routine not found.: std::char_traits<char>::to_char_type
   105: inl(1212): Source for routine not found.: std::ios_base::clear
   111: inl(1212): Source for routine not found.: std::basic_istream<char, std::char_traits<char>>::sentry::~sentry


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/string

FUNCTION NAME: std::getline<char, std::char_traits<char>, std::allocator<char>>
FORMAT LIST

 LINE   LOOP      STATEMENT

    64-               basic_istream<_Elem, _Traits>& getline(
    65-                   basic_istream<_Elem, _Traits> _LVALREF _Istr,
    66-                   basic_string<_Elem, _Traits, _Alloc>& _Str,
    67-                   const _Elem _Delim)
    68-               {   // get characters into string, discard delimiter
    69-               typedef basic_istream<_Elem, _Traits> _Myis;
    70-           
    71-               ios_base::iostate _State = ios_base::goodbit;
    72-               bool _Changed = false;
    73-               const typename _Myis::sentry _Ok(_Istr, true);
    74-           
    75-               if (_Ok)
    76-                   {   // state okay, extract characters
    77-                   _TRY_IO_BEGIN
    78-                   _Str.erase();
    79-                   const typename _Traits::int_type _Metadelim =
    80-                       _Traits::to_int_type(_Delim);
    81-                   typename _Traits::int_type _Meta = _Istr.rdbuf()->sgetc();
    82-           
    83- +------>          for (; ; _Meta = _Istr.rdbuf()->snextc())
    84- |                     if (_Traits::eq_int_type(_Traits::eof(), _Meta))
    85- |                         {   // end of file, quit
    86- |                         _State |= ios_base::eofbit;
    87- |                         break;
    88- |                         }
    89- |                     else if (_Traits::eq_int_type(_Meta, _Metadelim))
    90- |                         {   // got a delimiter, discard it and quit
    91- |                         _Changed = true;
    92- |                         _Istr.rdbuf()->sbumpc();
    93- |                         break;
    94- |                         }
    95- |                     else if (_Str.max_size() <= _Str.size())
    96- |                         {   // string too large, quit
    97- |                         _State |= ios_base::failbit;
    98- |                         break;
    99- |                         }
   100- |                     else
   101- |                         {   // got a character, add it to string
   102- |                         _Str += _Traits::to_char_type(_Meta);
   103- |                         _Changed = true;
   104- +------                   }
   105-                   _CATCH_IO_(_Istr)
   106-                   }
   107-           
   108-               if (!_Changed)
   109-                   _State |= ios_base::failbit;
   110-               _Istr.setstate(_State);
   111-               return (_Istr);
   112-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<unsigned long>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    46: inl(1212): Source for routine not found.: std::_Xbad_alloc


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<unsigned long>
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _DECLSPEC_ALLOCATOR _Ty *_Allocate(size_t _Count, _Ty *,
    37-                   bool _Try_aligned_allocation = true)
    38-               {   // allocate storage for _Count elements of type _Ty
    39-               void *_Ptr = 0;
    40-           
    41-               if (_Count == 0)
    42-                   return (static_cast<_Ty *>(_Ptr));
    43-           
    44-               // check overflow of multiply
    45-               if ((size_t)(-1) / sizeof (_Ty) < _Count)
    46-                   _Xbad_alloc();  // report no memory
    47-               const size_t _User_size = _Count * sizeof (_Ty);
    48-           
    49-            #if defined(_M_IX86) || defined(_M_X64)
    50-               if (_Try_aligned_allocation
    51-                   && _BIG_ALLOCATION_THRESHOLD <= _User_size)
    52-                   {   // allocate large block
    53-                   _STATIC_ASSERT2(sizeof (void *) < _BIG_ALLOCATION_ALIGNMENT,
    54-                       "Big allocations should at least match vector register size");
    55-                   const size_t _Block_size = _NON_USER_SIZE + _User_size;
    56-                   if (_Block_size <= _User_size)
    57-                       _Xbad_alloc();  // report no memory
    58-                   const uintptr_t _Ptr_container =
    59-                       reinterpret_cast<uintptr_t>(::operator new(_Block_size));
    60-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr_container != 0);
    61-                   _Ptr = reinterpret_cast<void *>((_Ptr_container + _NON_USER_SIZE)
    62-                       & ~(_BIG_ALLOCATION_ALIGNMENT - 1));
    63-                   static_cast<uintptr_t *>(_Ptr)[-1] = _Ptr_container;
    64-           
    65-            #ifdef _DEBUG
    66-                   static_cast<uintptr_t *>(_Ptr)[-2] = _BIG_ALLOCATION_SENTINEL;
    67-            #endif /* _DEBUG */
    68-                   }
    69-               else
    70-            #endif /* defined(_M_IX86) || defined(_M_X64) */
    71-           
    72-                   {   // allocate normal block
    73-                   _Ptr = ::operator new(_User_size);
    74-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr != 0);
    75-                   }
    76-               return (static_cast<_Ty *>(_Ptr));
    77-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<unsigned long>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<unsigned long>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::_Wrap_alloc<std::allocator<unsigned long>> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::_Wrap_alloc<std::allocator<unsigned long>> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  2003-                   move(_Ty&& _Arg) _NOEXCEPT
  2004-               {   // forward _Arg as movable
  2005-               return (static_cast<typename remove_reference<_Ty>::type&&>(_Arg));
  2006-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::vector<unsigned long, std::allocator<unsigned long>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::vector<unsigned long, std::allocator<unsigned long>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::use_facet<std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   560: inl(1212): Source for routine not found.: std::locale::_Getfacet const
   566: inl(1212): Source for routine not found.: std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>::_Getcat
   569: inl(1212): Source for routine not found.: std::bad_cast::bad_cast
   585: inl(1212): Source for routine not found.: std::locale::facet::_Register


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::use_facet<std::num_put<char, std::ostreambuf_iterator<char, std::char_traits<char>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   547-               const _Facet& use_facet(const locale& _Loc)
   548-           
   549-               {   // get facet reference from locale
   550-            #if _NO_LOCALES
   551-               static _Wrap_facet<_Facet> _Wfac;
   552-               return (*(_Facet *)&_Wfac);
   553-           
   554-            #else /* _NO_LOCALES */
   555-               _BEGIN_LOCK(_LOCK_LOCALE)   // the thread lock, make get atomic
   556-                   const locale::facet *_Psave =
   557-                       _Facetptr<_Facet>::_Psave;  // static pointer to lazy facet
   558-           
   559-                   size_t _Id = _Facet::id;
   560-                   const locale::facet *_Pf = _Loc._Getfacet(_Id);
   561-           
   562-                   if (_Pf != 0)
   563-                       ;   // got facet from locale
   564-                   else if (_Psave != 0)
   565-                       _Pf = _Psave;   // lazy facet already allocated
   566-                   else if (_Facet::_Getcat(&_Psave, &_Loc) == (size_t)(-1))
   567-           
   568-            #if _HAS_EXCEPTIONS
   569-                       _THROW1(_XSTD bad_cast());  // lazy disallowed
   570-           
   571-            #else /* _HAS_EXCEPTIONS */
   572-                       {
   573-                       __builtin_traceback((unsigned long *)__builtin_frame_address(0));
   574-                       abort();    // lazy disallowed
   575-                       }
   576-            #endif /* _HAS_EXCEPTIONS */
   577-           
   578-                   else
   579-                       {   // queue up lazy facet for destruction
   580-                       _Pf = _Psave;
   581-                       _Facetptr<_Facet>::_Psave = _Psave;
   582-           
   583-                       locale::facet *_Pfmod = (_Facet *)_Psave;
   584-                       _Pfmod->_Incref();
   585-                       _Pfmod->_Register();
   586-                       }
   587-           
   588-                   return ((const _Facet&)(*_Pf)); // should be dynamic_cast
   589-               _END_LOCK()
   590-            #endif /* _NO_LOCALES */
   591-               }   // end of use_facet body


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/string

FUNCTION NAME: std::operator <<<char, std::char_traits<char>, std::allocator<char>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   172: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
   179: inl(1212): Source for routine not found.: std::operator &
   180: vec( 103): Unvectorized loop.
   180: vec( 110): Vectorization obstructive function reference.:  
   180: vec( 110): Vectorization obstructive function reference.: to_int_type
   180: vec( 110): Vectorization obstructive function reference.: eq_int_type
   181: inl(1212): Source for routine not found.: std::char_traits<char>::to_int_type
   193: vec( 103): Unvectorized loop.
   193: vec( 110): Vectorization obstructive function reference.:  
   193: vec( 110): Vectorization obstructive function reference.: to_int_type
   193: vec( 110): Vectorization obstructive function reference.: eq_int_type
   201: inl(1212): Source for routine not found.: std::ios_base::clear
   205: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:08 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/string

FUNCTION NAME: std::operator <<<char, std::char_traits<char>, std::allocator<char>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   160-               basic_ostream<_Elem, _Traits>& operator<<(
   161-                   basic_ostream<_Elem, _Traits>& _Ostr,
   162-                   const basic_string<_Elem, _Traits, _Alloc>& _Str)
   163-               {   // insert a string
   164-               typedef basic_ostream<_Elem, _Traits> _Myos;
   165-               typedef basic_string<_Elem, _Traits, _Alloc> _Mystr;
   166-               typedef typename _Mystr::size_type _Mysizt;
   167-           
   168-               ios_base::iostate _State = ios_base::goodbit;
   169-               _Mysizt _Size = _Str.size();
   170-               _Mysizt _Pad = _Ostr.width() <= 0 || (_Mysizt)_Ostr.width() <= _Size
   171-                   ? 0 : (_Mysizt)_Ostr.width() - _Size;
   172-               const typename _Myos::sentry _Ok(_Ostr);
   173-           
   174-               if (!_Ok)
   175-                   _State |= ios_base::badbit;
   176-               else
   177-                   {   // state okay, insert characters
   178-               _TRY_IO_BEGIN
   179-                   if ((_Ostr.flags() & ios_base::adjustfield) != ios_base::left)
   180- +------>              for (; 0 < _Pad; --_Pad)    // pad on left
   181- |                         if (_Traits::eq_int_type(_Traits::eof(),
   182- |                             _Ostr.rdbuf()->sputc(_Ostr.fill())))
   183- |                             {   // insertion failed, quit
   184- |                             _State |= ios_base::badbit;
   185- |                             break;
   186- +------                       }
   187-           
   188-                   if (_State == ios_base::goodbit
   189-                       && _Ostr.rdbuf()->sputn(_Str.c_str(), (streamsize)_Size)
   190-                           != (streamsize)_Size)
   191-                           _State |= ios_base::badbit;
   192-                   else
   193- +------>              for (; 0 < _Pad; --_Pad)    // pad on right
   194- |                         if (_Traits::eq_int_type(_Traits::eof(),
   195- |                             _Ostr.rdbuf()->sputc(_Ostr.fill())))
   196- |                             {   // insertion failed, quit
   197- |                             _State |= ios_base::badbit;
   198- |                             break;
   199- +------                       }
   200-                   _Ostr.width(0);
   201-                   _CATCH_IO_(_Ostr)
   202-                   }
   203-           
   204-               _Ostr.setstate(_State);
   205-               return (_Ostr);
   206-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::endl<char, std::char_traits<char>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   992: inl(1212): Source for routine not found.: std::basic_ios<char, std::char_traits<char>>::widen const
   993: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::flush


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::endl<char, std::char_traits<char>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   990-                   endl(basic_ostream<_Elem, _Traits>& _Ostr)
   991-               {   // insert newline and flush stream
   992-               _Ostr.put(_Ostr.widen('\n'));
   993-               _Ostr.flush();
   994-               return (_Ostr);
   995-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::operator <<<std::char_traits<char>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   705: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
   712: inl(1212): Source for routine not found.: std::operator &
   713: vec( 103): Unvectorized loop.
   713: vec( 110): Vectorization obstructive function reference.:  
   713: vec( 110): Vectorization obstructive function reference.: to_int_type
   713: vec( 110): Vectorization obstructive function reference.: eq_int_type
   714: inl(1212): Source for routine not found.: std::char_traits<char>::to_int_type
   726: vec( 103): Unvectorized loop.
   726: vec( 110): Vectorization obstructive function reference.:  
   726: vec( 110): Vectorization obstructive function reference.: to_int_type
   726: vec( 110): Vectorization obstructive function reference.: eq_int_type
   734: inl(1212): Source for routine not found.: std::ios_base::clear
   738: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::operator <<<std::char_traits<char>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   695-               basic_ostream<char, _Traits>& operator<<(
   696-                   basic_ostream<char, _Traits>& _Ostr,
   697-                   const char *_Val)
   698-               {   // insert NTBS into char stream
   699-               typedef char _Elem;
   700-               typedef basic_ostream<_Elem, _Traits> _Myos;
   701-               ios_base::iostate _State = ios_base::goodbit;
   702-               streamsize _Count = (streamsize)_Traits::length(_Val);  // may overflow
   703-               streamsize _Pad = _Ostr.width() <= 0 || _Ostr.width() <= _Count
   704-                   ? 0 : _Ostr.width() - _Count;
   705-               const typename _Myos::sentry _Ok(_Ostr);
   706-           
   707-               if (!_Ok)
   708-                   _State |= ios_base::badbit;
   709-               else
   710-                   {   // state okay, insert
   711-                   _TRY_IO_BEGIN
   712-                   if ((_Ostr.flags() & ios_base::adjustfield) != ios_base::left)
   713- +------>              for (; 0 < _Pad; --_Pad)    // pad on left
   714- |                         if (_Traits::eq_int_type(_Traits::eof(),
   715- |                             _Ostr.rdbuf()->sputc(_Ostr.fill())))
   716- |                             {   // insertion failed, quit
   717- |                             _State |= ios_base::badbit;
   718- |                             break;
   719- +------                       }
   720-           
   721-                   if (_State == ios_base::goodbit
   722-                       && _Ostr.rdbuf()->sputn(_Val, _Count) != _Count)
   723-                       _State |= ios_base::badbit;
   724-           
   725-                   if (_State == ios_base::goodbit)
   726- +------>              for (; 0 < _Pad; --_Pad)    // pad on right
   727- |                         if (_Traits::eq_int_type(_Traits::eof(),
   728- |                             _Ostr.rdbuf()->sputc(_Ostr.fill())))
   729- |                             {   // insertion failed, quit
   730- |                             _State |= ios_base::badbit;
   731- |                             break;
   732- +------                       }
   733-                   _Ostr.width(0);
   734-                   _CATCH_IO_(_Ostr)
   735-                   }
   736-           
   737-               _Ostr.setstate(_State);
   738-               return (_Ostr);
   739-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::operator <<<std::char_traits<char>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   748: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::sentry
   755: inl(1212): Source for routine not found.: std::operator &
   756: vec( 103): Unvectorized loop.
   756: vec( 110): Vectorization obstructive function reference.:  
   756: vec( 110): Vectorization obstructive function reference.: to_int_type
   756: vec( 110): Vectorization obstructive function reference.: eq_int_type
   758: inl(1212): Source for routine not found.: std::char_traits<char>::to_int_type
   767: vec( 103): Unvectorized loop.
   767: vec( 110): Vectorization obstructive function reference.: to_int_type
   767: vec( 110): Vectorization obstructive function reference.: eq_int_type
   767: vec( 110): Vectorization obstructive function reference.:  
   772: inl(1212): Source for routine not found.: std::ios_base::clear
   777: inl(1212): Source for routine not found.: std::basic_ostream<char, std::char_traits<char>>::sentry::~sentry


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/ostream

FUNCTION NAME: std::operator <<<std::char_traits<char>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   742-               basic_ostream<char, _Traits>& operator<<(
   743-                   basic_ostream<char, _Traits>& _Ostr, char _Ch)
   744-               {   // insert a char into char stream
   745-               typedef char _Elem;
   746-               typedef basic_ostream<_Elem, _Traits> _Myos;
   747-               ios_base::iostate _State = ios_base::goodbit;
   748-               const typename _Myos::sentry _Ok(_Ostr);
   749-           
   750-               if (_Ok)
   751-                   {   // state okay, insert
   752-                   streamsize _Pad = _Ostr.width() <= 1 ? 0 : _Ostr.width() - 1;
   753-           
   754-                   _TRY_IO_BEGIN
   755-                   if ((_Ostr.flags() & ios_base::adjustfield) != ios_base::left)
   756- +------>              for (; _State == ios_base::goodbit && 0 < _Pad;
   757- |                         --_Pad) // pad on left
   758- |                         if (_Traits::eq_int_type(_Traits::eof(),
   759- |                             _Ostr.rdbuf()->sputc(_Ostr.fill())))
   760- +------                       _State |= ios_base::badbit;
   761-           
   762-                   if (_State == ios_base::goodbit
   763-                       && _Traits::eq_int_type(_Traits::eof(),
   764-                           _Ostr.rdbuf()->sputc(_Ch)))
   765-                       _State |= ios_base::badbit;
   766-           
   767- +------>          for (; _State == ios_base::goodbit && 0 < _Pad;
   768- |                     --_Pad) // pad on right
   769- |                     if (_Traits::eq_int_type(_Traits::eof(),
   770- |                         _Ostr.rdbuf()->sputc(_Ostr.fill())))
   771- +------                   _State |= ios_base::badbit;
   772-                   _CATCH_IO_(_Ostr)
   773-                   }
   774-           
   775-               _Ostr.width(0);
   776-               _Ostr.setstate(_State);
   777-               return (_Ostr);
   778-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::operator +<char, std::char_traits<char>, std::allocator<char>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  2379: inl(1212): Source for routine not found.: std::forward<const std::allocator<char>&>
  2380: inl(1212): Source for routine not found.: std::basic_string<char, std::char_traits<char>, std::allocator<char>>::reserve
  2381: inl(1212): Source for routine not found.: std::_Xout_of_range


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xstring

FUNCTION NAME: std::operator +<char, std::char_traits<char>, std::allocator<char>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  2375-               basic_string<_Elem, _Traits, _Alloc> operator+(
  2376-                   const basic_string<_Elem, _Traits, _Alloc>& _Left,
  2377-                   const _Elem _Right)
  2378-               {   // return string + character
  2379-               basic_string<_Elem, _Traits, _Alloc> _Ans;
  2380-               _Ans.reserve(_Left.size() + 1);
  2381-               _Ans += _Left;
  2382-               _Ans += _Right;
  2383-               return (_Ans);
  2384-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<TaskVariant *>&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<TaskVariant *>&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<TaskVariant *>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    46: inl(1212): Source for routine not found.: std::_Xbad_alloc


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<TaskVariant *>
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _DECLSPEC_ALLOCATOR _Ty *_Allocate(size_t _Count, _Ty *,
    37-                   bool _Try_aligned_allocation = true)
    38-               {   // allocate storage for _Count elements of type _Ty
    39-               void *_Ptr = 0;
    40-           
    41-               if (_Count == 0)
    42-                   return (static_cast<_Ty *>(_Ptr));
    43-           
    44-               // check overflow of multiply
    45-               if ((size_t)(-1) / sizeof (_Ty) < _Count)
    46-                   _Xbad_alloc();  // report no memory
    47-               const size_t _User_size = _Count * sizeof (_Ty);
    48-           
    49-            #if defined(_M_IX86) || defined(_M_X64)
    50-               if (_Try_aligned_allocation
    51-                   && _BIG_ALLOCATION_THRESHOLD <= _User_size)
    52-                   {   // allocate large block
    53-                   _STATIC_ASSERT2(sizeof (void *) < _BIG_ALLOCATION_ALIGNMENT,
    54-                       "Big allocations should at least match vector register size");
    55-                   const size_t _Block_size = _NON_USER_SIZE + _User_size;
    56-                   if (_Block_size <= _User_size)
    57-                       _Xbad_alloc();  // report no memory
    58-                   const uintptr_t _Ptr_container =
    59-                       reinterpret_cast<uintptr_t>(::operator new(_Block_size));
    60-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr_container != 0);
    61-                   _Ptr = reinterpret_cast<void *>((_Ptr_container + _NON_USER_SIZE)
    62-                       & ~(_BIG_ALLOCATION_ALIGNMENT - 1));
    63-                   static_cast<uintptr_t *>(_Ptr)[-1] = _Ptr_container;
    64-           
    65-            #ifdef _DEBUG
    66-                   static_cast<uintptr_t *>(_Ptr)[-2] = _BIG_ALLOCATION_SENTINEL;
    67-            #endif /* _DEBUG */
    68-                   }
    69-               else
    70-            #endif /* defined(_M_IX86) || defined(_M_X64) */
    71-           
    72-                   {   // allocate normal block
    73-                   _Ptr = ::operator new(_User_size);
    74-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr != 0);
    75-                   }
    76-               return (static_cast<_Ty *>(_Ptr));
    77-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::hash<unsigned long> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::hash<unsigned long> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_One_then_variadic_args_t>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_One_then_variadic_args_t>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::equal_to<unsigned long> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::equal_to<unsigned long> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<float>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<float>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<std::_List_node<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, void *>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    46: inl(1212): Source for routine not found.: std::_Xbad_alloc


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<std::_List_node<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, void *>>
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _DECLSPEC_ALLOCATOR _Ty *_Allocate(size_t _Count, _Ty *,
    37-                   bool _Try_aligned_allocation = true)
    38-               {   // allocate storage for _Count elements of type _Ty
    39-               void *_Ptr = 0;
    40-           
    41-               if (_Count == 0)
    42-                   return (static_cast<_Ty *>(_Ptr));
    43-           
    44-               // check overflow of multiply
    45-               if ((size_t)(-1) / sizeof (_Ty) < _Count)
    46-                   _Xbad_alloc();  // report no memory
    47-               const size_t _User_size = _Count * sizeof (_Ty);
    48-           
    49-            #if defined(_M_IX86) || defined(_M_X64)
    50-               if (_Try_aligned_allocation
    51-                   && _BIG_ALLOCATION_THRESHOLD <= _User_size)
    52-                   {   // allocate large block
    53-                   _STATIC_ASSERT2(sizeof (void *) < _BIG_ALLOCATION_ALIGNMENT,
    54-                       "Big allocations should at least match vector register size");
    55-                   const size_t _Block_size = _NON_USER_SIZE + _User_size;
    56-                   if (_Block_size <= _User_size)
    57-                       _Xbad_alloc();  // report no memory
    58-                   const uintptr_t _Ptr_container =
    59-                       reinterpret_cast<uintptr_t>(::operator new(_Block_size));
    60-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr_container != 0);
    61-                   _Ptr = reinterpret_cast<void *>((_Ptr_container + _NON_USER_SIZE)
    62-                       & ~(_BIG_ALLOCATION_ALIGNMENT - 1));
    63-                   static_cast<uintptr_t *>(_Ptr)[-1] = _Ptr_container;
    64-           
    65-            #ifdef _DEBUG
    66-                   static_cast<uintptr_t *>(_Ptr)[-2] = _BIG_ALLOCATION_SENTINEL;
    67-            #endif /* _DEBUG */
    68-                   }
    69-               else
    70-            #endif /* defined(_M_IX86) || defined(_M_X64) */
    71-           
    72-                   {   // allocate normal block
    73-                   _Ptr = ::operator new(_User_size);
    74-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr != 0);
    75-                   }
    76-               return (static_cast<_Ty *>(_Ptr));
    77-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_node<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, void *> *&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_node<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, void *> *&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    46: inl(1212): Source for routine not found.: std::_Xbad_alloc


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _DECLSPEC_ALLOCATOR _Ty *_Allocate(size_t _Count, _Ty *,
    37-                   bool _Try_aligned_allocation = true)
    38-               {   // allocate storage for _Count elements of type _Ty
    39-               void *_Ptr = 0;
    40-           
    41-               if (_Count == 0)
    42-                   return (static_cast<_Ty *>(_Ptr));
    43-           
    44-               // check overflow of multiply
    45-               if ((size_t)(-1) / sizeof (_Ty) < _Count)
    46-                   _Xbad_alloc();  // report no memory
    47-               const size_t _User_size = _Count * sizeof (_Ty);
    48-           
    49-            #if defined(_M_IX86) || defined(_M_X64)
    50-               if (_Try_aligned_allocation
    51-                   && _BIG_ALLOCATION_THRESHOLD <= _User_size)
    52-                   {   // allocate large block
    53-                   _STATIC_ASSERT2(sizeof (void *) < _BIG_ALLOCATION_ALIGNMENT,
    54-                       "Big allocations should at least match vector register size");
    55-                   const size_t _Block_size = _NON_USER_SIZE + _User_size;
    56-                   if (_Block_size <= _User_size)
    57-                       _Xbad_alloc();  // report no memory
    58-                   const uintptr_t _Ptr_container =
    59-                       reinterpret_cast<uintptr_t>(::operator new(_Block_size));
    60-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr_container != 0);
    61-                   _Ptr = reinterpret_cast<void *>((_Ptr_container + _NON_USER_SIZE)
    62-                       & ~(_BIG_ALLOCATION_ALIGNMENT - 1));
    63-                   static_cast<uintptr_t *>(_Ptr)[-1] = _Ptr_container;
    64-           
    65-            #ifdef _DEBUG
    66-                   static_cast<uintptr_t *>(_Ptr)[-2] = _BIG_ALLOCATION_SENTINEL;
    67-            #endif /* _DEBUG */
    68-                   }
    69-               else
    70-            #endif /* defined(_M_IX86) || defined(_M_X64) */
    71-           
    72-                   {   // allocate normal block
    73-                   _Ptr = ::operator new(_User_size);
    74-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr != 0);
    75-                   }
    76-               return (static_cast<_Ty *>(_Ptr));
    77-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory

FUNCTION NAME: std::_Uninit_move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   453: vec( 103): Unvectorized loop.
   453: vec( 163): Exception handling obstructs vectorization.
   453: vec( 110): Vectorization obstructive function reference.: operator delete
   453: vec( 110): Vectorization obstructive function reference.: forward
   454: inl(1212): Source for routine not found.: std::forward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
   454: opt(1097): This statement prevents loop optimization.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory

FUNCTION NAME: std::_Uninit_move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   446-               _FwdIt _Uninit_move(_InIt _First, _InIt _Last, _FwdIt _Dest,
   447-                   _WRAP_ALLOC(_Alloc)& _Al, _Valty *, _Nonscalar_ptr_iterator_tag)
   448-               {   // move [_First, _Last) to raw _Dest, using _Al, arbitrary type
   449-               _DEBUG_RANGE_PTR(_First, _Last, _Dest);
   450-               _FwdIt _Next = _Dest;
   451-           
   452-               _TRY_BEGIN
   453- +------>      for (; _First != _Last; ++_Dest, (void)++_First)
   454- +------           _Al.construct(_Dest, (_Valty _REFREF)*_First);
   455-               _CATCH_ALL
   456- +------>      for (; _Next != _Dest; ++_Next)
   457- +------           _Al.destroy(_Next);
   458-               _RERAISE;
   459-               _CATCH_END
   460-               return (_Dest);
   461-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory

FUNCTION NAME: std::_Uninit_fill_n<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, unsigned long, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   619: vec( 103): Unvectorized loop.
   619: vec( 163): Exception handling obstructs vectorization.
   619: vec( 110): Vectorization obstructive function reference.: operator delete
   619: vec( 110): Vectorization obstructive function reference.: forward
   620: inl(1212): Source for routine not found.: std::forward<const std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> &>
   620: opt(1097): This statement prevents loop optimization.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory

FUNCTION NAME: std::_Uninit_fill_n<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, unsigned long, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   607-               void _Uninit_fill_n(_FwdIt _First, _Diff _Count,
   608-                   const _Tval *_Pval, _WRAP_ALLOC(_Alloc)& _Al,
   609-                       _Valty *, _Nonscalar_ptr_iterator_tag)
   610-               {   // copy _Count * *_Pval to raw _First, using _Al, arbitrary type
   611-            #if _ITERATOR_DEBUG_LEVEL == 2
   612-           //  if (_Count < 0)
   613-           //      _DEBUG_ERROR("negative count in uninitialized fill");
   614-            #endif /* _ITERATOR_DEBUG_LEVEL == 2 */
   615-           
   616-               _FwdIt _Next = _First;
   617-           
   618-               _TRY_BEGIN
   619- +------>      for (; 0 < _Count; --_Count, (void)++_First)
   620- +------           _Al.construct(_First, *_Pval);
   621-               _CATCH_ALL
   622- +------>      for (; _Next != _First; ++_Next)
   623- +------           _Al.destroy(_Next);
   624-               _RERAISE;
   625-               _CATCH_END
   626-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xutility

FUNCTION NAME: std::_Move_backward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  3238: vec( 103): Unvectorized loop.
  3238: vec( 110): Vectorization obstructive function reference.: move
  3239: inl(1212): Source for routine not found.: std::move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xutility

FUNCTION NAME: std::_Move_backward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> *>
FORMAT LIST

 LINE   LOOP      STATEMENT

  3235-               _BidIt2 _Move_backward(_BidIt1 _First, _BidIt1 _Last,
  3236-                   _BidIt2 _Dest, _Nonscalar_ptr_iterator_tag)
  3237-               {   // move [_First, _Last) backwards to [..., _Dest), arbitrary iterators
  3238- +------>      while (_First != _Last)
  3239- +------           *--_Dest = _STD move(*--_Last);
  3240-               return (_Dest);
  3241-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  2003-                   move(_Ty&& _Arg) _NOEXCEPT
  2004-               {   // forward _Arg as movable
  2005-               return (static_cast<typename remove_reference<_Ty>::type&&>(_Arg));
  2006-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::forward_as_tuple<const unsigned long &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1298: inl(1212): Source for routine not found.: std::forward<const unsigned long &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::forward_as_tuple<const unsigned long &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1296-                   forward_as_tuple(_Types&&... _Args) _NOEXCEPT
  1297-               {   // forward arguments in a tuple
  1298-               return (tuple<_Types&&...>(_STD forward<_Types>(_Args)...));
  1299-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const unsigned long &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const unsigned long &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::piecewise_construct_t &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::piecewise_construct_t &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::tuple<const unsigned long &>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::tuple<const unsigned long &>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::tuple<>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::tuple<>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::tuple<const unsigned long &> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::tuple<const unsigned long &> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  2003-                   move(_Ty&& _Arg) _NOEXCEPT
  2004-               {   // forward _Arg as movable
  2005-               return (static_cast<typename remove_reference<_Ty>::type&&>(_Arg));
  2006-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::get<(unsigned long)0, const unsigned long &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::get<(unsigned long)0, const unsigned long &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1168-                   get(tuple<_Types...>&& _Tuple) _NOEXCEPT
  1169-               {   // get rvalue reference to _Index element of tuple
  1170-               typedef typename tuple_element<_Index, tuple<_Types...> >::_Ttype
  1171-                   _Ttype;
  1172-               typedef typename tuple_element<_Index, tuple<_Types...> >::type&&
  1173-                   _RRtype;
  1174-               return (_STD forward<_RRtype>(((_Ttype&)_Tuple)._Myfirst._Val));
  1175-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::hash<TaskVariant *> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::hash<TaskVariant *> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::equal_to<TaskVariant *> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::equal_to<TaskVariant *> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<std::_List_node<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, void *>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    46: inl(1212): Source for routine not found.: std::_Xbad_alloc


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<std::_List_node<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, void *>>
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _DECLSPEC_ALLOCATOR _Ty *_Allocate(size_t _Count, _Ty *,
    37-                   bool _Try_aligned_allocation = true)
    38-               {   // allocate storage for _Count elements of type _Ty
    39-               void *_Ptr = 0;
    40-           
    41-               if (_Count == 0)
    42-                   return (static_cast<_Ty *>(_Ptr));
    43-           
    44-               // check overflow of multiply
    45-               if ((size_t)(-1) / sizeof (_Ty) < _Count)
    46-                   _Xbad_alloc();  // report no memory
    47-               const size_t _User_size = _Count * sizeof (_Ty);
    48-           
    49-            #if defined(_M_IX86) || defined(_M_X64)
    50-               if (_Try_aligned_allocation
    51-                   && _BIG_ALLOCATION_THRESHOLD <= _User_size)
    52-                   {   // allocate large block
    53-                   _STATIC_ASSERT2(sizeof (void *) < _BIG_ALLOCATION_ALIGNMENT,
    54-                       "Big allocations should at least match vector register size");
    55-                   const size_t _Block_size = _NON_USER_SIZE + _User_size;
    56-                   if (_Block_size <= _User_size)
    57-                       _Xbad_alloc();  // report no memory
    58-                   const uintptr_t _Ptr_container =
    59-                       reinterpret_cast<uintptr_t>(::operator new(_Block_size));
    60-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr_container != 0);
    61-                   _Ptr = reinterpret_cast<void *>((_Ptr_container + _NON_USER_SIZE)
    62-                       & ~(_BIG_ALLOCATION_ALIGNMENT - 1));
    63-                   static_cast<uintptr_t *>(_Ptr)[-1] = _Ptr_container;
    64-           
    65-            #ifdef _DEBUG
    66-                   static_cast<uintptr_t *>(_Ptr)[-2] = _BIG_ALLOCATION_SENTINEL;
    67-            #endif /* _DEBUG */
    68-                   }
    69-               else
    70-            #endif /* defined(_M_IX86) || defined(_M_X64) */
    71-           
    72-                   {   // allocate normal block
    73-                   _Ptr = ::operator new(_User_size);
    74-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr != 0);
    75-                   }
    76-               return (static_cast<_Ty *>(_Ptr));
    77-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_node<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, void *> *&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_node<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>, void *> *&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    46: inl(1212): Source for routine not found.: std::_Xbad_alloc


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _DECLSPEC_ALLOCATOR _Ty *_Allocate(size_t _Count, _Ty *,
    37-                   bool _Try_aligned_allocation = true)
    38-               {   // allocate storage for _Count elements of type _Ty
    39-               void *_Ptr = 0;
    40-           
    41-               if (_Count == 0)
    42-                   return (static_cast<_Ty *>(_Ptr));
    43-           
    44-               // check overflow of multiply
    45-               if ((size_t)(-1) / sizeof (_Ty) < _Count)
    46-                   _Xbad_alloc();  // report no memory
    47-               const size_t _User_size = _Count * sizeof (_Ty);
    48-           
    49-            #if defined(_M_IX86) || defined(_M_X64)
    50-               if (_Try_aligned_allocation
    51-                   && _BIG_ALLOCATION_THRESHOLD <= _User_size)
    52-                   {   // allocate large block
    53-                   _STATIC_ASSERT2(sizeof (void *) < _BIG_ALLOCATION_ALIGNMENT,
    54-                       "Big allocations should at least match vector register size");
    55-                   const size_t _Block_size = _NON_USER_SIZE + _User_size;
    56-                   if (_Block_size <= _User_size)
    57-                       _Xbad_alloc();  // report no memory
    58-                   const uintptr_t _Ptr_container =
    59-                       reinterpret_cast<uintptr_t>(::operator new(_Block_size));
    60-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr_container != 0);
    61-                   _Ptr = reinterpret_cast<void *>((_Ptr_container + _NON_USER_SIZE)
    62-                       & ~(_BIG_ALLOCATION_ALIGNMENT - 1));
    63-                   static_cast<uintptr_t *>(_Ptr)[-1] = _Ptr_container;
    64-           
    65-            #ifdef _DEBUG
    66-                   static_cast<uintptr_t *>(_Ptr)[-2] = _BIG_ALLOCATION_SENTINEL;
    67-            #endif /* _DEBUG */
    68-                   }
    69-               else
    70-            #endif /* defined(_M_IX86) || defined(_M_X64) */
    71-           
    72-                   {   // allocate normal block
    73-                   _Ptr = ::operator new(_User_size);
    74-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr != 0);
    75-                   }
    76-               return (static_cast<_Ty *>(_Ptr));
    77-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory

FUNCTION NAME: std::_Uninit_move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   453: vec( 103): Unvectorized loop.
   453: vec( 163): Exception handling obstructs vectorization.
   453: vec( 110): Vectorization obstructive function reference.: operator delete
   453: vec( 110): Vectorization obstructive function reference.: forward
   454: inl(1212): Source for routine not found.: std::forward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
   454: opt(1097): This statement prevents loop optimization.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory

FUNCTION NAME: std::_Uninit_move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   446-               _FwdIt _Uninit_move(_InIt _First, _InIt _Last, _FwdIt _Dest,
   447-                   _WRAP_ALLOC(_Alloc)& _Al, _Valty *, _Nonscalar_ptr_iterator_tag)
   448-               {   // move [_First, _Last) to raw _Dest, using _Al, arbitrary type
   449-               _DEBUG_RANGE_PTR(_First, _Last, _Dest);
   450-               _FwdIt _Next = _Dest;
   451-           
   452-               _TRY_BEGIN
   453- +------>      for (; _First != _Last; ++_Dest, (void)++_First)
   454- +------           _Al.construct(_Dest, (_Valty _REFREF)*_First);
   455-               _CATCH_ALL
   456- +------>      for (; _Next != _Dest; ++_Next)
   457- +------           _Al.destroy(_Next);
   458-               _RERAISE;
   459-               _CATCH_END
   460-               return (_Dest);
   461-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory

FUNCTION NAME: std::_Uninit_fill_n<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, unsigned long, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   619: vec( 103): Unvectorized loop.
   619: vec( 163): Exception handling obstructs vectorization.
   619: vec( 110): Vectorization obstructive function reference.: operator delete
   619: vec( 110): Vectorization obstructive function reference.: forward
   620: inl(1212): Source for routine not found.: std::forward<const std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> &>
   620: opt(1097): This statement prevents loop optimization.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory

FUNCTION NAME: std::_Uninit_fill_n<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, unsigned long, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>, std::_Wrap_alloc<std::allocator<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   607-               void _Uninit_fill_n(_FwdIt _First, _Diff _Count,
   608-                   const _Tval *_Pval, _WRAP_ALLOC(_Alloc)& _Al,
   609-                       _Valty *, _Nonscalar_ptr_iterator_tag)
   610-               {   // copy _Count * *_Pval to raw _First, using _Al, arbitrary type
   611-            #if _ITERATOR_DEBUG_LEVEL == 2
   612-           //  if (_Count < 0)
   613-           //      _DEBUG_ERROR("negative count in uninitialized fill");
   614-            #endif /* _ITERATOR_DEBUG_LEVEL == 2 */
   615-           
   616-               _FwdIt _Next = _First;
   617-           
   618-               _TRY_BEGIN
   619- +------>      for (; 0 < _Count; --_Count, (void)++_First)
   620- +------           _Al.construct(_First, *_Pval);
   621-               _CATCH_ALL
   622- +------>      for (; _Next != _First; ++_Next)
   623- +------           _Al.destroy(_Next);
   624-               _RERAISE;
   625-               _CATCH_END
   626-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xutility

FUNCTION NAME: std::_Move_backward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  3238: vec( 103): Unvectorized loop.
  3238: vec( 110): Vectorization obstructive function reference.: move
  3239: inl(1212): Source for routine not found.: std::move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xutility

FUNCTION NAME: std::_Move_backward<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *, std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> *>
FORMAT LIST

 LINE   LOOP      STATEMENT

  3235-               _BidIt2 _Move_backward(_BidIt1 _First, _BidIt1 _Last,
  3236-                   _BidIt2 _Dest, _Nonscalar_ptr_iterator_tag)
  3237-               {   // move [_First, _Last) backwards to [..., _Dest), arbitrary iterators
  3238- +------>      while (_First != _Last)
  3239- +------           *--_Dest = _STD move(*--_Last);
  3240-               return (_Dest);
  3241-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::_List_unchecked_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  2003-                   move(_Ty&& _Arg) _NOEXCEPT
  2004-               {   // forward _Arg as movable
  2005-               return (static_cast<typename remove_reference<_Ty>::type&&>(_Arg));
  2006-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<bool>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<bool>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::pair<const unsigned long, std::unordered_map<TaskVariant *, std::vector<double, std::allocator<double>>, std::hash<TaskVariant *>, std::equal_to<TaskVariant *>, std::allocator<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::forward_as_tuple<TaskVariant *const &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  1298: inl(1212): Source for routine not found.: std::forward<TaskVariant *const &>


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::forward_as_tuple<TaskVariant *const &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1296-                   forward_as_tuple(_Types&&... _Args) _NOEXCEPT
  1297-               {   // forward arguments in a tuple
  1298-               return (tuple<_Types&&...>(_STD forward<_Types>(_Args)...));
  1299-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<TaskVariant *const &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<TaskVariant *const &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::tuple<TaskVariant *const &>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::tuple<TaskVariant *const &>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::tuple<TaskVariant *const &> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::move<std::tuple<TaskVariant *const &> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  2003-                   move(_Ty&& _Arg) _NOEXCEPT
  2004-               {   // forward _Arg as movable
  2005-               return (static_cast<typename remove_reference<_Ty>::type&&>(_Arg));
  2006-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::get<(unsigned long)0, TaskVariant *const &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/tuple

FUNCTION NAME: std::get<(unsigned long)0, TaskVariant *const &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1168-                   get(tuple<_Types...>&& _Tuple) _NOEXCEPT
  1169-               {   // get rvalue reference to _Index element of tuple
  1170-               typedef typename tuple_element<_Index, tuple<_Types...> >::_Ttype
  1171-                   _Ttype;
  1172-               typedef typename tuple_element<_Index, tuple<_Types...> >::type&&
  1173-                   _RRtype;
  1174-               return (_STD forward<_RRtype>(((_Ttype&)_Tuple)._Myfirst._Val));
  1175-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<double>&>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const std::allocator<double>&>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::_List_iterator<std::_List_val<std::_List_simple_types<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>>>>>>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>> &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<std::pair<TaskVariant *const , std::vector<double, std::allocator<double>>> &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<double>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

    46: inl(1212): Source for routine not found.: std::_Xbad_alloc


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xmemory0

FUNCTION NAME: std::_Allocate<double>
FORMAT LIST

 LINE   LOOP      STATEMENT

    36-               _DECLSPEC_ALLOCATOR _Ty *_Allocate(size_t _Count, _Ty *,
    37-                   bool _Try_aligned_allocation = true)
    38-               {   // allocate storage for _Count elements of type _Ty
    39-               void *_Ptr = 0;
    40-           
    41-               if (_Count == 0)
    42-                   return (static_cast<_Ty *>(_Ptr));
    43-           
    44-               // check overflow of multiply
    45-               if ((size_t)(-1) / sizeof (_Ty) < _Count)
    46-                   _Xbad_alloc();  // report no memory
    47-               const size_t _User_size = _Count * sizeof (_Ty);
    48-           
    49-            #if defined(_M_IX86) || defined(_M_X64)
    50-               if (_Try_aligned_allocation
    51-                   && _BIG_ALLOCATION_THRESHOLD <= _User_size)
    52-                   {   // allocate large block
    53-                   _STATIC_ASSERT2(sizeof (void *) < _BIG_ALLOCATION_ALIGNMENT,
    54-                       "Big allocations should at least match vector register size");
    55-                   const size_t _Block_size = _NON_USER_SIZE + _User_size;
    56-                   if (_Block_size <= _User_size)
    57-                       _Xbad_alloc();  // report no memory
    58-                   const uintptr_t _Ptr_container =
    59-                       reinterpret_cast<uintptr_t>(::operator new(_Block_size));
    60-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr_container != 0);
    61-                   _Ptr = reinterpret_cast<void *>((_Ptr_container + _NON_USER_SIZE)
    62-                       & ~(_BIG_ALLOCATION_ALIGNMENT - 1));
    63-                   static_cast<uintptr_t *>(_Ptr)[-1] = _Ptr_container;
    64-           
    65-            #ifdef _DEBUG
    66-                   static_cast<uintptr_t *>(_Ptr)[-2] = _BIG_ALLOCATION_SENTINEL;
    67-            #endif /* _DEBUG */
    68-                   }
    69-               else
    70-            #endif /* defined(_M_IX86) || defined(_M_X64) */
    71-           
    72-                   {   // allocate normal block
    73-                   _Ptr = ::operator new(_User_size);
    74-                   _SCL_SECURE_ALWAYS_VALIDATE(_Ptr != 0);
    75-                   }
    76-               return (static_cast<_Ty *>(_Ptr));
    77-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<double &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<double &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const double &>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

  No diagnostic message.


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/type_traits

FUNCTION NAME: std::forward<const double &>
FORMAT LIST

 LINE   LOOP      STATEMENT

  1986-               _CONST_FUN _Ty&& forward(
  1987-                   typename remove_reference<_Ty>::type& _Arg) _NOEXCEPT
  1988-               {   // forward an lvalue as either an lvalue or an rvalue
  1989-               return (static_cast<_Ty&&>(_Arg));
  1990-               }


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::use_facet<std::numpunct<char>>
DIAGNOSTIC LIST

 LINE              DIAGNOSTIC MESSAGE

   560: inl(1212): Source for routine not found.: std::locale::_Getfacet const
   566: inl(1212): Source for routine not found.: std::numpunct<char>::_Getcat
   569: inl(1212): Source for routine not found.: std::bad_cast::bad_cast
   585: inl(1212): Source for routine not found.: std::locale::facet::_Register


NEC C/C++ Compiler (1.6.0) for Vector Engine     Mon Dec  3 12:39:09 2018
FILE NAME: /opt/nec/ve/ncc/1.6.0/include/C++/xlocale

FUNCTION NAME: std::use_facet<std::numpunct<char>>
FORMAT LIST

 LINE   LOOP      STATEMENT

   547-               const _Facet& use_facet(const locale& _Loc)
   548-           
   549-               {   // get facet reference from locale
   550-            #if _NO_LOCALES
   551-               static _Wrap_facet<_Facet> _Wfac;
   552-               return (*(_Facet *)&_Wfac);
   553-           
   554-            #else /* _NO_LOCALES */
   555-               _BEGIN_LOCK(_LOCK_LOCALE)   // the thread lock, make get atomic
   556-                   const locale::facet *_Psave =
   557-                       _Facetptr<_Facet>::_Psave;  // static pointer to lazy facet
   558-           
   559-                   size_t _Id = _Facet::id;
   560-                   const locale::facet *_Pf = _Loc._Getfacet(_Id);
   561-           
   562-                   if (_Pf != 0)
   563-                       ;   // got facet from locale
   564-                   else if (_Psave != 0)
   565-                       _Pf = _Psave;   // lazy facet already allocated
   566-                   else if (_Facet::_Getcat(&_Psave, &_Loc) == (size_t)(-1))
   567-           
   568-            #if _HAS_EXCEPTIONS
   569-                       _THROW1(_XSTD bad_cast());  // lazy disallowed
   570-           
   571-            #else /* _HAS_EXCEPTIONS */
   572-                       {
   573-                       __builtin_traceback((unsigned long *)__builtin_frame_address(0));
   574-                       abort();    // lazy disallowed
   575-                       }
   576-            #endif /* _HAS_EXCEPTIONS */
   577-           
   578-                   else
   579-                       {   // queue up lazy facet for destruction
   580-                       _Pf = _Psave;
   581-                       _Facetptr<_Facet>::_Psave = _Psave;
   582-           
   583-                       locale::facet *_Pfmod = (_Facet *)_Psave;
   584-                       _Pfmod->_Incref();
   585-                       _Pfmod->_Register();
   586-                       }
   587-           
   588-                   return ((const _Facet&)(*_Pf)); // should be dynamic_cast
   589-               _END_LOCK()
   590-            #endif /* _NO_LOCALES */
   591-               }   // end of use_facet body


