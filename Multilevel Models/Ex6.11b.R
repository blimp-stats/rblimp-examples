library(fdir)
library(rblimp)

set()
load(file = 'data1.rda')

mymodel <- rblimp(
   data = data1,
   clusterid = 'level2id',
   latent = 'level2id = beta0_j beta1_j',
   center = 'groupmean = x_i;
   grandmean = m_j',
   model = ' 
   level2.model:
   beta0_j ~ 1 m_j;
   beta1_j ~ 1 m_j;
   beta0_j ~~ beta1_j;
   level1.model:
   y_i ~ 1@beta0_j x_i@beta1_j',
   seed = 90291,
   burn = 10000,
   iter = 10000)
output(mymodel)


