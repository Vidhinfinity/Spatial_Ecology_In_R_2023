# Population Ecology Analysis using Spatstat package

# Install and load the required package for point pattern analysis. 
## spatstat is an R package for spatial statistics with a strong focus on analysing spatial point patterns in 2D 
### (with some support for 3D and very basic support for space-time).
install.packages("spatstat")
library(spatstat)

# Use the 'bei' dataset from the spatstat package
# The 'bei' dataset contains tree locations in a forest plot
# More details: https://cran.r-project.org/web/packages/spatstat/index.html

# Plot the tree locations
plot(bei)

# Modify the plot by changing symbol size (cex)
plot(bei, cex = 0.5)
plot(bei, cex = 0.2)

# Change the plot symbol to a filled circle (pch = 19)
plot(bei, cex = 0.2, pch = 19)

# Additional dataset: 'bei.extra' which includes elevation data
plot(bei.extra)

# we need to take only elevation part of dataset. lets only use one part of dataset : elev. using $ sign to link
# Extract and plot the elevation data from 'bei.extra'
elevation <- bei.extra$elev
plot(elevation)

# Alternative method to extract elements from a list using double brackets.
# Double bracket parentheses as we are dealing with images. For tables, we have single parentheses
elevation2 <- bei.extra[[1]]
plot(elevation2)


# Start of a new section (10th October 2023)
# Continue working with the 'spatstat' package and 'bei' dataset

# The 'bei' dataset represents trees in a landscape; we will create a density map
# Create a density map from point data
densitymap <- density(bei)

# Plot the density map
plot(densitymap)

# Overlay the original tree points on the density map
points(bei, cex = 0.2)

#Color customization: Avoid using green, blue, and red for colorblind-friendly maps.
## Daltonic people cant see green blue and red so avoid using these colours in maps.

# Create a custom color palette from black to yellow
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
# cl is assigned to function and array of colors and 100 represent the numbers of colors passing.

# Plot the density map with the custom color palette
plot(densitymap, col = cl)

# Reduce the number of colors to make the map less continuous
cl <- colorRampPalette (c("black", "red", "orange", "yellow"))(4)  #changing the number from 100 to 4 will lead  to less continous map

# When you google colors in R, go to images, you will get codes for colors. Use them to edit the density map.
# virdis package for colors. On Google
plot(bei.extra)  # To obtain variables of elev and grad from the density map

# Lets only use one part of the dataset: elev. Using $ sign to link
elev <- bei.extra[[1]]  # Method 1
elevation <- bei.extra$elev  # Method 2
plot(elev)


## MULTIFRAME
## Par function, multiframe argument "mf". It is used to plot 2 things together. We are making a multiframe of density and elevation
par(mfrow = c(1, 2))
plot(densitymap)
plot(elev)


# If we want a plot of 2 rows and 1 column then change the mfrow to 2, 1
par(mfrow = c(2, 1))

# EXERCISE to make mf of bei density and elevation. 1 is the no. of rows, 3 is the no. of columns in the multiframe
par(mfrow = c(1, 3))
plot(bei)
plot(densitymap)
plot(elev)
