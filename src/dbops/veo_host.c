/** 
*   @file veo_host.c 
*   @brief This file serves as HOST code for a selection run on aurora tsubasa vector engine. 
*   memory allocation, mem transfer and execution is managed here
*
*   @author Johannes Fett
*
*   @date 1/29/2019
*/

#include<stdio.h>
#include<ve_offload.h>

int * createIntArrayRandomNumbers(int size){
    int * data = new int[size];
    for (int i = 0; i < size; i++){
        data[i] = rand() % 100000;
		
    }
	
    return data;
}

int main(){
int datasize = 102400;
string lib_path = "veo_kernel.c";

//generate random input data
int * data = createIntArrayRandomNumbers(datasize );
//genreate result array
bool * res = new bool[datasize];
int nodeid = 0;

/* check if proper version */
int version = veo_api_version();

/* open proc handle on particular VE node  */
struct veo_proc_handle *proc_handle = veo_proc_create(nodeid);

/* load VE dynamic library .so file into proc’s address 
space */
uint64_t lib_id = veo_load_library(proc_handle, lib_path);



/* allocate memory in VE proc address space, we need input data and result data*/

uint64_t ve_addr1;
uint64_t ve_addr2;
uint64_t ve_addr3;

int rc = veo_alloc_mem(proc_handle, &ve_addr1, len_bytes);
rc = veo_alloc_mem(proc_handle, &ve_addr2, len_bytes);

/* transfer input select int data to VE */
rc = veo_write_mem(proc_handle, ve_addr1, data, len);




struct *veo_thr_ctxt = veo_context_open(proc_handle);

//get context state
int res = veo_get_context_state(ctxt);

/* close VEO kernel execution context */
int rc = veo_context_close(ctxt);

//run program
int rc = veo_call_wait_result(ctxt, req_id, &result);

/* transfer result data to VH */
rc = veo_read_mem(proc_handle, data, ve_addr2, len);

/* free previously allocated memory in VE proc address space */
int rc = veo_free_mem(proc_handle, ve_addr1);
rc = veo_free_mem(proc_handle, ve_addr2);





/* destroy proc handle */
rc = veo_proc_destroy(proc_handle);


}


