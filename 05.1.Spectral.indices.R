# This script visualizes vegetation indices using satellite imagery

# Install and load necessary packages
install.packages("ggplot2")
install.packages("viridis")
library(ggplot2)
library(viridis)
library(terra)
library(imageRy)

# List available images in the working directory
im.list()

# Import the 1992 image of Matogrosso from Landsat 5
im.import("matogrosso_l5_1992219_lrg.jpg")
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# Display information about the imported image
m1992

# The bands in the image are: 1 = NIR (Near-Infrared), 2 = Red, 3 = Green

# Plot RGB combinations of the 1992 image
im.plotRGB(m1992, r=1, g=2, b=3) # NIR is put on red, everything red reflects NIR
im.plotRGB(m1992, 1, 2, 3) # Standard RGB visualization
im.plotRGB(m1992, r=2, g=1, b=3) # NIR on green
im.plotRGB(m1992, r=2, g=3, b=1) # NIR on blue, vegetation becomes blue, bare soil is yellow

# Import the 2006 image of Matogrosso from ASTER
m2006 <- im.import("matogrosso_ast_2006209_lrg")
im.plotRGB(m2006, r=2, g=3, b=1) # NIR on blue for 2006 image

# Build a multiframe with 1992 and 2006 images for comparison
par(mfrow=c(1, 2)) # Function to build a multiframe with 1 row and 2 columns
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)
dev.off() # Close the graphical device

# Plot the NIR band of the 1992 image
plot(m1992[[1]])

# Explanation of reflectance range (0 to 255) and bits
# Reflectance is the ratio between incidence and reflected radiance flux. Bits represent information.
# The range 0 to 255 comes from 8-bit information (2^8 = 256).

# Calculate the Difference Vegetation Index (DVI)
# DVI = NIR - RED
dvi1992 <- m1992[[1]] - m1992[[2]] # DVI of 1992
plot(dvi1992)

# Change the color palette for better visualization
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black"))(100)
plot(dvi1992, col=cl)
# Dark red indicates healthy vegetation, while yellow and blue indicate bare soil.

# Calculate and plot DVI for 2006
dvi2006 <- m2006[[1]] - m2006[[2]]
plot(dvi2006)
plot(dvi2006, col=cl) # Use the same color palette as for 1992

# Calculate the Normalized Difference Vegetation Index (NDVI)
# NDVI = (NIR - RED) / (NIR + RED)
ndvi1992 <- (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=cl)

# Calculate and plot NDVI for 2006
ndvi2006 <- (m2006[[1]] - m2006[[2]]) / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)

# Plot NDVI for 1992 and 2006 side by side
par(mfrow=c(1, 2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# Use a different color palette for better contrast
clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100)
plot(ndvi1992, col=clvir)
plot(ndvi2006, col=clvir)

# Speeding up the calculation using im.ndvi function from imageRy package
ndvi2006a <- im.ndvi(m2006, 1, 2) # Calculate NDVI using the predefined function
plot(ndvi2006a, col=cl) # Plot the calculated NDVI
