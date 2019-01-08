RAMOMETER
=========

This is a little tool for experimentally determining the speed/throughput of the memory.

GENERAL IDEA
============

We are interested in (1) the copy speed, (2) the write speed, and (3) the read speed.
(1) For measuring the copy speed, we copy all data from the source to the destination buffer.
(2) For measuring the write speed, we write a constant 8-bit value to all bytes of the destination buffer.
(3) The read speed can hardly be measured by only reading a buffer. Instead, we offer two options
  (a) Compare the first half of the source buffer with the first half of the destination buffer.
  (b) Read the source buffer and bitwise-OR-aggregate all data elements.

Each of the above tasks (copy, write, compare, and agg(OR)) can be implemented using the following methods: (A) scalar operations, (B) vector operations, or a (C) system call (except for agg(OR)).
(A) The scalar variants view a buffer as an array of type uintX_t with X being one of 8, 16, 32, 64.
(B) The vectorized variants view a buffer as an array of type __mXi with X being one of 128 (SSE), 256 (AVX), 512 (AVX-512).
    Furthermore, the vectorized variants can use one of the following so-called load/store-modes:
    (a) aligned
    (b) unaligned (in this case, the array-pointer is increased by one byte, such that the access is really unaligned)
    (c) streaming
(C) The system calls are memcpy(), memset(), and memcmp() for copy, write, and compare, respectively.

INPUT/ARGUMENTS
===============

The user can specify
- The size (in bytes) used for the source as well as the destination buffer. It is also possible to specify a comma-separated list of sizes. In that case, the tool does the experiments for all specified sizes, which is useful for investigating the impact of the buffer size. Each buffer size can be specified as a normal base-10 integer, which can have one of the suffixes "k"(*1000), "m", "g", "ki"(*1024), "mi", "gi", for convenience. If the buffer size is not a multiple of the element size, it will internally be rounded down.
- The number of repetitions of each task on each buffer size. To achieve stable measurements.
- The output mode (TSV or human readable)

OUTPUT
======

The tool outputs a table to stdout (you have to redirect the output to a file if necessary). This table is formatted as a TSV-file or more nicely to be human readable, depending on the command line arguments. In both cases, it has the following columns:
- arguments (should be self-explanatory, given the text above)
  - buffer size [Byte]
  - task
  - method
  - load mode
  - store mode
  - el size [Byte] (0 for system calls)
  - el size [Bit]
- type of output line
  - ind/AVG: The tool outputs one line for each individual repetition of a task, marked by "ind", as well as the average of these individual measurements, marked by "AVG". To see only one of them, consider piping the output of this tool to "grep ind" or "grep AVG" .
- measurements (in different units)
  - duration [s] (= the wall clock time (based on std::chrono::high_resolution_clock) elapsed for the task in seconds)
  - speed [mis] (= buffer size [Byte] / sizeof(uint32_t) / 1000000 / duration [s]; note that this assumes 32-bit integers)
  - speed [MiByte/s] (= buffer size [Byte] / 1024 / 1024 / duration [s])
  - speed [GiByte/s] (= speed [MiByte/s] / 1024)

FINALLY
=======

Compile the tool using one of

make sse
make avx
make avx512

Depending on the highest SIMD extension supported on the target machine.

Run the tool without arguments for a tiny help, including some example calls.
