library(fdir)
library(rblimp)

set()
load(file = 'data4.rda')

mymodel <- rblimp(
   data = data4,
   ordinal = 'd',
   fixed = 'x2 x3',
   model = '
   focal.model:
   y ~ d;
   propensity.model:
   logit(d) ~ x1 x2 x3 x4 x1*x2 x1*x3 x1*x4 x2*x3 x2*x4 x3*x4',
   seed = 90291,
   burn = 2000,
   iter = 10000,
   chains = 20,
   nimps = 20)
output(mymodel)


