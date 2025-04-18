connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.14.RDS', 'rb')
data <- readRDS(connect); close(connect)

library(fdir)
library(rblimp)

set()
load(file = 'data4.rda')

mymodel <- rblimp(
   data = data4,
   ordinal = 'g',
   fixed = 'g',
   latent = 'latenty',
   model = ' 
   structural.model:
   latenty ~ 1@0 g;
   var(latenty) ~ 1@0 g;
   measurement.model:
   y1 ~ 1 latenty@load_prior;
   y2 ~ g@difficept1 latenty g*latenty@diffload1;
   y3 ~ g@difficept2 latenty g*latenty@diffload2;
   y4 ~ g@difficept3 latenty g*latenty@diffload3;
   y5 ~ g@difficept4 latenty g*latenty@diffload4;
   y6 ~ g@difficept5 latenty g*latenty@diffload5',
   waldtest = list('diffload1:diffload5 = 0','difficept1:difficept5 = 0'),
   parameters = 'load_prior ~ truncate(0, Inf)',
   simple = 'latenty | g',
   seed = 90291,
   burn = 20000,
   iter = 10000)
output(mymodel)

