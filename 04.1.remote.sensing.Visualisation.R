# 02 November 2023
# This script visualizes remote sensing (RS) data using the imageRy and terra packages

# Load the devtools package, which is used to install packages from GitHub
library(devtools) 

# Install the imageRy package from GitHub
install_github("ducciorocchini/imageRy")  # from devtools

# Load the imageRy and terra packages for handling and visualizing satellite imagery
library(imageRy)
library(terra)

# If the terra package is not installed, uncomment the following line:
# install.packages("terra")

# List available images in the working directory
im.list() 
# All imageRy package functions start with "im."
# Sentinel data can be used, and instructions on downloading Sentinel data can be found on Duccio Rocchini's YouTube channel

# Importing spectral bands from Sentinel-2 data
# We have spectral bands of various colors in Sentinel-2

# Import the blue band (band 2) from Sentinel-2 data
b2 <- im.import("sentinel.dolomites.b2.tif")

# The console provides metadata about this band, such as the coordinate reference system: WGS 84 / UTM zone 32N (EPSG:32632)
# The y-axis represents the distance from the equator
# The x-axis represents the distance from the central meridian

# Define a grayscale color palette for plotting
cl <- colorRampPalette(c("dark grey","grey","light grey"))(100)
# Plot the blue band using the defined color palette
plot(b2, col=cl)

# Import and plot the green band (band 3) from Sentinel-2 data
b3 <- im.import("sentinel.dolomites.b3.tif") 
plot(b3, col=cl)

# Import and plot the red band (band 4) from Sentinel-2 data
b4 <- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=cl)

# Exercise: Import and plot the NIR band (band 8) from Sentinel-2 data
b8 <- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=cl)

# Plot multiple frames of the four bands (b2: blue, b3: green, b4: red, b8: infrared)
# Use the par() function to set up a multi-frame layout
par(mfrow= c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# Stack the four bands into a single image stack
stacksent <- c(b2, b3, b4, b8)

# Close all graphical devices and clean the slate
dev.off() 

# Plot the stacked image with the defined color palette
plot(stacksent, col=cl)

# Extract and plot the NIR band (fourth element) from the stack
plot(stacksent[[4]], col=cl) 

# Theory on how satellite images work can be taught through a PowerPoint presentation

# Exercise: Use different color palettes for different bands and plot them in a multi-frame layout
par(mfrow= c(2,2))
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(b2, col=clb)
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(b3, col=clg)
clr <- colorRampPalette(c("dark red","red","pink"))(100)
plot(b4, col=clr)
cln <- colorRampPalette(c("brown","yellow","orange"))(100)
plot(b8, col=cln)

# RGB composite image
# In RGB space, R stands for the red band (b4), G stands for the green band (b3), and B stands for the blue band (b2)
# stacksent contains the bands: 
#   band 2 (blue) as element 1: stacksent[[1]]
#   band 3 (green) as element 2: stacksent[[2]]
#   band 4 (red) as element 3: stacksent[[3]]
#   band 8 (NIR) as element 4: stacksent[[4]]

# Create and plot an RGB composite image using the specified bands
im.plotRGB(stacksent, r=3, g=2, b=1)
# This function creates an RGB image using the red band (b4), green band (b3), and blue band (b2)
