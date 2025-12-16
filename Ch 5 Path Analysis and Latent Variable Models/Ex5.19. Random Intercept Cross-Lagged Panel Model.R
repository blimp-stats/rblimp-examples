library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.19.RDS', 'rb')
data <- readRDS(connect); close(connect)

# basic riclpm
mymodel1 <- rblimp(
  data = data,
  latent = 'RIx RIy',
  model = ' 
   x1r = x1 - (mux1 + RIx);
   x2r = x2 - (mux2 + RIx);
   x3r = x3 - (mux3 + RIx);
   x4r = x4 - (mux4 + RIx);
   y1r = y1 - (muy1 + RIy);
   y2r = y2 - (muy2 + RIy);
   y3r = y3 - (muy3 + RIy);
   y4r = y4 - (muy4 + RIy);
   random.intercept:
   RIx ~~ RIy;
   x.models:
   x1 ~ 1@mux1 RIx@1;
   x2 ~ 1@mux2 RIx@1 x1r y1r;
   x3 ~ 1@mux3 RIx@1 x2r y2r;
   x4 ~ 1@mux4 RIx@1 x3r y3r;
   x5 ~ 1@mux5 RIx@1 x4r y4r;
   y.models:
   y1 ~ 1@muy1 RIy@1;
   y2 ~ 1@muy2 RIy@1 y1r x1r;
   y3 ~ 1@muy3 RIy@1 y2r x2r;
   y4 ~ 1@muy4 RIy@1 y3r x3r;
   y5 ~ 1@muy5 RIy@1 y4r x4r;
   covariances:
   x1 ~~ y1;
   x2 ~~ y2;
   x3 ~~ y3;
   x4 ~~ y4;
   x5 ~~ y5',
  seed = 90291,
  burn = 5000,
  iter = 10000)

output(mymodel1)
posterior_plot(mymodel1)

# time-varying covariate
mymodel2 <- rblimp(
  data = data,
  ordinal = 'z1',
  latent = 'RIx RIy',
  model = '
   x1r = x1 – (mux1 + RIx + z1*a1);
   x2r = x2 – (mux2 + RIx + z1*a2);
   x3r = x3 – (mux3 + RIx + z1*a3);
   x4r = x4 – (mux4 + RIx + z1*a4);
   y1r = y1 – (muy1 + RIy + z1*b1);
   y2r = y2 – (muy2 + RIy + z1*b2);
   y3r = y3 – (muy3 + RIy + z1*b3);
   y4r = y4 – (muy4 + RIy + z1*b4);
   random.intercept:
     RIx ~~ RIy;
   x.models:
     x1 ~ 1@mux1 RIx@1 z1@a1;
   x2 ~ 1@mux2 RIx@1 x1r y1r z1@a2;
   x3 ~ 1@mux3 RIx@1 x2r y2r z1@a3;
   x4 ~ 1@mux4 RIx@1 x3r y3r z1@a4;
   x5 ~ 1@mux5 RIx@1 x4r y4r z1@a5;
   y.models:
     y1 ~ 1@muy1 RIy@1 z1@b1;
   y2 ~ 1@muy2 RIy@1 y1r x1r z1@b2;
   y3 ~ 1@muy3 RIy@1 y2r x2r z1@b3;
   y4 ~ 1@muy4 RIy@1 y3r x3r z1@b4;
   y5 ~ 1@muy5 RIy@1 y4r x4r z1@b5;
   covariances:
   x1 ~~ y1;
   x2 ~~ y2;
   x3 ~~ y3;
   x4 ~~ y4;
   x5 ~~ y5',
  seed = 90291,
  burn = 5000,
  iter = 10000)

output(mymodel2)
posterior_plot(mymodel2)

# time-invariant covariate
mymodel3 <- rblimp(
  data = data,
  latent = 'RIx RIy',
  ordinal = 'z1',
  model = ' 
   x1r = x1 – (mux1 + RIx);
   x2r = x2 – (mux2 + RIx);
   x3r = x3 – (mux3 + RIx);
   x4r = x4 – (mux4 + RIx);
   y1r = y1 – (muy1 + RIy);
   y2r = y2 – (muy2 + RIy);
   y3r = y3 – (muy3 + RIy);
   y4r = y4 – (muy4 + RIy);
   random.intercepts:
   RIx ~ z1;
   RIy ~ z1;
   RIx ~~ RIy;
   x.models:
   x1 ~ 1@mux1 RIx@1;
   x2 ~ 1@mux2 RIx@1 x1r y1r;
   x3 ~ 1@mux3 RIx@1 x2r y2r;
   x4 ~ 1@mux4 RIx@1 x3r y3r;
   x5 ~ 1@mux5 RIx@1 x4r y4r;
   y.models:
   y1 ~ 1@muy1 RIy@1;
   y2 ~ 1@muy2 RIy@1 y1r x1r;
   y3 ~ 1@muy3 RIy@1 y2r x2r;
   y4 ~ 1@muy4 RIy@1 y3r x3r;
   y5 ~ 1@muy5 RIy@1 y4r x4r;
   covariances:
   x1 ~~ y1;
   x2 ~~ y2;
   x3 ~~ y3;
   x4 ~~ y4;
   x5 ~~ y5',
  seed = 90291,
  burn = 5000,
  iter = 10000)

output(mymodel3)
posterior_plot(mymodel3)

# random intercepts predicting distal outcome
mymodel4 <- rblimp(
  data = data,
  latent = 'RIx RIy',
  model = '
   x1r = x1 – (mux1 + RIx);
   x2r = x2 – (mux2 + RIx);
   x3r = x3 – (mux3 + RIx);
   x4r = x4 – (mux4 + RIx);
   y1r = y1 – (muy1 + RIy);
   y2r = y2 – (muy2 + RIy);
   y3r = y3 – (muy3 + RIy);
   y4r = y4 – (muy4 + RIy);
   random.intercepts:
   RIx ~~ RIy;
   x.models:
   x1 ~ 1@mux1 RIx@1;
   x2 ~ 1@mux2 RIx@1 x1r y1r;
   x3 ~ 1@mux3 RIx@1 x2r y2r;
   x4 ~ 1@mux4 RIx@1 x3r y3r;
   x5 ~ 1@mux5 RIx@1 x4r y4r;
   y.models:
   y1 ~ 1@muy1 RIy@1;
   y2 ~ 1@muy2 RIy@1 y1r x1r;
   y3 ~ 1@muy3 RIy@1 y2r x2r;
   y4 ~ 1@muy4 RIy@1 y3r x3r;
   y5 ~ 1@muy5 RIy@1 y4r x4r;
   covariances:
   x1 ~~ y1;
   x2 ~~ y2;
   x3 ~~ y3;
   x4 ~~ y4;
   x5 ~~ y5;
   distal.outcome:
   z2 ~ RIx RIy',
  seed = 90291,
  burn = 5000,
  iter = 10000)

output(mymodel4)
posterior_plot(mymodel4)

# within-person variables predicting distal outcome
mymodel5 <- rblimp(
  data = data,
  latent = 'RIx RIy',
  model = '
   x1r = x1 – (mux1 + RIx);
   x2r = x2 – (mux2 + RIx);
   x3r = x3 – (mux3 + RIx);
   x4r = x4 – (mux4 + RIx);
   x5r = x5 – (mux5 + RIx);
   y1r = y1 – (muy1 + RIy);
   y2r = y2 – (muy2 + RIy);
   y3r = y3 – (muy3 + RIy);
   y4r = y4 – (muy4 + RIy);
   y5r = y5 – (muy5 + RIy);
   random.intercepts:
   RIx ~~ RIy;
   x.models:
   x1 ~ 1@mux1 RIx@1;
   x2 ~ 1@mux2 RIx@1 x1r y1r;
   x3 ~ 1@mux3 RIx@1 x2r y2r;
   x4 ~ 1@mux4 RIx@1 x3r y3r;
   x5 ~ 1@mux5 RIx@1 x4r y4r;
   y.models:
   y1 ~ 1@muy1 RIy@1;
   y2 ~ 1@muy2 RIy@1 y1r x1r;
   y3 ~ 1@muy3 RIy@1 y2r x2r;
   y4 ~ 1@muy4 RIy@1 y3r x3r;
   y5 ~ 1@muy5 RIy@1 y4r x4r;
   covariances:
   x1 ~~ y1;
   x2 ~~ y2;
   x3 ~~ y3;
   x4 ~~ y4;
   x5 ~~ y5;
   distal.outcome:
   z2 ~ x1r y1r x2r y2r x3r y3r x4r y4r x5r y5r',
  seed = 90291,
  burn = 5000,
  iter = 10000)

output(mymodel5)
posterior_plot(mymodel5)
