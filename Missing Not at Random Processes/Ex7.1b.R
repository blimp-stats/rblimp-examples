library(fdir)
library(rblimp)

set()
load(file = 'data3.rda')

mymodel <- rblimp(
   data = data3,
   ordinal = 'd1 d2',
   fixed = 'd1 d2',
   center = 'x1',
   model = ' 
   y ~ d1 d2 x1;
   x2 x3 ~ y d1 d2 x1;
   y.missing ~ y d1',
   seed = 90291,
   burn = 2500,
   iter = 10000)
output(mymodel)


