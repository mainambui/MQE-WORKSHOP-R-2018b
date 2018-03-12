
#title:"1.2. Writing functions"
#Author:modified from 'nice-r-code': maina & Steph
#date: "27 October 2017"

#At some point, you will want to write a function, and it will probably be sooner than you think. 
#Functions are core to the way that R works, and the sooner that you get comfortable writing them, 
#the sooner you'll be able to leverage R's power, and start having fun with it.

#The first function many people seem to need to write is to compute the
#standard error of the mean for some variable, 
#because curiusly this function does not come with R's base package. 
#This is defined as sqrt(x)/n 
#(that is the square root of the variance divided by the sample size.

#Start by reloading our data set again.

## @knitr WF1
setwd("/Users/stephdagata/Documents/GitHub/WIO-R-WORKSHOP-2017")
data <- read.csv("data/seed_root_herbivores.csv")
## @knitr end WF1

#Explore the R data object:
## @knitr WF2
summary(data)
## @knitr end WF2

#We can already easily compute the mean:
## @knitr WF3
mean(data$Height)
## @knitr end WF3

#and the variance:
## @knitr WF4
var(data$Height)
## @knitr end WF4

#and the sample size

## @knitr WF5
length(data$Height)
## @knitr end WF5

#so it seems easy to compute the standard error:
## @knitr WF6
sqrt(var(data$Weight)/length(data$Weight))
## @knitr end WF6

#This is basically identical to the height case above. 
#We've copied and pasted the definition and replaced the variable that we are interested in. 
#This sort of substitution is tedious and error prone, 
#and the sort of things that computers are a lot better at doing reliably than humans are.

#It is also just not that clear from what is written what the point of these lines is. 
#Later on, you'll be wondering what those lines are doing.

#Look more carefully at the two statements and see the similarity in form, 
#and what is changing between them. This pattern is the key to writing functions.

## @knitr WF7
sqrt(var(data$Height)/length(data$Height))
## @knitr end WF7

#Here is the syntax for defining a function, 
#used to make a standard error function:

## @knitr WF8
standart.error <- function(x) {
  sqrt(var(x)/length(x))
}
## @knitr end WF8

#Takes one argument x
#Note indenting - to keep the code tydy
#Option to use return

#The result of the last line is "returned" from the function.

#We can call it like this:

## @knitr WF9
standart.error(data$Height)
## @knitr end WF9

#Note that 'x' has a special meaning within the curly braces. If we do this:

## @knitr WF10
x <- 1:100
## @knitr WF11
standart.error(data$Height)
## @knitr end WF11

#we get the same answer. Because 'x' appears in the "argument list", 
#it will be treated specially. 
#Note also that it is completely unrelated to the name of what is provided as value to the function.

#You can define variables within functions:

## @knitr WF12
standard.error <- function(x) {
  v <- var(x)
  n <- length(x)
  sqrt(v/n)
}
## @knitr end WF12

#This can often help you structure your function and your thoughts.
#These are also treated specially - they do not affect the main workspace (the "global environment") and are destroyed when the function ends. 
#If you had some value 'v' in the global environment, 
#it would be ignored in this function as soon as the local 'v' was defined, 
#with the local definition used instead.

## @knitr WF13
v <- 1000
standard.error(data$Height)
## @knitr end WF13

##Example 2

#We used the variance function above, but let's rewrite it. 
#The sample variance is defined as

#This case is more compliated, so we'll do it in pieces.

#We're going to use 'x' for the argument, 
#so name our first input data 'x' so we can use it.

## @knitr WF14
x <- data$Height
## @knitr end WF14

#The first term is easy:

## @knitr WF15
n <- length(x)
## @knitr WF16
(1/(n-1))
## @knitr end WF16

#The second term is harder. 
#We want the difference between all the 'x' values and the mean.

## @knitr WF17
m <- mean(x)
## @knitr WF18
x - m
## @knitr end WF18

#Then we want to square those differences:
## @knitr WF19
(x-m)^2
## @knitr end WF19

#and compute the sum and square:
## @knitr WF20
sum((x-m)^2)
## @knitr end WF20

#Watch that you don't do this, which is quite different
## @knitr WF21
sum(x-m)^2
## @knitr end WF21

#(this follows from the definition of the mean)

#Putting both halves together, the variance is

## @knitr WF22
(1/(n-1))*sum((x-m)^2)
## @knitr end WF22

#Which agrees with R's variance function

## @knitr WF23
var(x)
## @knitr end WF23


#The 'rm' function cleans up:

## @knitr WF24
rm(n,x,m)
## @knitr end WF24


#We can then define our function, using the pieces that we wrote above.

## @knitr WF25
variance <- function(x) {
  n <- length(x)
  m <- mean(x)
  (1/(n-1))*sum((x-m)^2)
}
## @knitr end WF25

#And test it:
## @knitr WF26
variance(data$Height)
## @knitr WF27
var(data$Height)
## @knitr end WF27


## An aside on floating point comparisons:

#Our function does not exactly agree with R's function

## @knitr WF28
variance(data$Height) == var(data$Height)
## @knitr end WF28

#This is not because one is more accurate than the other, 
#it is because "machine precision" is finite (that is, the number of decimal places being kept).

## @knitr WF29
variance(data$Height) - var(data$Height)
## @knitr end WF29

#This affects all sorts of things:

## @knitr WF30
sqrt(2)*sqrt(2)
## @knitr WF31
sqrt(2)*sqrt(2) - 2
## @knitr WF32
sqrt(2)*sqrt(2) - sqrt(2)*sqrt(2)
## @knitr end WF32

#So be careful with '==' for floating point comparisons. 


## Exercise: Often we are required to center amnd standardize data before we run analyses
## centerring means subtracting values from the mean
##standardizing is subrtacting values from the standard deviation
##we are going to define a function that standardizes data 
##and applies it to Height and Weight columns

#solution
## @knitr WF33
scaleMyData<-function(x){
  (x - mean(x)) / sd(x)
  }
## @knitr WF34
data.std<-sapply(data[c("Weight","Height")], scaleMyData)
## @knitr end WF34

#Compare this with the base function scale

