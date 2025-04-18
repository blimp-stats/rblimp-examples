library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.15.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   latent = 'latentx latentm latenty',
   model = ' 
   structural.model:
   latenty ~ latentx@b1 latentm@b2 latentx*latentm@b3;
   latenty ~~ latenty@1;
   predictor.model:
   latentx ~~ latentx@1;
   latentm ~~ latentm@1;
   latentx ~~ latentm;
   measurement.models:
   latentx -> x1@xload_prior x2:x3;
   latentm -> m1@mload_prior m2:m3;
   latenty -> y1@yload_prior y2:y3',
   parameters = 'xload_prior ~ truncate(0, Inf);
   mload_prior ~ truncate(0, Inf);
   yload_prior ~ truncate(0, Inf);
   xslope_mlow = b1 - b3 * (-1);
   xslope_mmean = b1 * (0);
   xslope_mhigh = b1 + b3 * (-1)',
   seed = 90291,
   burn = 10000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
