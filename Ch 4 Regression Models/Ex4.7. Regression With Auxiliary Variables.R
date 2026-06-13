library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex4.7.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel1 <- rblimp(
  data = data,
  ordinal = 'd a3',
  fixed = 'd',
  center = 'x',
  model = '
    focal.model:
    y ~ x d;
    auxiliary.model:
    a1 ~ y x d;
    a2 ~ a1 y x d;
    a3 ~ a1 a2 y x d',
  seed = 90291,
  burn = 10000,
  iter = 10000)

mymodel2 <- rblimp(
  data = data,
  ordinal = 'd a3',
  fixed = 'd',
  center = 'x',
  model = '
    focal.model:
    y ~ x d;
    auxiliary.model:
    a3 a2 a1 ~ y x d',
  seed = 90291,
  burn = 10000,
  iter = 10000)

output(mymodel2)
posterior_plot(mymodel2, 'y')
