library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.9.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  clusterid = 'level2id',
  timeid = 'time_i',
  dropout = 'dropout_i = y_i',
  latent = 'level2id = beta0_j beta1_j',
  model = '
   beta0_j ~~ beta1_j;
   growth.model:
   y_i ~ 1@beta0_j time_i@beta1_j;
   missingness.model:
   dropout_i ~ 1@-3 (time_i == 1) (time_i == 2) 
      (time_i == 3) (time_i == 4) (time_i == 5)
      (time_i > 0)*y_i (time_i > 0)*y_i.lag | 1@0',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel)