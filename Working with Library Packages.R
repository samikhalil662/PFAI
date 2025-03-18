# Install required packages (run only once)
#install.packages(c("ggplot2", "dplyr", "tidyr", "data.table"))

# Load libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(data.table)

# 1. Create a basic scatterplot using ggplot2
ggplot(mtcars, aes(x=mpg, y=hp)) + 
  geom_point(color="blue") + 
  ggtitle("Scatterplot of MPG vs HP") +
  theme_minimal()

# 2. Use dplyr to filter and arrange the iris dataset
iris_filtered <- iris %>%
  filter(Species == "setosa") %>%
  arrange(Sepal.Length)

print(head(iris_filtered))  # Display first few rows

# 3. Use tidyr to pivot a dataset from wide to long format and vice versa
wide_data <- data.frame(ID=c(1,2), A=c(10,20), B=c(30,40))

# Convert from wide to long format
long_data <- wide_data %>%
  pivot_longer(cols = c(A, B), names_to = "Variable", values_to = "Value")

print(long_data)

# Convert back from long to wide format
wide_data_again <- long_data %>%
  pivot_wider(names_from = Variable, values_from = Value)

print(wide_data_again)

# 4. Use data.table for simple aggregation
dt <- data.table(ID=1:5, Score=c(90,85,80,95,70))

# Calculate mean score
mean_score <- dt[, .(Mean_Score = mean(Score))]

print(mean_score)
