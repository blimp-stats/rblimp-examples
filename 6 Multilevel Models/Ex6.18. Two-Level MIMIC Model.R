library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.18.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  clusterid = 'level2id',
  latent = 'laty_lev1;
   level2id = laty_lev2',
  center = 'grandmean = x1_i x2_i x3_j',
  model = '
   structural.model:
   laty_lev1 ~ x1_i x2_i;
   laty_lev2 ~ x3_j;
   measurement.model:
   y1_i ~ laty_lev1@1 laty_lev2@1;
   y2_i ~ laty_lev1 laty_lev2;
   y3_i ~ laty_lev1 laty_lev2;
   y4_i ~ laty_lev1 laty_lev2',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel)
