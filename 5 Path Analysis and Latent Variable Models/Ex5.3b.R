library(rblimp)

mymodel <- rblimp(
   data = data,
   ordinal = 'y',
   center = 'x',
   model = '
   mediation.model:
   m ~ 1@m_icept x@alpha;
   logit(y) ~ 1@y_icept m@beta x@tau;
   auxiliary.model:
   a1:a3 ~ y m x',
   parameters = 'xvalue1 = -.50;
   xvalue2 = 0;
   xvalue3 = .50;
   ab_xval1 = alpha * (beta*exp(y_icept + beta*m_icept + tau*xvalue1)) / (1 + exp(y_icept + beta*m_icept + tau*xvalue1))^2;
   ab_xval2 = alpha * (beta*exp(y_icept + beta*m_icept + tau*xvalue2)) / (1 + exp(y_icept + beta*m_icept + tau*xvalue2))^2;
   ab_xval3 = alpha * (beta*exp(y_icept + beta*m_icept + tau*xvalue3)) / (1 + exp(y_icept + beta*m_icept + tau*xvalue3))^2',
   seed = 90291,
   burn = 1000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
