connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.1.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data7.rda')

mymodel <- rblimp(
   data = data7,
   clusterid = 'level2id',
   ordinal = 'd1_i d2_j',
   fixed = 'x2_i d2_j',
   center = 'grandmean = x1_i x2_i d1_i x3_j',
   model = ' y_i ~ x1_i x2_i d1_i x3_j d2_j',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


