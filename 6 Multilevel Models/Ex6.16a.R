library(fdir)
library(rblimp)

set()
load(file = 'data10.rda')

mymodel <- rblimp(
   data = data10,
   nominal = 'd_k',
   clusterid = 'level2id level3id',
   fixed = 'time_i d_k',
   model = 'y_i ~ time_i d_k time_i*d_k | time_i',
   simple = 'time_i | d_k',
   seed = 90291,
   burn = 15000,
   iter = 10000)
output(mymodel)


