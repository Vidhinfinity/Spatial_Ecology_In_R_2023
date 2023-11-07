library(imageRy)
library(terra)

im.list()

b2 <- im.import("sentinel.dolomites.b2.tif")
b3 <- im.import("sentinel.dolomites.b3.tif")
b4 <- im.import("sentinel.dolomites.b4.tif")
b8 <- im.import("sentinel.dolomites.b8.tif")


#associating bands with components. 

#rgb space
# RGB r is the red color b3, g stands for green b2 and b for blue b1, x is the image
# stacksent: 
#band 2 blue element 1, stacksent [[1]]
#band 3 green element 2, stacksent [[2]]
#band 4 red element 3, stacksent [[3]]
# band 8 NIR element 4, stacksent [[4]]

im.plotRGB (stacksent, r=3, g=2, b=1)
im.plotRGB (stacksent, r=4, g=3, b=2) 
im.plotRGB (stacksent, r=3, g=4, b=2) #violet is bare soil. green is trees. black is shadows 
im.plotRGB (stacksent, r=3, g=2, b=4) #moving NIr (near infrared) from green to blue, everything reflecting NIR will become blue. all vegetation is blue. 
#these are the colors of reflectance i.e. the ratio between the incidence and radiance.

# If we want to see the correlation between two bands say red or green. 
#if you have a number of variables and wish to see the correlation between them we use the function Pairs.

pairs(stacksent) #the 0.99 or 0.71 values represent the correlation btw bands from resp row and column. graphs represent the frequency of the reflectance. Scattered plot represent the correlation. more linear means more correlated.

#Difference vegetation index (DVI) 
#Example: difference btw NIR and Red we get DVR of 80 in 1990 and the same DVR in 2023 is 10. This means that the forest is being destroyed at that specific place.






