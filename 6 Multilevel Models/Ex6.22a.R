library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.22.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   transform = 'ylag_i = lag1(y_i,
   time,
   level2id)',
   latent = 'level2id = xmean_j ymean_j ylagmean_j phi_j beta_j',
   model = '
   level2.models:
   1 -> xmean_j ymean_j phi_j beta_j;
   level1.models:
   x_i ~ 1@xmean_j (ylag_i - ymean_j);
   y_i ~ 1@ymean_j (ylag_i - ymean_j)@phi_j (x_i - xmean_j)@beta_j;
   lagged.models:
   ylagmean_j ~ 1;
   ylag_i ~ 1@ylagmean_j',
   seed = 90291,
   burn = 10000,
   iter = 10000)


posterior_plot(mymodel)
