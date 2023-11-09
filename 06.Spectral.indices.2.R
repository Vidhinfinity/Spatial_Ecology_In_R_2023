# vegetation indices

install.packages("ggplot2")
install.packages("viridis")
library(ggplot2)
library(viridis)
library(terra)
library(imageRy)
im.list()
im.import("matogrosso_l5_1992219_lrg.jpg")
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m1992
#band 1 : 1=NIR, 2=red, 3=green

im.plotRGB(m1992, r=1, g=2, b=3) #NIR is put on red. everything red will reflect NIR
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m1992, r=2, g=1, b=3) 
im.plotRGB(m1992, r=2, g=3, b=1) #NIR on blue. Vegetation becomes blue. Bare soil is yellow

# import the 2006 image
m2006 <- im.import("matogrosso_ast_2006209_lrg")
im.plotRGB(m2006, r=2, g=3, b=1)


#build a multiframe with 1992 and 2006 images

par(mfrow=c (1, 2)) #function to build multiframe. mf row, we start wi
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)
dev.off()

plot(m1992[[1]])
#why the range of reflectance is 0 to 255? Reflectance is the ratio btw the incidence and reflected radiance flux. Bits is an information. by shannon in 1949.
#one bit of info can be 0 or 1. It is called binary code. The formula to calculate the information from bits is 2 raise to power n where n is the number of bits. ex: 4 bits will have
# 16 bits of information. They are at 8 bits. Hence, the range is till 255. (2 raised to power 8).

# The difference btw the two bands give us the DVI.
# DVI = NIR - RED
# bands: 1=NIR, 2=RED, 3=GREEN
dvi1992 = m1992 [[1]] - m1992 [[2]] #dvi of 1992 is the difference btw band 1 and 2
plot(dvi1992)

#now changing the palette
cl <- colorRampPalette (c("dark blue", "yellow", "red", "black"))(100)
plot(dvi1992, col=cl)
#everything that's dark red is ok, yellow and blue is bad from the vegetation pt of view as it represent bare soil.

#exercise DVI of 2006
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006)
cl <- colorRampPalette (c("dark blue", "yellow", "red", "black"))(100)
plot(dvi2006, col=cl) #plotting the DVI of 2006 with the same coloring palette.

# NDVI = NIR - red/ NIR + red

ndvi1992 = ( m1992 [[1]] - m1992 [[2]] )/ (m1992[[1]] + m1992[[2]])
ndvi1992 =  dvi1992/ (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=cl)

#NDVI for 2006

ndvi2006 = ( m2006 [[1]] - m2006 [[2]] )/ (m2006[[1]] + m2006[[2]])
ndvi2006 =  dvi2006/ (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)

#plot them together 1992 and 2006, both ranging from -1 to 1. forest on right and cultivated on left

par(mfrow = c (1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100) # specifying a color scheme
plot(ndvi1992, col=clvir)
plot(ndvi2006, col=clvir)

#speeding up the calculation

ndvi2006a <- im.ndvi (m2006, 1, 2) #we can use this function im.ndvi instead of the calculations to speed up the calculations.
plot(ndvi2006a, col=cl) 




