library(rblimp)

mymodel <- rblimp(
  data = SIMULATE(
    model = c(
      "x1:x2 = normal(0, 1)",
      "y = normal(b0 + b1*x1 + b2*x2, s2e)"
    ),
    n = 1000,
    define = c(
      "b0 = 10",
      "b1 = 0.5",
      "b2 = 0.3",
      "s2e = 1.0",
      "x1 ~~ x2 = 0.3"
    ),
    variables = ~ x1 + x2 + y
  ),
  model = c(
    "y ~ x1:x2",
    "x1 ~~ x2"
  ),
  seed = 10972,
  burn = 5000,
  iter = 5000
)

output(mymodel)
