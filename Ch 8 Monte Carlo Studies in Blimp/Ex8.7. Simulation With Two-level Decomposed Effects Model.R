library(rblimp)

mymodel <- rblimp(
  data = SIMULATE(
    model = list(
      id2 = c(
        "x_b = normal(0, 1)",
        "w = normal(0, 1)",
        "x_b ~~ w := cor_xw",
        "u0 = normal(0, var_u0)",
        "u1 = normal(0, var_u1)",
        "u0 ~~ u1 := cov_u01 / (sqrt(var_u0) * sqrt(var_u1))",
        "y_b = b0 + x_b * b2 + w * b3 + u0"
      ),
      id1 = c(
        "x_w = normal(0, 1)",
        "y_w = normal(x_w * (b1 + u1), var_e)",
        "x = x_w + x_b",
        "y = y_w + y_b"
      )
    ),
    n = list(id1 = 5000, id2 = 500),
    define = c(
      "var_u0 = 43.5",
      "var_u1 = 10.0",
      "cov_u01 = 6.257",
      "b0 = 46.838",
      "b1 = 3.606",
      "b2 = 1.581",
      "b3 = 1.581",
      "var_e = 1.43",
      "cor_xw = 0.3"
    ),
    variables = ~ id2 + y + x + w
  ),
  clusterid = "id2",
  latent = "id2 = x_b y_b u1",
  model = '
    xb_cgm = x_b - mu_x;
    w_cgm = w - mu_w;
    x_w = x - x_b;

    Outcome_l2:
      y_b ~ 1@mu_y w_cgm xb_cgm;
      u1 ~ 1;
      y_b ~~ u1;

    Outcome_l1:
      y ~ 1@y_b x_w@u1;

    Predictors:
      x_b ~ 1@mu_x;
      w ~ 1@mu_w;
      x_b ~~ w;
      x ~ 1@x_b;
  ',
  seed = 1239871,
  burn = 20000,
  iter = 20000
)

output(mymodel)
