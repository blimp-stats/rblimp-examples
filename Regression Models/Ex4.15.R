library(fdir)
library(rblimp)

set()
load(file = 'data22.rda')

mymodel <- rblimp(
   data = data22,
   ordinal = 'd1 d2',
   count = 'y',
   fixed = 'd1 x1',
   center = 'x1 x2',
   model = 'y ~ d1 d2 x1 x2',
   seed = 90291,
   burn = 5000,
   iter = 10000)
output(mymodel)


