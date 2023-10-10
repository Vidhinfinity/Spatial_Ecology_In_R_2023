# code related to population ecology

# package is needed for point pattern analysis

install.packages("spatstat")
library(spatstat)

# lets use bei data a dataset in  cran package of spatstat
# data description: 
# https://cran.r-project.org/web/packages/spatstat/index.html

# plotting the data

plot(bei)

# changing dimensions - cex

plot(bei, cex= 0.5)

plot(bei, cex= 0.2)

# changing the symbol tp pch 19

plot(bei, cex= 0.2, pch=19)

# additional dataset

bei.extra
plot(bei.extra)

# we need to take only elevation part of dataset

# lets only use one part of dataset : elev. using $ sign to link
bei.extra$elev

plot(bei.extra$elev)

elevation <- bei.extra$elev

plot(elevation)

# second method to select elemnt in dtaset. double bracket parentheses as we are dealing with images. for tables we have single parentheses
elevation2 <- bei.extra[[1]]
plot(elevation2)


### 10oct23
# working on spatstat. 
library(spatstat)
bei

# all the points are trees in a landscape. we will make a density map of the landscape.

# lets build density map passing from points to a continuous surface

densitymap <- density(bei)

# now we have pixels

plot(densitymap)

# plot points on top of density plot image. merge density and bei plots

points(bei, cex= .2)

## daltonic people cant see green blue and red so avoid using these colours in maps. we will change colors using below functions 

colorRampPalette
cl <- colorRampPalette (c("black", "red", "orange", "yellow"))(100)
cl

# cl is assigned to function and array of colors and 100 represent the numbers of colors passing


plot(densitymap, col=cl)  #plotting different color density map

cl <- colorRampPalette (c("black", "red", "orange", "yellow"))(4)  #chnaging the number from 100 to 4 will lead  to less continous map

## when you google colors in R, go to images you wil get codes for colors. use them to edit the density map.

##virdis package for colors. on google

plot(bei.extra) ##to obtain variable of elev and grad from density map

# lets only use one part of dataset : elev. using $ sign to link
elev <- bei.extra [[1]] #method 1
elevation <- bei.extra$elev #method 2

plot (elev)

##MULTIFRAME
## Par function, mutltiframe argument "mf". It is used to plot 2 things together. we are making multiframe of density and elevation

par(mfrow=c (1,2))

plot(densitymap)
plot(elev)

# if we want a plot of 2 rows and 1 columns then change the mfrow to 2, 1
par(mfrow=c (2, 1))

# EXCERCISE to make mf of bei density and elevation 1 is the no. of rows, 3 is the no. of columns in the multiframe..
par(mfrow=c (1, 3))
plot(bei)
plot(densitymap)
plot(elev)

