library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.1.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  model = '
    m ~ x@alpha;
    y ~ m@beta x;',
  parameters = 'indirect = alpha * beta',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel,'indirect')
posterior_plot(mymodel)


# Specify with prior on indirect effect
mymodelb <- rblimp(
  data = data,
  model = '
   m ~ x@alpha%1;
   y ~ x (m / alpha)@indirect;', 
  parameters = '
  indirect ~ normal(0, 10); # Informative Prior on Indirect effect
  alpha ~ normal(0, Inf);   # Uniformative Prior on A path',
  seed = 90291,
  burn = 20000,
  iter = 20000)

output(mymodelb)
posterior_plot(mymodelb,'indirect')
posterior_plot(mymodelb)
