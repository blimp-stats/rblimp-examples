connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.13.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data4.rda')

mymodel <- rblimp(
   data = data4,
   ordinal = 'd y1:y6 m1:m7',
   fixed = 'd',
   latent = 'latenty latentm',
   model = ' 
   structural.model:
   latentm ~ x d x*d;
   latenty ~ latentm x d latentm*d;
   latentm ~~ latentm@1;
   latenty ~~ latenty@1;
   measurement.models:
   latentm -> m1@xload_prior m2:m6;
   latenty -> y1@yload_prior y2:y6',
   parameters = 'xload_prior ~ truncate(0, Inf);
   yload_prior ~ truncate(0, Inf)',
   seed = 90291,
   burn = 50000,
   iter = 50000)
output(mymodel)


