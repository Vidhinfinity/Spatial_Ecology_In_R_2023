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
