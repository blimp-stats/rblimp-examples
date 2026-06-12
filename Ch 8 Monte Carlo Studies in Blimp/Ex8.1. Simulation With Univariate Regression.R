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
  burn = 10000,
  iter = 10000
)

output(mymodel)
