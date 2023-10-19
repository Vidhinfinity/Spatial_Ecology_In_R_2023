# wroking on community ecology today from vegan package

library(vegan)
data(dune) #dune is the dataset

head(dune) # to view the first 6 rows of dataset
#decorana funtion is used in ecology for multivariate analysis. Full form is detrended correspondence analysis (DCA). Taking the data and reshaping it into simpler form

decorana (dune)
ord <- decorana (dune)

#measuring the lengths of DCAs
ldc1 <- 3.7004
ldc2 <- 3.1166
ldc3 <- 1.30055
ldc4 <- 1.47888

total = ldc1 + ldc2 + ldc3 + ldc4

pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total

pldc1
pldc2
pldc1 + pldc2 # sum of first two axis

plot(ord) # to see final plot

plot(ex: bromus hordeaceus- one of typical species of dunes, acchilea so one part of the graph represent a grassland. salix repens - shrub) 31 you cant look at numbers and say that some species stay together and some dont. so graph guides you what kind of species stay together.



