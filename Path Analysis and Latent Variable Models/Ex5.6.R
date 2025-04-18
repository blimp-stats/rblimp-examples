library(fdir)
library(rblimp)

set()
load(file = 'data22.rda')

mymodel <- rblimp(
   data = data22,
   transform = 'y = missing(ycnt == 0, ycnt);
   ybin = ifelse(ycnt == 0, 0, 1)',
   ordinal = 'x ybin',
   count = 'y',
   model = ' 
   mediation.model:
   m ~ 1@m_icept x@alpha;
   y ~ 1@y_icept m@beta x@tau;
   binary.model:
   ybin ~ x m',
   parameters = 'x0 = 0;
   x1 = 1;
   ab_at_x0 = alpha * (beta*exp(y_icept + beta*m_icept + tau*x0)); 
   ab_at_x1 = alpha * (beta*exp(y_icept + beta*m_icept + tau*x1))',
   seed = 90291,
   burn = 5000,
   iter = 10000)
output(mymodel)
