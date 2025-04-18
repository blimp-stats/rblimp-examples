connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.15.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data9.rda')

mymodel <- rblimp(
   data = data9,
   clusterid = 'level2id',
   nominal = 'd_j',
   fixed = 'time_i d_j',
   model = 'y_i ~ time_i d_j time_i*d_j | time_i',
   simple = 'time_i | d_j',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


