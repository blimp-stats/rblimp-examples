library(fdir)
library(rblimp)

set()
load(file = 'data8.rda')

mymodel <- rblimp(
   data = data8,
   clusterid = 'level2id',
   latent = 'level2id = beta0_j beta1_j',
   center = 'groupmean = x1_i;
   grandmean = x2_i',
   model = '
   beta1_j ~ 1;
   beta0_j ~~ beta1_j;
   focal.model:
   y_i ~ 1@beta0_j x1_i@beta1_j x2_i',
   seed = 90291,
   burn = 10000,
   iter = 10000,
   options = 'use_phantom')
output(mymodel)


