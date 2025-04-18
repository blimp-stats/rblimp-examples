library(fdir)
library(rblimp)

set()
load(file = 'data8.rda')

mymodel <- rblimp(
   data = data8,
   clusterid = 'level2id',
   center = 'groupmean = x_i;
   grandmean = x_i.mean',
   model = 'y_i ~ x_i@beta_w x_i.mean@beta_b | x_i',
   parameters = 'contextual = beta_b - beta_w',
   seed = 90291,
   burn = 5000,
   iter = 10000)
output(mymodel)


