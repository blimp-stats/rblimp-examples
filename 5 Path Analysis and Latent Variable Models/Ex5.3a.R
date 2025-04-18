connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.3.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data20.rda')

mymodel <- rblimp(
   data = data20,
   ordinal = 'y',
   center = 'x',
   model = '
   mediation.model:
   m ~ 1@m_icept x@alpha;
   m ~~ m@m_resvar;
   y ~ 1@y_icept m@beta x@tau;
   auxiliary.model:
   a1:a3 ~ y m x',
   parameters = 'xvalue1 = -.50;
   xvalue2 = 0;
   xvalue3 = .50;
   ab_xval1 = phi((y_icept + beta*m_icept + 
      beta*alpha*xvalue1 + tau*xvalue1)/
      sqrt(beta^2*m_resvar + 1));
   ab_xval2 = phi((y_icept + beta*m_icept +  
      beta*alpha*xvalue2 + tau*xvalue2)/
      sqrt(beta^2*m_resvar + 1));
   ab_xval3 = phi((y_icept + beta*m_icept +  
      beta*alpha*xvalue3 + tau*xvalue3)/
      sqrt(beta^2*m_resvar + 1))',
   seed = 90291,
   burn = 1000,
   iter = 10000,
   output = 'default wald pvalue')


