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
