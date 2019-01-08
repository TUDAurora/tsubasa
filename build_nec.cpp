/**
 * @file build_nec.cpp
 *
 * needs c++17 and -static-libstdc++ -lstdc++fs to be build on nec
 *  g++ -std=c++17 -o build.out build_nec.cpp -static-libstdc++ -lstdc++fs
 * @brief Brief description
 * @author Johannes Pietrzyk
 * @todo TODOS?
 */

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <iostream>
#include <string>
#include <filesystem>


static int verbose_flag;

int main (int argc, char **argv) {
   int c;

   bool clear = false;
   std::string additional_flags{"-DCMAKE_C_COMPILER_ID_RUN=TRUE -DCMAKE_CXX_COMPILER_ID_RUN=TRUE -DAutovectorize=1"}; //-DAutovectorize=1
   std::string toolchain_file{"Toolchain-nec.cmake"};
   std::string mode{"-DCMAKE_BUILD_TYPE=Debug"};
   std::string out_dir{"out"};
   std::string tmpMode{""};


   while (1) {
      static struct option long_options[] =
         {
            {"clear",   no_argument,       0, 'c'},
            {"help",    no_argument,       0, 'h'},
            {"flags",   required_argument, 0, 'f'},
            {"tcf",     required_argument, 0, 't'},
            {"mode",    required_argument, 0, 'm'},
            {"out",     required_argument, 0, 'o'},
            {0, 0, 0, 0}
         };
      /* getopt_long stores the option index here. */
      int option_index = 0;

      c = getopt_long (argc, argv, "chf:t:m:o:",
                       long_options, &option_index);

      /* Detect the end of the options. */
      if (c == -1)
         break;

      switch (c) {
         case 0:
            /* If this option set a flag, do nothing else now. */
            if (long_options[option_index].flag != 0)
               break;
            printf ("option %s", long_options[option_index].name);
            if (optarg)
               printf (" with arg %s", optarg);
            printf ("\n");
            break;

         case 'c':
            clear = true;
            break;

         case 'f':
            additional_flags =  optarg;
            break;

         case 't':
            toolchain_file = optarg;
            break;

         case 'm':
            tmpMode = optarg ;
            if( ( std::string{"=D"}.compare( tmpMode ) == 0 ) || ( std::string{"=Debug"}.compare( tmpMode ) == 0 ) || ( std::string{"=DEBUG"}.compare( tmpMode ) == 0 ) ) {
               mode = "-DCMAKE_BUILD_TYPE=Debug";
            }else if( ( std::string{"=R"}.compare( tmpMode ) == 0 ) || ( std::string{"=Release"}.compare( tmpMode ) == 0 ) || ( std::string{"=RELEASE"}.compare( tmpMode ) == 0 ) ) {
               mode = "-DCMAKE_BUILD_TYPE=Release";
            }
            break;
         case 'o':
            out_dir = optarg;
            break;
         case '?':
            /* getopt_long already printed an error message. */
            break;

         default:
            std::cout << "Usage: " << argv[0] << " [-c] [-f Flags] [-h] [-m Build mode] [-o Output directory] [-t Toolchain file]\n\n"
                      << "  -c, --clear         Clears the output directory to get a fresh build.\n"
                      << "  -f, --flags=FLAGS   Specify additional FLAGS which should be passed to cmake (\"-D*CMAKEFLAG*=*VALUE* -D*CMAKEFLAG2*=*VALUE2*\".\n"
                      << "  -h, --help          Show this help.\n"
                      << "  -m, --mode=MODE     Specify build mode ( Release / RELEASE / R, Debug / DEBUG / D ).\n"
                      << "  -o, --out=OUTDIR    Specify the output directory.\n"
                      << "  -t, --tcf=TC-FILE   Specify the toolchain file.\n";
            return 1;

      }
   }

   std::cout << "Running CMake with following specs:\n"
             << "Additional Flags: " << additional_flags << "\n"
             << "Toolchain File:   " << toolchain_file << "\n"
             << "Build Mode:       " << mode << "\n"
             << "Output Directory: " << out_dir << "\n";

   auto base_path = std::filesystem::current_path();
   auto toolchain_path = base_path;
   toolchain_path /= toolchain_file;
   auto out_path = base_path;
   out_path /= out_dir;
   if( ! std::filesystem::is_directory( out_path ) ) {
      std::filesystem::create_directory( out_path );
   } else {
      if( clear ) {
         std::filesystem::remove_all( out_path );
         std::filesystem::create_directory( out_path );
      }
   }
   std::filesystem::current_path( out_path );

   std::string cmake{ "cmake3" };
   std::string command = cmake + " -DCMAKE_TOOLCHAIN_FILE=" + std::string{toolchain_path.c_str()} + " " + additional_flags + " " + mode + " ..";
   std::cout << "Executing: " << command << "\n[y/N]: " << std::flush;
   std::string g;
   std::cin >> g;
   if( std::string{"y"}.compare( g ) == 0 ) {
      int cmake_exit_state = std::system(command.c_str());
      if (cmake_exit_state == 0) {
         int make_exit_state = std::system( "make" );
         if( make_exit_state == 0 ) {
            std::system( "make CTEST_OUTPUT_ON_FAILURE=1 test" );
         }
      }
   }
   return 0;

}