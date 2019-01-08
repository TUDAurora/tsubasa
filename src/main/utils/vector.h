/**
 * @file vector.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_VECTOR_H
#define GENERAL_VECTOR_H

#include "literals.h"

#ifdef __NCC__
#   define DO_PRAGMA(x) _Pragma (#x)
#   define ENABLE_COMPILER_VECTOR_ DO_PRAGMA(_NEC vector)
#   define DISABLE_COMPILER_VECTOR_ DO_PRAGMA(_NEC novector)
#   define VE_CORE_COUNT                        8
#   define VE_CORE_LLC_SLICES_COUNT             8
#   define VE_CORE_LLC_SLIZES_SIZE              2_MB
#   define VE_CORE_LLC_CACHELINE_SIZE           128_B

#   define VE_CORE_SPU_COUNT                    1
#   define VE_CORE_SPU_L1_DATA_SIZE             32_KB
#   define VE_CORE_SPU_L2_SIZE                  256_KB

#   define VE_CORE_VPU_COUNT                    1
#   define VE_CORE_VPU_VPP_COUNT                32
#   define VE_CORE_VPU_ELEMENTS_PER_VPP_COUNT   8
#   define VE_CORE_VPU_VR_COUNT                 64
#   define VE_CORE_VPU_VR_ELEMENT_SIZE          64
#   define VE_CORE_VPU_VR_ELEMENT_SIZE_BYTE     64_b
#   define VE_CORE_VPU_VR_ELEMENT_COUNT         256
#   define VE_CORE_VPU_VR_BIT_SIZE              VE_CORE_VPU_VR_ELEMENT_SIZE*VE_CORE_VPU_VR_ELEMENT_COUNT
#   define VE_CORE_VPU_2_OPERAND_CHUNK_SIZE     2*VE_CORE_VPU_VR_SIZE
#   define VE_CORE_VPU_MAX_CHUNK_SIZE           VE_CORE_VPU_VR_COUNT*VE_CORE_VPU_VR_SIZE

#   define MAX_THREAD_COUNT                     8

#   define MVS                                  VE_CORE_VPU_VR_ELEMENT_COUNT
#elif defined(GNUCC_)
#   define DO_PRAGMA(x) _Pragma (#x)
#   define ENABLE_COMPILER_VECTOR_ DO_PRAGMA(GCC ivdep)
#   define DISABLE_COMPILER_VECTOR_ DO_PRAGMA(novector)
#   define MVS                                  8
#else

#endif


#endif //GENERAL_VECTOR_H
