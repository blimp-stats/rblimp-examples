library(rblimp)
library(ggplot2)

connect <- url('https://raw.githubusercontent.com/blimp-stats/rblimp-examples/main/Data/Ex6.6.RDS', 'rb')
data <- readRDS(connect); close(connect)

mymodel <- rblimp(
   data = data,
   clusterid = 'level2id',
   center = '
    groupmean = x1_i;
    grandmean = x2_i',
   model = 'y_i ~ x1_i x2_i | x1_i',
   seed = 90291,
   burn = 5000,
   iter = 10000,
   chains = 20,
   nimps = 20)

output(mymodel)
posterior_plot(mymodel,'y_i')

# plot y residuals across x
residual_plot(mymodel,'y_i')

# inspect variable names
names(mymodel@average_imp)

# plot average level-1 residuals
ggplot(as.data.frame(mymodel@average_imp), aes(x = y_i.residual)) +
  geom_density(fill = "steelblue", alpha = 0.6) +
  labs(title = "Density Plot of Level-1 Residuals",
       x = "Level-1 Residual",
       y = "Density")

# qqplot of level-1 residuals
ggplot(as.data.frame(mymodel@average_imp), aes(sample = y_i.residual)) +
  stat_qq() +
  stat_qq_line(color = "red") +
  labs(title = "QQ Plot of Level-1 Residuals",
       x = "Theoretical Quantiles",
       y = "Sample Quantiles")

# plot average level-2 residuals
ggplot(as.data.frame(mymodel@average_imp), aes(x = y_i.level2id.)) +
  geom_density(fill = "steelblue", alpha = 0.6) +
  labs(title = "Density Plot of Level-2 Residuals",
       x = "Level-2 Residual",
       y = NULL)

# qqplot of level-2 residuals
ggplot(as.data.frame(mymodel@average_imp), aes(sample = y_i.level2id.)) +
  stat_qq() +
  stat_qq_line(color = "red") +
  labs(title = "QQ Plot of Level-2 Residuals",
       x = "Theoretical Quantiles",
       y = "Sample Quantiles")




