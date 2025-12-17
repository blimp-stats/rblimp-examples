library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.18.RDS', 'rb')
data <- readRDS(connect); close(connect)

# full model with occasion-specific residual effects
mymodel1 <- rblimp(
  data = data,
  latent = 'icept slope',
  model = '
   ry1 = y1 - (icept + (0*slope));
   ry2 = y2 - (icept + (1*slope));
   ry3 = y3 - (icept + (2*slope));
   ry4 = y4 - (icept + (3*slope));
   ry5 = y5 - (icept + (4*slope));
   structural.model:
   icept ~~ slope;
   1 -> icept slope;
   measurement.model:
   { y1:y6 } ~ 1@icept;
   slope -> y1@0 y2@1 y3@2 y4@3 y5@4 y6@5;
   y2 ~ ry1@ac1;
   y3 ~ ry2@ac2;
   y4 ~ ry3@ac3;
   y5 ~ ry4@ac4;
   y6 ~ ry5@ac5',
  waldtest = 'ac1 = ac2:ac5',
  seed = 90291,
  burn = 30000,
  iter = 20000)

output(mymodel1)
posterior_plot(mymodel1)

# simplified model with constrained paths
mymodel2 <- rblimp(
  data = data,
  latent = 'icept slope',
  model = '
   ry1 = y1 - (icept + (0*slope));
   ry2 = y2 - (icept + (1*slope));
   ry3 = y3 - (icept + (2*slope));
   ry4 = y4 - (icept + (3*slope));
   ry5 = y5 - (icept + (4*slope));
   structural.model:
   icept ~~ slope;
   1 -> icept slope;
   measurement.model:
   { y1:y6 } ~ 1@icept;
   slope -> y1@0 y2@1 y3@2 y4@3 y5@4 y6@5;
   y2 ~ ry1@ac;
   y3 ~ ry2@ac;
   y4 ~ ry3@ac;
   y5 ~ ry4@ac;
   y6 ~ ry5@ac',
  seed = 90291,
  burn = 20000,
  iter = 20000)

output(mymodel2)
posterior_plot(mymodel2)

## Alternative shorthand specification 

# full model with occasion-specific residual effects
mymodel1 <- rblimp(
  data = data,
  latent = 'icept slope',
  model = '
    { i in 1:5 } : r_[i] = y[i] - (icept + ([i-1] * slope));
    structural.model:
    icept ~~ slope;
    1 -> icept slope;
    measurement.model:
    y1 ~ 1@icept slope@0;
    { i in 2:6 } : y[i] ~ 1@icept slope@[i-1] r_[i-1]@ac[i-1]',
  waldtest = 'ac1 = ac2:ac5',
  seed = 90291,
  burn = 30000,
  iter = 20000)

output(mymodel1)
posterior_plot(mymodel1)

# simplified model with constrained paths
mymodel2 <- rblimp(
  data = data,
  latent = 'icept slope',
  model = '
    { i in 1:5 } : r_[i] = y[i] - (icept + ([i-1] * slope));
    structural.model:
    icept ~~ slope;
    1 -> icept slope;
    measurement.model:
    y1 ~ 1@icept slope@0;
    { i in 2:6 } : y[i] ~ 1@icept slope@[i-1] r_[i-1]@ac',
  seed = 90291,
  burn = 20000,
  iter = 20000)

output(mymodel2)
posterior_plot(mymodel2)
