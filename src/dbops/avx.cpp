#include <stdio.h>
#include <immintrin.h>

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0') 


int main()
{

__m256i result,cd;
__m256i a,b;
a= _mm256_setr_epi32(0,0,2,0,4,0,6,6);
b= _mm256_setr_epi32(0,0,1,2,3,6,7,8);

cd =_mm256_conflict_epi32(a);
printf("input: (");
int * in = (int*) &a;
for(int i=0;i<8;i++)
{
  printf("%i ",in[i]);
}
printf(")\n \n");
result =  _mm256_add_epi64(a,b);
int * res = (int*) &cd;
    for(int i =0;i<8;i++){
        printf(" element %i ",i);
        printf(BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(res[i]));
        printf("\n");
    }
   

    
}