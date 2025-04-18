library(fdir)
library(rblimp)

set()
load(file = 'data4a.rda')

mymodel <- rblimp(
   data = data4a,
   ordinal = 'x1:x7 d1 d2',
   model = '
   focal.model:
   xscale = x1:+:x7; 
   y ~  xscale d1 d2; 
   predictor.model:
   x1:x7 d1 d2 ~ 1', 
   seed = 90291,
   burn = 5000,
   iter = 10000)
output(mymodel)
