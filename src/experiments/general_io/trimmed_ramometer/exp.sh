make nec_ve_autovec
make nec_ve_noautovec
make nec_host

./ramometer_ve_autovec   10 1mi,2mi,4mi,8mi,16mi,32mi,64mi,128mi,256mi,512mi,1gi,2gi,4gi,8gi t > ramometer_borealis_ve_autovec.tsv
./ramometer_ve_noautovec 10 1mi,2mi,4mi,8mi,16mi,32mi,64mi,128mi,256mi,512mi,1gi,2gi,4gi,8gi t > ramometer_borealis_ve_noautovec.tsv
./ramometer              10 1mi,2mi,4mi,8mi,16mi,32mi,64mi,128mi,256mi,512mi,1gi,2gi,4gi,8gi t > ramometer_borealis_host.tsv
