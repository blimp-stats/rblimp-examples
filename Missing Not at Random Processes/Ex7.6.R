library(fdir)
library(rblimp)

set()
load(file = 'data4.rda')

mymodel <- rblimp(
   data = data4,
   transform = 'm.mis = ismissing(m);
   y.mis = ismissing(y)',
   model = ' 
   mediation.model:
   m ~ x@alpha;
   y ~ m@beta x;
   missingness.model:
   m.mis ~ m x;
   y.mis ~ y m x;
   auxiliary.model:
   a1:a3 ~ y m x',
   parameters = 'indirect = alpha * beta',
   seed = 90291,
   burn = 2000,
   iter = 10000)
output(mymodel)


