#This file includes all the scripts that were taught during the lectures.

## Summary:
# 01 Beginning
# 02.1 Population densities
# 02.2 Population distribution
# 03.1 Community overlap
# 03.2 Community multivariate analysis
# 04. Remote sensing data visualisation
# 05. Spectral indices
# 06. Time series
# 07. External data import
# 08. Copernicus data
# 09. Classification
# 10. Variability
# 11. Principal Component Analysis

 # Here I can write anything I want! 
# Basic R operations and plotting examples
# R as a calculator
2 + 3 # Simple addition

# Assigning the result of an addition to an object
vidhi <- 2 + 3
vidhi # Display the value of 'vidhi'

# Assign another addition result to an object
duccio <- 5 + 3
duccio  # Display the value of 'duccio'

# Perform arithmetic with objects
final <- vidhi * duccio
final  # Display the result of multiplication

final^2

# Creating arrays (vectors) for microplastics and people
sophi <- c(10, 20, 30, 50, 70) # microplastics # functions have parentheses and inside them there are arguments

paula <- c(100, 500, 600, 1000, 2000) # people

Plot (paula, sophi)

# Plotting data with axis labels
Plot (paula, sophi, xlab= "number of people" , ylab= "microplastics" )

# Assigning vectors to more descriptive variable names
people <- paula
microplastics <- sophi

# Basic scatter plot
plot(people, microplastics)

# Customize plot symbols
plot (people, microplastics, pch= 19)

# Increase symbol size
plot (people, microplastics, pch= 19, cex=5)

# Change symbol color to blue
plot (people, microplastics, pch= 19, cex=5, col= "blue")

--------------

# Population Ecology Analysis using Spatstat package

# Install and load the required package for point pattern analysis. 
## spatstat is an R package for spatial statistics with a strong focus on analysing spatial point patterns in 2D 
### (with some support for 3D and very basic support for space-time).
install.packages("spatstat")
library(spatstat)

# Use the 'bei' dataset from the spatstat package
# The 'bei' dataset contains tree locations in a forest plot
# More details: https://cran.r-project.org/web/packages/spatstat/index.html

# Plot the tree locations
plot(bei)

# Modify the plot by changing symbol size (cex)
plot(bei, cex = 0.5)
plot(bei, cex = 0.2)

# Change the plot symbol to a filled circle (pch = 19)
plot(bei, cex = 0.2, pch = 19)

# Additional dataset: 'bei.extra' which includes elevation data
plot(bei.extra)

# we need to take only elevation part of dataset. lets only use one part of dataset : elev. using $ sign to link
# Extract and plot the elevation data from 'bei.extra'
elevation <- bei.extra$elev
plot(elevation)

# Alternative method to extract elements from a list using double brackets.
# Double bracket parentheses as we are dealing with images. For tables, we have single parentheses
elevation2 <- bei.extra[[1]]
plot(elevation2)


# Start of a new section (10th October 2023)
# Continue working with the 'spatstat' package and 'bei' dataset

# The 'bei' dataset represents trees in a landscape; we will create a density map
# Create a density map from point data
densitymap <- density(bei)

# Plot the density map
plot(densitymap)

# Overlay the original tree points on the density map
points(bei, cex = 0.2)

#Color customization: Avoid using green, blue, and red for colorblind-friendly maps.
## Daltonic people cant see green blue and red so avoid using these colours in maps.

# Create a custom color palette from black to yellow
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
# cl is assigned to function and array of colors and 100 represent the numbers of colors passing.

# Plot the density map with the custom color palette
plot(densitymap, col = cl)

# Reduce the number of colors to make the map less continuous
cl <- colorRampPalette (c("black", "red", "orange", "yellow"))(4)  #changing the number from 100 to 4 will lead  to less continous map

# When you google colors in R, go to images, you will get codes for colors. Use them to edit the density map.
# virdis package for colors. On Google
plot(bei.extra)  # To obtain variables of elev and grad from the density map

# Lets only use one part of the dataset: elev. Using $ sign to link
elev <- bei.extra[[1]]  # Method 1
elevation <- bei.extra$elev  # Method 2
plot(elev)


## MULTIFRAME
## Par function, multiframe argument "mf". It is used to plot 2 things together. We are making a multiframe of density and elevation
par(mfrow = c(1, 2))
plot(densitymap)
plot(elev)


# If we want a plot of 2 rows and 1 column then change the mfrow to 2, 1
par(mfrow = c(2, 1))

# EXERCISE to make mf of bei density and elevation. 1 is the no. of rows, 3 is the no. of columns in the multiframe
par(mfrow = c(1, 3))
plot(bei)
plot(densitymap)
plot(elev)
--------------------------------

# Why do populations disperse over a landscape in a certain manner?
# This script explores the spatial distribution of species using the SDM package and other tools.

## Load required libraries
library(sdm)   # SDM package for species distribution modeling
library(terra) # Terra package for spatial data manipulation

## Note: While installing a package, use quotes around the package name. 
## When loading a library, quotes are not required.

# Load the species data
file <- system.file("external/species.shp", package="sdm") 
# system.file locates the path to the specified file within the package
# "external" is the folder, "species" is the file name, and "shp" is the file extension for shapefiles

# Read the vector file
rana <- vect(file)
# vect reads vector files (series of coordinates) using the Terra package

# Display occurrence data
rana$Occurrence 
# Occurrence column: 0 represents absence, 1 represents presence of the species (Rana in this case)

# Plot the species data
plot(rana)
plot(rana, cex=.5) # Reduce the size of points for better visualization

# Select and plot presences
pres <- rana[rana$Occurrence == 1,] 
# Select rows where the species is present (Occurrence == 1)

plot(pres, cex= .5) # Plot presences with reduced point size


## Exercise: Select absences and call them 'abse'
abse <- rana[rana$Occurrence == 0,] 
# Select rows where the species is absent (Occurrence == 0)
plot(abse) # Plot absences

## Exercise: Plot presences and absences side by side using a multi-frame layout
par(mfrow=c(1, 2)) # Set up a plotting area with 1 row and 2 columns
plot(pres)         # Plot presences
plot(abse)         # Plot absences
dev.off()          # Close the graphical device

## Exercise: Plot presences and absences with different colors
plot(pres, col= "dark blue")   # Plot presences in dark blue
points(abse, col= "light blue") # Overlay absences in light blue

# Load environmental predictor variables (rasters)
# Elevation predictor
elev <- system.file("external/elevation.asc", package="sdm")
elevmap <- rast(elev) # Read the elevation raster using Terra package
plot(elevmap)
points(pres, cex = .5) # Overlay presences on the elevation map

# Temperature predictor
temp <- system.file("external/temperature.asc", package="sdm")
tempmap <- rast(temp) # Read the temperature raster using Terra package
plot(tempmap)
points(pres, cex = .5) # Overlay presences on the temperature map


## Exercise: Load and plot the vegetation cover predictor
vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast(vege) # Read the vegetation raster using Terra package
plot(vegemap)
points(pres, cex = .5) # Overlay presences on the vegetation map

# Precipitation predictor
prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast(prec) # Read the precipitation raster using Terra package
plot(precmap)
points(pres, cex = .5) # Overlay presences on the precipitation map


## Plot multiple predictors in a 2x2 multi-frame layout
par(mfrow=c(2, 2)) # Set up a plotting area with 2 rows and 2 columns
plot(elevmap)     # Plot elevation map
plot(tempmap)     # Plot temperature map
plot(vegemap)     # Plot vegetation map
plot(precmap)     # Plot precipitation map
dev.off()         # Close the graphical device
----------------------------

# Overlap: Estimates of Coefficient of Overlapping for Animal Activity Patterns
# This script analyzes the temporal activity patterns of different species and their overlap using kernel density estimates.

## Load required library
library(overlap) # Overlap package for analyzing animal activity patterns

# Load and summarize the data
data(kerinci)  # Load the kerinci dataset provided by the overlap package
summary(kerinci) # Summarize the dataset to understand its structure and contents

## Analyze activity patterns of tigers

# Select data for the first species: tiger
tiger <- kerinci[kerinci$Sps == "tiger",] 
# Filter rows where the species is "tiger"

summary(tiger) # Summarize the tiger data
head(tiger)    # Display the first few rows of the tiger data

# The unit of time is the day, so values range from 0 to 1.
# The overlap package uses radians for fitting density curves (using trigonometric functions like sin, cos, tan).
# Convert the time to radians for accurate density calculations: kerinci$Time * 2 * pi
kerinci$timeRad <- kerinci$Time * 2 * pi 

# Select time data for tigers in radians
timetig <- tiger$timeRad 
# Extract the timeRad column for tigers

# Plot the density of tiger activity
densityPlot(timetig, rug=TRUE) 
# Plot the density of tiger activity with rug plot for individual data points

## Exercise: Analyze activity patterns of macaque individuals

# Select data for the second species: macaque
macaque <- kerinci[kerinci$Sps == "macaque",] 
# Filter rows where the species is "macaque"

head(macaque) # Display the first few rows of the macaque data

# Select time data for macaques in radians
timemac <- macaque$timeRad 
# Extract the timeRad column for macaques

# Plot the density of macaque activity
densityPlot(timemac, rug=TRUE) 
# Plot the density of macaque activity with rug plot for individual data points

# Use overlap to check the activity patterns of tigers and macaques together
# This helps to identify periods when tigers could potentially predate on macaques.

# Plot the overlapping density of tiger and macaque activity
overlapPlot(timetig, timemac) 
# Plot the overlap of tiger and macaque activity patterns
---------------------------------

# Working on community ecology today using the vegan package

# Load the vegan package
library(vegan)

# Load the dune dataset, which contains vegetation data
data(dune)

# Display the first 6 rows of the dataset to understand its structure
head(dune)

# The decorana function is used in ecology for multivariate analysis.
# It performs Detrended Correspondence Analysis (DCA), which helps to simplify complex ecological data.
ord <- decorana(dune)

# Display the DCA results
ord

# Define the lengths of DCA axes obtained from the decorana output
ldc1 <- 3.7004
ldc2 <- 3.1166
ldc3 <- 1.30055
ldc4 <- 1.47888

# Calculate the total length of all DCA axes
total <- ldc1 + ldc2 + ldc3 + ldc4

# Calculate the percentage contribution of each DCA axis to the total variation
pldc1 <- ldc1 * 100 / total
pldc2 <- ldc2 * 100 / total
pldc3 <- ldc3 * 100 / total
pldc4 <- ldc4 * 100 / total

# Display the percentage contribution of each DCA axis
pldc1
pldc2
pldc3
pldc4

# Calculate and display the sum of the first two DCA axes' percentages
pldc1 + pldc2 # Sum of the first two axes

# Plot the DCA results to visualize the relationships between species and samples
plot(ord)

# Example species to plot and interpret their positions in the ordination plot
# Bromus hordeaceus - a typical species of dunes
# Achillea - representative of grassland areas
# Salix repens - a shrub species

# Note: In the ordination plot, the position of species and samples indicates their ecological relationships.
# Species that are close together in the plot tend to occur together in the same samples.
# The graph helps to visualize which species are associated with each other and the different habitat types they represent.
----------------------------------

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
-------------------------------

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
------------------------------


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
---------------------
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
--------------------------

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

-----------------

#time series
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

----------------

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

----------------

# Working on copernicus data. Discussion on copernicus site and definitions.
#Leaf Area index: half the total area of green elements of the canopy per unit horizontal ground area.
#FCOVER (Fraction of Vegetation Cover): the fraction of ground covered by green vegetation.
#FAPAR (Fraction of Absorbed Photosynthetically Active Radiation): the fraction of the solar radiation absorbed by live leaves for the photosynthesis activity. 
#NDVI: Normalized Difference Vegetation Index: NDVI = (REF_nir – REF_red)/(REF_nir + REF_red)
#Dry Matter Productivity (DMP) represents the overall growth rate or dry biomass increase of the vegetation.
#energy, water cycle and cryosphere parameters being discussed.

#login to Copernicus > choose a collection > blue arrow for download > pop up window explaining the image information
 Data available at:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# Load the required libraries
install.packages("ncdf4")  # Install the ncdf4 package if not already installed
library(ncdf4)
library(terra)

# Set the working directory where your data files are located
setwd("C:/Users/HP/Downloads")  # Replace with the actual path to your data

# Import the raster data from Copernicus (NetCDF format)
soilm <- rast("c_gls_SSM1km_201511280000_CEURO_S1CSAR_V1.1.1.nc")

# Plot the entire raster dataset to visualize the full extent
plot(soilm)

# Plot the first band of the raster dataset
plot(soilm[[1]])

# Define a color palette for visualization
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)

# Plot the first band of the raster dataset with the defined color palette
plot(soilm[[1]], col = cl)

# Define the extent for cropping: c(minlong, maxlong, minlat, maxlat)
ext <- c(22, 26, 55, 57)  # Longitude and latitude coordinates

# Crop the raster dataset based on the defined extent
soilmc <- crop(soilm, ext)

# Plot the cropped raster dataset
plot(soilmc[[1]], col = cl)

# Import and crop another raster dataset
soilm24 <- rast("c_gls_SSM1km_201511240000_CEURO_S1CSAR_V1.1.1.nc")

# Crop the new raster dataset using the same extent
soilmc24 <- crop(soilm24, ext)

# Plot the cropped raster dataset for the new image
plot(soilmc24[[1]], col = cl)
----------------------

# Classifying remote sensing data

# THEORY: Grouping the pixels to make a final class. If you have an image say having forest cover having different parts like water and agriculture, if we take
# 2 bands for example like red band for x axis and  NIR band for y. we will see the reflectance in terms of random pixels. water will abosrb all NIR and may relect some red.
# Different areas will reflect light at different points. Classes or cluster is a set of individuals having similar characteristics.
# The smallest distance to the nearest class is calculated to assign a class to an incognito class.
#you can assign classes to different pixels.

 # Procedure for classifying remote sensing data

library(terra)
library(imageRy)
im.list() # sun images to classify the images of sun radiations

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") # to import the sun image
#high level : yellow ; lower level: brownish;  low level : black color

# im.classify is the function followed by (image, number of clusters you want to put)
im.classify (sun, num_clusters = 3)
sunc <- im.classify (sun, num_clusters = 3)
plot(sunc) #class with yellow area will represent the higher energy which in this case is 1.

# working with mattogosso forest time change # Classify Satelitte data
#step 1 : import the images
m1992 <- im.import ("matogrosso_ast_2006209_lrg.jpg")                   
m2006 <- im.import ( "matogrosso_l5_1992219_lrg.jpg")
# step 2 classification
m1992c <- im.classify (m1992, num_clusters=2)
# step 3 plot
plot(m1992c) 
#classes: forest =1 ; human = 2

#step 4: same for 2006 image
# step 2 classification
m2006c <- im.classify (m2006, num_clusters=2)
# step 3 plot
plot(m2006c) 
#classes: forest =1 ; human = 2

#step 5: plotting multi-frame of both plots

par(mfrow=c(1,2))
plot(m1992c) 
plot(m2006c)

# To see the frequency we use the below function, to see how many pixels are attaining to a forest and how many to humans.
f1992c <- freq(m1992c)

# let's extract the total number of pixels from images
tot1992 <- ncell(m1992c)

#percentage: frequency *100/ total

p1992 <- f1992 *100 / tot1992
p1992

#forest: 54% ; humans: 45%

#calculate freq, total and percentage for 2006 image
f2006c <- freq(m2006c)
tot2006 <- ncell(m2006c)
p2006 <- f2006c *100 / tot2006
p2006

# #forest: 16% ; humans: 83%

#building the final table
class <- c("forest", "human")
y1992 <- c (54, 45)
y2006 <- c (16, 83)

#putting everything together
tabout <- data.frame (class, y1992, y2006)
tabout

## final plot # we will make a barplot with tabout
p1 <- ggplot(tabout, aes(x=class, y=1992, color=cover)) + geom_bar(stat="identity", fill="white"))
p2 <- ggplot(p, aes(x=cover, y=perc2006, color=cover)) + geom_bar(stat="identity", fill="white"))
p1+p2

#12dec23

# Building the final table
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55) 

tabout <- data.frame(class, y1992, y2006)
tabout

# final output
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2 

# scales are used in the above case to soften the impact of change as the y limit is different in the two graphs.

# final output, rescaled
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2

#now, the above graph shows the same limits on the y-axis. The loss of forest detection was determined by comparing 1992 and 2006.
----------------------------------

# measurements of RS based variability

# Load necessary libraries
library(terra)    # For raster data processing
library(imageRy)  # For image import and manipulation
library(viridis)  # For creating perceptually uniform color palettes

# List available images in the workspace
im.list()

# Import the Sentinel image from the specified file
sent <- im.import("sentinel.png")

# Plot the image using RGB bands
# Band 1 - NIR (Near-Infrared), Band 2 - Red, Band 3 - Green
im.plotRGB(sent, r = 1, g = 2, b = 3) # Plotting the image

# Extract the NIR band from the Sentinel image
NIR <- sent[[1]]
plot(NIR)

# Method called "moving window" is used to check variability.
# Function called focal is used in R to calculate standard deviation.
# Correct focal call to calculate standard deviation using a 3x3 window
sd3 <- focal(NIR, matrix(1/9, 3, 3), fun = sd)
plot(sd3)

# Create a color palette using viridis
viridis <- colorRampPalette(viridis(7))(255) # Variability in space

# Plotting standard deviation with 3x3 window using viridis palette
plot(sd3, col = viridis)

# Calculate standard deviation using a 7x7 window
sd7 <- focal(NIR, matrix(1/49, 7, 7), fun = sd)
plot(sd7)

# Plotting standard deviation with 7x7 window using viridis palette
viridis <- colorRampPalette(viridis(7))(255)
plot(sd7, col = viridis)

----------------

# Multivariate analysis #Dimensionality #Book recommendation: Numerical Ecology by Legendre
# Take 3 bands of Sentinel data and compact them into one. Use principal components: PC1 and PC2.

library(imageRy) # Library for image processing
library(viridis) # Library for color scales
library(terra)   # Library for spatial data

im.list() # List available images

# Import Sentinel image
sent <- im.import("sentinel.png")

# Pairs function is used to make a plot to see correlation. 1 is a perfect positive correlation and -1 is a negative correlation.
# Perform PCA on the Sentinel image
sent.pca <- im.pca(sent)

# Isolating PC1
pc1 <- sent.pca$PC1
plot(pc1) # Plot PC1

# Calculation of standard deviation on top of PC1 using a 3x3 moving window
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridis) # Plot with viridis color scale

# Calculation of standard deviation on top of PC1 using a 7x7 moving window
pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridis) # Plot with viridis color scale

# Plotting all graphs together
par(mfrow=c(2, 3)) # Set up the plotting area to have 2 rows and 3 columns

# Plot the original Sentinel image using bands 2, 1, and 3
im.plotRGB(sent, r=2, g=1, b=3)

# Plot the standard deviation from the variability script
plot(sd3, col=viridis)
plot(sd7, col=viridis)
plot(pc1, col=viridis)
plot(pc1sd3, col=viridis)
plot(pc1sd7, col=viridis)

# Stack all standard deviation layers
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
plot(sdstack, col=viridis) # Plot the stack with viridis color scale

# Assign names to the layers in the stack
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridis) # Plot the named stack with viridis color scale.

------------

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

-------
