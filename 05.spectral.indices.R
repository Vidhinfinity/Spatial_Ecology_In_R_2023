# vegetation indices

# Indices derived from RS imagery

library(imageRy)
library(terra)

im.list()

# Go to prof's Github's repository > imagRy > data description. Here you will find a description of the data that we are using for examples in R and GitHub.
# we are going to use matogrosso. An inland state of central Brazil. A railroad, followed by highways and airplanes, eventually connected this state with other regions in the twentieth century.
# we are importing data from matogrosso_l5_1992219_lrg.jpg description 

im.import("matogrosso_l5_1992219_lrg.jpg")
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
#band 1 : 1=NIR, 2=red, 3=green


im.plotRGB(m1992, r=1, g=2, b=3) #putting NIR on red
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m1992, r=2, g=1, b=3) #putting NIT on green
im.plotRGB(m1992, r=2, g=3, b=1)

# import the 2006 image
m2006 <- im.import("matogrosso_ast_2006209_lrg")
im.plotRGB(m2006, r=2, g=3, b=1)  #putting NIR on blue we get yellow for soil.

