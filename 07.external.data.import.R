#external data import
library(terra) 
#concept is called working directory. We can set working directory by function called set working directory 
setwd ("your path")
#for windows users: change the slash in your path to / 
setwd("C:/Users/HP/Downloads")

#rast is the function to upload the data(image) in the terra library.
#this is like the im.import function where we put name of image from the data imageRY and assign it to an object.
naja <- rast("najaf.jpg")  

#we can now plot the image, here we use func from terra. name of image an dbands corresponding to RGB image.
plotRGB (naja, r=1, g=2, b=3)

#exercise download the second image from same site and import on R
najaaug <- rast("najaf2.jpg")
plotRGB (najaaug, r=1, g=2, b=3)

par(mfrow =c(2,1))
plotRGB (naja, r=1, g=2, b=3)
plotRGB (najaaug, r=1, g=2, b=3)

#excercise: multitemporal change detection
najadif = naja[[1]] - najaaug[[1]]]
cl <- colorRampPalette("brown", "grey", "orange") (100)
plot (najadif, col= cl)

#we are going to download our own images. I have chosen drought in Brazil in 2019 vs 2021. It is better to maintain the same name as it will redirect you to the same image in the future of the earth observatory.
brazil <- rast("brazil_oli_2019163_lrg.jpg")
plotRGB( brazil, r=1, g=2, b=3)

brazil2021 <- rast("brazil_oli_2021168_lrg.jpg")
plotRGB( brazil2021, r=1, g=2, b=3)

par(mfrow =c(2,1))
plotRGB( brazil, r=1, g=2, b=3)
plotRGB( brazil2021, r=1, g=2, b=3)

#the Mato Grosso image can be downloaded directly from the Earth Observatory as well instead of imagery.

# ncdf4 package needs to be installed for the next lecture. Lecture on Copernicus on november28. 




