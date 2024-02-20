# Here I can write anything I want! 
## R as a calculator
2 + 3

# Assign to an object
vidhi <- 2 + 3
vidhi

duccio <- 5 + 3
duccio

final <- vidhi * duccio
final

final^2

# array
# they're functions. fuctions always have parenthesis and inside them there are the arguments.
#examples
sophi <- c(10, 20, 30, 50, 70) # microplastics 
paula <- c(100, 500, 600, 1000, 2000) # people

# we can plot them together
plot(paula, sophi, xlab="number of people", ylab="microplastics")

# we can also previously assign paula and sophi to some objects
people <- paula
microplastics <- sophi
plot(people, microplastics)
plot (people, microplastics, pch= 19)
plot (people, microplastics, pch= 19, cex=5)
plot (people, microplastics, pch= 19, cex=5, col= "blue") #pch gives the shape of the symbols in R, cex represents the size, col for the color
# we can find the symbols in this site:
# http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r
