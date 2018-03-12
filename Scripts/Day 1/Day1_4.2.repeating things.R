#title: "4.1. Repeating things"
#author: "Modified from nice R code"
#date: "13th of March 2018"

## Repeating things

#If there is one piece of advice I would recommend keeping in 
#your head when working with R, it is this:

#***Don't Repeat Yourself***

## Applying a function over and over and over and over

#We'll be using the 'seed_root_herbivores.csv', with factors sorted alphabetically as discussed in the last section.

## @knitr RT1
setwd("/Users/stephdagata/Documents/GitHub/WIO-R-WORKSHOP-2017")
data <- read.csv("data/seed_root_herbivores.csv", stringsAsFactors = FALSE)
## @knitr RT2
data$Plot <- factor(data$Plot, levels = unique(data$Plot))
## @knitr end RT2

#There are a few data columns in the data set that we've been using.
## @knitr RT3
head(data)
## @knitr end RT3

#'No.stems', 'Height', 'Weight', 'Seed.heads', 'Seeds.in.25.heads'.

#What if we wanted to get the mean of each column?

## @knitr RT4
mean.no.stems <- mean(data$No.stems)
## @knitr RT5
mean.Height <- mean(data$Height)
## @knitr RT6
mean.Weight <- mean(data$Weight)
## @knitr RT7
mean.Seed.heads <- mean(data$Seed.heads)
## @knitr RT8
mean.Seeds.in.25.heads <- mean(data$Seeds.in.25.heads)
## @knitr end RT8

#What if we wanted to get the variance of all these? 
#Copy and paste and change the function name? 
#Very repetitive, hard to see intent, easy to make mistakes, and boring.

#Notice the pattern though - we are taking each column in turn and applying the same function to it.
#Somebody else noticed this pattern too.

#The function that we will use is 'sapply'. 
#It takes as its first argument a list, and applies a function to each element in turn.

#As a simple example, here is a little list with toy data:

## @knitr RT9
obj <- list(a = 1:5, b = c(1, 5, 6), c = c(pi, exp(1)))
obj
## @knitr end RT9

#This computes the length of each element in 'obj'

## @knitr RT10
sapply(obj, length)
## @knitr end RT10

#This computes their sum
## @knitr RT11
sapply(obj, sum)
## @knitr end RT11

#This computes the variance
## @knitr RT12
sapply(obj, var)
## @knitr end RT12

#This works with any function you want to use as the second argument.

#Here are our variables:
## @knitr RT13
response.variables <- c("No.stems", "Height", "Weight", "Seed.heads", "Seeds.in.25.heads")
## @knitr end RT13 

#Remember when I said that a 'data.frame' is like a list; this is one case where we take advantage of that.
## @knitr RT14
sapply(data[response.variables], mean)
## @knitr end RT14

#This does all of the repetitive hard work that we did before, 
#but in one line. Read it as:

#"Apply to each element in 'data' (subset by my response variables) the function 'mean'"

## Exercise

#The coefficient of variation is defined as the standard deviation (square root of the variance) divided by the mean
#Compute the coefficient of variation of these variables, and tell me which variable has the largest CV.

#Hint:
## @knitr RT15
coef.variation <- function(x) {
    sqrt(var(x))/mean(x)
}
## @knitr end RT15

#Did you just do
## @knitr RT16
sapply(data[response.variables], coef.variation)
## @knitr end RT16
#and look for the largest variable?

#did you do:
## @knitr RT17
cvs <- sapply(data[response.variables], coef.variation)
## @knitr RT18
which(cvs == max(cvs))
## @knitr end RT18

#you can also do:
## @knitr RT19
which.max(cvs)
## @knitr end RT19
#Similarly, for minimum
## @knitr RT20
which.min(cvs)
## @knitr end RT20

## Note

#There is a function 'lapply' works well when you are not expecting the same length output for the result of applying your function to each element in the list. 
#It gives you the result back in a list, for example

## @knitr RT21
lapply(obj, sum)
## @knitr end RT21

#compared with:
## @knitr RT22
sapply(obj, sum)
## @knitr end RT22
#lapply has its uses. For example, suppose we wanted to double all the elements in obj.
#We can't just multiply this list by 2:
## @knitr RT23
obj * 2  # causes error
## @knitr end RT23
#However, we can do this with lapply, as long as we have a function that will double things:

## @knitr RT24
double <- function(x) {
    2 * x
}
## @knitr end RT24
#Apply the 'double' function to each element in our list:
## @knitr RT26
lapply(obj, double)
## @knitr end RT26
#OR
## @knitr RT27
lapply(obj, function(x) double(x))
## @knitr end RT27
#We have to use 'lapply' rather than 'sapply' because the result of the function on different elements is different lengths.

#Note also that 'sapply' actually does the same thing here. But if the elements of 'obj' happened to have the same length they would give different answers.
#i.e. diffent data types
## @knitr RT28
sapply(obj, double)
## @knitr RT29
obj2 <- list(a = 1:3, b = c(1, 5, 6), c = c(pi, exp(1), log(10)))
## @knitr end RT29

#Returns a list:
## @knitr RT31
lapply(obj2, double)
## @knitr end RT31
#Returns a matrix:
## @knitr RT32
sapply(obj2, double)
## @knitr end RT32

#This is probably more than you need to know right now, but it may stick around in your head until needed.



## The split-apply-combine pattern

#Fairly often, you'll want to do something like compute means for each level of a treatment. 
#To compute the mean height given the root herbivore treatment (i.e. present/absent)
#here we could do:

## @knitr RT33
height.with <- mean(data$Height[data$Root.herbivore])
## @knitr RT34
height.without <- mean(data$Height[!data$Root.herbivore])
## @knitr end RT34

#Remember read '!' as "not".
#(notice that plant height is taller when herbivores are absent).

#However, suppose that we want to get mean height by *plot*:

## @knitr RT35
height.2 <- mean(data$Height[data$Plot == "plot-2"])
## @knitr RT36
height.4 <- mean(data$Height[data$Plot == "plot-4"])
## @knitr RT37
height.6 <- mean(data$Height[data$Plot == "plot-6"])
## @knitr end RT37

#and so on until we go out of our minds.

#There is a function 'tapply' that automates this.

#It's arguments are
## @knitr RT38
args(tapply)
## @knitr end RT38

#The first argument, X is our data variable; the thing that we want the means of.

#The second argument, INDEX is the grouping variable; the thing that we want means at each distinct value/level of.

#The third argument, FUN is the function that you want to apply; in our case mean.

#So we have:

## @knitr RT39
tapply(data$Height, data$Plot, mean)
## @knitr end RT39
#For the first example (present/absent) we have:
## @knitr RT40
tapply(data$Height, data$Root.herbivore, mean)
## @knitr end RT40
#Notice that there was no more work going from 2 levels to 30 levels!

#Also notice that it's really easy to change variables (as above) or change functions:
## @knitr RT41
tapply(data$Height, data$Root.herbivore, var)
## @knitr end RT41

#This approach has been called the "split-apply-combine" pattern. 
#There is a package plyr that a lot of people like that can make this easier.

## Two factors at once
#The experiment here is a 2x2 factorial design (though imbalanced as all ecological data end up being after they've been left in the field for a while).
#You can do that with tapply above, but it gets quite hard. The aggregate function can do this nicely though.

#There are two interfaces to this (see the help page ?aggregate).
#In the first, you supply the response variable as the first argument,
#the grouping variables as the second, and the function as the third (just like tapply).

## @knitr RT42
aggregate(data$Height, data[c("Root.herbivore", "Seed.herbivore")], mean)
## @knitr end RT42
#or similarly, take a 1 column data frame:
## @knitr RT43
aggregate(data["Height"], data[c("Root.herbivore", "Seed.herbivore")], mean)
## @knitr end RT43

#The other interface uses R's formula interface, which can be a lot shorter and easier to read.
## @knitr RT44
aggregate(Height ~ Root.herbivore + Seed.herbivore, data = data, mean)
## @knitr end RT44

#This is why I think it is important to get used to writing functions:
#Because your own functions work just as well with these tools:
## @knitr RT45
standard.error <- function(x) {
    sqrt(var(x)/length(x))
}
## @knitr RT46
aggregate(Height ~ Root.herbivore + Seed.herbivore, data = data, standard.error)
## @knitr end RT46

#(now you have everything for an interaction plot to start seeing how the different herbivores interact to effect plant growth).

##Explicit loops

#In contrast with most programming languages, we have not covered a basic loop yet. You may be familiar with these if you've written basic, python, perl, etc.
#The idea is the same as the first section in this page. You want to apply a function (or do some calculation) over a series of elements in a list.
#For example, the 'print' function prints a representation of an object to the screen. Suppose we wanted to print all the elements of our list 'obj'.

#This is confusing!
## @knitr RT47
sapply(obj, print)
## @knitr end RT47

#This is because we want to just print the result to the screen and we don't 
#actually want to do anything with the result (it turns out that 'print' silently returns what is passed into it.

## @knitr RT48
for (i in obj) {
    print(i)
}
## @knitr end RT48

#The element 'i' is created at the beginning of the loop, and set to the first element in obj. 
#Each time "around" the loop it is set to the next element (so on the second iteration it will be the second element, and so on).
#Note that in contrast with functions, the variables created by loops do actually replace things in the global environment:
## @knitr RT49
i
## @knitr end RT49
#We need to create the *enclosing environment*, so that a loop within a function leaves the global environment unaffected.

#If you want to do something with the results of the loop, you need more scaffolding. 
#Let's do the mean example again and get the mean of each element in the list.

#First, we need somewhere to put the output. The function 'numeric' creates a numeric vector of the requested length.
## @knitr RT50
n <- length(obj)
## @knitr RT51
out <- numeric(n)
## @knitr end RT41

#Then, rather than loop over the elements directly as above, we loop over their *indices*:

## @knitr RT52
for (i in 1:n) {
    out[i] <- mean(obj[[i]])
}
## @knitr end RT42
#Read the line within the loop as 
#"into the i'th element of output ('out') save the result of running the function on the i'th element if the input ('obj')". 
#The double square brackets are needed (Why? Because 'out[i]' would be a list with one element while 'out[[i]]' is the 'i'th element itself.).
## @knitr RT53
out
## @knitr end RT43
#This does not have names like the 'sapply' version did. If we want names, add them back with 'names'.
## @knitr RT54
names(out) <- names(obj)
## @knitr end RT54

#There are times where loops are absolutely the best (or the only way) of doing something.
#For example, 
#if you want a cumulative sum over list elements (so that out[[i]] contains the sum of 'obj[[1]]', 'obj[[2]]', ., 'obj[[i]]'), you might do that with a loop:

## @knitr RT55
n <- length(obj)
out <- numeric(n)
total <- 0  # running total
## @knitr RT56
for (i in 1:n) {
    total <- total + sum(obj[[i]])
    out[[i]] <- total
}
## @knitr RT57
names(out) <- names(obj)
## @knitr end RT57

#Although we can actually do that with the built-in function 'cumsum' and 'sapply'ing over the list to get the sums.
## @knitr RT58
cumsum(lapply(obj, sum))
## @knitr end RT58



