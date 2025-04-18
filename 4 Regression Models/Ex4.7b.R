library(fdir)
library(rblimp)

set()
load(file = 'data3.rda')

mymodel <- rblimp(
   data = data3,
   ordinal = 'd a3',
   fixed = 'd',
   center = 'x',
   model = ' 
   focal.model:
   y ~ x d;
   auxiliary.model:
   a3 a2 a1 ~ y x d',
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)


