library(rblimp)

mymodel <- rblimp(
  data = SIMULATE(
    model = c(
      "f1:f2 = normal(0, 1)",
      "y1_1:y1_5 = normal(f1, v_1)",
      "y2_1:y2_5 = normal(f2, v_2)"
    ),
    n = 1000,
    define = c(
      "f1 ~~ f2 = 0.3",
      "rel_1 = 0.7",
      "rel_2 = 0.8",
      "v_1 = (1 / rel_1) - 1",
      "v_2 = (1 / rel_2) - 1"
    ),
    variables = ~ y1_1:y1_5 + y2_1:y2_5
  ),
  latent = "factor1 factor2",
  model = c(
    "factor1 ~~ factor2",
    "factor1 -> y1_1:y1_5",
    "factor2 -> y2_1:y2_5"
  ),
  seed = 10972,
  burn = 10000,
  iter = 10000
)

output(mymodel)
