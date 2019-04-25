rm -rf generated
rm -rf out
python generator.py
mkdir out/
cp -R generated/* out/
cd out
/opt/nec/ve/bin/nc++ -report-all -fdiag-vector=2 -fdiag-inline=2 -fdiag-system-header -assembly-list -Bstatic -static -v -O3 -fipa -finline -finline-functions -mvector -fopenmp main.cpp utils.cpp measurement_32bit.cpp measurement_64bit.cpp copy_32bit.cpp copy_64bit.cpp read_32bit.cpp read_64bit.cpp test_copy_32bit.cpp test_copy_64bit.cpp test_read_32bit.cpp test_read_64bit.cpp test_write_32bit.cpp test_write_64bit.cpp write_32bit.cpp write_64bit.cpp -o non_optimal >build.out 2>build.err
rm *.cpp
rm -rf include
cd -
