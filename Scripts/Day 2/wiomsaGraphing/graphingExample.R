##
##	AN EXAMPLE OF WHAT I CONSIDER TO BE BEST PRACTICE FOR PUBLICATION FIGURES
##


##	PAGE SIZES FOR THE JOURNAL IN QUESTION
##	this means if you need to change journals it is very easy to update.
##	also makes it very easy to reuse code for other papers.
#############################################################################
pageWidthOne <- 3.5		# one column width (in inches, yikes!)
pageWidthTwo <- 7.2		# two column width (in inches, yikes!)
pageHeight <- 9.4		# page height (in inches, yikes!)

pagePaper <- 'A4'		# My paper size (or: 'A4r','letter')

fontFamily <- 'Times'	# font family - some journals will tell you which they want.

sLwd <- 2				# journals will often have a minimum line width
sLty <- 3				# this is line type, not specific to journal, but with other line par()


# NOTE: FANCY SCRIPT - ONLY CREATES THE DIRECTORY IF THE DIRECTORY IS NOT ALREADY THERE
if(!("./figs") %in% list.dirs(".")) dir.create("./figs")


## NEEDED TO INCLUDE A JPEG IN A PLOT
library(jpeg) 

## LOAD THE PHOTO INTO R
shellImage <- readJPEG("data/20267blackSmall.jpg") 

## LOAD TRACE ELEMENT DATA
shellTrace <- read.csv("data/traceElement20267multiYear.csv", skip=2)

## THESE VALUES WERE SET MANUALLY BASED ON THE POSITION OF THE WINTERS IN THE PHOTO
winters <- c(2.63,7.5,15.2,25.17)
linesX <- c(2.0, 6.5, 12.7, 23)
linesY <- c(1.5, 5.0, 07.8, 08)

## OPEN A PDF FILE...
pdf("./figs/shellTraceElements.pdf", width=pageWidthTwo, height= pageHeight, family=fontFamily, paper=pagePaper)

## SET 4 ROWS AND 1 COLUMN & VARIOUS OTHER PARAMETERS
par (mfcol=c(4,1))
par(oma=c(4,5,1,1), mar=c(0,0,0,0), bty='u', xaxs='i', mgp=c(2,0.6,0), cex=0.75)

##	PLOT SHELL IMAGE...
plot(shellTrace$Dist_mm,shellTrace$MgCaRatio, type='n', ann=FALSE, axes=FALSE, ylim=c(0,10), yaxs='i', las=1, lwd=0.5)
rasterImage(shellImage, xleft=0, ybottom=0, xright=max(shellTrace$Dist_mm), ytop=10)
text(1,8,"Shell 20267", pos=4, col='white', cex=2)

##	LINES TO INDICATE YEARS (WINTER SEASONS)
segments(winters, rep(0,4),linesX,linesY, col='white', lty= sLty, lwd= sLwd)

##	LOCATION ALONG THE X AXIS FOR yLab TO BE PRINTED
labX <- 15.5

##	A PANEL FOR EACH TRACE ELEMENT:
yLab <- 'Mg/Ca'
plot(shellTrace$Dist_mm,shellTrace$MgCaRatio, type='l', xaxt='n', ylab=yLab, ylim=c(0,3), yaxs='i', las=1, lwd=0.5)
segments(x0=winters, y0=rep(-1,4), x1=winters, y1=rep(100,4), lty=sLty, lwd=sLwd)
text (labX,2.5,yLab, pos=4, cex=2)

##	A PANEL FOR EACH TRACE ELEMENT:
yLab <- 'Ba/Ca'
plot(shellTrace$Dist_mm,shellTrace$BaCaRatio, type='l', xaxt='n', ylab=yLab, ylim=c(0,0.047), yaxs='i', las=1, lwd=0.5)
segments(x0=winters, y0=rep(-1,4), x1=winters, y1=rep(100,4), lty= sLty, lwd= sLwd)
text (labX,0.04,yLab, pos=4, cex=2)
mtext("(mmol/mol)", side=2, line=3, outer=FALSE, cex=1.25)

##	A PANEL FOR EACH TRACE ELEMENT:
yLab <- 'Sr/Ca'
plot(shellTrace$Dist_mm,shellTrace$SrCaRatio, type='l', ylab=yLab, ylim=c(1.5,11), yaxs='i', las=1, lwd=0.5)
segments(x0=winters, y0=rep(-1,4), x1=winters, y1=rep(100,4), lty= sLty, lwd= sLwd)
text (labX,10,yLab, pos=4, cex=2)

##	X AXIS:
mtext("Distance (mm)", side=1, line=2.5, outer=TRUE, cex=1.25)

dev.off()