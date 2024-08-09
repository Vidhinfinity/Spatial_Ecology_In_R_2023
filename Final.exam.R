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
plotRGB(mang2014, r=1, g=2, b=3, main="2014") # Plot the cropped 2014 image
plotRGB(mang2016, r=1, g=2, b=3, main="2016") # Plot the cropped 2016 image


# Step 5: Calculate NDVI (Normalized Difference Vegetation Index)
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
dvimang2014
cl <-  colorRampPalette(c("red", "black", "green"))(100)
plot(dvimang2014, col=cl, , main="DVI 2014") # Plot DVI for 2014

# Calculate and plot DVI for 2016
dvimang2016 <- mang2016[[1]] - mang2016[[2]]# Calculate DVI for 2016
dvimang2016
plot(dvimang2016, col=cl, , main="DVI 2016") # Plot DVI for 2016

# Calculate and plot NDVI for 2014 and 2016
ndvimang2014 <- (mang2014[[1]] - mang2014[[2]]) / (mang2014[[1]] + mang2014[[2]]) # NDVI for 2014
ndvimang2014
plot(ndvimang2014, col=cl, , main="NDVI 2014") # Plot NDVI for 2014

ndvimang2016 <- (mang2016[[1]] - mang2016[[2]]) / (mang2016[[1]] + mang2016[[2]]) # NDVI for 2016
plot(ndvimang2016, col=cl, , main="NDVI 2016") # Plot NDVI for 2016

# Plot NDVI for 2014 and 2016 side by side
par(mfrow=c(2, 2)) # Set up a 1x2 plot layout
plot(dvimang2014, col=cl, main="DVI 2014")
plot(dvimang2016, col=cl, main="DVI 2016")
plot(ndvimang2014, col=cl,main="NDVI 2014" ) # Plot NDVI for 2014
plot(ndvimang2016, col=cl, main="NDVI 2016") # Plot NDVI for 2016

# Difference in NDVI between 2014 and 2016
ndvi_diff <- ndvimang2014 - ndvimang2016
ndvi_diff
plot(ndvi_diff, col=cl, main="NDVI Difference (2014 - 2016)")

# Difference in DVI between 2014 and 2016
dvi_diff <- dvimang2014 - dvimang2016
dvi_diff
plot(dvi_diff, col=cl, main="DVI Difference (2014 - 2016)")

# Count the number of pixels with negative differences
ndvi_reduction <- sum(ndvi_diff[] < 0, na.rm = TRUE) / ncell(ndvi_diff) * 100
dvi_reduction <- sum(dvi_diff[] < 0, na.rm = TRUE) / ncell(dvi_diff) * 100

# Print the percentage of reduction
print(paste("NDVI reduction:", ndvi_reduction, "%"))
print(paste("DVI reduction:", dvi_reduction, "%"))

#results: "NDVI reduction: 87.1557142857143 %"
# "DVI reduction: 87.27 %"

##Variability

# Plot the image using RGB bands
im.plotRGB(mang2014, r = 1, g = 2, b = 3) # Plotting the image

# Extract the NIR band from the Sentinel image
NIR2014 <- mang2014[[1]]
plot(NIR2014, col=cl)

# Method called "moving window" is used to check variability.
# Function called focal is used in R to calculate standard deviation.
# calculate standard deviation using a 3x3 and 7x7 window
sd3 <- focal(NIR2014, matrix(1/9, 3, 3), fun = sd)
sd7 <- focal(NIR2014, matrix(1/9, 7, 7), fun = sd)

# Create a color palette using viridis
viridis <- colorRampPalette(viridis(7))(255) # Variability in space
plot(sd7, col=viridis)
plot(sd3, col=viridis)

# principal component analysis

# Pairs function is used to make a plot to see correlation. 1 is a perfect positive correlation and -1 is a negative correlation.
# Perform PCA 
mang2014.pca <- im.pca(mang2014)

# Isolating PC1
pc1 <- mang2014.pca$PC1
plot(pc1) # Plot PC1

# Calculation of standard deviation on top of PC1 using a 3x3 moving window
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridis) # Plot with viridis color scale

# Calculation of standard deviation on top of PC1 using a 7x7 moving window
pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridis) # Plot with viridis color scale


# Plot the standard deviation from the variability script
plot(sd3, col=viridis)
plot(sd7, col=viridis)
plot(pc1, col=viridis)
plot(pc1sd3, col=viridis)
plot(pc1sd7, col=viridis)

# Stack all standard deviation layers
sdstack <- c(sd3,sd7,pc1sd3, pc1sd7)
plot(sdstack, col=viridis) # Plot the stack with viridis color scale

# Assign names to the layers in the stack
names(sdstack) <- c("sd3","sd7","pc1sd3", "pc1sd7")
plot(sdstack, col=viridis) # Plot the named stack with viridis color scale

#calculation of variability and pca for 2016

# Plot the image using RGB bands
im.plotRGB(mang2016, r = 1, g = 2, b = 3) # Plotting the image

# Extract the NIR band from the Sentinel image
NIR2016 <- mang2016[[1]]
plot(NIR2016, col=cl)

SD3 <- focal(NIR2016, matrix(1/9, 3, 3), fun = sd)
SD7 <- focal(NIR2016, matrix(1/9, 7, 7), fun = sd)

plot(SD7, col=viridis)
plot(SD3, col=viridis)

#PERFORM PCA
mang2016.pca <- im.pca(mang2016)

# Isolating PC1
PC1 <- mang2016.pca$PC1
plot(PC1) # Plot PC1

# Calculation of standard deviation on top of PC1 using a 3x3 moving window
PC1SD3 <- focal(PC1, matrix(1/9, 3, 3), fun=sd)
plot(PC1SD3, col=viridis) # Plot with viridis color scale

# Calculation of standard deviation on top of PC1 using a 7x7 moving window
PC1SD7 <- focal(PC1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridis) # Plot with viridis color scale


# Plot the standard deviation from the variability script
plot(SD3, col=viridis)
plot(SD7, col=viridis)
plot(PC1, col=viridis)
plot(PC1SD3, col=viridis)
plot(PC1SD7, col=viridis)

sdstack1 <- c(SD3,SD7,PC1SD3, PC1SD7)
plot(sdstack1, col=viridis) # Plot the stack with viridis color scale

# Assign names to the layers in the stack
names(sdstack1) <- c("SD3","SD7","PC1SD3", "PC1SD7")

plot(sdstack1, col=viridis) # Plot the named stack with viridis color scale

# Step 6: Perform PCA (Principal Component Analysis)
# Perform PCA on 2014 and 2016 images
mang2014.pca <- im.pca(mang2014)
mang2016.pca <- im.pca(mang2016)

# Extract PC1 from both years
pc1_2014 <- mang2014.pca$PC1
pc1_2016 <- mang2016.pca$PC1

# Normalize PC1 values
pc1_2014 <- (pc1_2014 - min(pc1_2014[])) / (max(pc1_2014[]) - min(pc1_2014[]))
pc1_2014
pc1_2016 <- (pc1_2016 - min(pc1_2016[])) / (max(pc1_2016[]) - min(pc1_2016[]))
pc1_2016

# Set up a 1x2 plot layout
par(mfrow = c(1, 2))

# Plot PC1 for 2014
plot(pc1_2014, main = "PC1 - 2014", col = viridis::viridis(255))

# Plot PC1 for 2016
plot(pc1_2016, main = "PC1 - 2016", col = viridis::viridis(255))

# Calculate the difference between PC1 in 2014 and 2016
pc1_diff <- pc1_2014 - pc1_2016
pc1_diff

# Plot the difference
plot(pc1_diff, main = "Difference in PC1 (2014 - 2016)", col = colorRampPalette(c("red", "black", "green"))(255))

# Calculate the percentage of pixels with negative changes in PC1
pc1_reduction <- sum(pc1_diff[] < 0, na.rm = TRUE) / ncell(pc1_diff) * 100
print(paste("Percentage of area with reduction in PC1:", round(pc1_reduction, 2), "%"))

# Step 7: Classification
mang2014c <- im.classify(mang2014, num_clusters=2) # Classify the 2014 image into 2 clusters
mang2014c # Print classification result
plot(mang2014c) # Plot the classified 2014 image

# Classify the 2016 image into 2 clusters
mang2016c <- im.classify(mang2016, num_clusters=2)
mang2016c # Print classification result
plot(mang2016c) # Plot the classified 2016 image

# Step: Compare classifications
par(mfrow=c(1, 2)) # Set up a 1x2 plot layout for side-by-side comparison
plot(mang2014c) # Plot the classified 2014 image
plot(mang2016c) # Plot the classified 2016 image

# Calculate frequency of each class for 2014
fmang2014c <- freq(mang2014c) # Get frequency of classes in the 2014 image
tot2014 <- ncell(mang2014c) # Total number of pixels in the 2014 image
p2014 <- fmang2014c * 100 / tot2014 # Calculate percentage of each class
p2014 # Print percentages for 2014

##layer        value   count
#1 0.0002040816 0.0002040816 85.0749
#2 0.0002040816 0.0004081633 14.9251

# Calculate frequency of each class for 2016
fmang2016c <- freq(mang2016c) # Get frequency of classes in the 2016 image
tot2016 <- ncell(mang2016c) # Total number of pixels in the 2016 image
p2016 <- fmang2016c * 100 / tot2016 # Calculate percentage of each class
p2016 # Print percentages for 2016

#layer        value    count
#1 0.0002040816 0.0002040816 86.22653
#2 0.0002040816 0.0004081633 13.77347

# Build final output table
class <- c("water", "forest") # Define class names
y2014 <- c(85, 15) # Percentage of each class in 2014
y2016 <- c(87, 13) # Percentage of each class in 2016
tabout <- data.frame(class, y2014, y2016) # Create a data frame with the results
tabout

#class y2014 y2016
#1  water    85    87
#2 forest    15    13

# Build a summary table for visualization
cover <- c("water", "forest")
p2014 <- c(85, 15)
p2016 <- c(87, 13)
p <- data.frame(cover, p2014, p2016) # Create a data frame for plotting
p
# Create bar plots for class percentages
p1 <- ggplot(tabout, aes(x=class, y=y2014, color=class)) + geom_bar(stat="identity", fill="white") # Plot for 2014
p2 <- ggplot(tabout, aes(x=class, y=y2016, color=class)) + geom_bar(stat="identity", fill="white") # Plot for 2016

# Combine the plots side by side
p1 + p2 # Display the plots together

# Rescale and plot the final bar plots
p1 <- ggplot(tabout, aes(x=class, y=y2014, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) # Rescale for 2014
p2 <- ggplot(tabout, aes(x=class, y=y2016, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) # Rescale for 2016

# Combine the rescaled plots side by side
p1 + p2 # Display the rescaled plots together

