library(fdir)
library(rblimp)

set()
load(file = 'data26.rda')

mymodel <- rblimp(
   data = data26,
   ordinal = 'y_i',
   clusterid = 'level2id',
   fixed = 'time_i',
   center = 'grandmean = x_j',
   model = '
   logit(y_i) ~ 1@0 (time_i==1)@alpha1 (time_i==2)@alpha2 (time_i==3)@alpha3
      (time_i==4)@alpha4 (time_i==5)@alpha5 (time_i==6)@alpha6 d_j x_j | 1@0',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


