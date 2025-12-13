library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/MCNEISH_HAMAKER_2020.RDS', 'rb')
data <- readRDS(connect); close(connect)

# equation 4c
mymodel1 <- rblimp(
   data = data,
   clusterid = 'level2id',
   timeid = 'time',
   latent = 'level2id = xmean_j ymean_j phi_j beta_j',
   model = '
   level2.models:
   1 -> xmean_j ymean_j phi_j beta_j;
   level1.models:
   x_i ~ 1@xmean_j;
   y_i ~ 1@ymean_j (y_i.lag - ymean_j)@phi_j (x_i - xmean_j)@beta_j;',
   seed = 90291,
   burn = 20000,
   iter = 20000)

output(mymodel1)

# equation 5
mymodel2 <- rblimp(
  data = data,
  clusterid = 'level2id',
  timeid = 'time',
  latent = 'level2id = xmean_j ymean_j phi_j beta_j',
  model = '
   level2.models:
   xmean_j ~ 1;
   ymean_j ~ w1_j w2_j xmean_j;
   phi_j ~ w1_j w2_j; 
   beta_j ~ w1_j w2_j;
   level1.models:
   x_i ~ 1@xmean_j;
   y_i ~ 1@ymean_j (y_i.lag - ymean_j)@phi_j (x_i - xmean_j)@beta_j;',
  seed = 90291,
  burn = 20000,
  iter = 20000)

output(mymodel2)

# equation 6
mymodel3 <- rblimp(
  data = data,
  clusterid = 'level2id',
  timeid = 'time',
  latent = 'level2id = xmean_j ymean_j phi_j beta_j logvar_j',
  model = '
   level2.models:
   xmean_j ~ 1;
   ymean_j ~ w1_j w2_j xmean_j;
   phi_j ~ w1_j w2_j; 
   beta_j ~ w1_j w2_j;
   level1.models:
   x_i ~ 1@xmean_j;
   y_i ~ 1@ymean_j (y_i.lag - ymean_j)@phi_j (x_i - xmean_j)@beta_j;
   variance.model:
   logvar_j ~ 1 w1_j w2_j;
   var(y_i) ~ 1@logvar_j;',
  seed = 90291,
  burn = 20000,
  iter = 20000)

output(mymodel3)
