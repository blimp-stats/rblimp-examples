library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.5.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'y1mis y2mis y3mis y4mis y5mis y6mis',
  transform = 'y1mis = ismissing(y1);
   y2mis = ismissing(y2);
   y3mis = ismissing(y3);
   y4mis = ismissing(y4);
   y5mis = ismissing(y5);
   y6mis = ismissing(y6)',
  latent = 'latenty latentx',
  model = ' 
   latent.model:
   latentx ~~ latentx@1;
   latenty ~~ latenty@1;
   latentx ~~ latenty;
   measurement.models:
   latentx -> x1@xload_prior x2:x6;
   latenty -> y1@yload_prior y2:y6;
   missingness.model:
   y1mis ~ latenty@misconstraint;
   y2mis ~ latenty@misconstraint;
   y3mis ~ latenty@misconstraint;
   y4mis ~ latenty@misconstraint;
   y5mis ~ latenty@misconstraint;
   y6mis ~ latenty@misconstraint',
  parameters = 'xload_prior ~ truncate(0,
   Inf);
   yload_prior ~ truncate(0,
   Inf)',
  seed = 90291,
  burn = 20000,
  iter = 20000)

output(mymodel)
posterior_plot(mymodel)
