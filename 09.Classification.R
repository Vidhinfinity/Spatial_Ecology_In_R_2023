# Classifying remote sensing data

# THEORY: Grouping the pixels to make a final class. If you have an image say having forest cover having different parts like water and agriculture, if we take
# 2 bands for example like red band for x axis and  NIR band for y. we will see the reflectance in terms of random pixels. water will abosrb all NIR and may relect some red.
# Different areas will reflect light at different points. Classes or cluster is a set of individuals having similar characteristics.
# The smallest distance to the nearest class is calculated to assign a class to an incognito class.
#you can assign classes to different pixels.

 # Procedure for classifying remote sensing data

library(terra)
library(imageRy)
im.list() # sun images to classify the images of sun radiations

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") # to import the sun image
#high level : yellow ; lower level: brownish;  low level : black color

# im.classify is the function followed by (image, number of clusters you want to put)
im.classify (sun, num_clusters = 3)
sunc <- im.classify (sun, num_clusters = 3)
plot(sunc) #class with yellow area will represent the higher energy which in this case is 1.

# working with mattogosso forest time change # Classify Satelitte data
#step 1 : import the images
m1992 <- im.import ("matogrosso_ast_2006209_lrg.jpg")                   
m2006 <- im.import ( "matogrosso_l5_1992219_lrg.jpg")
# step 2 classification
m1992c <- im.classify (m1992, num_clusters=2)
# step 3 plot
plot(m1992c) 
#classes: forest =1 ; human = 2

#step 4: same for 2006 image
# step 2 classification
m2006c <- im.classify (m2006, num_clusters=2)
# step 3 plot
plot(m2006c) 
#classes: forest =1 ; human = 2

#step 5: plotting multi-frame of both plots

par(mfrow=c(1,2))
plot(m1992c) 
plot(m2006c)

# To see the frequency we use the below function, to see how many pixels are attaining to a forest and how many to humans.
f1992c <- freq(m1992c)

# let's extract the total number of pixels from images
tot1992 <- ncell(m1992c)

#percentage: frequency *100/ total

p1992 <- f1992 *100 / tot1992
p1992

#forest: 54% ; humans: 45%

#calculate freq, total and percentage for 2006 image
f2006c <- freq(m2006c)
tot2006 <- ncell(m2006c)
p2006 <- f2006c *100 / tot2006
p2006

# #forest: 16% ; humans: 83%

#building the final table
class <- c("forest", "human")
y1992 <- c (54, 45)
y2006 <- c (16, 83)

#putting everything together
tabout <- data.frame (class, y1992, y2006)
tabout

## final plot # we will make a barplot with tabout
p1 <- ggplot(tabout, aes(x=class, y=1992, color=cover)) + geom_bar(stat="identity", fill="white"))
p2 <- ggplot(p, aes(x=cover, y=perc2006, color=cover)) + geom_bar(stat="identity", fill="white"))
p1+p2

#12dec23

# Building the final table
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55) 

tabout <- data.frame(class, y1992, y2006)
tabout

# building the output table
cover <- c("forest", "agriculture") 
perc1992 <- c(83.08, 16.91)
perc2006 <- c(45.31, 54.69)

# final table
p <- data.frame(cover, perc1992, perc2006)
p


# final output
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2 

# scales are used in the above case to soften the impact of change as the y limit is different in the two graphs.

# final output, rescaled
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2

#now, the above graph shows the same limits on the y-axis. The loss of forest detection was determined by comparing 1992 and 2006.
