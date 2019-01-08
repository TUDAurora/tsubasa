#!/usr/bin/env bash

mkdir out

make nec_host_noparallel
mv ramometer_noparallel out/

make nec_host_ompparallel
mv ramometer_ompparallel out/

make nec_ve_autovec_noparallel
mv ramometer.L out/ramometer_ve_autovec_noparallel.L
mv ramometer.O out/ramometer_ve_autovec_noparallel.O
mv ramometer_ve_autovec_noparallel out/

make nec_ve_autovec_mparallel
mv ramometer.L out/ramometer_ve_autovec_mparallel.L
mv ramometer.O out/ramometer_ve_autovec_mparallel.O
mv ramometer_ve_autovec_mparallel out/

make nec_ve_autovec_ompparallel
mv ramometer.L out/ramometer_ve_autovec_ompparallel.L
mv ramometer.O out/ramometer_ve_autovec_ompparallel.O
mv ramometer_ve_autovec_ompparallel out/


ramometer_noparallel
ramometer_ompparallel
ramometer_ve_autovec_mparallel
ramometer_ve_autovec_noparallel
ramometer_ve_autovec_ompparallel