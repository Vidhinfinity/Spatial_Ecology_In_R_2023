# overlap: Estimates of Coefficient of Overlapping for Animal Activity Patterns
# relation among species in time. Kernal density
library (overlap)

# data
data(kerinci)
summary(kerinci)

# tiger


# selecting the first species
tiger <- kerinci[kerinci$Sps=="tiger",]
tiger
summary(tiger)
head(tiger)
# The unit of time is the day, so values range from 0 to 1. 
# The package overlap works entirely in radians: fitting density curves uses trigonometric functions (sin, cos, tan),
# so this speeds up simulations. The conversion is straightforward: kerinci$Time * 2 * pi
kerinci$timeRad <- kerinci$Time * 2 * pi

# selecting the first species
tiger <- kerinci[kerinci$Sps=="tiger",]

# selecting the time for the tiger
timetig <- tiger$timeRad
densityPlot(timetig, rug=TRUE)

#excercise : select onbly the data on macaque individuals

macaque  <- kerinci[kerinci$Sps=="macaque",]
head(macaque)

timemac <- macaque$timeRad
densityPlot(timemac, rug=TRUE)

# here we now use overlap to check the tiger and macaque graph together to see when can tiger predate on monkeys.

# overlap!
overlapPlot(timetig, timemac)

