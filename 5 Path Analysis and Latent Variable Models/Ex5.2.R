connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.2.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data4.rda')

mymodel <- rblimp(
   data = data4,
   ordinal = 'd',
   fixed = 'd',
   model = '
   mediation.model:
   m ~ x@alpha d x*d@alphamod;
   y ~ m@beta x d m*d@betamod;
   auxiliary.model:
   a1:a3 ~ y m x d',
   parameters = 'indirect.d0 = alpha * beta;
   indirect.d1 = ( alpha + alphamod ) * ( beta + betamod )',
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)


