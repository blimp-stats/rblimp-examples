library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.17.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel1 <- rblimp(
  data = data,
  ordinal = 'x1:x7 d1 d2',
  model = '
    focal.model:
    xscale = x1:+:x7;
    yscale ~ xscale d1 d2;
    predictor.model:
    x1:x7 d1 d2 ~ 1',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel1)
posterior_plot(mymodel1, 'yscale')

mymodel2 <- rblimp(
  data = data,
  ordinal = 'y1:y5 x1:x7 d1 d2',
  model = '
    focal.model:
    xscale = x1:+:x7;
    yscale ~ xscale d1 d2;
    predictor.model:
    x1:x7 d1 d2 ~ 1;
    auxiliary.models:
    y1:y5 ~ yscale',
  seed = 90291,
  burn = 20000,
  iter = 20000)

output(mymodel2)
posterior_plot(mymodel2, 'yscale')
