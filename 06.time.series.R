# Load necessary libraries
library(terra)
library(imageRy)

# List available images in the working directory
im.list()

# Import the data
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

# Create a multi-frame layout to display the images
par(mfrow = c(2, 1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

# Calculate the difference between the two images (for band 1)
diff <- EN01[[1]] - EN13[[1]]

# Define a color palette for the difference plot
cldif <- colorRampPalette(c('blue', 'white', 'red'))(100)

# Plot the difference
plot(diff, col = cldif)

# Copernicus: to provide data on vegetation state, energy budget, water cycle, cryosphere.

# Example: Temperature in Greenland

# List available images in the working directory
im.list()

# Import the Greenland images from different years
g2000 <- im.import("greenland.2000.tif")
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

# Define a color palette for the Greenland plots
clg <- colorRampPalette(c('black', 'blue', 'white', 'red'))(100)

# Plot the 2000 and 2015 Greenland images side by side
par(mfrow = c(1, 2))
plot(g2000, col = clg)
plot(g2015, col = clg)

# Stack the Greenland images into a single object
stackg <- c(g2000, g2005, g2010, g2015)

# Plot the stacked images
plot(stackg, col = clg)

# Calculate the difference between the first and last elements of the stack
diffg <- stackg[[1]] - stackg[[4]]
plot(diffg, col = cldif)

# Exercise: Make an RGB plot using different years
# Assign 2000 to red, 2005 to green, and 2010 to blue
im.plotRGB(stackg, r = 1, g = 2, b = 3)

# Note: Using satellite images, we can monitor changes in the landscape, making it easier to detect changes over time.

# Earth Observatory site: Search for 'drought' to find and download images from different years.
# Learn how to download images from the network, save them on your computer, and use them in analysis.
