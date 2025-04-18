connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.7.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data8.rda')

mymodel <- rblimp(
   data = data8,
   clusterid = 'level2id',
   ordinal = 'd_j',
   fixed = 'd_j',
   center = 'groupmean = x1_i;
   grandmean = x2_i x3_j d_j',
   model = 'y_i ~ x1_i x2_i x3_j d_j | x1_i',
   seed = 90291,
   burn = 5000,
   iter = 10000,
   options = 'hev')
output(mymodel)


