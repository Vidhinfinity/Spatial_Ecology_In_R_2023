#multivariate analysis #Dimensionality #Book recommendation: numerical ecology by legendre
# Take 3 bands of sentinels and compact them into one. principal components : pc 1 and pc2

library(imageRy)
library(viridis)
library(terra)

im.list()

sent <- im.import("sentinel.png")
#Pairs function is used to make a plot to see correlation. 1 is  a perfect positive correlation and -1 is a negative correlation. we will take sent data and make pca calculation.
#perform PCA on  sent
sent.pca <- im.pca(sent)

#isolating pc1
pc1 <- sentpc$PC1
plot (pc1)

#calcualtion std deviation ontop pf pc1
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot (pc1sd3, col= viridis)

# 7 by 7
#calcualtion std deviation ontop pf pc1
pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot (pc1sd7, col= viridis)

#plotting all graphs together

par(mfrow= c(2, 3)
im.plotRGB (sent, 2, 1, 3 )

#sd from the variability script

plot (sd3, col= viridis)
plot (sd7, col= viridis)
plot (pc1, col= viridis)
plot (pc1sd3, col= viridis)
plot (pc1sd7, col= viridis)

#staqck all standard deviation layers 
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
plot(sdstack, col=viridis)

names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col= viridis)





