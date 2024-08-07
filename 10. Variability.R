# measurements of RS based variability

# Load necessary libraries
library(terra)    # For raster data processing
library(imageRy)  # For image import and manipulation
library(viridis)  # For creating perceptually uniform color palettes

# List available images in the workspace
im.list()

# Import the Sentinel image from the specified file
sent <- im.import("sentinel.png")

# Plot the image using RGB bands
# Band 1 - NIR (Near-Infrared), Band 2 - Red, Band 3 - Green
im.plotRGB(sent, r = 1, g = 2, b = 3) # Plotting the image

# Extract the NIR band from the Sentinel image
NIR <- sent[[1]]
plot(NIR)

# Method called "moving window" is used to check variability.
# Function called focal is used in R to calculate standard deviation.
# Correct focal call to calculate standard deviation using a 3x3 window
sd3 <- focal(NIR, matrix(1/9, 3, 3), fun = sd)
plot(sd3)

# Create a color palette using viridis
viridis <- colorRampPalette(viridis(7))(255) # Variability in space

# Plotting standard deviation with 3x3 window using viridis palette
plot(sd3, col = viridis)

# Calculate standard deviation using a 7x7 window
sd7 <- focal(NIR, matrix(1/49, 7, 7), fun = sd)
plot(sd7)

# Plotting standard deviation with 7x7 window using viridis palette
viridis <- colorRampPalette(viridis(7))(255)
plot(sd7, col = viridis)
