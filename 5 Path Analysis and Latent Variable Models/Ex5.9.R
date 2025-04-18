library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.9.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'x1:x6 y1:y6',
   latent = 'latenty latentx',
   model = ' 
   latent.model:
   latentx ~~ latentx@1;
   latenty ~~ latenty@1;
   latentx ~~ latenty;
   measurement.model:
   latentx -> x1@xload_prior x2:x6;
   latenty -> y1@yload_prior y2:y6',
   parameters = 'xload_prior ~ truncate(0, Inf);
   yload_prior ~ truncate(0, Inf)',
   seed = 90291,
   burn = 50000,
   iter = 50000)

output(mymodel)


posterior_plot(mymodel)
