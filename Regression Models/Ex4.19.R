library(fdir)
library(rblimp)

set()
load(file = 'data6.rda')

mymodel <- rblimp(
   data = data6,
   ordinal = 'y d1 d2',
   fixed = 'd1 x1',
   model = '
   focal.model:
   logit(y) ~ x1 x2 d1 d2;
   predictor.model:
   yjt(x2 - 16) ~ x1 d1; 
   d2 ~ x2 x1 d1',
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)


