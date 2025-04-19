library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.1.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  model = '
   mediation.model:
   m ~ x@alpha;
   y ~ m@beta x;', 
  parameters = 'indirect = alpha * beta',
  seed = 90291,
  burn = 1000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel,'indirect')
posterior_plot(mymodel)
