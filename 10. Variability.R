# measurements of RS based variability

library(terra)
library(imageRy)
library(viridis)

im.list()

sent <- im.import("sentinel.png")
im.plotRGB(sent, r= 1, g= 2, b= 3) #plotting the image
#band 1 - NIR
#band 2 - red
#band 3 - green

NIR <- sent [[1]]
plot (NIR)

#method called "moving window" is used to check variability. Function called focal is used in R. It is going to dp calculate standard deviation in our case.

focal (NIR, matri) #nir is the band, matrix is describing the dimension of the moving window, composed of 9 pixels made of 3 * 3 dimensions. function is sd that is std deviation
sd3 <- focal(NIR, matrix(1/9, 3, 3), fun=sd)
plot(sd3)
viridis <- colorRampPalette(viridis(7))(255) #variability in space #The “viridis” scales do better - they cover a wide perceptual range in brightness in brightness and blue-yellow.

#plotting with 7*7 standard deviation
sd7 <- focal(NIR, matrix(1/49, 7, 7), fun=sd)
sd7
plot(sd7)
viridis <- colorRampPalette(viridis(7))(255) 
plot(sd3, col=viridis)







