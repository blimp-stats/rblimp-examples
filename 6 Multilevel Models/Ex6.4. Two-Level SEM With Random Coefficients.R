library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.4.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   ordinal = 'd_j',
   latent = 'level2id = beta0_j beta1_j',
   fixed = 'd_j',
   center = '
    groupmean = x1_i;
    grandmean = x2_i x3_j d_j',
   model = '
    level2.model:
    beta0_j ~ 1 x3_j d_j;
    beta1_j ~ 1;
    beta0_j ~~ beta1_j;
    level1.model:
    y_i ~ 1@beta0_j x1_i@beta1_j x2_i',
   seed = 90291,
   burn = 5000,
   iter = 10000)

output(mymodel)
posterior_plot(mymodel)
