# This is a script to visualize satellite data

library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")

library(imageRy)
library(terra)
# now we will use a package
im.list()

# importing data
# blue band
b2 <- im.import("sentinel.dolomites.b2.tif") # b2 is the blue wavelength
b2
