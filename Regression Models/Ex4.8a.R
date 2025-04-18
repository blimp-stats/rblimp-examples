library(fdir)
library(rblimp)

set()
load(file = 'data4.rda')

mymodel <- rblimp(
   data = data4,
   ordinal = 'd',
   nominal = 'm',
   fixed = 'm',
   center = 'x d',
   model = 'y ~ x m x*m d',
   simple = 'x | m',
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)
simple_plot(y ~ x | m.1, mymodel)

