library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.3.RDS', 'rb')
data <- readRDS(connect); close(connect)

# probit outcome model with causally-defined indirect effects
mymodel1 <- rblimp(
  data = data,
  ordinal = 'y x',
  model = '
   mediation.model:
   m ~ 1@m_icept x@alpha;
   m@m_resvar;
   y ~ 1@y_icept m@beta x@tau;',
  parameters = '
   den = sqrt(beta^2*m_resvar + 1);
   # Model-implied marginal probabilities at X=0 and X=1
   p_x0 = phi( ( y_icept + beta*(m_icept + alpha*0) + tau*0 ) / den );
   p_x1 = phi( ( y_icept + beta*(m_icept + alpha*1) + tau*1 ) / den );
   # Natural Indirect Effect: P(Y=1 | X=1, M_{X=1}) - P(Y=1 | X=1, M_{X=0})
   nie = phi( ( y_icept + beta*(m_icept + alpha*1) + tau*1 ) / den )
     - phi( ( y_icept + beta*(m_icept + alpha*0) + tau*1 ) / den );
   # Natural Direct Effect: P(Y=1 | X=1, M_{X=0}) - P(Y=1 | X=0, M_{X=0})
   nde = phi( ( y_icept + beta*(m_icept + alpha*0) + tau*1 ) / den )
     - phi( ( y_icept + beta*(m_icept + alpha*0) + tau*0 ) / den );
   # Total Effect = P(Y=1|X=1) - P(Y=1|X=0) = NIE + NDE
   te  = p_x1 - p_x0;',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel1)
posterior_plot(mymodel1,'nie')
posterior_plot(mymodel1,'nde')
posterior_plot(mymodel1,'te')

# logistic outcome model with derivative-based (conditional) indirect effects 
mymodel2 <- rblimp(
  data = data,
  ordinal = 'y x',
  model = '
   m ~ 1@m_icept x@alpha;
   logit(y) ~ 1@y_icept m@beta x@tau;',
  parameters = '
   # conditional indirect effect at X = 0
   ab_x0 = alpha * ( beta * exp( y_icept + beta*(m_icept + alpha*0) + tau*0 ) ) /
     ( 1 + exp( y_icept + beta*(m_icept + alpha*0) + tau*0 ) )^2;
   # conditional indirect effect at X = 1
   ab_x1 = alpha * ( beta * exp( y_icept + beta*(m_icept + alpha*1) + tau*1 ) ) /
    ( 1 + exp( y_icept + beta*(m_icept + alpha*1) + tau*1 ) )^2;
   # contrast
   ab_diff = ab_x1 - ab_x0;',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel2)
posterior_plot(mymodel2,'ab_x0')
posterior_plot(mymodel2,'ab_x1')
posterior_plot(mymodel2,'ab_diff')
posterior_plot(mymodel2)
