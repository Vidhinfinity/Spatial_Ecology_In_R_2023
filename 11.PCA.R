# Multivariate analysis #Dimensionality #Book recommendation: Numerical Ecology by Legendre
# Take 3 bands of Sentinel data and compact them into one. Use principal components: PC1 and PC2.

library(imageRy) # Library for image processing
library(viridis) # Library for color scales
library(terra)   # Library for spatial data

im.list() # List available images

# Import Sentinel image
sent <- im.import("sentinel.png")

# Pairs function is used to make a plot to see correlation. 1 is a perfect positive correlation and -1 is a negative correlation.
# Perform PCA on the Sentinel image
sent.pca <- im.pca(sent)

# Isolating PC1
pc1 <- sent.pca$PC1
plot(pc1) # Plot PC1

# Calculation of standard deviation on top of PC1 using a 3x3 moving window
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridis) # Plot with viridis color scale

# Calculation of standard deviation on top of PC1 using a 7x7 moving window
pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridis) # Plot with viridis color scale

# Plotting all graphs together
par(mfrow=c(2, 3)) # Set up the plotting area to have 2 rows and 3 columns

# Plot the original Sentinel image using bands 2, 1, and 3
im.plotRGB(sent, r=2, g=1, b=3)

# Plot the standard deviation from the variability script
plot(sd3, col=viridis)
plot(sd7, col=viridis)
plot(pc1, col=viridis)
plot(pc1sd3, col=viridis)
plot(pc1sd7, col=viridis)

# Stack all standard deviation layers
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
plot(sdstack, col=viridis) # Plot the stack with viridis color scale

# Assign names to the layers in the stack
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridis) # Plot the named stack with viridis color scale
