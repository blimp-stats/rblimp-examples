connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.1.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data3.rda')

mymodel <- rblimp(
   data = data3,
   ordinal = 'd1 d2',
   fixed = 'd1 d2',
   center = 'x1',
   model = ' 
   focal.model:
   y ~ d1 d2 x1;
   missingness.model:
   y.missing ~ y;
   auxiliary.model:
   x2 x3 ~ y d1 d2 x1',
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)


