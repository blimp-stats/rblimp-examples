library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.4.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'm',
   center = 'x',
   model = ' 
   mediation.model:
   m ~ x@alpha;
   y ~ m.latent@beta x;
   auxiliary.model:
   a1:a3 ~ y m.latent x',
   parameters = 'indirect = alpha * beta',
   seed = 90291,
   burn = 10000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
