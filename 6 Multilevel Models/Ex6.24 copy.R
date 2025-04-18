connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.24.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()

load(file = 'mcneish_hamaker_2020.rda')

mymodel <- rblimp(
   data = mcneish_hamaker_2020,
   clusterid = 'level2id',
   transform = 'ylag_i = lag1(y_i,
   time,
   level2id);
   xlag_i = lag1(x_i,
   time,
   level2id)',
   latent = 'level2id = xmean_j xlagmean_j ymean_j ylagmean_j 
      phi1_j phi2_j phi3_j phi4_j yvarlog_j xvarlog_j',
   model = '
   level2.models:
   1 -> xmean_j xlagmean_j ymean_j ylagmean_j phi1_j phi2_j phi3_j phi4_j;
   xmean_j ~~ xmean_j@xvar_prior;
   level1.models:
   y_i ~ 1@ymean_j (ylag_i - ymean_j)@phi1_j (xlag_i - xmean_j)@phi4_j;
   x_i ~ 1@xmean_j (xlag_i - xmean_j)@phi2_j (ylag_i - ymean_j)@phi3_j;
   variance.model:
   1 -> xvarlog_j yvarlog_j;
   var(y_i) ~ 1@yvarlog_j;
   var(x_i) ~ 1@xvarlog_j;
   lagged.models:
   1 -> xlagmean_j ylagmean_j;
   xlagmean_j ~~ xlagmean_j@xvar_prior;
   ylag_i ~ 1@ylagmean_j;
   xlag_i ~ 1@xlagmean_j',
   parameters = 'xvar_prior ~ invgamma(1,
   .5)',
   seed = 90291,
   burn = 10000,
   iter = 20000)
output(mymodel)


