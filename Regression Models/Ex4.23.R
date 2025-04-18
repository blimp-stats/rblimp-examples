library(fdir)
library(rblimp)

set()
load(file = 'data1.rda')

mymodel <- rblimp(
   data = data1,
   ordinal = 'd',
   fixed = 'd',
   center = 'x1 x2',
   model = 'y ~ x1@b1 x2@b2 d@b3',
   waldtest = list('b1:b3 = 0', 'b1:b2 = 0', 'b1 = b2'),
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)


