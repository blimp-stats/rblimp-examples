library(fdir)
library(rblimp)

set()
load(file = 'data1.rda')

mymodel <- rblimp(
   data = data1,
   model = '
   x1 y1 y2 ~~ x1 y1 y2',
   seed = 90291,
   burn = 10000,
   iter = 10000,
   options = 'use_phantom')
output(mymodel)


