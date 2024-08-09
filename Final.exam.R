#The primary goal of this project is to detect and quantify changes in land cover, 
#specifically focusing on the degradation of mangrove forests along the Australian coast between 2014 and 2016, 
#utilizing various remote sensing and image processing techniques to assess changes in these critical ecosystems. 
#Key techniques include NDVI calculation, Principal Component Analysis (PCA), and image classification.

# Step 1 : Install required packages if not already installed
install.packages(c("terra", "jpeg", "ggplot2", "viridis", "patchwork","devtools"))

# Load the packages
library(terra)
library(jpeg)
library(ggplot2)
library(viridis)
library(patchwork)
library(imageRy)

#Note: Load the devtools package, which is used to install packages from GitHub
# Install the imageRy package from GitHub through
devtools::install_github("ducciorocchini/imageRy")


setwd("C:/Users/HP/OneDrive/Desktop/Spatial R exam")

# Step 2: Import images
m2014 <- rast("2014.jpg")
m2016 <- rast("2016.jpg")

#plot rgb

plotRGB(m2014, r=3, g=2, b=1, stretch="hist")
plotRGB(m2016, r=3, g=2, b=1, stretch="hist")

#cropping the images
crop_extent <- ext(300, 1000, 300, 1000)
mang2014 <- crop(m2014, crop_extent)
mang2016 <- crop(m2016, crop_extent)

# Step 3: Plot the cropped images to verify
par(mfrow=c(1, 2)) # Create a 1x2 plot layout
plotRGB(mang2014, r=3, g=2, b=1, main="Cropped 2014 RGB Image")
plotRGB(mang2016, r=3, g=2, b=1, main="Cropped 2016 RGB Image")

# Step 4: Stack the cropped images for further analysis
stacked <- c(mang2014[[1:3]], mang2016[[1:3]])
plot(stacked)


# Define a color palette for the difference plot
cl <- colorRampPalette(c("red", "black", "orange"))(100)


#calculation of NDVI
# Plot RGB combinations of the 2014 and 2016 images

im.plotRGB(mang2014, r=3, g=2, b=1)
im.plotRGB(mang2016, r=3, g=2, b=1)

# Build a multiframe for comparison
par(mfrow=c(1, 2)) # Function to build a multiframe with 1 row and 2 columns
im.plotRGB(mang2014, r=2, g=1, b=3)
im.plotRGB(mang2016, r=2, g=1, b=3)
dev.off() # Close the graphical device

# Plot the NIR band of the 2014 image
plot(mang2014[[1]])
# Calculate the Difference Vegetation Index (DVI)
dvimang2014 <- mang2014[[1]] - mang2014[[2]] # DVI of mang2014
plot(dvimang2014, col=cl)

# Calculate and plot DVI for 2016
dvimang2016 <- mang2016[[1]] - mang2016[[2]]
plot(dvimang2016, col=cl) # Use the same color palette as for 2014

# Calculate the Normalized Difference Vegetation Index (NDVI)
# NDVI = (NIR - RED) / (NIR + RED)
ndvimang2014 <- (mang2014[[1]] - mang2014[[2]]) / (mang2014[[1]] + mang2014[[2]])
plot(ndvimang2014, col=cl)

# Calculate and plot NDVI for 2016
ndvimang2016 <- (mang2016[[1]] - mang2016[[2]]) / (mang2016[[1]] + mang2016[[2]])
plot(ndvimang2016, col=cl)

# Plot NDVI for 2014 and 2016 side by side
par(mfrow=c(1, 2))
plot(ndvimang2014, col=cl)
plot(ndvimang2016, col=cl)


# Step 1: Perform PCA on 2014 and 2016 images using the im.pca() function
mang2014_pca <- im.pca(mang2014)  # Perform PCA on 2014 image
mang2016_pca <- im.pca(mang2016)  # Perform PCA on 2016 image

# Step 2: Extract the first principal component (PC1)
pc1_2014 <- mang2014_pca$PC1
pc1_2016 <- mang2016_pca$PC1

# Step 3: Normalize the PC1 values (0 to 1 scaling)
pc1_2014 <- (pc1_2014 - min(pc1_2014[])) / (max(pc1_2014[]) - min(pc1_2014[]))
pc1_2016 <- (pc1_2016 - min(pc1_2016[])) / (max(pc1_2016[]) - min(pc1_2016[]))

# Step 4: Plot PC1 for 2014 and 2016 side by side
par(mfrow = c(1, 2))  # Set up a 1x2 plot layout
plot(pc1_2014, main = "PC1 - 2014", col = viridis::viridis(255))  # Plot PC1 for 2014
plot(pc1_2016, main = "PC1 - 2016", col = viridis::viridis(255))  # Plot PC1 for 2016

# Calculate the difference between PC1 in 2014 and 2016
pc1_diff <- pc1_2014 - pc1_2016
pc1_diff

# Calculate the percentage of pixels with negative changes in PC1
pc1_reduction <- sum(pc1_diff[] < 0, na.rm = TRUE) / ncell(pc1_diff) * 100

# Print the percentage of reduction
print(paste("Percentage of area with reduction in PC1:", round(pc1_reduction, 2), "%"))

## classification

# step 2 classification
mang2014c <- im.classify (mang2014, num_clusters=2)
mang2014c
plot(mang2014c) 
#classes: water =1 ; forest= 2

#same for 2006 image
mang2016c <- im.classify (mang2016, num_clusters=2)
mang2016c
plot(mang2016c) 
#classes: water =1 ; forest= 2

#step 5: plotting multi-frame of both plots

par(mfrow=c(1,2))
plot(mang2014c) 
plot(mang2016c)

# To see the frequency we use the below function, to see how many pixels are attaining to a forest and how many to humans.
fmang2014c <- freq(mang2014c)

# let's extract the total number of pixels from images
tot2014 <- ncell(mang2014c)

#percentage: frequency *100/ total

p2014 <- fmang2014c *100 / tot2014
p2014

#water (1): 85% ; forest: 15%

#calculate freq, total and percentage for 2006 image
fmang2016c <- freq(mang2016c)
tot2016 <- ncell(mang2016c)
p2016 <- fmang2016c *100 / tot2016
p2016

# #water: 87% ; forest: 13%

#building the final table
class <- c("water", "forest")
y2014 <- c (85, 15)
y2016 <- c (87, 13)

#putting everything together
tabout <- data.frame (class, y2014, y2016)
tabout

# building the output table
cover <- c("water", "forest") 
p2014 <- c(85, 15)
p2016 <- c(87, 13)

# final table
p <- data.frame(cover, p2014, p2016)
p

# final output
p1 <- ggplot(tabout, aes(x=class, y=y2014, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2016, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2 

# scales are used in the above case to soften the impact of change as the y limit is different in the two graphs.

# final output, rescaled
p1 <- ggplot(tabout, aes(x=class, y=y2014, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2016, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2


#now, the above graph shows the same limits on the y-axis.

