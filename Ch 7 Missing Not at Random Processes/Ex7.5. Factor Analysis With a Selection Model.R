library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.5.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'm1:m6',
  transform = '
    m1 = ismissing(y1);
    m2 = ismissing(y2);
    m3 = ismissing(y3);
    m4 = ismissing(y4);
    m5 = ismissing(y5);
    m6 = ismissing(y6);',
  latent = 'latenty latentx',
  model = '
    latent.model:
    latentx@1;
    latenty@1;
    latentx ~~ latenty;
    measurement.models:
    latentx -> x1@xload_prior x2:x6;
    latenty -> y1@yload_prior y2:y6;
    missingness.model:
    m1 ~ latenty@misconstraint;
    m2 ~ latenty@misconstraint;
    m3 ~ latenty@misconstraint;
    m4 ~ latenty@misconstraint;
    m5 ~ latenty@misconstraint;
    m6 ~ latenty@misconstraint',
  parameters = '
    xload_prior ~ truncate(0,Inf);
    yload_prior ~ truncate(0,Inf)',
  seed = 90291,
  burn = 20000,
  iter = 20000
)

output(mymodel)
posterior_plot(mymodel)
