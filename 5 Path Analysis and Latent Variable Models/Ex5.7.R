library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.7.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   latent = 'latenty latentx',
   model = ' 
   latent.model:
   latentx ~~ latentx@1;
   latenty ~~ latenty@1;
   latentx ~~ latenty;
   measurement.models:
   latentx -> x1@xload_prior x2:x6;
   latenty -> y1@yload_prior y2:y6',
   parameters = 'xload_prior ~ truncate(0,
   Inf);
   yload_prior ~ truncate(0,
   Inf)',
   seed = 90291,
   burn = 10000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
