library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.19.RDS', 'rb')
data <- readRDS(connect); close(connect)

# basic riclpm
mymodel1 <- rblimp(
  data = data,
  latent = 'etax etay',
  model = '
    # definition variables for residuals
    rx1 = x1 - (mux1 + etax);
    rx2 = x2 - (mux2 + etax);
    rx3 = x3 - (mux3 + etax);
    rx4 = x4 - (mux4 + etax);
    ry1 = y1 - (muy1 + etay);
    ry2 = y2 - (muy2 + etay);
    ry3 = y3 - (muy3 + etay);
    ry4 = y4 - (muy4 + etay);
    random.intercepts:
    etax ~~ etay;
    x.models:
    x1 ~ 1@mux1 etax@1;
    x2 ~ 1@mux2 etax@1 rx1 ry1;
    x3 ~ 1@mux3 etax@1 rx2 ry2;
    x4 ~ 1@mux4 etax@1 rx3 ry3;
    x5 ~ 1@mux5 etax@1 rx4 ry4;
    y.models:
    y1 ~ 1@muy1 etay@1;
    y2 ~ 1@muy2 etay@1 ry1 rx1;
    y3 ~ 1@muy3 etay@1 ry2 rx2;
    y4 ~ 1@muy4 etay@1 ry3 rx3;
    y5 ~ 1@muy5 etay@1 ry4 rx4;
    covariances:
    x1 ~~ y1;
    x2 ~~ y2;
    x3 ~~ y3;
    x4 ~~ y4;
    x5 ~~ y5;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel1)
posterior_plot(mymodel1)

# time-varying covariate
mymodel2 <- rblimp(
  data = data,
  ordinal = 'z1',
  latent = 'etax etay',
  model = '
    # definition variables for residuals
    rx1 = x1 - (mux1 + etax + z1*a1);
    rx2 = x2 - (mux2 + etax + z1*a2);
    rx3 = x3 - (mux3 + etax + z1*a3);
    rx4 = x4 - (mux4 + etax + z1*a4);
    ry1 = y1 - (muy1 + etay + z1*b1);
    ry2 = y2 - (muy2 + etay + z1*b2);
    ry3 = y3 - (muy3 + etay + z1*b3);
    ry4 = y4 - (muy4 + etay + z1*b4);
    random.intercepts:
    etax ~~ etay;
    x.models:
    x1 ~ 1@mux1 etax@1 z1@a1;
    x2 ~ 1@mux2 etax@1 rx1 ry1 z1@a2;
    x3 ~ 1@mux3 etax@1 rx2 ry2 z1@a3;
    x4 ~ 1@mux4 etax@1 rx3 ry3 z1@a4;
    x5 ~ 1@mux5 etax@1 rx4 ry4 z1@a5;
    y.models:
    y1 ~ 1@muy1 etay@1 z1@b1;
    y2 ~ 1@muy2 etay@1 ry1 rx1 z1@b2;
    y3 ~ 1@muy3 etay@1 ry2 rx2 z1@b3;
    y4 ~ 1@muy4 etay@1 ry3 rx3 z1@b4;
    y5 ~ 1@muy5 etay@1 ry4 rx4 z1@b5;
    covariances:
    x1 ~~ y1;
    x2 ~~ y2;
    x3 ~~ y3;
    x4 ~~ y4;
    x5 ~~ y5;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel2)
posterior_plot(mymodel2)

# time-invariant covariate
mymodel3 <- rblimp(
  data = data,
  latent = 'etax etay',
  ordinal = 'z1',
  model = '
    # definition variables for residuals
    rx1 = x1 - (mux1 + etax);
    rx2 = x2 - (mux2 + etax);
    rx3 = x3 - (mux3 + etax);
    rx4 = x4 - (mux4 + etax);
    ry1 = y1 - (muy1 + etay);
    ry2 = y2 - (muy2 + etay);
    ry3 = y3 - (muy3 + etay);
    ry4 = y4 - (muy4 + etay);
    random.intercepts:
    etax ~ z1;
    etay ~ z1;
    etax ~~ etay;
    x.models:
    x1 ~ 1@mux1 etax@1;
    x2 ~ 1@mux2 etax@1 rx1 ry1;
    x3 ~ 1@mux3 etax@1 rx2 ry2;
    x4 ~ 1@mux4 etax@1 rx3 ry3;
    x5 ~ 1@mux5 etax@1 rx4 ry4;
    y.models:
    y1 ~ 1@muy1 etay@1;
    y2 ~ 1@muy2 etay@1 ry1 rx1;
    y3 ~ 1@muy3 etay@1 ry2 rx2;
    y4 ~ 1@muy4 etay@1 ry3 rx3;
    y5 ~ 1@muy5 etay@1 ry4 rx4;
    covariances:
    x1 ~~ y1;
    x2 ~~ y2;
    x3 ~~ y3;
    x4 ~~ y4;
    x5 ~~ y5;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel3)
posterior_plot(mymodel3)

# random intercepts predicting distal outcome
mymodel4 <- rblimp(
  data = data,
  latent = 'etax etay',
  model = '
    # definition variables for residuals
    rx1 = x1 - (mux1 + etax);
    rx2 = x2 - (mux2 + etax);
    rx3 = x3 - (mux3 + etax);
    rx4 = x4 - (mux4 + etax);
    ry1 = y1 - (muy1 + etay);
    ry2 = y2 - (muy2 + etay);
    ry3 = y3 - (muy3 + etay);
    ry4 = y4 - (muy4 + etay);
    random.intercepts:
    etax ~~ etay;
    x.models:
    x1 ~ 1@mux1 etax@1;
    x2 ~ 1@mux2 etax@1 rx1 ry1;
    x3 ~ 1@mux3 etax@1 rx2 ry2;
    x4 ~ 1@mux4 etax@1 rx3 ry3;
    x5 ~ 1@mux5 etax@1 rx4 ry4;
    y.models:
    y1 ~ 1@muy1 etay@1;
    y2 ~ 1@muy2 etay@1 ry1 rx1;
    y3 ~ 1@muy3 etay@1 ry2 rx2;
    y4 ~ 1@muy4 etay@1 ry3 rx3;
    y5 ~ 1@muy5 etay@1 ry4 rx4;
    covariances:
    x1 ~~ y1;
    x2 ~~ y2;
    x3 ~~ y3;
    x4 ~~ y4;
    x5 ~~ y5;
    distal.outcome:
    z2 ~ etax etay;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel4)
posterior_plot(mymodel4)

# within-person variables predicting distal outcome
mymodel5 <- rblimp(
  data = data,
  latent = 'etax etay',
  model = '
    # definition variables for residuals
    rx1 = x1 - (mux1 + etax);
    rx2 = x2 - (mux2 + etax);
    rx3 = x3 - (mux3 + etax);
    rx4 = x4 - (mux4 + etax);
    rx5 = x5 - (mux5 + etax);
    ry1 = y1 - (muy1 + etay);
    ry2 = y2 - (muy2 + etay);
    ry3 = y3 - (muy3 + etay);
    ry4 = y4 - (muy4 + etay);
    ry5 = y5 - (muy5 + etay);
    random.intercepts:
    etax ~~ etay;
    x.models:
    x1 ~ 1@mux1 etax@1;
    x2 ~ 1@mux2 etax@1 rx1 ry1;
    x3 ~ 1@mux3 etax@1 rx2 ry2;
    x4 ~ 1@mux4 etax@1 rx3 ry3;
    x5 ~ 1@mux5 etax@1 rx4 ry4;
    y.models:
    y1 ~ 1@muy1 etay@1;
    y2 ~ 1@muy2 etay@1 ry1 rx1;
    y3 ~ 1@muy3 etay@1 ry2 rx2;
    y4 ~ 1@muy4 etay@1 ry3 rx3;
    y5 ~ 1@muy5 etay@1 ry4 rx4;
    covariances:
    x1 ~~ y1;
    x2 ~~ y2;
    x3 ~~ y3;
    x4 ~~ y4;
    x5 ~~ y5;
    distal.outcome:
    z2 ~ rx1 ry1 rx2 ry2 rx3 ry3 rx4 ry4 rx5 ry5;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel5)
posterior_plot(mymodel5)

## Alternative shorthand specification

# basic riclpm
mymodel1 <- rblimp(
  data = data,
  latent = 'etax etay',
  model = '
    { v in x y, i in 1:4 } : r[v][i] = [v][i] - (mu[v][i] + eta[v]);
    random.intercept:
    etax ~~ etay;
    x.models:
    x1 ~ 1@mux1 etax@1;
    { i in 2:5 } : x[i] ~ 1@mux[i] etax@1 rx[i-1] ry[i-1];
    y.models:
    y1 ~ 1@muy1 etay@1;
    { i in 2:5 } : y[i] ~ 1@muy[i] etay@1 ry[i-1] rx[i-1];
    covariances:
    { i in 1:5 } : x[i] ~~ y[i];',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel1)
posterior_plot(mymodel1)

# time-varying covariate
mymodel2 <- rblimp(
  data = data,
  ordinal = 'z1',
  latent = 'etax etay',
  model = '
    { v in x y, i in 1:4 } : r[v][i] = [v][i] - (mu[v][i] + eta[v] + z1*b[v][i]);
    random.intercept:
    etax ~~ etay;
    x.models:
    x1 ~ 1@mux1 etax@1 z1@bx1;
    { i in 2:5 } : x[i] ~ 1@mux[i] etax@1 rx[i-1] ry[i-1] z1@bx[i];
    y.models:
    y1 ~ 1@muy1 etay@1 z1@by1;
    { i in 2:5 } : y[i] ~ 1@muy[i] etay@1 ry[i-1] rx[i-1] z1@by[i];
    covariances:
    { i in 1:5 } : x[i] ~~ y[i];',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel2)
posterior_plot(mymodel2)

# time-invariant covariate
mymodel3 <- rblimp(
  data = data,
  latent = 'etax etay',
  ordinal = 'z1',
  model = '
    { v in x y, i in 1:4 } : r[v][i] = [v][i] - (mu[v][i] + eta[v]);
    random.intercepts:
    { etax etay } ~ z1;
    etax ~~ etay;
    x.models:
    x1 ~ 1@mux1 etax@1;
    { i in 2:5 } : x[i] ~ 1@mux[i] etax@1 rx[i-1] ry[i-1];
    y.models:
    y1 ~ 1@muy1 etay@1;
    { i in 2:5 } : y[i] ~ 1@muy[i] etay@1 ry[i-1] rx[i-1];
    covariances:
    { i in 1:5 } : x[i] ~~ y[i];',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel3)
posterior_plot(mymodel3)

# random intercepts predicting distal outcome
mymodel4 <- rblimp(
  data = data,
  latent = 'etax etay',
  model = '
    { v in x y, i in 1:4 } : r[v][i] = [v][i] - (mu[v][i] + eta[v]);
    random.intercept:
    etax ~~ etay;
    x.models:
    x1 ~ 1@mux1 etax@1;
    { i in 2:5 } : x[i] ~ 1@mux[i] etax@1 rx[i-1] ry[i-1];
    y.models:
    y1 ~ 1@muy1 etay@1;
    { i in 2:5 } : y[i] ~ 1@muy[i] etay@1 ry[i-1] rx[i-1];
    covariances:
    { i in 1:5 } : x[i] ~~ y[i];
    distal.outcome:
    z2 ~ etax etay',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel4)
posterior_plot(mymodel4)

# within-person variables predicting distal outcome
mymodel5 <- rblimp(
  data = data,
  latent = 'etax etay',
  model = '
    { v in x y, i in 1:5 } : r[v][i] = [v][i] - (mu[v][i] + eta[v]);
    random.intercept:
    etax ~~ etay;
    x.models:
    x1 ~ 1@mux1 etax@1;
    { i in 2:5 } : x[i] ~ 1@mux[i] etax@1 rx[i-1] ry[i-1];
    y.models:
    y1 ~ 1@muy1 etay@1;
    { i in 2:5 } : y[i] ~ 1@muy[i] etay@1 ry[i-1] rx[i-1];
    covariances:
    { i in 1:5 } : x[i] ~~ y[i];
    distal.outcome:
    z2 ~ rx1 ry1 rx2 ry2 rx3 ry3 rx4 ry4 rx5 ry5;',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel5)
posterior_plot(mymodel5)