library(fdir)
library(rblimp)

set()
load(file = 'data1.rda')

mymodel <- rblimp(
   data = data1,
   ordinal = 'y d',
   fixed = 'd',
   center = 'x1 x2',
   model = 'y ~ x1 x2 d',
   seed = 90291,
   burn = 20000,
   iter = 10000)
output(mymodel)


