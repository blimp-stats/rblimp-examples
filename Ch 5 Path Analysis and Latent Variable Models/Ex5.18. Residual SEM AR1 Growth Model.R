library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.18.RDS', 'rb')
data <- readRDS(connect); close(connect)

# full model with occasion-specific residual effects
mymodel1 <- rblimp(
  data = data,
  latent = 'eta_icept eta_slope',
  model = '
    # definition variables for residuals
    ry1 = y1 - (eta_icept + (0*eta_slope));
    ry2 = y2 - (eta_icept + (1*eta_slope));
    ry3 = y3 - (eta_icept + (2*eta_slope));
    ry4 = y4 - (eta_icept + (3*eta_slope));
    ry5 = y5 - (eta_icept + (4*eta_slope));
    structural.model:
    eta_icept ~~ eta_slope;
    1 -> eta_icept eta_slope;
    measurement.model:
    eta_icept -> y1@1 y2@1 y3@1 y4@1 y5@1 y6@1;
    eta_slope -> y1@0 y2@1 y3@2 y4@3 y5@4 y6@5;
    1 -> y1@0 y2@0 y3@0 y4@0 y5@0 y6@0;
    # AR1 paths
    y2 ~ ry1@ac1;
    y3 ~ ry2@ac2;
    y4 ~ ry3@ac3;
    y5 ~ ry4@ac4;
    y6 ~ ry5@ac5;',
  waldtest = 'ac1 = ac2:ac5',
  seed = 90291,
  burn = 30000,
  iter = 30000
)

output(mymodel1)
posterior_plot(mymodel1)

# simplified model with constrained paths
mymodel <- rblimp(
  data = data,
  latent = 'eta_icept eta_slope',
  model = '
    # definition variables for residuals
    ry1 = y1 - (eta_icept + (0*eta_slope));
    ry2 = y2 - (eta_icept + (1*eta_slope));
    ry3 = y3 - (eta_icept + (2*eta_slope));
    ry4 = y4 - (eta_icept + (3*eta_slope));
    ry5 = y5 - (eta_icept + (4*eta_slope));
    structural.model:
    eta_icept ~~ eta_slope;
    1 -> eta_icept eta_slope;
    measurement.model:
    eta_icept -> y1@1 y2@1 y3@1 y4@1 y5@1 y6@1;
    eta_slope -> y1@0 y2@1 y3@2 y4@3 y5@4 y6@5;
    1 -> y1@0 y2@0 y3@0 y4@0 y5@0 y6@0;
    # AR1 paths
    y2 ~ ry1@ac;
    y3 ~ ry2@ac;
    y4 ~ ry3@ac;
    y5 ~ ry4@ac;
    y6 ~ ry5@ac;',
  seed = 90291,
  burn = 20000,
  iter = 20000
)

output(mymodel)
posterior_plot(mymodel)

## alternative specification with looping structure

# full model with occasion-specific residual effects
mymodel1 <- rblimp(
  data = data,
  latent = 'eta_icept eta_slope',
  model = '
    # define residuals
    { i in 1:5 } : ry[i] = y[i] - (eta_icept + ([i-1] * eta_slope));
    structural.model:
    eta_icept ~~ eta_slope;
    1 -> eta_icept eta_slope;
    measurement.model:
    y1 ~ 1@eta_icept eta_slope@0;
    { i in 2:6 } : y[i] ~ 1@eta_icept eta_slope@[i-1] ry[i-1]@ac[i-1]',
  waldtest = 'ac1 = ac2:ac5',
  seed = 90291,
  burn = 30000,
  iter = 30000)

output(mymodel1)
posterior_plot(mymodel1)

# simplified model with constrained paths
mymodel2 <- rblimp(
  data = data,
  latent = 'eta_icept eta_slope',
  model = '
    # define residuals
    { i in 1:5 } : ry[i] = y[i] - (eta_icept + ([i-1] * eta_slope));
    structural.model:
    eta_icept ~~ eta_slope;
    1 -> eta_icept eta_slope;
    measurement.model:
    y1 ~ 1@eta_icept eta_slope@0;
    { i in 2:6 } : y[i] ~ 1@eta_icept eta_slope@[i-1] ry[i-1]@ac',
  seed = 90291,
  burn = 20000,
  iter = 20000)

output(mymodel2)
posterior_plot(mymodel2)
