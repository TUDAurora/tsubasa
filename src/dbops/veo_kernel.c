#define SELECTION(val) {              		\
	res = (!lowerSet) || (val>lower);           \
	res &= (!upperSet) || (val<upper);          \
	res |= (val == lower) && (lowerInclusive);  \
	res |= (val == upper) && (upperInclusive);  \
	res = anti ? !res : res;                  \
	res = (val == NIL) ? 0 : res;				\
}

int main()
{


    
}