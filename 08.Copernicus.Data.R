# Working on copernicus data. Discussion on copernicus site and definitions.
#Leaf Area index: half the total area of green elements of the canopy per unit horizontal ground area.
#FCOVER (Fraction of Vegetation Cover): the fraction of ground covered by green vegetation.
#FAPAR (Fraction of Absorbed Photosynthetically Active Radiation): the fraction of the solar radiation absorbed by live leaves for the photosynthesis activity. 
#NDVI: Normalized Difference Vegetation Index: NDVI = (REF_nir – REF_red)/(REF_nir + REF_red)
#Dry Matter Productivity (DMP) represents the overall growth rate or dry biomass increase of the vegetation.
#energy, watercycle and cryosphere parameters being discussed.

#login to Copernicus > choose a collection > blue arrow for download > pop up window explaining the image information
 Data available at:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html
#library to read the NC files, we have to install package 
install.packages("ncdf4")
library(ncdf4) 

#explaining R where the data is going to be stored, we are inside R and we going outside to get the data. 
#set a working directory with the path of your data. to know the path go to your image, right click, properties. path

setwd ("C:/Users/HP/Downloads")

# newnameoftheobject <- rast ("name of the file here")
soilm <- rast ("c_gls_SSM1km_201511280000_CEURO_S1CSAR_V1.1.1.nc")

plot(soilm)
#there are two image elements, but now we take only a single image by using the following fiction
plot (soilm[[1]])

cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(soilm[[1]], col= cl)

#define a variable, here it is minimum and max longitude and latitude

ext <- c (22, 26, 55, 57) #minlong, maxlong, minlat, maxlat .lat is the y axis and long is x-axis pts of plot
soilmc <- crop (soilm, ext) #used the function "crop" by using the coordinates of longitude and latitude to crop the image

plot (soilmc [[1]], col= cl) #plotting the new image

#we adownload another image, the idea is thatw e can now crop this image based on previous image, now we have 2 images cropped at different time intervals on same longi and lattitudes
#new image

soilm24 <- rast ("c_gls_SSM1km_201511240000_CEURO_S1CSAR_V1.1.1.nc")
soilmc24 <- crop (soilm, ext)
plot (soilmc24 [[1]], col= cl)
