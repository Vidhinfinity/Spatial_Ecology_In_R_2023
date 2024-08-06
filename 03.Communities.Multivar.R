# Working on community ecology today using the vegan package

# Load the vegan package
library(vegan)

# Load the dune dataset, which contains vegetation data
data(dune)

# Display the first 6 rows of the dataset to understand its structure
head(dune)

# The decorana function is used in ecology for multivariate analysis.
# It performs Detrended Correspondence Analysis (DCA), which helps to simplify complex ecological data.
ord <- decorana(dune)

# Display the DCA results
ord

# Define the lengths of DCA axes obtained from the decorana output
ldc1 <- 3.7004
ldc2 <- 3.1166
ldc3 <- 1.30055
ldc4 <- 1.47888

# Calculate the total length of all DCA axes
total <- ldc1 + ldc2 + ldc3 + ldc4

# Calculate the percentage contribution of each DCA axis to the total variation
pldc1 <- ldc1 * 100 / total
pldc2 <- ldc2 * 100 / total
pldc3 <- ldc3 * 100 / total
pldc4 <- ldc4 * 100 / total

# Display the percentage contribution of each DCA axis
pldc1
pldc2
pldc3
pldc4

# Calculate and display the sum of the first two DCA axes' percentages
pldc1 + pldc2 # Sum of the first two axes

# Plot the DCA results to visualize the relationships between species and samples
plot(ord)

# Example species to plot and interpret their positions in the ordination plot
# Bromus hordeaceus - a typical species of dunes
# Achillea - representative of grassland areas
# Salix repens - a shrub species

# Note: In the ordination plot, the position of species and samples indicates their ecological relationships.
# Species that are close together in the plot tend to occur together in the same samples.
# The graph helps to visualize which species are associated with each other and the different habitat types they represent.
