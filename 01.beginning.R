 # Here I can write anything I want! 
# Basic R operations and plotting examples
# R as a calculator
2 + 3 # Simple addition

# Assigning the result of an addition to an object
vidhi <- 2 + 3
vidhi # Display the value of 'vidhi'

# Assign another addition result to an object
duccio <- 5 + 3
duccio  # Display the value of 'duccio'

# Perform arithmetic with objects
final <- vidhi * duccio
final  # Display the result of multiplication

final^2

# Creating arrays (vectors) for microplastics and people
sophi <- c(10, 20, 30, 50, 70) # microplastics # functions have parentheses and inside them there are arguments

paula <- c(100, 500, 600, 1000, 2000) # people

Plot (paula, sophi)

# Plotting data with axis labels
Plot (paula, sophi, xlab= "number of people" , ylab= "microplastics" )

# Assigning vectors to more descriptive variable names
people <- paula
microplastics <- sophi

# Basic scatter plot
plot(people, microplastics)

# Customize plot symbols
plot (people, microplastics, pch= 19)

# Increase symbol size
plot (people, microplastics, pch= 19, cex=5)

# Change symbol color to blue
plot (people, microplastics, pch= 19, cex=5, col= "blue")

