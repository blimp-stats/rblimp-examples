library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.11.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(lavaan)
library(lavaan.mi)

mymodel <- rblimp(
  data = data,
  latent = 'latentx latenty',
  model = '
    structural.model:
    latentx@1;
    latenty@1;
    latentx ~~ latenty;
    measurement.models:
    latentx -> x1 x3;
    yjt(x2) ~ latentx;
    yjt(y1) ~ latenty;
    latenty -> y2 y3',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel)