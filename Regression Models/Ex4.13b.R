library(fdir)
library(rblimp)

set()
load(file = 'data1.rda')

mymodel <- rblimp(
   data = data1,
   ordinal = 'y d',
   fixed = 'd',
   center = 'x1 x2',
   model = 'logit(y) ~ 1@b0 x1 x2 d@b3',
   parameters = 'pp_d0 = exp(b0) / (1 + exp(b0));
   pp_d1 = exp(b0 + b3) / (1 + exp(b0 + b3));
   pp_diff = pp_d1 - pp_d0',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


