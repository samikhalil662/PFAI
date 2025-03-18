# Load required packages
#install.packages(c("lubridate", "rvest", "caret", "xts", "zoo")) # Install packages if needed
library(lubridate)
library(rvest)
library(caret)
library(xts)
library(zoo)

# ------------------ 1. Parsing and Formatting Dates ------------------
current_date <- Sys.Date()
formatted_date <- format(current_date, "%A, %d %B %Y")
cat("Formatted Date:", formatted_date, "\n")

# Parsing a specific date string
date_str <- "2025-03-18"
parsed_date <- ymd(date_str)
cat("Parsed Date:", parsed_date, "\n")

# ------------------ 2. Web Scraping with rvest ------------------
url <- "https://example.com"  # Replace with a real website
webpage <- read_html(url)

# Extracting the first <h1> element from the webpage
title <- webpage %>% html_node("h1") %>% html_text()
cat("Webpage Title:", title, "\n")

# ------------------ 3. Classification Model with caret ------------------
# Create a simple dataset
data(iris)
set.seed(123)

# Split into training and testing sets
trainIndex <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
trainData <- iris[trainIndex, ]
testData <- iris[-trainIndex, ]

# Train a classification model (Random Forest)
model <- train(Species ~ ., data = trainData, method = "rf", trControl = trainControl(method = "cv", number = 5))
cat("Model Training Completed!\n")

# Predict on test data
predictions <- predict(model, testData)
confMatrix <- confusionMatrix(predictions, testData$Species)
print(confMatrix)

# ------------------ 4. Time-Series Data Visualization with xts & zoo ------------------
# Create a sample time-series dataset
set.seed(123)
dates <- seq(as.Date("2024-01-01"), by = "month", length.out = 12)
values <- rnorm(12, mean = 50, sd = 10)

# Convert to xts and zoo objects
time_series_xts <- xts(values, order.by = dates)
time_series_zoo <- zoo(values, dates)

# Plot the time-series data
plot(time_series_zoo, type = "o", col = "blue", main = "Time-Series Data", xlab = "Date", ylab = "Values")
