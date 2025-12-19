library(rblimp)

mymodel <- rblimp(
  data = SIMULATE(
    model = list(
      level_2 = c(
        "u0 = normal(10, 1.0)",
        "u1 = normal(0.5, 0.2)",
        "u0 ~~ u1 := 0.3"
      ),
      level_1 = c(
        "time0 = level_1.time - 1",
        "y = normal(u0 + time0 * u1, 1)"
      )
    ),
    n = list(level_1 = 4000, level_2 = 1000),
    variables = ~ y + time0 + level_2
  ),
  clusterid = "level_2",
  model = "y ~ time0 | time0",
  seed = 198723,
  burn = 10000,
  iter = 10000
)

output(mymodel)
