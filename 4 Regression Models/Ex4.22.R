library(fdir)
library(rblimp)

set()
load(file = 'data21.rda')

mymodel <- rblimp(
   data = data21,
   weights = 'wght',
   model = 'y ~ x1 x2 x3',
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)


