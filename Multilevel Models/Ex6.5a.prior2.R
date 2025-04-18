library(fdir)
library(rblimp)

set()
load(file = 'data8.rda')

mymodel <- rblimp(
   data = data8,
   clusterid = 'level2id',
   center = 'groupmean = x1_i;
   grandmean = x2_i',
   model = 'y_i ~ x1_i x2_i | x1_i',
   seed = 90291,
   burn = 10000,
   iter = 10000,
   options = 'prior2')
output(mymodel)


