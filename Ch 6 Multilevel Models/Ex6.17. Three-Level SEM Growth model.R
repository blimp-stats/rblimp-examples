library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.17.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  nominal = 'd_k',
  clusterid = 'level2id level3id',
  latent = 'level2id = beta0_j beta1_j;
   level3id = beta0_k beta1_k',
  model = ' 
   level3.model:
   beta0_k ~ 1 d_k;
   beta1_k ~ 1 d_k;
   beta0_k ~~ beta1_k;
   level2.model:
   beta0_j ~ 1@beta0_k;
   beta1_j ~ 1@beta1_k;
   beta0_j ~~ beta1_j;
   level1.model:
   y_i ~ 1@beta0_j time_i@beta1_j',
  seed = 90291,
  burn = 30000,
  iter = 30000)

output(mymodel)
posterior_plot(mymodel)
