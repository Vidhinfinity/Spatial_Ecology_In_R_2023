# 02november2023

# RS data

library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
install_github("ducciorocchini/imageRy")  # from devtools

library(imageRy)
library(terra)
# in case you have not terra
# install.packages("terra")

# now we will use a package
im.list() #all imagry package start will im. #we will use the sentinal data #on the duccio YT channel you can find video on how to download sentinal data

#We have spectral bands of various colors in sentinal 

# we are importing sentinal band number 2 from the data
b2 <- im.import("sentinel.dolomites.b2.tif")

# in the console we get the data about this band, coord. ref. : WGS 84 / UTM zone 32N (EPSG:32632) 
# y axis is the distance from equator 
# x axis is the distance from central merridean. 

#for different we will use following finctions
cl <- colorRampPalette(c("dark grey","grey","light grey")) (100)
plot(b2, col=cl) we will get a plot based on blue wavelength

#now we see it with band 3 wavelength
# import the green band from Sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif") 
plot(b3, col=cl)

# import the red band from Sentinel-2 (band 4)
b4 <- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=cl)

#EXercise Import the NIR band from sentinel-2 (band 8)
b8 <- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=cl)

#multiframes of four bands in a plots b2 blue, b3 green, b4 red and b8 infrared
#functions used for multiframe par(mfrow)

par(mfrow= c(2,2))
plot (b2, col=cl)
plot (b3, col=cl)
plot (b4, col=cl)
plot (b8, col=cl)

# now we will pack all these 4 plots of 4 bands in a single image

#stack images
stacksent <- c(b2, b3, b4, b8)
dev.off() #it closes devices and graphs. clean slate

plot (stacksent, col=cl)

plot (stacksent[[4]], col=cl) # to extract the NIr that is the fourth element of this graph we use this function.

#theory on how satellite images work are being taught through ppt

#lets use different color palletes for different bands. 
# Excercise : Plot in a multiframe the bands with different color ramps

par(mfrow= c(2,2))
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot (b2, col=clb)
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot (b3, col=clg)
clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot (b4, col=clr)
cln <- colorRampPalette(c("brown","yellow","orange")) (100)
plot (b8, col=cln)

#rgb space
# RGB r is the red color b3, g stands for green b2 and b for blue b1, x is the image
# stacksent: 
#band 2 blue element 1, stacksent [[1]]
#band 3 green element 2, stacksent [[2]]
#band 4 red element 3, stacksent [[3]]
# band 8 NIR element 4, stacksent [[4]]

im.plotRGB (stacksent, r=3, g=2, b=1)
