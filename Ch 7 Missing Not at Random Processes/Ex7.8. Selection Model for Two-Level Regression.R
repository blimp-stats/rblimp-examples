library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.8.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  clusterid = 'level2id',
  ordinal = 'd_j ymis_i;',
  transform = 'ymis_i = ismissing(y_i)',
  fixed = 'd_j',
  center = 'groupmean = x1_i;
   grandmean = x2_i x3_j d_j',
  model = ' 
   focal.model:
   y_i ~ x1_i x2_i x3_j d_j | x1_i;
   missingness.model:
   ymis_i ~ y_i x1_i',
  seed = 90291,
  burn = 10000,
  iter = 20000)

output(mymodel)
posterior_plot(mymodel)
