library(rblimp)

mymodel <- rblimp(
  data = SIMULATE(
    model = c(
      "x1 ~~ x2 := cor",
      "x1:x2 = normal(0, var_x)",
      "y = normal(b0 + b1 * x1 + b2 * x2, s2e)",
      "x1m = missing(uniform(0, 1) < pmis_x1, x1)",
      "mu_y := b0 + mu_x * b1 + mu_x * b2",
      "var_y := b1^2 * var_x + b2^2 * var_x + s2e",
      "m_star = normal(sqrt(r2_mis) * ((y - mu_y) / sqrt(var_y)), 1.0 - r2_mis)",
      "x2m = missing(m_star < iphi(pmis_x2), x2)"
    ),
    n = 1000,
    define = c(
      "mu_x = 0.0",
      "var_x = 1.0",
      "cor = 0.3",
      "b0 = 10",
      "b1 = 0.5",
      "b2 = 0.3",
      "s2e = 1.0",
      "pmis_x1 = 0.15",
      "pmis_x2 = 0.25",
      "r2_mis = 0.6"
    ),
    variables = ~ x1 + x2 + x1m + x2m + y
  ),
  model = c(
    "y ~ x1m:x2m",
    "x1m ~~ x2m"
  ),
  seed = 10972,
  burn = 5000,
  iter = 5000
)

output(mymodel)
