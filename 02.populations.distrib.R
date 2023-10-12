# Why populations disperse over as landscape in a certain manner?
## Read about Gdal and OSGeo project
library(sdm)
library(terra)
## while installing package we need quotes as we are doing it from outside R. while using library we dont use quotes

file <- system.file("external/species.shp", package="sdm") # we have a system file, extrernal is the folder, species is the file name, shp is an extension of file name. sdm is the package. 

# vector files. vector is series of coordinates

rana <- vect(file)

rana$Occurrence #the 0 represents absence of rana and 1 represents present of an organism in a data in this case is rana.
plot(rana)
plot(rana, cex=.5) # decreased size of points

# selecting presences
pres <- rana[rana$occurrence == 1,] # double = as in sql language we use it like this

pres

plot(pres, cex= .5) #plotting presences

## excercise: select absences and call them abse

abse <- rana[rana$Occurrence == 0, ] # , here is used to close sql 
abse 
plot(abse)

## Excercise: plotting pres and abse side by side using multiframe

par(mfrow=c (1, 2))
plot(pres)
plot(abse)
dev.off() # to close the graph use this function

## exercise: plot pres and abse with 2 different colors. first use plot function followed by points function to plot two different graphs on one.
plot(pres, col= "dark blue")
points (abse, col= "light blue")

# predictors: environmental variables. rasters are images, previously we deal with points.

elev <- system.file("external/elevation.asc", package="sdm")
elevmap <- rast (elev) #from terra package
revamp
plot(elevmap)
points(pres, cex = .5)

## temperature predictor

temp <- system.file("external/temperature.asc", package="sdm")
tempmap <- rast (temp) #from terra package
tempmap
plot(tempmap)
points (pres, cex = .5)

## exercise : do the same with vegetation cover "vegetation"

vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast (vege) #from terra package
vegemap
plot(vegemap)
points (pres, cex = .5)

#precipitation
prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast (prec) #from terra package
precmap
plot(precmap)
points (pres, cex = .5)



##plot multiframe of 2*2 

par(mfrow=c (2, 2))



