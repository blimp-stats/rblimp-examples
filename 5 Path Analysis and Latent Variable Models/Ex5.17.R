library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.17.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   ordinal = 'd',
   fixed = 'd',
   latent = 'icept slope',
   model = '
   structural.model:
   icept ~ 1 d;
   slope ~ 1 d;
   icept ~~ slope;
   measurement.model:
   y0 ~ 1@0 icept@1 slope@0;
   y1 ~ 1@0 icept@1 slope@1;
   y3 ~ 1@0 icept@1 slope@3;
   y6 ~ 1@0 icept@1 slope@6;
   y0 ~~ y0@resvar;
   y1 ~~ y1@resvar;
   y3 ~~ y3@resvar;
   y6 ~~ y6@resvar',
   seed = 90291,
   burn = 10000,
   iter = 10000)

output(mymodel)


posterior_plot(mymodel)
