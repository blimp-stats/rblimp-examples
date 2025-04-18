connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.14.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data4.rda')

mymodel <- rblimp(
   data = data4,
   nominal = 'y',
   fixed = 'x2 x3',
   center = 'x1 x2 x3',
   model = 'logit(y) ~ x1 x2 x3',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


