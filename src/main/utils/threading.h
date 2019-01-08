/**
 * @file threading.h
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#ifndef GENERAL_THREADING_H
#define GENERAL_THREADING_H

#include <unistd.h>
#include <sys/types.h>
#include <iostream>
#include <pthread.h>

bool check_root( void ) {
   return ( getuid() == 0 );
}

class posix_thread {
   private:
      int32_t        policy;   // SCHED_OTHER, SCHED_FIFO, SCHED_RR
      pthread_attr_t attribute;
      cpu_set_t      cpu_set;
      pthread_t      t;

   public:
      posix_thread( void ) {
         CPU_ZERO( &cpu_set );
         pthread_attr_init( &attribute );
      }
      void set_cpu( int32_t cpu ) {
         CPU_SET( cpu, &cpu_set );
//         pthread_attr_setaffinity_np( &attribute, sizeof( cpu_set_t ), &cpu_set );
      }

      pthread_t * get_thread_ptr( void ) {
         return &t;
      }

      pthread_t get_thread( void ) {
         return t;
      }

      pthread_attr_t * get_attribute( void ) {
         return &attribute;
      }

      int32_t get_prio( void ) {
         struct sched_param param;
         pthread_t t = pthread_self();
         if((pthread_getschedparam( t, &policy, &param)) == 0  ) {
            return param.sched_priority;
         }
         return 0;
      }
      void setprio( int policy, int prio ) {
         struct sched_param param;
         param.sched_priority=prio;
         if((pthread_setschedparam( t,
                                    policy, &param)) != 0  ) {
            std::cerr << "Could not change thread policy or priority.\n";
            pthread_exit((void *)pthread_self());
         }
      }
};

template< typename T >
struct partition_manager_even_chunks {
   T * base_addr;
   std::size_t data_size;
   std::size_t num_threads;
   std::size_t chunk_size;
   std::size_t residual;
   partition_manager_even_chunks( T * const b_addr, std::size_t size ) :
      base_addr{ b_addr },
      data_size{ size },
      num_threads{ MAX_THREAD_COUNT },
      chunk_size{ size / MAX_THREAD_COUNT },
      residual{ size % MAX_THREAD_COUNT }{ }

   void set_base_addr( T * b_addr ) {
      base_addr = b_addr;
   }
   void set_thread_count( std::size_t num_threads_ ) {
      num_threads = num_threads_;
      chunk_size = data_size / num_threads_;
      residual = data_size % num_threads_;
   }
   std::pair< T*, T* > get_chunk( std::size_t thread_id ) const {
      assert( thread_id < MAX_THREAD_COUNT && thread_id < num_threads );
      T * start = base_addr + ( thread_id * chunk_size );
      if( ( thread_id == num_threads - 1 ) && ( residual != 0 ) ) {
         return { start, start + chunk_size + residual };
      } else {
         return { start, start + chunk_size };
      }
   }
   std::pair< T*, std::size_t > get_chunk_with_size( std::size_t thread_id ) const {
      assert( thread_id < MAX_THREAD_COUNT && thread_id < num_threads );
      T * start = base_addr + ( thread_id * chunk_size );
      if( ( thread_id == num_threads - 1 ) && ( residual != 0 ) ) {
         return { start, chunk_size + residual };
      } else {
         return { start, chunk_size };
      }
   }
   T * get_chunk_base_addr( std::size_t thread_id ) const {
      assert( thread_id < MAX_THREAD_COUNT && thread_id < num_threads );
      return base_addr + ( thread_id * chunk_size );
   }

};

#endif //GENERAL_THREADING_H
