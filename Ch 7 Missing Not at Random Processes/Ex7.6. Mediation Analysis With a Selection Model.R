library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.6.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
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
posterior_plot(mymodel)
