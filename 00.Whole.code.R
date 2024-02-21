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
## R as a calculator
2 + 3

# Assign to an object
vidhi <- 2 + 3
vidhi

duccio <- 5 + 3
duccio

final <- vidhi * duccio
final

final^2

# array
# they're functions. fuctions always have parenthesis and inside them there are the arguments.
#examples
sophi <- c(10, 20, 30, 50, 70) # microplastics 
paula <- c(100, 500, 600, 1000, 2000) # people

# we can plot them together
plot(paula, sophi, xlab="number of people", ylab="microplastics")

# we can also previously assign paula and sophi to some objects
people <- paula
microplastics <- sophi
plot(people, microplastics)
plot (people, microplastics, pch= 19)
plot (people, microplastics, pch= 19, cex=5)
plot (people, microplastics, pch= 19, cex=5, col= "blue") #pch gives the shape of the symbols in R, cex represents the size, col for the color
# we can find the symbols in this site: http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r

# ----------------------

# 02.1 Population densities
# Install spatstat, which allows us to make a SPATIAL POINT PATTERN ANALYSIS
install.packages("spatstat") # QUOTES are needed to protect the package we want to install which is outside R

# the function library(spatstat) is used to check if the package has already been installed and to open it at every R session
# quotes are not needed as the package has already been installed from outside R

library(spatstat)

# DATA DESCRIPTION
# Let's use some datasets provided by spatstat, like BEI DATA 
#(The dataset bei gives the positions of 3605 trees of the species Beilschmiedia pendula (Lauraceae) 
# in a 1000 by 500 metre rectangular sampling region in the tropical rainforest of Barro Colorado Island)

# PLOTTING  DATA FROM SPATSTAT
plot(bei)  # as the points are too big for this area, we'll change their shape

# CHANGING DATA DIMENSION - cex
plot(bei,cex=.5)

# CHANGING THE SYMBOL  - pch
plot(bei,cex=.2,pch=19) #search the number of R symbols on the internet

# ADDITIONAL DATASETS
bei.extra # it has two variables: elevation (elev) and gradient (grad). 
# They allow us to understand the distribution of bei datas

plot(bei.extra) #here we have the raster file =! vector file

# Let's use only part of the dataset: elev
bei.extra$elev  #$ sign links elevation to the dataset
plot(bei.extra$elev) 
elevation <- plot(bei.extra$elev)  #elevation has been assignet to an homonimous object, simple to find

# second method to select elements
bei.extra[1] # take the fist element, so it's another way to isolate elevation
elevation2 <- bei.extra[[1]]
plot(elevation2)

# INTERPOLATION: infer values within the range covered by the data
# tt is possible by passing from points to a continuous surface called DENSITY MAP
densitymap <- density(bei) # the densitymap gives us info about the distribution of pixel
plot(densitymap)

# let's overlap  bei points to the densitymap
points(bei, cex=.2)

######## IMPORTANT: avoid pictures with a combination of blue, green and red colors as daltonic people can't see them

# let's change the colors
# find new colors in the site: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100) # 100 represents the different colors that can be present between those chosen

# Indeed, the quality is much worse if we put a smaller number, like

cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(4)
plot(densitymap, col=cl)

######## IMPORTANT: R is case-sensitive

plot(densitymap, col=cl)

####### TIP: properly use yellow colour, cause it's the most impacting one



# MULTIFRAME (shows different plots at the same time)
par(mfrow=c(1,2)) #1 row and 2 columns, and they're part of an array
# and then the two plots 
plot(densitymap)
plot(elev)

par(mfrow=c(2,1)) #2 rows and 1 column, and they're part of an array
# and then the two plots 
plot(densitymap)
plot(elev)

# ----------------------

# 02.2 Population distribution
# why populations disperse in a certain manner over the landscape?

# Sdm and rgdal packages required

install.packages("sdm")
install.packages("rgdal", dependencies=T) #W arning Message: rgdal will be retired cause it'll be included in terra package

# open the packages

library(sdm) # Species Distribution Modelling
library(terra) # spatial predictors, that are environmental variables
library(rgdal) # translator library for raster and vector geospatial data formats 

# select a file from the sdm package

file <- system.file("external/species.shp", package="sdm") # sdm have vector files and images

###### let's import a VECTOR, which is a coordinate system, with the function: vect()
species <- vect(file) 

# to see Occurrence just link the vector to Occurrence with the $
species$Occurrence # PRESENCE-ABSENCE DATA: the presence is objective, the absence could be due to a sampling bias
# in this case, for study purpuses, let's take each 0 like a real 0

plot(species)

# select only presences or absences

pres <- species[species$Occurrence==1,]  # we write 1 cause we need the 1 value, which is the presence
species[species$Occurrence==1,]
plot(pres)
abs <- species[species$Occurrence==0,] # or
abs <- species[species$Occurrence=!1,]
plot(abs)

# plot presences and absences together, one beside the other (like last time)
par(mfrow=c(1,2))
plot(pres)
plot(abs)

# to delete the graphics
dev.off()

# plot presences and absences together, in two different colors, one beside the other
par(mfrow=c(1,2))
plot(pres, col="dark blue")
plot(abs, col="light blue")

# we can also do this:
plot(pres, col="dark blue")
points(abse, col="light blue")

###### let's import an IMAGE with the function: rast()
# Elevation predictor
elev <- system.file("external/elevation.asc", package="sdm") #asc is an extention of sdm and it's a type of file, like png 
elevmap <- rast(elev) 
plot(elevmap)
points(pres,cex=0.5) #we see that the specie, which is in this case, Rana temporaria, is avoiding a valley. More, it's not choosing very low and very high elevations

# Temperature predictor
temp <- system.file("external/temperature.asc", package="sdm") 
tempmap <-rast(temp) 
plot(tempmap)
points(pres,cex=0.5)

# Vegetational cover
veg <- system.file("external/vegetation.asc", package="sdm") 
vegmap <-rast(veg) 
plot(vegmap)
points(pres,cex=0.5)

# Precipitation predictor
prec <- system.file("external/precipitation.asc", package="sdm") 
precmap <-rast(prec) 
plot(precmap)
points(pres,cex=0.5)

# Final multiframe
par(mfrow=c(2,2))

# elevation
plot(elevmap)
points(pres,cex=0.5)

# temperature
plot(tempmap)
points(pres,cex=0.5)

# vegetation
plot(vegmap)
points(pres,cex=0.5)

# precipitation
plot(precmap)
points(pres,cex=0.5)

# ----------------------

# 03.1 Community multivariate analysis
# In communities, species are overlapping in space and time: let's analyse them separated to better understand them

# Multivariate analysis of species overlap in SPACE:

# Vegetation Analisys
install.packages("vegan")
library(vegan)
data(dune) 
# Dune is a data frame of observations of 30 species at 20 sites. 
# The species names are abbreviated to 4+4 letters.

dune # to see the dataset
# or
head(dune) # just the first 6 rows
tail(dune) # just the last 6 rows
# we see a matrix of amout of individuals present in every plot

ord <- decorana(dune) # decorana function from the package vegan gives the Detrended Correspondace Analysis
# DCA is a multivariate statistical technique used by ecologists to find the main factor or gradient in species-rich but sparse data matrices that tipify ecological community data

# set the length of the new axes

ldc1 = 3.7004 # length decorana 1
ldc2 = 3.1166 
ldc3 = 1.30055 
ldc4 = 1.47888
total = ldc1 + ldc2 + ldc3 + ldc4

pldc1 = ldc1 * 100/total # percentage of every axes
pldc2 = ldc2 * 100/total
pldc3 = ldc3 * 100/total
pldc4 = ldc4 * 100/total

pldc1
pldc2
pldc3
pldc4

# as pldc1 + pldc2 represent the 70% of the total, we can also keep them only

plot(ord) 
# names represent species (we see coupling species), numbers represent plots: everything is depicted in a new dimention made by dca1 and 2
# from the distribution we can hypothesize the environmental parameters affecting the species distribution

# ----------------------

# 03.2 Community overlap
# Multivariate analysis of species overlap in TIME:

install.packages("overlap")
library(overlap)

data(kerinci) # data from Kerinci-Seblat National Park in Sumatra, Indonesia
kerinci
head(kerinci)
summary(kerinci)

# select the first species: TIGER
tiger <- kerinci[kerinci$Sps=="tiger",] # Sps=species

# select its time
timetig <- kerinci$Time*2*pi # time in radiants: multiply the linear time to 2 pi greek 

# plot it
densityPlot(timetig, rug=TRUE)

# selecting the second species: MACAQUE
macaque <- kerinci[kerinci$Sps=="macaque",] # Sps=species

# select its time
timemac <- macaque$Time*2*pi 

# plot it
densityPlot(timemac, rug=TRUE)

#overlap the tiger's time
overlapPlot(timetig,timemac)

# ----------------------

# 04. Remote sensing data visualisation
# Where to store additional packages, not present in R? 

# packages can be stored in GitHub (not connected to R: it's not controlled) or CRAN (directly conencted to R: it's controlled)

# to install them from CRAN (Coomprehensive R Archive Network), the function is: install.packages()
install.packages("devtools") # devtools package allows to download packages outside CRAN

# to open the packages, the function is always: library()
library (devtools) 

# to install them from GitHub, the function is: install_github()
install_github("ducciorocchini/imageRy")  
library (imageRy)

# to see all the possible images from the imageRy package, the function is: im.list()

# to import one image, the function is: im.import()
b2 <- im.import("sentinel.dolomites.b2.tif")

# Information provided from the image (called Reference System): 
# Word Geodetic System, Universal Transverse Mercator, Coordination of the point + the emisphere (N or S)
# to know more, you can go to Sentinel-2 in Wikipedia

clb <- colorRampPalette(c("dark grey", "grey", "light grey")) (100)
plot(b2,col=clb)

c1 <- colorRampPalette(c("black", "grey", "white")) (100)
c2 <- colorRampPalette(c("purple", "pink", "white")) (100)
c3 <- colorRampPalette(c("dark green", "light green", "white")) (100)
c4 <- colorRampPalette(c("blue", "light blue", "white")) (100)

par(mfrow=c(2,2))
plot(b2,col=c1)
plot(b3,col=c2)
plot(b4,col=c3)
plot(b8, col=c4) 


###### STACK IMAGES
# they're a function that plots all the selected images together, one over the other (in this case, four bands all together)
# RGB SPACE = Red, Green and Blue components that build other colours by overlapping
# BLUE
b2 <- im.import("sentinel.dolomites.b2.tif") 

# GREEN
b3<-im.import("sentinel.dolomites.b3.tif") 

# RED
b4 <- im.import("sentinel.dolomites.b4.tif") 

# NIR
b8 <- im.import("sentinel.dolomites.b8.tif") 

stack_sent <- c(b2,b3,b4,b8)

im.plotRGB(stack_sent, r = 3, g = 2, b = 1) # our view

im.plotRGB(stack_sent, 4, 3, 2) # with infrared: vegetation becomes red, we get more information

# change the position of NIR band to see it in different colors
im.plotRGB(stack_sent, r=3, g=4, b=2)
im.plotRGB(stack_sent, r=3, g=2, b=4)


# correlation between the bands
pairs(stack_sent)

# ----------------------

# 05. Spectral indices
# Vegetation Cover Change between 1992 and 2006 

install.packages("ggplot2")
install.packages("viridis")

library(ggplot2)
library(viridis)
library(terra)
library(imageRy)
im.list()

m1992<- im.import("matogrosso_l5_1992219_lrg.jpg") # image from satellite LANDSAT (1962)
# it's a processed image, where bands 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m1992, r=1, g=2, b=3) 
# in this way, the NIR bands will be depicted in red: they're typical of an healthy vegetation
# the RED ones will be represented in green: they're typical of unhealthy or absent vegetation
# and the GREEN one will be painted in blue
im.plotRGB(m1992, r=2, g=1, b=3)
im.plotRGB(m1992, r=2, g=3, b=1)

m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006,r=2, g=3, b=1)

# import the 2006 image
m2006 <- im.import("matogrosso_ast_2006209_lrg") # another processed image, where bands 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m2006, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=1, b=3) #we see the result of deforestation

#build a multiframe with 1992 and 2006 images

par(mfrow = c(1, 2)) 
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)
dev.off()

plot(m1992[[1]])
# In this picture, the range of reflectance goes from 0 to 255 (pink-green colors)
# Reflectance is the ratio between reflected and incident radiant flux 
# One bit of info can be 0 or 1 (BINARY CODE)
# The formula to calculate the amount of information every bit gives is:
# 2 raise to the power of n, where n is the number of bits.
# Ex: 4 bits will have 16 bits of information. 
# In this picture we have up to 8 bits, hence, up to 255 bits of reflectance (2 raised to power 8).

# The difference between the two bands give us the DVI.
# DVI = NIR - RED, where bands: 1=NIR, 2=RED, 3=GREEN
dvi1992 = m1992 [[1]] - m1992 [[2]] #dvi of 1992 is the difference between band 1 and 2
plot(dvi1992)

# now changing the palette
cl <- colorRampPalette (c("dark blue", "yellow", "red", "black"))(100)
plot(dvi1992, col=cl)
#everything that's dark red is healthy, yellow and blue is bad from the vegetation point of view as it represents bare soil.

# exercise DVI of 2006
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006)
cl <- colorRampPalette (c("dark blue", "yellow", "red", "black"))(100)
plot(dvi2006, col=cl) #plotting the DVI of 2006 with the same coloring palette.

# NDVI = NIR - RED/ NIR + RED

ndvi1992 = ( m1992 [[1]] - m1992 [[2]] )/ (m1992[[1]] + m1992[[2]])
#also
ndvi1992 =  dvi1992/ (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=cl)

#NDVI for 2006

ndvi2006 = ( m2006 [[1]] - m2006 [[2]] )/ (m2006[[1]] + m2006[[2]])
ndvi2006 =  dvi2006/ (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)

# plot them together 1992 and 2006, both ranging from -1 to 1. forest on right and cultivated on left

par(mfrow = c (1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# speeding up the calculation of the NDVI, the function is: im.ndvi()

ndvi2006a <- im.ndvi (m2006, 1, 2) 
plot(ndvi2006a, col=cl) 

# ----------------------

# 06. Time series

# TIME SERIES are series of data (images) scattered in time 
library(terra)
library(imageRy)
im.list()

#### CHANGES IN NITROGEN CONCENTRATION due to COVID, from January to March 2020
EN01<-im.import("EN_01.png") #European Nitrogen in January
EN13<-im.import("EN_13.png") #European Nitrogen in March
EN01
EN13

par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

# Let's make the difference between the red bands of the first two images
dev.off()
diff=EN01[[1]]-EN13[[1]]
plot(diff)

# Reminder: blue and red or green and red aren't good for daltonic people
# So, let's change the colors

cl <- colorRampPalette(c('red','orange','yellow'))(100)  
plot(diff,col=cl) 
# red is higher in march, yellow is higher in january
# so we have a huge decrease in march (there's more yellow than red)
# we see that in many cities people stopped to use cars

##### CHANGES IN TEMPERATURE of Greenland ice sheet

dev.off()
im.list()
G2000<-im.import("greenland.2000.tif") #16 bits image
plot(G2000,col=cl) #temperature on the surface of the land
# red=almost perennial ice cap

G2005<-im.import("greenland.2005.tif")
G2010<-im.import("greenland.2010.tif")
G2015<-im.import("greenland.2015.tif")

par(mfrow=c(2,2))
plot(G2000,col=cl)
plot(G2005,col=cl)
plot(G2010,col=cl)
plot(G2015,col=cl)

# to make it more effective
cl1 <- colorRampPalette(c('black', 'blue','white','red'))(100) 
par(mfrow=c(2,2))
plot(G2000,col=cl1)
plot(G2005,col=cl1)
plot(G2010,col=cl1)
plot(G2015,col=cl1)

# it's the same as

dev.off()
stackG4<-c(G2000,G2005,G2010,G2015) #around 2005 there was the worst period
plot(stackG4, col=cl1)
# we see that the surface temperature in Greenland have increased and then decreased back, while that in the Nunavut has gradually increased
# also Island's temperature has decreased a little bit

# or only the first and the last
dev.off()
stackG2<-c(G2000,G2015)
plot(stackG2, col=cl1)

# Make the difference between the first and the last element
diffg<-stackG4[[1]]-stackG4[[4]]
# it's the same as
difg<-G2000-G2015
plot(diffg, col=cl1) 
# blue=temperature was lower in the past 
# so there's a lot of increase in temperatures, therefore so decrease in ice sheet
# red= temperature was higher in the past

# Make a RGB plot using different years
dev.off()
im.plotRGB(stackG4, r=1,g=2,b=3)
# red = temperature was lower in the past (external part)
# green = temperature similar to the past
# blue = temperature was higher in the past (central part)

# ----------------------

# 07 External data import

################## EXTERNAL DATA IMPORT
library(terra)

# 1 st Step: explain to R which folder we are gonna use (called WORKING DIRECTORY) with the function: setwd("pathway for the document")
setwd("/Users/anita/Desktop") #if we use always the same folder, the command working directory can be always the same

# Import the data using the function: rast("name of the document")

Najaf2003 <- rast("najafiraq_etm_2003140_lrg.jpg") #like function im.import

# Plot it
plotRGB( Najaf2003, r=1, g=2, b=3)
Najaf2023 <- rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB( Najaf2023, r=1, g=2, b=3)

# plot them together
par(mfrow=c(2,1))
plotRGB( Najaf2003, r=1, g=2, b=3)
plotRGB( Najaf2023, r=1, g=2, b=3)

dev.off()

##################### Multitemporal change detection
Najaf_time<-Najaf2003[[1]]-Najaf2023[[1]]
cl<-colorRampPalette(c("brown", "grey", "orange")) (100)
plot(Najaf_time,col=cl)

##################Importing my own image
snow<-rast("rockiesfirstsnow_tmo_2023288_lrg.jpg")
plotRGB(snow,1,2,3)
plotRGB(snow,2,1,3)
plotRGB(snow,3,2,1)

# My multitemporal change detection
lakepowell22<-rast("lakepowell_oli2_2022267_lrg.jpg")
lakepowell23<-rast("lakepowell_oli_2023293_lrg.jpg")
lakepowell_time<-lakepowell22[[1]]-lakepowell23[[1]]
plot(lakepowell_time,col=cl)

install.packages("ncdf4")

# ----------------------

# 08 Copernicus data

library (ncdf4) # read Copernicus data with nc extension 
library(terra)

setwd("/Users/anita/Desktop/Unibo/Courses/1st YEAR/1st SEMESTER/Spatial Ecology in R") #set working directory with the path R needs to find the document

soilm2023<-rast("c_gls_SSM1km_202311220000_CEURO_S1CSAR_V1.2.1.nc")
soilm2023
# no projection file
# reference system in 3d

plot(soilm2023)
# we're interested only in the first image, not in that with noise
plot(soilm2023[[1]])

cl<-colorRampPalette(c("red", "orange", "yellow"))(100)
plot(soilm2023[[1]], col=cl)

ext<-c(22,26,55,57) #min&max longitude (x), min&max latitude (y)
# we use this extent to crop another image
soilm2023crop<-crop(soilm2023,ext)
# let's see it
plot(soilm2023crop[[1]], col=cl)  
  
# another extent
ext1<-c(10,24,60,75)
soilm2023crop1<-crop(soilm2023,ext1)
plot(soilm2023crop1[[1]], col=cl) 


# ANOTHER IMAGE
setwd("/Users/anita/Desktop/Unibo/Courses/1st YEAR/1st SEMESTER/Spatial Ecology in R")
soilm2023_25<-rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")
soilm2023_25crop<-crop(soilm2023_25,ext1)
plot(soilm2023_25crop[[1]], col=cl) 

# ----------------------

# 09 Classification

# Estimate the qualitative and quantitative difference between two images taken at different times
# We need to transform images in classes (land cover, land use, etc.)

# Satellite image of the Alps: green snow, blue pastures, green forests, pink villages
# We can compare quantitative (points in the graph) and qualitative (images RGB) data, by taking a picture in the image and analyze the waves it reflects
# Thay we try to guess the element according to the reflectance: water for example reflects NIR and red

# Pixels = training sites, expressing the main classes or clusters. They're set of individual objects having the same features. In this case the main classes are agricutural areas, forests, etc.

# How to classify pixels? From : we can estimate if the pixel represents an urban area or a forest using the the minimum distance from the class we think it belongs

# CLASSIFYING SATELLITE IMAGES AND ESTIMATING THE AMOUNT OF CHANGE
library(terra)
library(imageRy)
im.list()
#S un pillars are sun regions with high energy

# https://www.esa.int/Science_Exploration/Space_Science/Solar_Orbiter/Solar_Orbiter_s_first_views_of_the_Sun_image_gallery

sun<-im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# instant RGB picture, with 3 levels of energy: yellow (higher), brown, black. So, we expect 3 cluters.
# We have to explain to the softer the numbers of the cluster

sunc<- im.classify(sun, num_clusters = 3)
# We should reach similar images, but not the same. The random set of pixel makes every plot different in colors but not in shape.

# We want to measure the amount of error

m1992<- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006<- im.import("matogrosso_ast_2006209_lrg.jpg")
plotRGB(m1992)

m1992c<-im.classify(m1992, num_clusters=2) # amount of classes that we want to see in the image
plot(m1992c) # 3 replicate of the same image: white class of forest, green human intervention

# Classes: forest = 1, human = 2
m2006c<-im.classify(m2006, num_clusters=2)
plot(m2006c)

par(mfrow=c(1,2))
plot(m1992c[[1]]) # DOUBLE PARENTHESIS to plot choose only the first image
plot(m2006c[[1]])

# What is the proportion of forest and human classes? function: freq() (calculates the pixels from a certain classes)
f1992<-freq(m1992c[[1]])

# Total number of pixels? function: ncell()
tot1992<-ncell(m1992c)
tot1992

# Percentage? 
p1992<-f1992*100/tot1992
p1992

# forest = 83%, human = 17%

# Percentage of 2006
f2006<-freq(m2006c[[1]])
tot2006<-ncell(m2006c)
p2006<-f2006*100/tot2006
p2006

# forest = 45%, human = 55%

# Building the final table, which means a graph with all this data -> function: data
# We need to build the columns
class<- c("forest", "human")
y1992<- c(83, 17) # forest and humans in 1992
y2006<- c(45, 55) # forest and humans in 2006

# And to assign them to the dataframe
tabout <- data.frame(class, y1992, y2006)
tabout

# And build a graph
library(ggplot2)
library(patchwork) # allows to put several graphs together

p1<- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2<- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
# bar plot with the tabout class, aestethics will be the class

p1+p2

# ----------------------

# 10 Variability

# Measurement of R based variability
# there are different indices in statistics: the most simple thing in our case was to measure the standard deviation, that is how much the different data are divergin from the mean
# we measured it with the focal() function

library (imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png") # Similaun Glacier

# band 1 = NIR
# band 2 = red
# band 3 = green

im.plotRGB(sent, r = 1, g = 2, b = 3)

# snow in white, lake in black

im.plotRGB(sent, r = 2, g = 1, b = 3)

nir <- sent[[1]]
plot(nir) # 8 bit image as it distributed in a range between 0 and 250

# MOVING WINDOW APPROACH FOR DIVERSITY ASSESSMENT
# we are going to calculate the standard deviation (sd) of windows of pixels, one at the time
# in the end we would have passed the window in the whole image, calculating each time the sd value of the central pixel of the window 

# calculate the standard deviation with the function: focal()

sd3 <- focal(nir, matrix(1/9,3,3), fun=sd) # avoid givid the name sd without numbers cause it can be confused with the value of the standard deviation

# use of the nir band, matrix describes the dimension of the moving window. it is composed by 9 pixels, so they go from 1 to 9 (written as 1/9). In general we use squared matrices. The function calculated is the standard deviation (sd).

plot(sd3)

cl<-colorRampPalette(viridis(7))(255) # the 7th palette of viridis, with 255 different colors used

plot(sd3, col=cl) # northwest part is the area where the variability is higher

# let's calculate the variability in a 7x7 moving window
sd7 <- focal(nir, matrix(1/49,7,7), fun=sd)
plot(sd7, col=cl) 
# sd in a smaller window will give a local calculation and see subtile differences
# with larger windows, the resulting picture will include additional pixels, so it will be less precise

par(mfrow=c(1,2))
plot(sd3, col=cl)
plot(sd7, col=cl)

# original image plus the 7x7 sd
par(mfrow=c(1,2))
im.plotRGB(sent, r = 2, g = 1, b = 3)
plot(sd7, col=cl) # the line on the top left reflects a lot of variability; it can be due to snow or a clowd better recognized in the nir picture. Other times it can be due to geological or botanical variability

# ----------------------

# 11 Principal Component Analysis

library (imageRy)
library(terra)
library(viridis)

im.list()
dev.off()

sent <- im.import("sentinel.png") #Similaun Glacier

pairs(sent)
viridisc <- colorRampPalette(viridis(7))(255)

# Pearson correlation index goes from -1 to +1. We see that there's perfect correlation between the visible bands, wile the NIR adds more info so there's no correlation with the others. 


# MULTIVARIATE ANALYSIS
# Measurement of R based variability with a single layer, which is chosen objectivle with Multivariate Analysis
# compact the 3 bands of sentinel into one to better visualize it

# we have already seen the DCA (detrended component analysis)
# now we will see the PCA (principal component analysis)
# the last row is nothing

sentpc <- im.pca2(sent)


# it says that the principal component will show the 71% of the variability, the second 53% etc.

pc1 <- sentpc$PC1 # we choose only the first principal component
plot(pc1, col=viridisc)

# calculating sd onto of pc1 in a 3x3 matrix
pc1sd3 <- focal(pc1, matrix(1/9,3,3), fun=sd)
plot(pc1sd3, col=viridisc)


# calculating sd onto of pc1 in a 7x7 matrix
pc1sd7 <- focal(pc1, matrix(1/49,7,7), fun=sd)
plot(pc1sd7, col=viridisc)



# multiframe

sd3 <- focal(nir, matrix(1/9,3,3), fun=sd)
sd7 <- focal(nir, matrix(1/49,7,7), fun=sd)

par(mfrow=c(3,3))
im.plotRGB(sent, 2,1,3)
# sd from the variability script:
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)
dev.off()

# stack all the sd layers
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
plot(sdstack, colr = viridisc)

# change the names

names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col = viridisc)

# focal can also be used for other statistics: mean, coefficent variation etc.


# ----------------------
