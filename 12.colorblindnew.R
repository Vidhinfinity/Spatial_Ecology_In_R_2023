# Install and load the 'colorblindr' package, which is used to simulate color-blind vision
# Note: Ensure you have 'devtools' installed before running this
library(devtools)
devtools::install_github("clauswilke/colorblindr")  # Install colorblindr from GitHub
library(colorblindr)  # Load the colorblindr package

# Load the 'ggplot2' package for creating visualizations
library(ggplot2)  # Load ggplot2 for plotting

# Display the first few rows of the 'iris' dataset to understand its structure
head(iris)  # Show the first few rows of the iris dataset

# Create a density plot of Sepal.Length, colored by Species
fig <- ggplot(iris, aes(x = Sepal.Length, fill = Species)) +  # Define aesthetics with Sepal.Length and Species
  geom_density(alpha = 0.7)  # Create a density plot with transparency

# Display the density plot
print(fig)  # Print the plot to the R console

# Simulate color-blind vision for the current density plot
cvd_grid(fig)  # Apply color-blind simulation to the plot

# Create a density plot of Sepal.Width, colored by Species
fig <- ggplot(iris, aes(x = Sepal.Width, fill = Species)) +  # Define aesthetics with Sepal.Width and Species
  geom_density(alpha = 0.7)  # Create a density plot with transparency

# Display the density plot
print(fig)  # Print the plot to the R console

# Simulate color-blind vision for the current density plot
cvd_grid(fig)  # Apply color-blind simulation to the plot
