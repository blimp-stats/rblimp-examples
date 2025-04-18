library(fdir)
library(rblimp)

set()
load(file = 'data4.rda')

mymodel <- rblimp(
   data = data4,
   model = '
   mediation.model:
   m ~ x@alpha;
   y ~ m@beta x;
   auxiliary.model:
   a1:a3 ~ y m x', 
   parameters = 'indirect = alpha * beta',
   seed = 90291,
   burn = 1000,
   iter = 10000)
output(mymodel)


