library(fdir)
library(rblimp)

set()
load(file = 'data4.rda')

mymodel <- rblimp(
   data = data4,
   ordinal = 'y1:y5 x1:x7 d1 d2',
   model = '
   focal.model:
   xscale = x1:+:x7;
   yscale ~  xscale d1 d2;
   predictor.model:
   x1:x7 d1 d2 ~ 1; 
   auxiliary.models:
   y1:y5 ~ yscale',
   seed = 90291,
   burn = 20000,
   iter = 10000)
output(mymodel)


