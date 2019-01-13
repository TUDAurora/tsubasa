#!/usr/bin/env bash

mkdir out

make nec_host_noparallel >out/BUILD_VH_NoParallel.out 2>out/BUILD_VH_NoParallel.err
mv ramometer_noparallel out/

make nec_host_ompparallel >out/BUILD_VH_OMPParallel.out 2>out/BUILD_VH_OMPParallel.err
mv ramometer_ompparallel out/

make nec_ve_autovec_noparallel >out/BUILD_VE_NoParallel.out 2>out/BUILD_VE_NoParallel.err
mv ramometer.L out/ramometer_ve_autovec_noparallel.L
mv ramometer.O out/ramometer_ve_autovec_noparallel.O
mv ramometer_ve_autovec_noparallel out/

#make nec_ve_autovec_mparallel >out/BUILD_VE_MParallel.out 2>out/BUILD_VE_MParallel.err
#mv ramometer.L out/ramometer_ve_autovec_mparallel.L
#mv ramometer.O out/ramometer_ve_autovec_mparallel.O
#mv ramometer_ve_autovec_mparallel out/
#
make nec_ve_autovec_ompparallel >out/BUILD_VE_OMPParallel.out 2>out/BUILD_VH_OMPParallel.err
mv ramometer.L out/ramometer_ve_autovec_ompparallel.L
mv ramometer.O out/ramometer_ve_autovec_ompparallel.O
mv ramometer_ve_autovec_ompparallel out/
