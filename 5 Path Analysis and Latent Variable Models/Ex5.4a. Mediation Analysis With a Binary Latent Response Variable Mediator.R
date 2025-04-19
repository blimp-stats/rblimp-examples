library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.4.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'm',
  center = 'x',
  model = ' 
   m ~ x@alpha;
   y ~ m.latent@beta x;',
  parameters = 'indirect = alpha * beta',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel,'indirect')
posterior_plot(mymodel)
