library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.3.RDS', 'rb')
data <- readRDS(connect); close(connect)

# probit outcome model
mymodel1 <- rblimp(
  data = data,
  ordinal = 'y',
  center = 'x',
  model = '
   mediation.model:
   m ~ 1@m_icept x@alpha;
   m ~~ m@m_resvar;
   y ~ 1@y_icept m@beta x@tau;',
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
  iter = 10000)

output(mymodel1)
posterior_plot(mymodel1,'ab_xval1')
posterior_plot(mymodel1,'ab_xval2')
posterior_plot(mymodel1,'ab_xval3')
posterior_plot(mymodel1)

# logistic outcome model
mymodel2 <- rblimp(
  data = data,
  ordinal = 'y',
  center = 'x',
  model = '
   m ~ 1@m_icept x@alpha;
   logit(y) ~ 1@y_icept m@beta x@tau;',
  parameters = '
   xvalue1 = -.50;
   xvalue2 = 0;
   xvalue3 = .50;
   # derivative-based (instantaneous) indirect effect at each x:
   # CIE(x) = alpha * [ beta * exp(eta(x)) / (1 + exp(eta(x)))^2 ]
   # where eta(x) = y_icept + beta*(m_icept + alpha*x) + tau*x
   ab_xval1 = alpha * ( beta * exp( y_icept + 
      beta*(m_icept + alpha*xvalue1) + tau*xvalue1 ) ) /
      ( 1 + exp( y_icept + beta*(m_icept + alpha*xvalue1) + tau*xvalue1 ) )^2;
   ab_xval2 = alpha * ( beta * exp( y_icept + 
      beta*(m_icept + alpha*xvalue2) + tau*xvalue2 ) ) /
      ( 1 + exp( y_icept + beta*(m_icept + alpha*xvalue2) + tau*xvalue2 ) )^2;
   ab_xval3 = alpha * ( beta * exp( y_icept + 
      beta*(m_icept + alpha*xvalue3) + tau*xvalue3 ) ) /
      ( 1 + exp( y_icept + beta*(m_icept + alpha*xvalue3) + tau*xvalue3 ) )^2',
  seed = 90291,
  burn = 1000,
  iter = 10000)

output(mymodel2)
posterior_plot(mymodel2,'ab_xval1')
posterior_plot(mymodel2,'ab_xval2')
posterior_plot(mymodel2,'ab_xval3')
posterior_plot(mymodel2)
