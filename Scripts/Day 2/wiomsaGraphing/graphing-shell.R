## ORIGINALLY BASED ON WORK BY: JOSHUA MADIN
## http://acropora.bio.mq.edu.au/resources/introduction-to-r/graphing/
##
##	MODIFIED BY M. KOSNIK IN 2017.OCT

##	WE NEED SOME DATA TO PLAY WITH
#######################################
#	Individual bivalves collected from soft sediment at One Tree Reef with measurements.
#	This is a similified version of the data related to this research:
#
#	Julieta C. Martinelli, Matthew A. Kosnik, And Joshua S. Madin 
#	Passive Defensive Traits Are Not Good Predictors Of Predation For Infaunal Reef Bivalves 
#	PALAIOS, 2016, v. 31, 607–615 . http://dx.doi.org/10.2110/palo.2016.018  
#
#	Matthew A. Kosnik, Quan Hua, Darrell S. Kaufman, Atun Zawadzki 
#	Sediment accumulation, stratigraphic order, and the extent of time-averaging in lagoonal sediments: 
#	a comparison of 210Pb and 14C/amino acid racemization chronologies
#	Coral Reefs (2015) 34:215–229. http://dx.doi.org/10.1007/s00338-014-1234-2 

##	READ A TAB DELIMITED FILE './data/oti_measurements.txt'
otiShells <- 

##	WHAT HAVE WE GOT HERE?

# ANYTHING FISHY?

# RE-IMPORT & CLEAN UP AS NEEDED

## REVIEW: DIFFERENT WAYS REFERENCE COLUMNS, SHOULD ALL WORK
otiShells[1:10,"x_mm"] 
otiShells[["x_mm"]][1:10]
otiShells$x_mm[1:10]

## IF YOU ARE GOING TO USE IT A BUNCH - MAKE A NEW COLUMN FOR THE TRANSFORMED VARIABLE
otiShells$crMass <- otiShells$mass_mg^(1/3)

#######################################
## HISTOGRAMS
#######################################
? hist()

#################
## PLOT HISTOGRAM OF SHELL SIZE
hist()

## LETS ADD BETTER AXIS LABELS

## LETS COLOUR OUR COLUMNS & ADD MAIN TITLE

## plot a histogram of log shell mass?

# QUESTION: which log is this?

## WHAT ELSE CAN "hist()" DO?
aHist <- hist(log2(otiShells[grep('Abranda',otiShells$taxonName),'mass_mg']), plot=FALSE)

# QUESTION: tell me about object aHist

## MAKE A HISTOGRAM FOR LOG ABRANDA SHELL MASS... WITH NO AXES OR LABELS
plot(aHist, col='seagreen', )

## ADD Y axis() MANUALLY (ALLOWS FOR GREATER CONTROL)
? axis()
	# identical to what would have been drawn from hist()

## SPECIFY A COMPLEX AXIS
where <- seq(floor(min(aHist$breaks)),ceiling(max(aHist$breaks)),by=2)
what <- 2^where
axis(1, at=where, labels=what, lwd=2, lty=3, col='blue', font=3)	 # specify details of line 

## ANOTHER WAY TO ADD MARGIN TEXT (AKA - LABEL)
? mtext()
mtext("Abranda", side=, line=-2, font=, adj=, cex=)	# big, bold italic font right side

# USE mtext() to add title to x-axis

## WHAT OTHER OPTIONS DOES HISTOGRAM HAVE?
? hist()
## SET "breaks"
aHist <- hist(otiShells[grep('Abranda',otiShells$taxonName),'x_mm'], plot=FALSE, breaks=0:28)
aHist
plot(aHist, col='seagreen', ann=FALSE, axes=TRUE, las=1)

## use mtext() to add labels & text...


#######################################
## BIVARIATE PLOTS
#######################################
? plot()

## subset the data to get only Pinguitellina
pingData <- 

## SPECIFY THE COLUMN WITH THE X DATA AND THE COLUMN WITH THE Y DATA
# plot() x_mm on the x-axis vs mass_mg on the y-axis
plot()

## ALTERNATIVELY, USE FORMULA NOTATION (SAME PLOT, BUT BETTER DEFAULT AXIS LABELS)
plot(mass_mg ~ x_mm, pingData)

## PLOT IT WITH A CUBE ROOT TRANSFORM ON THE Y AXIS?
plot() 

## LETS MAKE NICER AXIS LABELS USING xlab, ylab & col


## LETS MAKE IT PLOT LINES INSTEAD (what other options are there?)


## IF YOU ARE GOING TO USE IT A BUNCH - MAKE A NEW COLUMN FOR THE TRANSFORMED VARIABLE
# make a new column in otiShells for cuberoot of mass called crMass


## LETS MAKE IT PLOT THE AXES, BUT NOT ANY POINTS!
# plot crMass as a function of x_mm for otiShells, but no points!

## ?? WHY WOULD WE WANT TO DO THAT??
? points()

## LETS PLOT THE "Pinguitellina" as red circles

## LETS PLOT THE "Abranda" as green squares

## WHAT ELSE CAN WE SPECIFY FOR POINTS?

## PLOT IS SUPER GENERAL (IT WILL TRY TO PLOT ANYTHING). FACTORS DEFAULT TO BOXPLOTS...
plot(crMass ~ siteName, otiShells)


#######################################
## BOX PLOTS
#######################################
? boxplot()

# make a box plot of Pinguitellina length
boxplot()

## SPLIT IT BY "siteName"?


## BETTER AXIS LABELS


## ADD "notch"ES?

## ?? WHAT ARE THE "notch"es??

## OVERLAY THE POINTS? ( IT WORKS BECAUSE siteName IS A FACTOR )


#######################################
## EXPLORATORY PLOTTING
#######################################
? pairs()

## A VERY COOL FUCNTION, BUT ONLY WORKS WITH NUMERIC DATA
## Great way to quickly access collinearity among variables, check it for Pinguitellina?


## WHICH COLUMNS HAVE NUMERIC DATA??


## PLOT ALL PAIR-WISE COMPARISONS FOR NUMERIC Pinguitellina DATA


## and an explaination for why there are two relations instead of 1!

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

#	It is possible to read shape files, and do basic GIS type things in R.

#######################################
## BAR PLOTS
#######################################

# I PERSONALLY REALLY DISLIKE BARPLOTS, BUT THEY ARE COMMONLY USED
# R DOES NOT HAVE A STANDARD ERROR FUNCTION, BUT WE CAN WRITE ONE...
standard.error <- function(x) {  }

## REMEMBER ALL THE WAY BACK TO THE MORNING...
## USE "aggregate" TO GET THE mean otiShells['x_mm'] BY otiShells["taxonName"]
## TIP: USING otiShells["x_mm"] INSTEAD OF otiShells$x_mm GIVES YOU NICER COLUMN NAMES

mn <- aggregate()
# make a barplot of the mean length
bp <- barplot()
## NOTE: BY ASSIGNING barplot() TO bp... WE CAN DO THE NEXT STEP

## USE "aggregate" TO GET THE standard.error
se <- aggregate()
## ADD THE STANDARD ERROR USING arrows
arrows(bp, mn$x_mm + se$x_mm, bp, mn$x_mm - se$x_mm, code=3, angle=90, length=0.1, lwd=2)
## ?? DOESN'T QUITE LOOK RIGHT

## MAKE A BAR PLOT AND SPECIFY Y-AXIS "ylim" SO THAT THE WHOLE SE FITS IN...


## ADD LABELS USING axis()

## STILL NOT WHAT WE WANT BECAUSE R DOES SKIPS LABELS THAT WOULD OVER WRITE
# try again but rotating the axis labels 90 degrees

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
# use par() to set margin. hint: try 12 for margin 1


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
par(mar=c(12, 4, 4, 2)) 
bp <- barplot(mn$x_mm, ylim=c(0, max(mn$x_mm + se$x_mm, na.rm=TRUE)), las=1) 
arrows(bp, mn$x_mm + se$x_mm, bp, mn$x_mm - se$x_mm, code=3, angle=90, length=0.04, lwd=2)
axis(1, at=bp, labels= mn$taxonName, las=2, font=3, cex=0.7)
mtext("Species", side=1, line=10) 
mtext("Shell length (mm)", side=2, line=2.5) 
title("One Tree Reef Bivalvia") 
dev.off()
## MUST ALWAYS USE dev.off() WHEN YOU ARE DONE WRITING TO THE FILE... OR IT STAYS OPEN...

# START A PNG FILE
png(filename="./figs/my_barplot.png", width=400, height=400) 

## USE THE SAME CODE FOR THE PNG AS FOR THE PDF

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
plot(aHist, col='blue', ann=FALSE, main='Abranda') 
pHist <- hist(pingData$x_mm, col='green', main='Pinguitellina') 
hist(pingData$y_mm, col='red') 
plot(aHist,col='pink', ann=FALSE) 
par(oldPar)

##  LETS MAKE IT NICER...
##  - SET MARGINS ALL TO 1
##  - SET THE OUTER MARGINS TO c(4,3,4,2)
par(mfrow=c(2, 2), mar=c(1, 1, 1, 1), oma=c(4, 3, 4, 2))

##  LETS ONLY PUT THE OUTER AXES ON (COMMON IF THE AXES ARE THE SAME)
##  LETS LABEL EACH PANEL A-D IN THE UPPER LEFT CORNER
plot(aHist, ann=FALSE, axes=FALSE, col='forestgreen', xlim=range(pHist$breaks, aHist$breaks)) 
axis(2) 
mtext("A", 3, -2, adj = 0.1, font=2, cex=1.2) 
hist(pingData$x_mm, ann=FALSE, axes=FALSE, col='skyblue') 
mtext("B", 3, -2, adj = 0, font=2, cex=1.2) 
plot(pHist, ann=FALSE, col='pink', xlim=range(pHist$breaks, aHist$breaks)) 
mtext("C", 3, -2, adj = 0.1, font=2, cex=1.2) 
hist(pingData$x_mm, ann=FALSE, axes=FALSE, col='grey40') 
axis(1) 
mtext("D", 3, -2, adj = 0, font=2, cex=1.2)

##  JUST TO DEMONSTRATE THE POSSIBLE BOXES...
? box()
box("plot", col="red") 
box("figure", col="blue") 
box("inner", col="black") 
box("outer", col="pink")

##	mtext REALLY SHINES - PUTTING JOINT AXIS LABELS "outer"
mtext("Shell size (mm)", side=1, outer=TRUE, line=2) 
mtext("Frequency", side=2, outer=TRUE, line=2) 
mtext("Four plots of shell size", side=3, outer=TRUE, line=1, cex=1.5) 

par(oldPar)


#######################################
##  ADDING ADDITIONAL THINGS TO PLOTS
#######################################
plot(crMass ~ x_mm, pingData, type="p", axes=FALSE, ann=FALSE, pch=21, col="white", bg="black") 
axis(1) 
axis(2, las=2) 
mtext("Shell size (mm)", side = 1, line = 3) 
mtext("Cuberoot shell mass (mg)", side = 2, line = 3) 
title("Figure 1", adj=0)

##  GET/PLOT A BEST FIT LINE USING lm()
mod <- lm(crMass ~ x_mm, pingData)
##  PLOT THE LINE USING (abline)
abline(mod, lwd=2, lty=2, col='blue')

# GET/PLOT THE PREDICTION INTERVALS
hs <- seq(min(pingData$x_mm), max(pingData$x_mm), 1) 
intPred <- predict(mod, list(x_mm = hs), interval = "prediction") 
lines(hs, intPred[,"lwr"], lty = 2) 
lines(hs, intPred[,"upr"], lty = 2) 

# GET/PLOT THE CONFIDENCE INTERVALS
intConf <- predict(mod, list(x_mm = hs), interval = "confidence") 
lines(hs, intConf[,"lwr"]) 
lines(hs, intConf[,"upr"]) 

# PLOT A SHADED THE PREDICTION INTERVAL REGION
polygon(c(hs, rev(hs)), c(intPred[,"lwr"], rev(intPred[,"upr"])), col = rgb(0,0,0,0.2), border = NA)

##  LETS ADD THE R-SQUARED TO THE PLOT
##  TIP: UNICODE CHARACTERS ARE AN EASY WAY TO GET SOME CHARACTERS
text(5,4,paste("r\U00b2 = ",round(summary(mod)$r.squared,2)))

# ADD A LEGEND
legend("topleft", c("green data", "actual data", "orange cross"), pch=c(4, 20, 3), col=c("green", "black", "orange"), bty="y")

# ADD SOME MATH 
text(11, 2, expression(Y[i] == beta[0]+beta[1]*X[i1]+epsilon[i])) # see demo(plotmath) for more examples 


## NOW... WRAP THE SUPER NICE PLOTS INTO A PDF...