## BASED ON: JOSH MADIN
## http://acropora.bio.mq.edu.au/resources/introduction-to-r/graphing/
##
##	MODIFIED BASED ON DELIVERY BY M. KOSNIK IN 2017.MAR


## WE NEED SOME DATA TO PLAY WITH
##	READ A CSV FILE
data <- read.csv("data/seed_root_herbivores.csv", as.is=TRUE)

## WHAT HAVE WE GOT HERE?
head(data)

## DIFFERENT WAYS REFERENCE COLUMNS, SHOULD ALL WORK
data[,"Height"] 
data[["Height"]] 
data$Height

#######################################
## HISTOGRAMS
#######################################
? hist()

#################
## PLOT HISTOGRAM OF HEIGHT
hist(data$Height)

## LETS ADD BETTER AXIS LABELS
hist(data$Height, xlab='Height (cm)')

## LETS COLOUR OUR COLUMNS & ADD MAIN TITLE
hist(data$Height, xlab='Height (cm)', col='blue', main="Figure 1")

## ANOTHER WAY TO SPECIFY COLOURS
hist(data$Height, xlab="Height (cm)", col=rgb(0,0.1,0.5), main="Figure 1")

#################
## MAKE A HISTOGRAM FOR SEED.HEADS... WITH NO AXES OR LABELS
hist(data$Seed.heads, col='forestgreen', ann=FALSE, axes=FALSE)

## ADD AXES MANUALLY (ALLOWS FOR GREATER CONTROL)
? axes()
axis(side= 1)	# identical to what would have been drawn from hist()
axis(2, lwd=2, lty=3, col='blue', font=3)	# specify details of line 
## ANOTHER WAY TO ADD MARGIN TEXT (AKA - LABEL)
? mtext()
mtext("Genus italicus", side=3, line=-2, font=4, adj=0.7, cex=2)	# big, italic font right side
mtext("Number of seed heads", side=1, line=2)

## WHAT OTHER OPTIONS DOES HISTOGRAM HAVE?
? hist()
## SET "breaks"
hist(sqrt(data$Seed.heads), breaks=(0:34), col='lightgrey')

## WHAT ELSE CAN "hist()" DO?
seedHeadHist <- hist(sqrt(data$Seed.heads), breaks=(0:36), plot=FALSE)
seedHeadHist

#######################################
## BIVARIATE PLOTS
#######################################
? plot()

## SPECIFY THE COLUMN WITH THE X DATA AND THE COLUMN WITH THE Y DATA
plot(data$Height, data$Seed.heads)

## ALTERNATIVELY, USE FORMULA NOTATION (SAME PLOT, BUT BETTER DEFAULT AXIS LABELS)
plot(Seed.heads ~ Height, data)

## PLOT IT WITH A SQUARE ROOT TRANSFORM ON THE Y AXIS?
plot(sqrt(Seed.heads) ~ Height, data) 

## LETS MAKE NICER AXIS LABELS
plot(sqrt(Seed.heads) ~ Height, data, xlab="Height, cm", ylab="Sqrt number of seed heads", col='forestgreen')

## LETS MAKE IT PLOT LINES INSTEAD
plot(sqrt(Seed.heads) ~ Height, data, xlab="Height (cm)", ylab="Sqrt number of seed heads", type = "l")

## LETS MAKE IT PLOT THE AXES, BUT NOT ANY POINTS!
plot(sqrt(Seed.heads) ~ Height, data, xlab="Height, cm", ylab="Sqrt number of seed heads", type="n") 
## ?? WHY WOULD WE WANT TO DO THAT??
? points()

## LETS PLOT THE "Root.herbivore == TRUE" treatmet as red circles
points(sqrt(Seed.heads) ~ Height, data=data[data$Root.herbivore==TRUE,], col="red", pch=21) 
## LETS PLOT THE "Root.herbivore == FALSE" treatmet as green squares
points(sqrt(Seed.heads) ~ Height, data=data[data$Root.herbivore==FALSE,], col="green", pch=22)
## WHAT ELSE CAN WE SPECIFY FOR POINTS?

## PLOT IS SUPER GENERAL (IT WILL TRY TO PLOT ANYTHING).. HERE IT DEFAULTS TO POINTS, FACTORS DEFAULT TO BOXPLOTS...
plot(Seed.heads ~ as.factor(Seed.herbivore), data)


#######################################
## BOX PLOTS
#######################################
? boxplot()

boxplot(data$Height, col='darkblue')

## SPLIT IT BY "Root.herbivore" TREATMENT?
boxplot(Height ~ Root.herbivore, data, col='skyblue') 

## BETTER AXIS LABELS
boxplot(Height ~ Root.herbivore, data, xlab="Root herbivores", ylab="Plant height, cm") 

## ADD "notch"ES?
boxplot(Height ~ Root.herbivore, data, xlab="Root herbivores", ylab="Plant height, cm", notch = TRUE)
## ?? WHAT ARE THE "notch"es??

## OVERLAY THE POINTS? ( IT WORKS - IF WE MAKE Root.herbivore A FACTOR )
boxplot(Height ~ Root.herbivore, data, xlab="Root herbivores", ylab="Plant height, cm", notch = TRUE)
points(as.factor(data$Root.herbivore),data$Height, cex=0.5)


#######################################
## EXPLORATORY PLOTTING
#######################################
? pairs()

## A VERY COOL FUCNTION, BUT ONLY WORKS WITH NUMERIC DATA
## Great way to quickly access collinearity among variables
pairs(data)

## WHICH COLUMNS HAVE NUMERIC DATA??
names(data) 
comps <- names(data)[2:8]
comps

## BEHOLD A QUICK SET OF PLOTS FOR ALL PAIR-WISE COMPARISONS 
pairs(data[comps])


#######################################
## 3D PLOTTING
#######################################

# LETS USE THE BUILT IN volcano DATASET FOR THIS...
?volcano

# TO GOOD BUILT IN FUNCTIONS ARE image() AND contour()
image(volcano) 
contour(volcano) 

## SPECIFY THE COLOUR GRADIENT
image(volcano, col=terrain.colors(50))
## "ADD" CONTOURS OVER TOP OF image()
contour(volcano, add=TRUE)


#######################################
## BAR PLOTS
#######################################

# I PERSONALLY REALLY DISLIKE BARPLOTS, BUT THEY ARE COMMONLY USED
# R DOES NOT HAVE A STANDARD ERROR FUNCTION, BUT WE CAN WRITE ONE...
standard.error <- function(x) { sd(x)/sqrt(length(x)) }

## REMEMBER ALL THE WAY BACK TO THE MORNING...
## USE "aggregate" TO GET THE mean data['Height'] BY data[c("Root.herbivore", "Seed.herbivore")]
## TIP: USING data["Height"] INSTEAD OF data$Height GIVES YOU NICER COLUMN NAMES

mn <- aggregate(data["Height"], data[c("Root.herbivore", "Seed.herbivore")], mean) 
bp <- barplot(mn$Height)
## NOTE: BY ASSIGNING barplot() TO bp... WE CAN DO THE NEXT STEP

## USE "aggregate" TO GET THE standard.error
se <- aggregate(data["Height"], data[c("Root.herbivore", "Seed.herbivore")], standard.error)
## ADD THE STANDARD ERROR USING arrows
arrows(bp, mn$Height + se$Height, bp, mn$Height - se$Height, code=3, angle=90)
## ?? DOESN'T QUITE LOOK RIGHT

## MAKE A BAR PLOT AND SPECIFY Y-AXIS "ylim" SO THAT THE WHOLE SE FITS IN...
bp <- barplot(mn$Height, ylim=c(0, max(mn$Height + se$Height))) 
arrows(bp, mn$Height + se$Height, bp, mn$Height - se$Height, code=3, angle=90)

## ADD LABELS
axis(1, at=bp, labels=as.character(mn$Root.herbivore)) 
axis(1, at=bp, labels=as.character(mn$Seed.herbivore), line=1, tick=FALSE)
# ? WHAT DOES "tick" DO?

## MAKE BETTER LABELS
herb_labels <- c("None", "Root only", "Seed only", "Both root & seed") 
bp <- barplot(mn$Height, ylim=c(0, 80)) 
arrows(bp, mn$Height + se$Height, bp, mn$Height - se$Height, code=3, angle=90)
axis(1, at=bp, labels=herb_labels)
## STILL NOT WHAT WE WANT BECAUSE R DOES SKIPS LABELS THAT WOULD OVER WRITE
axis(1, at=bp, labels=herb_labels, las=2)
title("Barplots are a pain...")

##  HOW DO WE FIX THE MARGIN SIZE...
##  SHOW ME HOW TO DO THAT CRAZY VOODOO THAT YOUDOO?
##  REMEMBER IF YOU DIG DEEP ENOUGH YOU CAN TINKER WITH ANYTHING IN R
##  Afraid? "You will be. You... will... be." (Yoda) 


#######################################
##  GLOBAL GRAPHIC PARAMETERS
#######################################

?par
# NOTE: NO ONE REMEMBERS ALL OF THESE PARAMETERS BUT HOPEFULLY YOU WILL REMEMBER THAT ?par GETS YOU THE ANSWER
# NOTE: CLOSING YOUR GRAPHING WINDOW WILL RESET YOUR GLOBAL PARAMETERS (FOR GOOD AND BAD)
# TIP: YOU CAN SAVE PARAMETERS TO A VARIABLE TO RESTORE YOUR OLD ONES
# TIP: par() WILL TELL YOU WHAT THE CURRENT PARAMETERS ARE

# SAVE CURRENT / ORIGINAL PARAMETERS
oldPar <- par()

## SO HOW CAN WE FIX OUR MARGIN ISSUE?
par(mar=c(9, 4, 4, 2)) 
bp <- barplot(mn$Height, ylim=c(0, 80)) 
arrows(bp, mn$Height + se$Height, bp, mn$Height - se$Height, code=3, angle=90, lwd=2)
axis(1, at=bp, labels=herb_labels, las=2) 
mtext("Type of herbivory", side=1, line=7) 
mtext("Plant height, cm", side=2, line=3) 
title("Barplots are still a pain...")

# RESTORE ORIGINAL PARAMETERS
par(oldPar)


#######################################
## SAVING PLOTS
#######################################

# NOTE: YOU CAN SAVE OR "EXPORT" THE GRAPHING WINDOW TO SAVE YOUR PLOTS
# TIP: DON'T SAVE OR "EXPORT" THE GRAPHING WINDOW TO SAVE YOUR PLOTS
# TIP: ALWAYS USE A VECTOR FORMAT (I.E., PDF) SO THAT YOUR PLOTS LOOK GOOD WHEN SCALED
# TIP: IF YOU MUST USE A RASTER FORMAT USE PNG RATHER THAN JPEG
# TIP: SAVE YOUR PLOT FROM THE COMMAND LINE!
#       - TOTAL CONTROL OF PLOT SIZES, ETC TO MEET SPECIFIC JOURNAL REQUIREMENTS
#       - YOU CAN JUST RUN A SCRIPT TO REGENERATE ALL YOUR PLOTS IF (WHEN) YOUR DATA CHANGE OR YOUR SUPERVISOR WANTS IT TO LOOK A LITTLE DIFFERENT
#       - EVERYTIME THE SCRIPT RUNS YOU WILL ALWAYS GET THE EXACT SAME PLOT, REPRODUCIBILITY IS KEY TO GOOD SCIENCE

# TIP: MAKE A SUBDIRECTORY CALLED "figs" IN YOUR PROJECT DIRECTORY
dir.create("./figs")

# NOTE: FANCY SCRIPT - ONLY CREATES THE DIRECTORY IF THE DIRECTORY IS NOT ALREADY THERE
# TIP: DEALING WITH THE UNEXPECTED WELL IS WHAT MAKES FLEXIBLE CODE (MOST CODE WE WRITE IT NOT FLEXIBLE)
if(!("./figs") %in% list.dirs(".")) dir.create("./figs")

# START A PDF FILE TO WRITE TO
pdf("./figs/my_barplot.pdf", width=5, height=5) 
# WHAT ARE THE UNITS OF WIDTH AND HEIGHT
par(mar=c(9, 4, 4, 2)) 
bp <- barplot(mn$Height, ylim=c(0, 80)) 
arrows(bp, mn$Heigh + se$Height, bp, mn$Heigh - se$Height, angle=90, code=3) 
axis(1, at=bp, labels=herb_labels, las=2) 
mtext("Degree of herbivory", 1, line=7) 
mtext("Plant height, cm", 2, line=3) 
title("Barplots are a pain...") 
dev.off()
## MUST ALWAYS USE dev.off() WHEN YOU ARE DONE WRITING TO THE FILE... OR IT STAYS OPEN...

# START A PNG FILE
png(filename="./figs/my_barplot.png", width=400, height=400) 
par(mar=c(9, 4, 4, 2)) 
bp <- barplot(mn$Height, ylim=c(0, 80)) 
arrows(bp, mn$Heigh + se$Height, bp, mn$Heigh - se$Height, angle=90, code=3) 
axis(1, at=bp, labels=herb_labels, las=2) 
mtext("Degree of herbivory", 1, line=7) 
mtext("Plant height, cm", 2, line=3) 
title("Barplots are a pain...") 
dev.off()

##  TIP: WHEN THINGS GO WRONG SAVING PLOTS
##  - IT IS NEARLY ALWAYS BECAUSE THE FILE WAS NOT CLOSED
##  - REPEAT dev.off() until it says "cannot shut down device"


#######################################
## MULTIPLE PANEL PLOTS
#######################################

## "mfrow" FILLS YOUR PANELS ACROSS THE TOP ROW AND THEN SEQUENTIAL ROWS DOWN
## "mfcol" FILLS YOUR PANELS DOWN THE LEFT MOST COLUMN FIRST...

oldPar <- par()

##  MAKE 4 HISTOGRAMS
par(mfcol=c(2,2)) 
hist(data$Height, col='blue') 
hist(data$Height, col='green') 
hist(data$Height, col='red') 
hist(data$Height) 
par(oldPar)

##  LETS MAKE IT NICER...
##  - SET MARGINS ALL TO 1
##  - SET THE OUTER MARGINS TO c(4,3,4,2)
par(mfrow=c(2, 2), mar=c(1, 1, 1, 1), oma=c(4, 3, 4, 2))

##  LETS ONLY PUT THE OUTER AXES ON (COMMON IF THE AXES ARE THE SAME)
##  LETS LABEL EACH PANEL A-D IN THE UPPER LEFT CORNER
hist(data$Height, ann=FALSE, axes=FALSE, col='forestgreen') 
axis(2) 
mtext("A", 3, -2, adj = 0.1, font=2, cex=1.2) 
hist(data$Height, ann=FALSE, axes=FALSE, col='darkblue') 
mtext("B", 3, -2, adj = 0, font=2, cex=1.2) 
hist(data$Height, ann=FALSE, col='skyblue') 
mtext("C", 3, -2, adj = 0.1, font=2, cex=1.2) 
hist(data$Height, ann=FALSE, axes=FALSE, col='grey40') 
axis(1) 
mtext("D", 3, -2, adj = 0, font=2, cex=1.2)

##  JUST TO DEMONSTRATE THE POSSIBLE BOXES...
? box()
box("plot", col="red") 
box("figure", col="blue") 
box("inner", col="black") 
box("outer", col="pink")

##	mtext REALLY SHINES - PUTTING JOINT AXIS LABELS "outer"
mtext("Height (cm)", side=1, outer=TRUE, line=2) 
mtext("Frequency", side=2, outer=TRUE, line=2) 
mtext("Four plots of height", side=3, outer=TRUE, line=1, cex=1.5) 



#######################################
##  ADDING ADDITIONAL THINGS TO PLOTS
#######################################
plot(sqrt(Seed.heads) ~ Height, data, type="p", axes=FALSE, ann=FALSE, pch=21, col="white", bg="black") 
axis(1) 
axis(2, las=2) 
mtext("Height (cm)", side = 1, line = 3) 
mtext("sqrt(Number of seed heads)", side = 2, line = 3) 
title("Figure 1", adj=0)

##  GET/PLOT A BEST FIT LINE USING lm()
mod <- lm(sqrt(Seed.heads) ~ Height, data)
##  PLOT THE LINE USING (abline)
abline(mod, lwd=2, lty=2, col='blue')

# GET/PLOT THE PREDICTION INTERVALS
hs <- seq(min(data$Height), max(data$Height), 1) 
seed_pred <- predict(mod, list(Height = hs), interval = "prediction") 
lines(hs, seed_pred[,"lwr"], lty = 2) 
lines(hs, seed_pred[,"upr"], lty = 2) 

# GET/PLOT THE CONFIDENCE INTERVALS
seed_conf <- predict(mod, list(Height = hs), interval = "confidence") 
lines(hs, seed_conf[,"lwr"]) 
lines(hs, seed_conf[,"upr"]) 

# PLOT A SHADED THE CONFIDENCE INTERVAL REGION
polygon(c(hs, rev(hs)), c(seed_conf[,"lwr"], rev(seed_conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)

##  LETS ADD THE R-SQUARED TO THE PLOT
##  TIP: UNICODE CHARACTERS ARE AN EASY WAY TO GET SOME CHARACTERS
text(80,5,paste("r\U00b2 = ",round(summary(mod_sqrt)$r.squared,2)))

# ADD A LEGEND
legend("topleft", c("green data", "actual data", "orange point"), pch=c(4, 20, 3), col=c("green", "black", "orange"), bty="n")

# ADD SOME MATH 
text(90, 3, expression(Y[i] == beta[0]+beta[1]*X[i1]+epsilon[i])) # see demo(plotmath) for more examples 


## NOW... WRAP THE SUPER NICE PLOTS INTO A PDF...