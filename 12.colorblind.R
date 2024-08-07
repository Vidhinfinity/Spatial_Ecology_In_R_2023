# Install and load the necessary packages

# Load the 'devtools' package, which provides functions to install packages from sources like GitHub
library(devtools)  

# Load the 'colorblindr' package, which allows for simulating color-blind vision in plots
library(colorblindr)  

# Install the 'colorblindr' package from GitHub
# The install_github function from the 'devtools' package is used to install the package directly from its GitHub repository
install_github("clauswilke/colorblindr")

# Load the 'ggplot2' package, which is a popular package for creating complex plots in R
library(ggplot2)  

# Create a density plot of Sepal.Length with color fill based on species
# ggplot() initializes a plot object with the data and aesthetic mappings
# aes() defines how data should be mapped to plot aesthetics
# geom_density() adds a density plot layer with specified transparency (alpha = 0.7)
fig <- ggplot(iris, aes(Sepal.Length, fill = Species)) + 
  geom_density(alpha = 0.7)  

# Display the density plot
# The 'fig' object contains the plot created by ggplot2
# When evaluated, it displays the plot in the R environment or RStudio viewer
fig  

# Simulate color-blind vision for the density plot of Sepal.Length
# cvd_grid() from the 'colorblindr' package applies a simulation of color-blind vision to the plot
# This helps to visualize how the plot appears to individuals with different types of color blindness
cvd_grid(fig)  

------------------------------------------------------------------------------------

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
