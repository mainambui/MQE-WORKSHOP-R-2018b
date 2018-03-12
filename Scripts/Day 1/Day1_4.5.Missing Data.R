#---
#  title: "4.5.Missing Data"
#author: "Modified from nice R code"
#date: "13 of March 2018"
#output: html_document
#---
  
#Missing data are a fact of life in biology. 
#Individuals die, equipment breaks, you forget to measure something, 
#you can't read your writing, etc.

#If you load in data with blank cells, 
#they will appear as an 'NA' value.

## @knitr MD1
setwd("/Users/stephdagata/Documents/GitHub/WIO-R-WORKSHOP-2017")
data <- read.csv("data/seed_root_herbivores.csv")
## @knitr end MD1

#Some data to play with.

## @knitr MD2
x <- data$Height[1:10]
## @knitr end MD2

#If the 5th element was missing

## @knitr MD3
x[5] <- NA
## @knitr end MD3

#This is what it would look like:

#Note that this is not a string "NA"; that is something different entirely.

#Treat a missing value as a number that could stand in for anything.

#So what is

## @knitr MD4
1 + NA
## @knitr MD5
1 * NA
## @knitr MD6
NA + NA
## @knitr end MD6


#These are all NA because if the input could be anything, 
#the output could be anything.

#What is the value of this:

## @knitr MD7
mean(x)
## @knitr end MD7

#It's 'NA' too because 'x[1] + x[2] + NA + ...' must be 'NA'. 
#And then 'NA/length(x)' is also 'NA'.

#This is a pretty common situation for data, 
#so the mean function takes an 'na.rm' argument

## @knitr MD8
mean(x, na.rm = TRUE)
## @knitr end MD8

#'sum' takes the same argument too:

## @knitr MD9
sum(x, na.rm = TRUE)
## @knitr end MD9

#Be careful though:

## @knitr MD10
sum(x, na.rm = TRUE)/length(x)  # not the mean!
## @knitr MD11
mean(x, na.rm = TRUE)
## @knitr end MD11

#The 'na.omit'function will strip out all NA values:

## @knitr MD12
na.omit(x)
## @knitr end MD12

#So we can do this:

## @knitr MD13
length(na.omit(x))
## @knitr end MD13

#You can't test for 'NA'-ness with '==':

## @knitr MD14
x == NA
## @knitr end MD14

#(why not?)
#Use 'is.na' instead:

## @knitr MD15
is.na(x)
## @knitr end MD15

#So 'na.omit' is (roughly) equivalent to

## @knitr MD16
x[!is.na(x)]
## @knitr end MD16

## Excercise
#Our standard error function doesn't deal well with missing values:

## @knitr MD17
standard.error <- function(x) {
    v <- var(x)
    n <- length(x)
    sqrt(v/n)
}
## @knitr end MD17

#Can you write one that always filters missing values?


## Other special values:
#Positive and negative infinities

## @knitr MD18
1/0
## @knitr MD19
-1/0
## @knitr MD20
0/0

