#This project aimed to detect and quantify changes in land cover, with a specific focus on the degradation of mangrove forests,
#along the Australian coast between 2014 and 2016. 
#The analysis involved using various remote sensing and image processing techniques such as NDVI calculation, 
#Principal Component Analysis (PCA), and classification to assess changes in these critical ecosystems.

#--------------------

# Summary:
# 01 Importing modules and setting the working directory
# 02 Investigating the snow seasonal cycle 
# 03 Investigating the change in snow cover throughout the years
# 04 A remarkable phenomenon: Fagradalsfjall volcanic eruption

#--------------------

# Step 1: Install required packages if not already installed
install.packages(c("terra", "jpeg", "ggplot2", "viridis", "patchwork")) # Install packages for raster data, plotting, and visualization


# Load the necessary packages into the R session
library(terra)     # For working with raster data
library(jpeg)      # For reading JPEG images
library(ggplot2)   # For creating plots
library(viridis)   # For color palettes
library(patchwork) # For combining multiple ggplot2 plots

# Install devtools if not already installed; useful for package development
install.packages("devtools")

# Load the imageRy package, which provides functions for image processing (make sure this is correctly installed)
library(imageRy)

# Set the working directory to where the image files are stored
setwd("C:/Users/HP/OneDrive/Desktop/Spatial R exam")

# Step 2: Import images
m2014 <- rast("2014.jpg") # Import the 2014 image as a raster object
m2016 <- rast("2016.jpg") # Import the 2016 image as a raster object

# Plot RGB images to visualize them
plotRGB(m2014, r=1, g=2, b=3, stretch="hist") # Plot the 2014 image with histogram stretching for enhanced contrast
plotRGB(m2016, r=1, g=2, b=3, stretch="hist") # Plot the 2016 image with histogram stretching for enhanced contrast

# Step 3: Crop the images to focus on a specific region of interest
crop_extent <- ext(300, 1000, 300, 1000) # Define the extent (xmin, xmax, ymin, ymax) for cropping
mang2014 <- crop(m2014, crop_extent) # Crop the 2014 image to the defined extent
mang2016 <- crop(m2016, crop_extent) # Crop the 2016 image to the defined extent

# Step 4: Plot the cropped images to verify the region of interest
par(mfrow=c(1, 2)) # Set up a 1x2 plot layout to compare images side by side
plotRGB(mang2014, r=1, g=2, b=3, main="Cropped 2014 RGB Image") # Plot the cropped 2014 image
plotRGB(mang2016, r=1, g=2, b=3, main="Cropped 2016 RGB Image") # Plot the cropped 2016 image

# Step 5: Stack the cropped images for further analysis
stacked <- c(mang2014[[1:3]], mang2016[[1:3]]) # Combine bands from both images into a single stack
plot(stacked) # Plot the stacked image to visualize combined bands

# Perform correlation analysis between bands
pairs(stacked) # Create a scatterplot matrix to examine pairwise correlations between bands

# Step 6: Create a multi-frame for comparing RGB combinations
par(mfrow=c(1, 2)) # Set up a 1x2 plot layout for side-by-side comparison
plotRGB(mang2014, r=1, g=2, b=3) # Plot the 2014 image
plotRGB(mang2016, r=1, g=2, b=3) # Plot the 2016 image

# Step 7: Multitemporal change detection
mangdif <- mang2014[[1]] - mang2016[[1]] # Compute the difference between the 2014 and 2016 images
cl <- colorRampPalette(c("red", "black", "orange"))(100) # Define a color palette for visualizing differences
plot(mangdif, col = cl) # Plot the difference image with the defined color palette

# Step 8: Calculate NDVI (Normalized Difference Vegetation Index)
# NDVI is calculated as (NIR - RED) / (NIR + RED)
im.plotRGB(mang2014, r=2, g=1, b=3) # Plot the 2014 image for reference
im.plotRGB(mang2016, r=2, g=1, b=3) # Plot the 2016 image for reference

# Build a multi-frame 
par(mfrow=c(1, 2)) # Set up a 1x2 plot layout
im.plotRGB(mang2014, r=2, g=1, b=3) 
im.plotRGB(mang2016, r=2, g=1, b=3) 

# Plot the NIR band of the 2014 image
plot(mang2014[[1]])
# Calculate and plot the Difference Vegetation Index (DVI)
dvimang2014 <- mang2014[[1]] - mang2014[[2]] # Calculate DVI for 2014
plot(dvimang2014, col=cl) # Plot DVI for 2014

# Calculate and plot DVI for 2016
dvimang2016 <- mang2016[[1]] - mang2016[[2]] # Calculate DVI for 2016
plot(dvimang2016, col=cl) # Plot DVI for 2016

# Calculate and plot NDVI for 2014 and 2016
ndvimang2014 <- (mang2014[[1]] - mang2014[[2]]) / (mang2014[[1]] + mang2014[[2]]) # NDVI for 2014
plot(ndvimang2014, col=cl) # Plot NDVI for 2014

ndvimang2016 <- (mang2016[[1]] - mang2016[[2]]) / (mang2016[[1]] + mang2016[[2]]) # NDVI for 2016
plot(ndvimang2016, col=cl) # Plot NDVI for 2016

# Plot NDVI for 2014 and 2016 side by side
par(mfrow=c(1, 2)) # Set up a 1x2 plot layout
plot(ndvimang2014, col=cl) # Plot NDVI for 2014
plot(ndvimang2016, col=cl) # Plot NDVI for 2016

# Step 9: Analyze variability
im.plotRGB(mang2014, r = 1, g = 2, b = 3) # Plot RGB image for 2014

# Extract the NIR band from the Sentinel image
NIR2014 <- mang2014[[1]]
plot(NIR2014, col=cl) # Plot the NIR band of the 2014 image

# Calculate variability using a moving window
# Compute standard deviation with 3x3 and 7x7 windows
sd3 <- focal(NIR2014, matrix(1/9, 3, 3), fun = sd) # Standard deviation with 3x3 window
sd7 <- focal(NIR2014, matrix(1/9, 7, 7), fun = sd) # Standard deviation with 7x7 window

# Create a color palette using viridis for variability plots
viridis <- colorRampPalette(viridis(7))(255)
plot(sd7, col=viridis) # Plot standard deviation with 7x7 window
plot(sd3, col=viridis) # Plot standard deviation with 3x3 window

# Perform PCA (Principal Component Analysis)
mang2014.pca <- im.pca(mang2014) # Perform PCA on the 2014 image

#Standard deviations (1, .., p=3):
  [1] 58.112414 16.637336  8.981358

# Rotation (n x k) = (3 x 3):
  PC1        PC2        PC3
2014_1 0.9573259  0.1907982  0.2170787
2014_2 0.2791482 -0.4158947 -0.8655102
2014_3 0.0748559 -0.8891725  0.4514077

# Isolate PC1 (Principal Component 1)
pc1 <- mang2014.pca$PC1
plot(pc1) # Plot PC1

# Calculate and plot standard deviation on PC1 using moving windows
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd) # Standard deviation with 3x3 window on PC1
plot(pc1sd3, col=viridis) # Plot standard deviation on PC1 with 3x3 window

pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd) # Standard deviation with 7x7 window on PC1
plot(pc1sd7, col=viridis) # Plot standard deviation on PC1 with 7x7 window

# Stack and plot all standard deviation layers
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7) # Combine all standard deviation layers
plot(sdstack, col=viridis) # Plot the stacked layers with viridis color scale

# Assign names to the layers in the stack for clarity
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridis) # Plot the named stack with viridis color scale

# Step 10: Calculate variability and PCA for 2016
im.plotRGB(mang2016, r = 1, g = 2, b = 3) # Plot RGB image for 2016

# Extract the NIR band for 2016
NIR2016 <- mang2016[[1]]
plot(NIR2016, col=cl) # Plot the NIR band of the 2016 image

# Calculate variability with moving windows for 2016
SD3 <- focal(NIR2016, matrix(1/9, 3, 3), fun = sd) # Standard deviation with 3x3 window
SD7 <- focal(NIR2016, matrix(1/9, 7, 7), fun = sd) # Standard deviation with 7x7 window

plot(SD7, col=viridis) # Plot standard deviation with 7x7 window
plot(SD3, col=viridis) # Plot standard deviation with 3x3 window

# Perform PCA for 2016
mang2016.pca <- im.pca(mang2016) # Perform PCA on the 2016 image

Standard deviations (1, .., p=3):
  [1] 67.26652 14.84784 11.10753

Rotation (n x k) = (3 x 3):
  PC1        PC2          PC3
2016_1 0.8081232  0.5889540  0.008368228
2016_2 0.4978112 -0.6905192  0.524754406
2016_3 0.3148346 -0.4199004 -0.851212539

# Isolate PC1 for 2016
PC1 <- mang2016.pca$PC1
plot(PC1) # Plot PC1

# Calculate and plot standard deviation on PC1 for 2016
PC1SD3 <- focal(PC1, matrix(1/9, 3, 3), fun=sd) # Standard deviation with 3x3 window on PC1
plot(PC1SD3, col=viridis) # Plot standard deviation on PC1 with 3x3 window

PC1SD7 <- focal(PC1, matrix(1/49, 7, 7), fun=sd) # Standard deviation with 7x7 window on PC1
plot(PC1SD7, col=viridis) # Plot standard deviation on PC1 with 7x7 window

# Stack and plot all standard deviation layers for 2016
sdstack1 <- c(SD3, SD7, PC1SD3, PC1SD7) # Combine all standard deviation layers for 2016
plot(sdstack1, col=viridis) # Plot the stacked layers with viridis color scale

# Assign names to the layers in the stack for clarity
names(sdstack1) <- c("SD3", "SD7", "PC1SD3", "PC1SD7")
plot(sdstack1, col=viridis) # Plot the named stack with viridis color scale

# Step 11: Classification
mang2014c <- im.classify(mang2014, num_clusters=2) # Classify the 2014 image into 2 clusters
mang2014c # Print classification result
plot(mang2014c) # Plot the classified 2014 image

# Classify the 2016 image into 2 clusters
mang2016c <- im.classify(mang2016, num_clusters=2)
mang2016c # Print classification result
plot(mang2016c) # Plot the classified 2016 image

# Step 12: Compare classifications
par(mfrow=c(1, 2)) # Set up a 1x2 plot layout for side-by-side comparison
plot(mang2014c) # Plot the classified 2014 image
plot(mang2016c) # Plot the classified 2016 image

# Calculate frequency of each class for 2014
fmang2014c <- freq(mang2014c) # Get frequency of classes in the 2014 image
tot2014 <- ncell(mang2014c) # Total number of pixels in the 2014 image
p2014 <- fmang2014c * 100 / tot2014 # Calculate percentage of each class
p2014 # Print percentages for 2014

layer        value   count
1 0.0002040816 0.0002040816 85.0749
2 0.0002040816 0.0004081633 14.9251

# Calculate frequency of each class for 2016
fmang2016c <- freq(mang2016c) # Get frequency of classes in the 2016 image
tot2016 <- ncell(mang2016c) # Total number of pixels in the 2016 image
p2016 <- fmang2016c * 100 / tot2016 # Calculate percentage of each class
p2016 # Print percentages for 2016

layer        value    count
1 0.0002040816 0.0002040816 86.22653
2 0.0002040816 0.0004081633 13.77347

# Step 13: Build final output table
class <- c("water", "forest") # Define class names
y2014 <- c(85, 15) # Percentage of each class in 2014
y2016 <- c(87, 13) # Percentage of each class in 2016
tabout <- data.frame(class, y2014, y2016) # Create a data frame with the results
tabout

class y2014 y2016
1  water    85    87
2 forest    15    13

# Build a summary table for visualization
cover <- c("water", "forest")
p2014 <- c(85, 15)
p2016 <- c(87, 13)
p <- data.frame(cover, p2014, p2016) # Create a data frame for plotting
p
# Step 14: Create bar plots for class percentages
p1 <- ggplot(tabout, aes(x=class, y=y2014, color=class)) + geom_bar(stat="identity", fill="white") # Plot for 2014
p2 <- ggplot(tabout, aes(x=class, y=y2016, color=class)) + geom_bar(stat="identity", fill="white") # Plot for 2016

# Combine the plots side by side
p1 + p2 # Display the plots together

# Step 15: Rescale and plot the final bar plots
p1 <- ggplot(tabout, aes(x=class, y=y2014, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) # Rescale for 2014
p2 <- ggplot(tabout, aes(x=class, y=y2016, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) # Rescale for 2016

# Combine the rescaled plots side by side
p1 + p2 # Display the rescaled plots together


