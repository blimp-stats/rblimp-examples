library(rblimp)
set_blimp("/Applications/Blimp/blimp-nightly")

mymodel <- rblimp(
  data = SIMULATE(
    model = c(
      "x = normal(0, 1)",
      "y = normal(10 + x*0.5, 1)"
    ),
    n = 1000
  ),
  model = "y ~ x",
  seed = 10972,
  burn = 5000,
  iter = 5000
)

output(mymodel)
