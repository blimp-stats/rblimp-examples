library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex7.1.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel1 <- rblimp(
  data = data,
  ordinal = 'd1 d2',
  fixed = 'd1 d2',
  center = 'x1',
  model = '
    focal.model:
    y ~ d1 d2 x1;
    missingness.model:
    y.missing ~ y;
    auxiliary.model:
    x2 x3 ~ y d1 d2 x1',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel1)
posterior_plot(mymodel1)

mymodel2 <- rblimp(
  data = data,
  ordinal = 'd1 d2',
  fixed = 'd1 d2',
  center = 'x1',
  model = '
    focal.model:
    y ~ d1 d2 x1;
    missingness.model:
    y.missing ~ y d1;
    auxiliary.model:
    x2 x3 ~ y d1 d2 x1',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel2)
posterior_plot(mymodel2)
