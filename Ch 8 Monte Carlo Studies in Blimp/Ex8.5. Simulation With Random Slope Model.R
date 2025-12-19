library(rblimp)

mymodel <- rblimp(
  data = SIMULATE(
    model = list(
      level_2 = c(
        "z = normal(0, 1)",
        "u0 = normal(10 + z * -0.5, 1.0)",
        "u1 = normal(0.5, 0.2)",
        "u0 ~~ u1 := 0.2"
      ),
      level_1 = c(
        "x = normal(0, 1)",
        "y = normal(u0 + x * u1, 1)"
      )
    ),
    n = list(level_1 = 1000, level_2 = 100),
    variables = ~ x + y + z + level_2
  ),
  clusterid = "level_2",
  model = "y ~ x z | x",
  seed = 198723,
  burn = 10000,
  iter = 10000
)

output(mymodel)
