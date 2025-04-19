library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.20.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   latent = 'level2id = beta0_j',
   model = '
   beta0_j ~ 1@0;
   y_i ~ d_j d_j@beta0_j | 1@0',
   seed = 90291,
   burn = 1000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
