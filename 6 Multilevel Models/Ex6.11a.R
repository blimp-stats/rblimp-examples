library(fdir)
library(rblimp)

set()
load(file = 'data1.rda')

mymodel <- rblimp(
   data = data1,
   clusterid = 'level2id',
   center = 'groupmean = x_i;
   grandmean = m_j',
   model = 'y_i ~ x_i m_j x_i*m_j | x_i',
   simple = 'x_i | m_j',
   seed = 90291,
   burn = 10000,
   iter = 10000)
output(mymodel)


