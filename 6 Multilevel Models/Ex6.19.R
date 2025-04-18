connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.19.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data21.rda')

mymodel <- rblimp(
   data = data21,
   clusterid = 'level2id',
   weights = 'level1wgt level2wgt',
   model = 'y_i ~ x1_i x2_i x3_i',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


