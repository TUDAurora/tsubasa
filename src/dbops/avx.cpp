#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <immintrin.h>
#include <bitset>
#include <vector>
#include <iostream>
#include <algorithm>

using namespace std;


void intrinsicCD(void){
__m256i result,cd;
__m256i a,b;
a= _mm256_setr_epi32(0,0,2,0,4,0,6,6);
b= _mm256_setr_epi32(0,0,1,2,3,6,7,8);

cd =_mm256_conflict_epi32(a);
printf("input: (");
for(int i =0;i<8;i++){
int * in = (int*) &a;

  printf("%i ",in[i]);
}
printf(")\n \n");
result =  _mm256_add_epi64(a,b);
int * res = (int*) &cd;
    
}

/**
 * This function performs a conflict detection on a list 
 * of sorted unsigned integers (uint32_t)
 * It returns a bitset that contains a 1 for each conflict 
 * at the same spot. Any further occurence after the first one of a value will be a conflict.
 * example: input {0,0,1,2,2}
 * will generate the following output bitset: {0,1,0,0,1}
 * 
 */
bitset<256> scalarCD(vector<uint32_t> input)
{
bitset<256> result ={0};

uint32_t last;
last = input[0];


for (int i =1; i<input.size();i++){
   
   if(input[i]==last)
   {
       result[i]=1;
   }
    last=input[i];
}
//DOES ONLY WORK WITH STD LIB GLIBCXX_3.4.21 or higher. not available on remote server!
//string bitstring = result.to_string<char,string::traits_type,string::allocator_type>();
//cout << "result: " << result << '\n';

return result;
}

/**
 * Helper function to output the contents of a vector<uint32_t>
 * 
 */
void printvec(vector<uint32_t> input)
{
     cout << "(";
     for (uint32_t &t : input){
        cout <<" "<< t <<" " ;
    }
    cout << ")"<<endl;
}

void printvec(vector<int> input)
{
     cout << "(";
     for (int &t : input){
        cout <<" "<< t <<" " ;
    }
    cout << ")"<<endl;
}

/**
 * This program performs a conflict detection on a vector<uint32_t>
 * 
 * 
 * 
 */
int main()
{
    size_t datasize = 12;
    //unsorted input data
    vector<uint32_t> input={6,8,1,2,1,4,4,1,3,9,12,9};
    //contains a permutatation list. index[i] contains the original position of each input element before sort
    vector<int> index(input.size(),0);
    for(int i=0;i!=index.size();i++){
        index[i]=i;
    }

    cout << "input: ";
    printvec(input);

    //generate permutation list 
    sort(index.begin(),index.end(),
    [&](const int& a, const int& b) {
        return (input[a] < input[b]);
    }
);
    cout <<"permutations: ";
    printvec(index);

    sort(input.begin(),input.end()); 
    cout << "sorted input:";
    printvec(input);
    bitset<256> output ={0};
    
//do conflict detection
bitset<256> result = scalarCD(input);

cout<< "conflicts: ";
for(int i =0;i<input.size();i++)
{
    cout<<" "<<result[i]<<" ";
}
cout <<endl;

for(int i =0;i<12;i++)
{

output[index[i]]=result[i];
}

cout<< "conflicts sorted: ";
for(int i =0;i<input.size();i++)
{
    cout<<" "<<output[i]<<" ";
}
cout <<endl;
cout <<"number of conflicts: "<<output.count()<<endl;

return 0;
}
