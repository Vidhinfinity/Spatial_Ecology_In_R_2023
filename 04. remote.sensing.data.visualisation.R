# Load the necessary libraries for handling and visualizing satellite imagery
library(imageRy)
library(terra)

# List available images in the working directory
im.list()

# Importing Sentinel-2 bands
b2 <- im.import("sentinel.dolomites.b2.tif") # Blue band
b3 <- im.import("sentinel.dolomites.b3.tif") # Green band
b4 <- im.import("sentinel.dolomites.b4.tif") # Red band
b8 <- im.import("sentinel.dolomites.b8.tif") # Near-Infrared (NIR) band

# Associate bands with components
# Stack the imported bands into a single image stack
stacksent <- c(b2, b3, b4, b8)

# RGB space visualization
# Create RGB images by mapping different bands to the RGB channels

# Standard RGB visualization: Red = b4, Green = b3, Blue = b2
im.plotRGB(stacksent, r=3, g=2, b=1)

# Enhanced RGB visualization with NIR: Red = NIR, Green = Red, Blue = Green
im.plotRGB(stacksent, r=4, g=3, b=2)

# Visualization with NIR as green: Red = Red, Green = NIR, Blue = Green
im.plotRGB(stacksent, r=3, g=4, b=2)
# Violet indicates bare soil, green indicates trees, and black indicates shadows

# Visualization with NIR as blue: Red = Red, Green = Green, Blue = NIR
im.plotRGB(stacksent, r=3, g=2, b=4)
# Moving NIR from green to blue shows all vegetation as blue

# These visualizations show the colors of reflectance, which is the ratio between incidence and radiance.

# Correlation analysis between bands
# Use the pairs() function to see the correlation between bands
pairs(stacksent)
# The 0.99 or 0.71 values represent the correlation between bands from respective rows and columns.
# The graphs represent the frequency of reflectance.
# Scatter plots represent the correlation; more linear means more correlated.

# Difference Vegetation Index (DVI)
# Example: The difference between NIR and Red bands
# If DVI is 80 in 1990 and the same DVI in 2023 is 10, it indicates deforestation in that specific area.
dvi <- b8 - b4
plot(dvi, col=colorRampPalette(c("blue", "white", "green"))(100))
# DVI calculation example; you can visualize it by plotting
