# This script visualizes satellite data

# Load the devtools package, which is used to install packages from GitHub
library(devtools) 

# Install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")

# Load the imageRy package, which is used for handling satellite imagery
library(imageRy)
# Load the terra package, which is used for spatial data manipulation
library(terra)

# List available images in the working directory
im.list()

# Importing satellite data
# Import the blue band (B2) from Sentinel-2 imagery
b2 <- im.import("sentinel.dolomites.b2.tif") 
# b2 represents the blue wavelength band from the Sentinel-2 satellite image

# Display the imported blue band data
b2
