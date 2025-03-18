# Install required packages (Run only if not installed)
install.packages("plotly")

# Load the library
library(plotly)

# 1. Create an Interactive Plot using plotly
library(ggplot2)

p <- ggplot(mtcars, aes(x=mpg, y=hp)) +
  geom_point(color="red") +
  ggtitle("Interactive Scatterplot of MPG vs HP") +
  theme_minimal()

# Convert ggplot to interactive plotly plot
ggplotly(p)

# -----------------------------------------------
# 2. Debugging a Simple R Script
# -----------------------------------------------

# 2.1 Syntax Error Example
# Incorrect Code (Uncomment to see the error)
# x <- 10
# y <- 5
# result <- (x + y  # ERROR: Missing closing bracket

# Corrected Code
x <- 10
y <- 5
result <- (x + y)  # Fixed syntax
print(result)

# -----------------------------------------------
# 2.2 Logical Error Example
# Incorrect Code: The function should multiply, not add
calculate_area <- function(length, width) {
  return(length + width)  # ERROR: Incorrect formula (addition instead of multiplication)
}

area_wrong <- calculate_area(5, 10)  # Expected 50, but returns 15
print(area_wrong)  # Debug this output

# Corrected Code
calculate_area_fixed <- function(length, width) {
  return(length * width)  # Corrected formula
}

area_correct <- calculate_area_fixed(5, 10)  # Now correctly returns 50
print(area_correct)

# -----------------------------------------------
# 3. Debugging Tools
# -----------------------------------------------

# Using traceback() after an error
traceback()  

# Step through function execution with debug()
debug(calculate_area_fixed)  
calculate_area_fixed(5, 10)  # Step through the function

# Pause execution for debugging
browser()  

# End debugging mode
undebug(calculate_area_fixed)
