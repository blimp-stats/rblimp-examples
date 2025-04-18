connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.5.RDS', 'rb')
data <- readRDS(connect); close(connect)

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
   model = 'y ~ x d n',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


