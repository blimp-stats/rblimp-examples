library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.5.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
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
posterior_plot(mymodel,'ab_at_x0')
posterior_plot(mymodel,'ab_at_x1')
posterior_plot(mymodel)
