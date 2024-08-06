#external data import
# Load the required library
library(terra)

# Set the working directory to where your data files are located
# Replace "your path" with the actual path to your data folder
setwd("C:/Users/HP/Downloads")

# Import the raster image using the `rast` function from the terra package
naja <- rast("najaf.jpg")

# Plot the RGB image
# r = 1 (Red), g = 2 (Green), b = 3 (Blue) - Adjust according to your image bands
plotRGB(naja, r = 1, g = 2, b = 3)

# Exercise: Download the second image from the same site and import it
najaaug <- rast("najaf2.jpg")
plotRGB(najaaug, r = 1, g = 2, b = 3)

# Create a multi-frame plot to compare the two images side-by-side
par(mfrow = c(2, 1))
plotRGB(naja, r = 1, g = 2, b = 3)
plotRGB(najaaug, r = 1, g = 2, b = 3)

# Exercise: Multitemporal change detection
# Calculate the difference between the two images (band 1)
najadif <- naja[[1]] - najaaug[[1]]

# Define a color palette for the difference plot
cl <- colorRampPalette(c("brown", "grey", "orange"))(100)

# Plot the difference
plot(najadif, col = cl)

# Import additional images for Brazil from different years
brazil <- rast("brazil_oli_2019163_lrg.jpg")
brazil2021 <- rast("brazil_oli_2021168_lrg.jpg")

# Plot the RGB images for Brazil for the two years
plotRGB(brazil, r = 1, g = 2, b = 3)
plotRGB(brazil2021, r = 1, g = 2, b = 3)

# Create a multi-frame plot to compare the two Brazil images side-by-side
par(mfrow = c(2, 1))
plotRGB(brazil, r = 1, g = 2, b = 3)
plotRGB(brazil2021, r = 1, g = 2, b = 3)

# Note: The Mato Grosso image can be downloaded directly from the Earth Observatory.
# For the next lecture on November 28, make sure to install the `ncdf4` package if needed.
