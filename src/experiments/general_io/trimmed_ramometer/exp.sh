cd out/
./ramometer_ve_autovec_noparallel 50 1mi,2mi,4mi,8mi,16mi,32mi,64mi,128mi,256mi,512mi,1gi,2gi,4gi,8gi t > ramometer_australis_ve_noparallel.tsv
./ramometer_ve_autovec_ompparallel 50 1mi,2mi,4mi,8mi,16mi,32mi,64mi,128mi,256mi,512mi,1gi,2gi,4gi,8gi t > ramometer_australis_ve_omp.tsv
#./ramometer_noparallel 10 1mi,2mi,4mi,8mi,16mi,32mi,64mi,128mi,256mi,512mi,1gi,2gi,4gi,8gi t > ramometer_australis_vh_noparallel.tsv
#./ramometer_ompparallel 10 1mi,2mi,4mi,8mi,16mi,32mi,64mi,128mi,256mi,512mi,1gi,2gi,4gi,8gi t > ramometer_australis_vh_omp.tsv
#./ramometer_ve_autovec_mparallel 10 1mi,2mi,4mi,8mi,16mi,32mi,64mi,128mi,256mi,512mi,1gi,2gi,4gi,8gi t > ramometer_borealis_ve_mparallel.tsv
cd -