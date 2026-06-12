library(rblimp)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex5.17.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
  data = data,
  ordinal = 'd',
  fixed = 'd',
  latent = 'eta_icept eta_slope',
  model = '
    structural.model:
    eta_icept ~ 1 d;
    eta_slope ~ 1 d;
    eta_icept ~~ eta_slope;
    measurement.model:
    eta_icept -> y0@1 y1@1 y3@1 y6@1;
    eta_slope -> y0@0 y1@1 y3@3 y6@6;
    1 -> y0@0 y1@0 y3@0 y6@0;
    # common residual variance
    y0@resvar;
    y1@resvar;
    y3@resvar;
    y6@resvar;',
  seed = 90291,
  burn = 10000,
  iter = 10000
)

output(mymodel)
posterior_plot(mymodel)
