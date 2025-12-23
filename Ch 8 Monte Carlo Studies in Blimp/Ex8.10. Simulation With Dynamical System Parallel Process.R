library(rblimp)

mymodel <- rblimp(
  data = SIMULATE(
    model = list(
      level_2 = c(
        "yb ~ normal(0, 1)",
        "xb ~ normal(0, 1)",
        "yb ~~ xb := 0.3"
      ),
      level_1 = c(
        "time = level_1.time",
        "e_y ~ normal(0, 1)",
        "e_x ~ normal(0, 1)",
        "e_x ~~ e_y := 0.3",
        "yc = yb + (xc.lag - xb)*-0.3 + (yc.lag - yb)*0.3 + e_y",
        "xc = xb + (yc.lag - yb)*-0.3 + (xc.lag - xb)*0.3 + e_x",
        "y = missing((time > 1) and (time < 50) and (bernoulli(0.5)), yc)",
        "x = missing((time > 1) and (time < 50) and (bernoulli(0.5)), xc)"
      )
    ),
    n = list(level_1 = 5000, level_2 = 100),
    variables = ~ x + y + time + level_2
  ),
  clusterid = "level_2",
  timeid = "time",
  latent = "level_2 = b0j g0j",
  model = c(
    "y ~ 1@b0j (x.lag - g0j) (y.lag - b0j)",
    "x ~ 1@g0j (x.lag - g0j) (y.lag - b0j)",
    "b0j ~~ g0j",
    "x ~~ y"
  ),
  seed = 12893,
  burn = 10000,
  iter = 10000
)

output(mymodel)
