library(fdir)
library(rblimp)

set()
load(file = 'data2.rda')

mymodel <- rblimp(
   data = data2,
   ordinal = 'd',
   fixed = 'x1',
   center = 'x1 x2',
   model = 'yjt(y - 9) ~ x1 x2 d',
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)


