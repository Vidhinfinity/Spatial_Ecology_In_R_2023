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
