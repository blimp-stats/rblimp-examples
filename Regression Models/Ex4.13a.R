library(fdir)
library(rblimp)

set()
load(file = 'data1.rda')

mymodel <- rblimp(
   data = data1,
   ordinal = 'y d',
   fixed = 'd',
   center = 'x1 x2',
   model = 'logit(y) ~ x1 x2 d',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


