connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.5.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data22.rda')

mymodel <- rblimp(
   data = data22,
   ordinal = 'x',
   count = 'y',
   model = ' 
   m ~ 1@m_icept x@alpha; 
   y ~ 1@y_icept m@beta x@tau',
   parameters = 'x0 = 0; 
   x1 = 1; 
   ab_at_x0 = alpha * (beta*exp(y_icept + beta*m_icept + tau*x0)); 
   ab_at_x1 = alpha * (beta*exp(y_icept + beta*m_icept + tau*x1))',
   seed = 90291,
   burn = 5000,
   iter = 10000)
output(mymodel)


