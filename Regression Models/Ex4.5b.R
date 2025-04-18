library(fdir)
library(rblimp)

set()
load(file = 'data2.rda')

mymodel <- rblimp(
   data = data2,
   ordinal = 'd',
   nominal = 'n',
   fixed = 'x',
   center = 'x',
   model = 'y ~ x d n.2 n.3 n.4',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


