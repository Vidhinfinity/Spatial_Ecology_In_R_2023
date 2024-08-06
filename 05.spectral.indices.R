# Vegetation Indices
# Indices derived from remote sensing (RS) imagery

# Load the necessary libraries for handling and visualizing satellite imagery
library(imageRy)
library(terra)

# List available images in the working directory
im.list()

# Go to the professor's GitHub repository > imageRy > data description
# Here you will find a description of the data that we are using for examples in R and GitHub.
# We are going to use an image from Mato Grosso, an inland state of central Brazil.
# A railroad, followed by highways and airplanes, eventually connected this state with other regions in the twentieth century.

# Import the 1992 Mato Grosso image
im.import("matogrosso_l5_1992219_lrg.jpg")
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
# The bands are as follows:
# Band 1: NIR (Near-Infrared)
# Band 2: Red
# Band 3: Green

# Plot the 1992 image using different band combinations to visualize vegetation and other features
# Plot with NIR as red, red as green, and green as blue
im.plotRGB(m1992, r=1, g=2, b=3) 

# Another example of plotting the 1992 image with the same band combination for comparison
im.plotRGB(m1992, 1, 2, 3)

# Plot with NIR as green, red as red, and green as blue
im.plotRGB(m1992, r=2, g=1, b=3)

# Plot with NIR as blue, red as green, and green as red
im.plotRGB(m1992, r=2, g=3, b=1)

# Import the 2006 Mato Grosso image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
# Note: Ensure the file extension is included in the file path

# Plot the 2006 image with NIR as blue, red as green, and green as red
# This combination helps in visualizing soil and vegetation differences
im.plotRGB(m2006, r=2, g=3, b=1)
# When NIR is set to blue, we often see yellow for soil and different shades for vegetation.
