library(ggplot2)

set.seed(123)

# Simulate data
n <- 100
educ <- rnorm(n, mean = 12, sd = 3)
age <- rnorm(n, mean = 35, sd = 10)
wage <- 1000 + 200*educ + 50*age + rnorm(n, mean = 0, sd = 100)

# Create data frame
data <- data.frame(educ = educ, age = age, wage = wage)

# Plot data
ggplot(data, aes(x = educ, y = wage)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Years of education", y = "Wage")



# Catehorical

library(ggplot2)

# generate simulated data
set.seed(123)
gender <- factor(rep(c("Male", "Female"), each = 50))
educ <- rnorm(100, mean = 12, sd = 2)
wage <- 20 + 5*as.numeric(gender) + 2*educ + rnorm(100, mean = 0, sd = 5)
data <- data.frame(gender, educ, wage)

# plot the data with linear regression lines by gender
ggplot(data, aes(x = educ, y = wage, color = gender)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  xlab("Years of Education") +
  ylab("Wage") +
  ggtitle("Wage by Education Level and Gender") +
  scale_color_manual(values = c("blue", "red"))



# Ejemplos
# simulate data
set.seed(123)
gasto <- exp(rnorm(100))
voters <- 1 + 2 * log(x) + rnorm(100)

# plot the data
library(ggplot2)
ggplot(data.frame(x = gasto, y = voters), aes(x, y)) + 
  geom_point() + 
  xlab("Gasto") + 
  ylab("Votantes")

# fit a linear model
fit_lm <- lm(y ~ x)
summary(fit_lm)

# plot the linear fit
ggplot(data.frame(x = x, y = y), aes(x, y)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  xlab("Gasto") + 
  ylab("Votantes")

# fit a linear-log model
fit_lmlg <- lm(y ~ log(x))
summary(fit_lmlg)

# plot the linear-log fit
ggplot(data.frame(x = x, y = y), aes(x, y)) + 
  geom_point() + 
  geom_smooth(method = "lm", formula = y ~ log(x)) +
  xlab("Gasto") + 
  ylab("Votantes")


# Log -x



# Simulate data
# Load libraries
library(ggplot2)
library(dplyr)

# Simulate data
set.seed(123)
exp <- runif(100, 0, 20)
wage <- exp^2 + rnorm(100, 0, 1)
data <- data.frame(exp, wage)

# Fit linear regression
fit_lin <- lm(wage ~ exp, data = data)
summary(fit_lin)

# Fit logarithmic regression
fit_log <- lm(log(wage) ~ exp, data = data)
summary(fit_log)

# Plot data and regression lines
library(ggplot2)
ggplot(data, aes(x = exp, y = wage)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "red") +
  geom_smooth(method = "lm", formula = log(y) ~ x, se = FALSE, color = "blue") +
  labs(title = "Wage vs Experience",
       x = "Experience",
     y = "Wage")


# log log
set.seed(123)
n <- 100
x <- exp(2  + rnorm(n))
y <- exp(2 * log(x) + rnorm(n))
data <- data.frame(x = x, y = y)

# Linear regression
fit_lm <- lm(y ~ x, data = data)
summary(fit_lm)

# Logarithmic regression
fit_log <- lm(log(y) ~ log(x), data = data)
summary(fit_log)

# Plotting the results
library(ggplot2)
ggplot(data, aes(x, y)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "red") +
  geom_smooth(method = "lm", formula = log(y) ~ log(x), se = FALSE, color = "blue") +
  scale_x_log10() +
  scale_y_log10()



# Cuadratic

set.seed(123)
n <- 100
exp <- runif(n, 0, 20)
beta0 <- 150000
beta1 <- 90000
beta2 <- -5000
wage <- beta0 + beta1*exp + beta2*exp^2 + 1000*rnorm(n, 0, 20)

df <- data.frame(exp, wage)

# Linear regression
model_lm <- lm(wage ~ exp, data = df)

# Quadratic regression
model_qr <- lm(wage ~ exp + I(exp^2), data = df)

# Plot
library(ggplot2)

ggplot(df, aes(exp, wage)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  geom_smooth(method = "lm", formula = y ~ x + I(x^2), se = FALSE, color = "blue") +
  labs(title = "Quadratic vs Linear Regression",
       x = "Experience",
       y = "Wage",
       color = "Regression Type") +
  scale_color_manual(values = c("red", "blue")) +
  theme_minimal()
 
options(scipen = 999)



# beta positive

# Cuadratic

set.seed(123)
n <- 100
exp <- runif(n, 0, 50)
beta0 <- 750
beta1 <- -30
beta2 <- 0.8
wage <- beta0 + beta1*exp + beta2*exp^2 + 30*rnorm(n, 0, 1)

df <- data.frame(exp, wage)

# Linear regression
model_lm <- lm(wage ~ exp, data = df)

# Quadratic regression
model_qr <- lm(wage ~ exp + I(exp^2), data = df)


ggplot(df, aes(exp, wage)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  geom_smooth(method = "lm", formula = y ~ x + I(x^2), se = FALSE, color = "blue") +
  labs(title = "Quadratic vs Linear Regression",
       x = "Edad",
       y = "Hacerle caso a los padres",
       color = "Regression Type") +
  scale_color_manual(values = c("red", "blue")) +
  theme_minimal()



# Interaction
library(ggplot2)

# Simulated data
# Create data
set.seed(123)
n <- 100
exp <- runif(n, 0, 20)
beta0 <- 500
beta1 <- 2
beta2 <- -0.5
age <- runif(n, 20, 60)
wage <- beta0 + beta1*exp + beta2*age*exp + rnorm(n, 0, 1)

df <- data.frame(exp, age, wage)

# Linear regression
model_int <- lm(wage ~ exp + age, data = df)

# Plot
library(ggplot2)

ggplot(df, aes(exp, wage, color = age)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Linear Regression with Interaction term",
       x = "Experience",
       y = "Wage",
       color = "Age") +
  scale_color_viridis_c(option = "magma", name = "Age") +
  theme_minimal()


# Interaction with gender
set.seed(123)
n <- 200
exp <- runif(n, 0, 20)
gender <- sample(c("male", "female"), n, replace = TRUE)
beta0 <- 100000
beta1 <- 500
beta2 <- -100
beta3 <- 1000
beta4 <- -5000
wage <- beta0 + beta4*(gender == "male") + beta1*exp + beta2*exp^2 + beta3*exp*(gender == "male") + 1000*rnorm(n, 0, 1)

df <- data.frame(exp, gender, wage)

# Linear regression for females
fit_female <- lm(wage ~ exp, data = df %>% filter(gender == "female"))

# Quadratic regression for males
fit_male <- lm(wage ~ exp + I(exp^2) + I(exp*(gender == "male")), data = df %>% filter(gender == "male"))

# Plot
library(ggplot2)

ggplot(df, aes(exp, wage, color = gender)) +
  geom_point() +
  geom_smooth(data = df %>% filter(gender == "female"), method = "lm", formula = y ~ x + I(x^2), se = FALSE, color = "red") +
  geom_smooth(data = df %>% filter(gender == "male"), method = "lm", formula = y ~ x + I(x^2) , se = FALSE, color = "blue") +
  labs(title = "Quadratic vs Linear Regression by Gender",
       x = "Experience",
       y = "Wage",
       color = "Gender") +
  scale_color_manual(values = c("red", "blue")) +
  theme_minimal()



# Interaction

set.seed(123)
n <- 200
exp <- runif(n, 0, 20)
gender <- sample(c(0, 1), n, replace = TRUE)
marital_status <- sample(c(0, 1), n, replace = TRUE)
beta0 <- 10000
beta1 <- 2000
beta2 <- 7000
beta3 <- -4000
beta4 <- -10000
wage <- beta0 + beta1*exp + beta2*gender + beta3*marital_status + beta4*gender*marital_status + 2000*rnorm(n, 0, 1)

df <- data.frame(exp, gender, marital_status, wage)

df <- df %>% mutate(gender = as_factor(if_else(gender == 1, "Male", "Female")),
                    marital_status = as_factor(if_else(marital_status == 1, "Single", "Married"))) %>% 
  unite(gen_marital, c("gender", "marital_status"), sep = "-")
# Linear regression
fit_lm <- lm(wage ~ exp + gender + marital_status + gender*marital_status, data = df)

# Plot
library(ggplot2)

ggplot(df, aes(x = exp, y = wage, color = factor(gen_marital))) +
  geom_point() +
  geom_smooth(aes(group = gen_marital), method = "lm", se = FALSE) +
  scale_color_manual(values = c("red", "blue", "purple", "green")) +
  labs(title = "Linear Regression by Gender and Marital Status",
       x = "Experiencia",
       y = "Salario (diario)",
       color = "") +
  theme_minimal()


