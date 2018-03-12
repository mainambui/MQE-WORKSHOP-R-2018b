#title: 2.2. Understanding factors
#author: Modified from Software Capentry:Maina and Stephanie
#date: "27 October 2017"

## understanding factors

** Questions** 
 # + How is categorical data represented in R?
 # + How do I work with factors?
  
#**Objectives**

  #+ Understand how to represent categorical data in R.
  #+ Know the difference between ordered and unordered factors.
  #+ Be aware of some of the problems encountered when using factors.
  
  
#Factors are used to represent categorical data. 
#Factors can be ordered or unordered and are an important class for statistical analysis and for plotting.

#Factors are stored as integers, and have labels associated with these unique integers. 
#While factors look (and often behave) like character vectors, they are actually integers under the hood, 
#and you need to be careful when treating them like strings.

#Once created, factors can only contain a pre-defined set values, known as levels. 
#By default, R always sorts levels in alphabetical order. For instance, if you have a factor with 2 levels:

## The factor() Command

#The 'factor()' command is used to create and modify factors in R:

## @knitr UF1
gender <- factor(c("male", "female", "female", "male"))
## @knitr end UF1

#R will assign '1' to the level '"female"' and '2' to the level '"male"' (because 'f' comes before 'm', even though the first element in this vector is '"male"'). You can check this by using the function 'levels()', and check the number of levels using 'nlevels()':
## @knitr UF2
levels(gender)
## @knitr UF3
nlevels(gender)
## @knitr end UF3

#Sometimes, the order of the factors does not matter, 
#other times you might want to specify the order because it is meaningful (e.g., "low", "medium", "high") or it is required by particular type of analysis.
#Additionally, specifying the order of the levels allows us to compare levels:
## @knitr UF4
food <- factor(c("low", "high", "medium", "high", "low", "medium", "high"))
## @knitr UF5
levels(food)
## @knitr UF6
food <- factor(food, levels = c("low", "medium", "high"))
## @knitr UF7
levels(food)
## @knitr UF8
min(food) ## doesn't work
## @knitr UF9
food <- factor(food, levels = c("low", "medium", "high"), ordered=TRUE)
## @knitr UF10
levels(food)
## @knitr UF11
min(food) ## works!
## @knitr end UF11

#In R's memory, these factors are represented by numbers (1, 2, 3). 
#They are better than using simple integer labels because factors are self describing:
#"low", "medium", and "high" is more descriptive than '1', '2', '3'. 
#Which is low? You wouldn't be able to tell with just integer data. 
#Factors have this information built in. It is particularly helpful when there are many levels (like the subjects in our example data set).

## Representing Data in R
#You have a vector representing levels of exercise undertaken by 5 subjects

#**"l","n","n","i","l"** ; n=none, l=light, i=intense

#What is the best way to represent this in R?

    #+ a) exercise <- c("l", "n", "n", "i", "l")

    #+ b) exercise <- factor(c("l", "n", "n", "i", "l"), ordered = TRUE)

    #+ c) exercise < -factor(c("l", "n", "n", "i", "l"), levels = c("n", "l", "i"), ordered = FALSE)

    #+ d) exercise <- factor(c("l", "n", "n", "i", "l"), levels = c("n", "l", "i"), ordered = TRUE)

## Converting Factors

#Converting from a factor to a number can cause problems:
## @knitr UF12
f <- factor(c(3.4, 1.2, 5))
## @knitr UF13
as.numeric(f)
## @knitr end UF13

#This does not behave as expected (and there is no warning).

#The recommended way is to use the integer vector to index the factor levels:
## @knitr UF14
levels(f)[f]
## @knitr end UF14

#This returns a character vector, the 'as.numeric()' function is still required to convert the values to the proper type (numeric).
## @knitr UF15
f <- levels(f)[f]
## @knitr UF16
f <- as.numeric(f)
## @knitr end UF16




