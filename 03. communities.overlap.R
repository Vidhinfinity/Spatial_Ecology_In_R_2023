# Overlap: Estimates of Coefficient of Overlapping for Animal Activity Patterns
# This script analyzes the temporal activity patterns of different species and their overlap using kernel density estimates.

## Load required library
library(overlap) # Overlap package for analyzing animal activity patterns

# Load and summarize the data
data(kerinci)  # Load the kerinci dataset provided by the overlap package
summary(kerinci) # Summarize the dataset to understand its structure and contents

## Analyze activity patterns of tigers

# Select data for the first species: tiger
tiger <- kerinci[kerinci$Sps == "tiger",] 
# Filter rows where the species is "tiger"

summary(tiger) # Summarize the tiger data
head(tiger)    # Display the first few rows of the tiger data

# The unit of time is the day, so values range from 0 to 1.
# The overlap package uses radians for fitting density curves (using trigonometric functions like sin, cos, tan).
# Convert the time to radians for accurate density calculations: kerinci$Time * 2 * pi
kerinci$timeRad <- kerinci$Time * 2 * pi 

# Select time data for tigers in radians
timetig <- tiger$timeRad 
# Extract the timeRad column for tigers

# Plot the density of tiger activity
densityPlot(timetig, rug=TRUE) 
# Plot the density of tiger activity with rug plot for individual data points

## Exercise: Analyze activity patterns of macaque individuals

# Select data for the second species: macaque
macaque <- kerinci[kerinci$Sps == "macaque",] 
# Filter rows where the species is "macaque"

head(macaque) # Display the first few rows of the macaque data

# Select time data for macaques in radians
timemac <- macaque$timeRad 
# Extract the timeRad column for macaques

# Plot the density of macaque activity
densityPlot(timemac, rug=TRUE) 
# Plot the density of macaque activity with rug plot for individual data points

# Use overlap to check the activity patterns of tigers and macaques together
# This helps to identify periods when tigers could potentially predate on macaques.

# Plot the overlapping density of tiger and macaque activity
overlapPlot(timetig, timemac) 
# Plot the overlap of tiger and macaque activity patterns
