library(rblimp)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   ordinal = 'd_j',
   latent = 'level2id = beta0_j beta1_j',
   fixed = 'd_j',
   center = 'groupmean = x1_i;
   grandmean = x2_i x3_j d_j',
   model = '
   level2.model:
   beta0_j ~ 1 x3_j d_j;
   beta1_j ~ 1;
   beta0_j ~~ beta1_j;
   level1.model:
   y_i ~ 1@beta0_j x1_i@beta1_j x2_i;
   distal.outcome:
   y2_j ~ beta0_j beta1_j x3_j',
   seed = 90291,
   burn = 10000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
