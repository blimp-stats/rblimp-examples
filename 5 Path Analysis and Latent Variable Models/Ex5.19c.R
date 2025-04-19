library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.19.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  latent = 'RIx RIy',
  ordinal = 'z1',
  model = ' 
   x1r = x1 - RIx;
   x2r = x2 - RIx;
   x3r = x3 - RIx;
   x4r = x4 - RIx;
   y1r = y1 - RIy;
   y2r = y2 - RIy;
   y3r = y3 - RIy;
   y4r = y4 - RIy;
   random.intercept:
   RIx ~ z1;
   RIy ~ z1;
   RIx ~~ RIy;
   x.models:
   x1 ~ RIx@1;
   x2 ~ x1r y1r RIx@1;
   x3 ~ x2r y2r RIx@1;
   x4 ~ x3r y3r RIx@1;
   x5 ~ x4r y4r RIx@1;
   y.models:
   y1 ~ RIy@1;
   y2 ~ x1r y1r RIy@1;
   y3 ~ x2r y2r RIy@1;
   y4 ~ x3r y3r RIy@1;
   y5 ~ x4r y4r RIy@1;
   covariances:
   x1 ~~ y1;
   x2 ~~ y2;
   x3 ~~ y3;
   x4 ~~ y4;
   x5 ~~ y5',
  seed = 90291,
  burn = 5000,
  iter = 10000)

output(mymodel)
posterior_plot(mymodel)
