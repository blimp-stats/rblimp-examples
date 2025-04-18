connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.3.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data1.rda')

mymodel <- rblimp(
   data = data1,
   ordinal = 'd',
   fixed = 'd',
   center = 'x1 x2',
   model = 'y ~ x1 x2 d',
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)
