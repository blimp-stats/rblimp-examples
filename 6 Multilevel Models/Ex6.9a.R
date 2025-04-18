library(fdir)
library(rblimp)

set()
load(file = 'data8.rda')

mymodel <- rblimp(
   data = data8,
   clusterid = 'level2id',
   ordinal = 'd_j',
   randomeffect = 'beta0_j = y_i | 1 [level2id];
   beta1_j = y_i | x1_i [level2id]',
   fixed = 'd_j',
   center = 'groupmean = x1_i;
   grandmean = x2_i x3_j d_j',
   model = ' 
   focal.model:
   y_i ~ x1_i x2_i x3_j d_j | x1_i;
   distal.outcome:
   y2_j ~ beta0_j beta1_j x3_j',
   seed = 90291,
   burn = 10000,
   iter = 10000)
output(mymodel)


