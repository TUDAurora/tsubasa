/** 
*   @file selection.cpp 
*   @brief This file will perform a selection operator with random generated int numbers  on a NEC Aurora Vector engine 
*   for each value in the array data, the program calculates if it is a hit or a miss. 
*   a corresponding result array gets filled with 1 and 0s. 1 means a hit and 0 a miss.
*
*
*   @author Johannes Fett
*
*   @date 1/16/2019
*/


#include <limits.h> 
#include <stdio.h>                                                                                                                               
#include <stdlib.h>

#include <time.h>
#include <math.h>

#define NIL INT_MIN

/*
*   This macro calculates a SELECTION Operator. It return 1 on the following conditions:
    The value val is within the range determined by lower and upper. Inclusive adds the boarder of the range as valid value
    so it becomes lower <= val <=upper
    anti inverts the result

*/

#define SELECTION(val) {              		\
	res = (!lowerSet) || (val>lower);           \
	res &= (!upperSet) || (val<upper);          \
	res |= (val == lower) && (lowerInclusive);  \
	res |= (val == upper) && (upperInclusive);  \
	res = anti ? !res : res;                  \
	res = (val == NIL) ? 0 : res;				\
}


//creates an array of random ints, parameter size determines the size of the array
int * createIntArrayRandomNumbers(int size){
    int * data = new int[size];
    for (int i = 0; i < size; i++){
        data[i] = rand() % 100000;
		
    }
	
    return data;
}

// creates an array of bools set to 0, parameter size determines the size of the array
bool * createBoolempty(int size)
{
    bool * data = new bool[size];
    for (int i =0;i<size;i++){
        data[i]=0;
    }
    return data;

}

//function to get the current time in miliseconds
static inline long getTimestamp(){
    struct timespec ts;
    timespec_get(&ts, TIME_UTC);
    // timestap is additive from 2 components: current time in nanoseconds + current time in seconds since epoch
    //tv_nsec only counts between 0 and 0,99 seconds. Therefore a timestampt needs to use tv_sec and tv_nsec
    return ts.tv_nsec/1000000 + ts.tv_sec*1000;
}



int main()
{
long start= getTimestamp();
//it depends on the size if the calculation gets vectorized
//set the size of the input data, randomly generated
//autovectorize up to 131072 elements, which equals 4096kb of memory
int datasize = 10240000;

//generate random input data
int * data = createIntArrayRandomNumbers(datasize );
bool * result = createBoolempty(datasize);


//Selection calculation

//set up constants
 
    const int lower = 0;    
    const int upper = 250000;
    const char lowerSet = 0;
    const char upperSet = 1;
    const char lowerInclusive = 1;
    const char upperInclusive = 1;
    const char anti = 0;

bool res;
int val;

#pragma _NEC outerloop_unroll(1024)
for(int i= 0; i<datasize; i+=256)
{

//#pragma _NEC shortloop
for(int k =0; k<datasize/256;k++)
{


val = data[k];
SELECTION(val);
result[k] = res;

}

}

int hits=0;

for(int f=0;f<datasize;f++)
{
    if(result[f]){
    hits++;
    }
    
}
float phit = (float)hits / (float)datasize;
long end = getTimestamp();
long dif = end-start;
printf("hits: %i  percentage of hits: %f %%\nTime needed: %i ms \n",hits,100*phit, dif);


}
