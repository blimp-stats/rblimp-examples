library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.2.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'd',
  fixed = 'd',
  model = '
   mediation.model:
   m ~ x@alpha d x*d@alphadif;
   y ~ m@beta x d m*d@betadif;',
  parameters = '
     indirect_d0 = alpha * beta;
     indirect_d1 = ( alpha + alphadif ) * ( beta + betadif );
     indirect_dif = indirect_d1 - indirect_d0;',
  simple = 'x | d',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel,'indirect_d0')
posterior_plot(mymodel,'indirect_d1')
posterior_plot(mymodel,'indirect_dif')
posterior_plot(mymodel)
simple_plot(m ~ x | d, mymodel)
simple_plot(y ~ x | d, mymodel)
