sse:
	# ***********************
	# Compiling with SSE only
	# ***********************
	# use make avx or make avx512 if you need wider vectors
	#
	sleep 3s # so that the user sees the above remark
	g++ -O3 -Wold-style-cast -Wall -fno-tree-vectorize -std=c++11 -msse4.1                  ramometer.cpp -o ramometer

avx:
	# **************************
	# Compiling with SSE and AVX
	# **************************
	# use make avx512 if you need wider vectors
	#
	g++ -O3 -Wold-style-cast -Wall -fno-tree-vectorize -std=c++11 -msse4.1 -mavx2           ramometer.cpp -o ramometer
	
avx512:
	# ************************************
	# Compiling with SSE, AVX, and AVX-512
	# ************************************
	#
	g++ -O3 -Wold-style-cast -Wall -fno-tree-vectorize -std=c++11 -msse4.1 -mavx2 -mavx512f ramometer.cpp -o ramometer
	
nec_host_noparallel:
	g++ -DGNUCC_ -O3 -Wold-style-cast -Wall -fno-tree-vectorize -std=c++11 -msse4.1 -mavx2 -mavx512f -static-libstdc++ ramometer.cpp -o ramometer_noparallel

nec_host_ompparallel:
	g++ -DGNUCC_ -O3 -DOMP_ -Wold-style-cast -Wall -fno-tree-vectorize -std=c++11 -msse4.1 -mavx2 -mavx512f -static-libstdc++ ramometer.cpp -fopenmp -o ramometer_ompparallel

nec_ve_autovec_noparallel:
	/opt/nec/ve/bin/nc++ -DNCC_ -report-all -fdiag-vector=2 -fdiag-inline=2 -fdiag-system-header -assembly-list -Bstatic -static -v -O3 -finline -finline-functions -Wall -pedantic -DRELEASE -mvector    ramometer.cpp -o ramometer_ve_autovec_noparallel

nec_ve_autovec_mparallel:
	/opt/nec/ve/bin/nc++ -DNCC_ -report-all -fdiag-vector=2 -fdiag-inline=2 -fdiag-system-header -assembly-list -Bstatic -static -v -O3 -finline -finline-functions -Wall -pedantic -DRELEASE -mvector -mparallel   ramometer.cpp -o ramometer_ve_autovec_mparallel

nec_ve_autovec_ompparallel:
    /opt/nec/ve/bin/nc++ -DNCC_ -DOMP_ -report-all -fdiag-vector=2 -fdiag-inline=2 -fdiag-system-header -assembly-list -Bstatic -static -v -O3 -finline -finline-functions -Wall -pedantic -DRELEASE -mvector -fopenmp  ramometer.cpp -o ramometer_ve_autovec_ompparallel

clean:
	rm -f ramometer ramometer_noparallel ramometer_ompparallel ramometer_ve_autovec_noparallelramometer_ve_autovec_mparallel ramometer_ve_autovec_ompparallel