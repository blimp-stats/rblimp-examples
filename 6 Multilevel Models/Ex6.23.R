library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.23.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   transform = 'ylag_i = lag1(y_i,
   time,
   level2id)',
   latent = 'level2id = xmean_j ymean_j ylagmean_j phi_j beta_j logvar_j',
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
   variance.model:
   logvar_j ~ 1 w1_j w2_j;
   var(y_i) ~ 1@logvar_j;
   lagged.models:
   ylagmean_j ~ 1;
   ylag_i ~ 1@ylagmean_j',
   parameters = 'xvar_prior ~ invgamma(1,
   .5)',
   seed = 90291,
   burn = 10000,
   iter = 10000)


posterior_plot(mymodel)
