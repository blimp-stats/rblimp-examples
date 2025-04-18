library(fdir)
library(rblimp)

set()

load(file = 'mcneish_hamaker_2020.rda')

mymodel <- rblimp(
   data = mcneish_hamaker_2020,
   clusterid = 'level2id',
   transform = 'ylag_i = lag1(y_i,
   time,
   level2id)',
   latent = 'level2id = xmean_j ymean_j ylagmean_j phi_j beta_j',
   fixed = 'w1_j w2_j',
   center = 'grandmean = w1_j w2_j',
   model = '
   level2.models:
   xmean_j ~ 1;
   xmean_j ~~ xmean_j@xvar_prior;
   { phi_j beta_j } ~ 1 w1_j w2_j;
   ymean_j ~ 1 w1_j w2_j xmean_j;
   level1.models:
   x_i ~ 1@xmean_j (ylag_i - ymean_j);
   y_i ~ 1@ymean_j (ylag_i - ymean_j)@phi_j (x_i - xmean_j)@beta_j;
   lagged.models:
   ylagmean_j ~ 1;
   ylag_i ~ 1@ylagmean_j',
   parameters = 'xvar_prior ~ invgamma(1,
   .5)',
   seed = 90291,
   burn = 10000,
   iter = 10000)


