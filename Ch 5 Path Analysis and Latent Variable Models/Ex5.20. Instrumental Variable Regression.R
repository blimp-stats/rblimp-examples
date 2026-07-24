library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.20.RDS', 'rb')
data <- readRDS(connect); close(connect)

# correlated residual specification
mymodel1 <- rblimp(
  data = data,
  model = '
    x ~ 1@x_icept z@alpha;
    xpredicted = x_icept + alpha*z;
    y ~ xpredicted;
    x ~~ y;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel1)
posterior_plot(mymodel1)

# control function specification
mymodel2 <- rblimp(
  data = data,
  model = '
    x ~ 1@x_icept z@alpha;
    xpredicted = x_icept + alpha*z;
    xresidual = x - (x_icept + alpha*z);
    y ~ xpredicted xresidual;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel2)
posterior_plot(mymodel2)