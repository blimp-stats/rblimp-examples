library(rblimp)

mymodel <- rblimp(
  data = SIMULATE(
    model = list(
      level_2 = c(
        "u0 = normal(10, 1.0)"
      ),
      level_1 = c(
        "y = normal(u0 + (y.lag - u0) * 0.5, 1)",
        "time = level_1.time"
      )
    ),
    n = list(level_1 = 5000, level_2 = 100),
    variables = ~ y + time + level_2
  ),
  clusterid = "level_2",
  timeid = "time",
  latent = "level_2 = b0j",
  model = "y ~ 1@b0j (y.lag - b0j)",
  seed = 198723,
  burn = 5000,
  iter = 5000
)

output(mymodel)
