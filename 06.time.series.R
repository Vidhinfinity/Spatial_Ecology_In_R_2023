#time series analysis
library (terra)
library(imagRY)

#we are making a list of images to use.
im.list()

#import the data

EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

#creating multi frame
par(mfrow= c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#diff between the two band images
diff <-EN01[[1]] - EN13[[1]] #difference in band 1 of image 1 and band 1 of image 13.

cldif <- colorRampPalette(c('blue','white','red'))(100) 
plot(diff, col=cldif) #all red parts are those where values are higher in January. 

#copernicus: to provide data. Vegetation state, Energy budget, water cycle, cryosphere.

##New example: temperature in Greenland

im.list() #to get data

g2000 <-im.import( "greenland.2000.tif" ) #import image
clg <- colorRampPalette(c('blue','white','red'))(100) #colorpalette
plot (g2000, col=clg) #plotting graph using image and color palette

#importing images from 3 different years

g2005 <-im.import("greenland.2005.tif" )                               
g2010 <-im.import("greenland.2010.tif" )                               
g2015 <-im.import("greenland.2015.tif")
clg <- colorRampPalette(c('black', 'blue','white','red'))(100)
plot (g2015, col=clg)


par(mfrow =c (1,2))
plot (g2000, col=clg)
plot (g2015, col=clg)

#making a stack of bands of images, instead of plotting 4 different images, we stack the 4 images in a single step.

stackg <- c(g2000, g2005, g2010, g2015)
plot (stackg, col=clg) 

#make difference between first and final elements of the stack
difg <- stackg [[1]] - stackg [[4]]
plot( diffg, col= cldiff)

##Note: on thursday we will work on our own data. How to use data for the exam.

#take image from 2000 and put on red channel, 2005: green, 2010: blue. If high value temp in 2000, they will become red, 
#simliarly in  2005 these spots will become green and 2010 blue. If the majority area is blue, so we can conclude that the temperature is higher during the final period.

#Excercise: Make an RGB plot using different years.
im.plotRGB(stackg, r=1, g=2, b=3)

#we have the possibility of seeing changes in the landscape and monitoring such changes by human beings is difficult and if you use satellite images it makes things easier.

#earth observatory  site> search bar > drought> you can download images from 2 different years. # learn how to take image from network, put in computer and use that in analysis.

