connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.8.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'Ex4.8.RDS')

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


