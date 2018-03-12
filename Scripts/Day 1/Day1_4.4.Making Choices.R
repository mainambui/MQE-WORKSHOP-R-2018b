#---
#  title: "4.4. Making Choices"
#author: Adapted from Software Carpentry; modified by Maina,Stephanie
#date: "13th of March 2018"
#output: html_document
---
  
#**Questions**

 # + How do I make choices using 'if' and 'else' statements?
 # + How do I compare values?
  
#**Objectives**
 # + Write conditional statements with 'if' and 'else'.
 # + Correctly evaluate expressions containing '&' ('and') and '|' ('or').

#Our previous lessons have shown us how to manipulate data, define our own functions, and repeat things. However, the programs we have written so far always do the same things, regardless of what data they're given. We want programs to make choices based on the values they are manipulating.

## Conditionals

## @knitr MC1
num <- 37
if (num > 100) {
  print("greater")
} else {
  print("not greater")
}
## @knitr end MC1

#The second line of this code uses an 'if' statement to
#tell R that we want to make a choice. 
#If the following test is true, the body of the 'if'
#(i.e., the lines in the curly braces underneath it) are executed. 
#If the test is false, the body of the 'else' is executed instead. 
#Only one or the other is ever executed:

## @knitr MC2
num > 100
## @knitr end MC2

#And as you likely guessed, the opposite of 'FALSE' is 'TRUE'.
## @knitr MC3
num < 100
## @knitr end MC3

#Conditional statements don't have to include an 'else. 
#If there isn't one, R simply does nothing if the test is false:

## @knitr MC4
num <- 53
if (num > 100) {
  print("num is greater than 100")
}
## @knitr end MC4

#We can also chain several tests together when there are more than two options.
#This makes it simple to write a function that returns the sign of a number:

## @knitr MC5
sign <- function(num) {
  if (num > 0) {
    return(1)
  } else if (num == 0) {
    return(0)
  } else {
    return(-1)
  }
}
## @knitr MC6
sign(-3)
## @knitr MC7
sign(0)
## @knitr MC8
sign(2/3)
## @knitr end MC8

#Note that when combining 'else and 'if'' in an else if statement, 
#the 'if' portion still requires a direct input condition. 
#This is never the case for the else statement alone, 
#which is only executed if all other conditions go unsatisfied. 
#Note that the test for equality uses two equal signs, '=='.

### Other Comparisons

#Other tests include greater than or equal to ('>='), 
#less than or equal to ('<='), 
#and not equal to ('!=').

#We can also combine tests. 
#An ampersand, '&', symbolizes "and".
#A vertical bar, '|', symbolizes "or". '&' is only true if both parts are true:

## @knitr MC9
if (1 > 0 & -1 > 0) {
    print("both parts are true")
} else {
  print("at least one part is not true")
}
## @knitr end MC9
#while '|' is true if either part is true:

## @knitr MC10
if (1 > 0 | -1 > 0) {
    print("at least one part is true")
} else {
  print("neither part is true")
}
## @knitr end MC10

#In this case, "either" means "either or both", 
#not "either one or the other but not both".

#Write a function `plot_dist` that plots a boxplot if the length of the vector is greater than a specified threshold and a stripchart otherwise. To do this you'll use the R functions `boxplot` and `stripchart`.

## @knitr MC11
plot_dist <- function(x, threshold) {
if (length(x) > threshold) {
boxplot(x)
} else {
stripchart(x)
}
}
## @knitr MC11a
setwd("/Users/stephdagata/Documents/GitHub/WIO-R-WORKSHOP-2017")
dat <- read.csv("data/inflammation-01.csv", header = FALSE)
plot_dist(dat[, 10], threshold = 10)     # day (column) 10

## @knitr MC12
plot_dist(dat[1:5, 10], threshold = 10)  # samples (rows) 1-5 on day (column) 10
## @knitr end MC12

### Solution:
## @knitr MC13
plot_dist <- function(x, threshold) {
if (length(x) > threshold) {
boxplot(x)
} else {
stripchart(x)
}
}
## @knitr end MC13

### Histograms Instead
#One of your collaborators prefers to see the distributions of the larger vectors as a histogram instead of as a boxplot. In order to choose between a histogram and a boxplot we will edit the function `plot_dist` and add an additional argument `use_boxplot`. By default we will set `use_boxplot` to `TRUE` which will create a boxplot when the vector is longer than `threshold`. When `use_boxplot` is set to `FALSE`, `plot_dist` will instead plot a histogram for the larger vectors. As before, if the length of the vector is shorter than `threshold`, `plot_dist` will create a stripchart. A histogram is made with the `hist` command in R.

## @knitr MC14
plot_dist <- function(x, threshold, use_boxplot = TRUE) {
if (length(x) > threshold & use_boxplot) {
boxplot(x)
} else if (length(x) > threshold & !use_boxplot) {
hist(x)
} else {
stripchart(x)
}
}
## @knitr MC16
setwd("/Users/stephdagata/Documents/GitHub/WIO-R-WORKSHOP-2017")
dat <- read.csv("data/inflammation-01.csv", header = FALSE)
plot_dist(dat[, 10], threshold = 10, use_boxplot = TRUE)   # day (column) 10 - create boxplot
## @knitr MC17
plot_dist(dat[, 10], threshold = 10, use_boxplot = FALSE)  # day (column) 10 - create histogram
## @knitr MC18
plot_dist(dat[1:5, 10], threshold = 10)                    # samples (rows) 1-5 on day (column) 10
## @knitr MC19
plot_dist <- function(x, threshold, use_boxplot = TRUE) {
if (length(x) > threshold & use_boxplot) {
boxplot(x)
} else if (length(x) > threshold & !use_boxplot) {
hist(x)
} else {
stripchart(x)
}
}
## @knitr end MC19

### Find the Maximum Inflammation Score
#Find the file containing the patient with the highest average inflammation score. Print the file name, the patient number (row number) and the value of the maximum average inflammation score.
#Tips:
#+ 1. Use variables to store the maximum average and update it as you go through files and patients.
#+ 2.You can use nested loops (one loop is inside the other) to go through the files as well as through the patients in each file (every row).
#Complete the code below:

## @knitr MC19a
filenames <- list.files(path = "data", pattern = "inflammation.*csv", full.names = TRUE)
filename_max <- "" # filename where the maximum average inflammation patient is found
patient_max <- 0 # index (row number) for this patient in this file
average_inf_max <- 0 # value of the average inflammation score for this patient
for (f in filenames) {
dat <- read.csv(file = f, header = FALSE)
dat.means = apply(dat, 1, mean)
for (patient_index in length(dat.means)){
patient_average_inf = dat.means[patient_index]
# Add your code here ...
}
}
## @knitr MC20
print(filename_max)
## @knitr MC21
print(patient_max)
## @knitr MC22
print(average_inf_max)
## @knitr end MC22


### Solution

# Add your code here ...
## @knitr MC23
if (patient_average_inf > average_inf_max) {
average_inf_max = patient_average_inf
filename_max <- f
patient_max <- patient_index
}
## @knitr end MC23

## Saving Automatically Generated Figures
#Now that we know how to have R make decisions based on input values, let's update `analyze`:
  
## @knitr MC24
analyze <- function(filename, output = NULL) {
  # Plots the average, min, and max inflammation over time.
  # Input:
  #    filename: character string of a csv file
  #    output: character string of pdf file for saving
  if (!is.null(output)) {
    pdf(output)
  }
  dat <- read.csv(file = filename, header = FALSE)
  avg_day_inflammation <- apply(dat, 2, mean)
  plot(avg_day_inflammation)
  max_day_inflammation <- apply(dat, 2, max)
  plot(max_day_inflammation)
  min_day_inflammation <- apply(dat, 2, min)
  plot(min_day_inflammation)
  if (!is.null(output)) {
    dev.off()
  }
}
## @knitr end MC24
#We added an argument, `output`, that by default is set to `NULL`. An `if` statement at the beginning checks the argument `output` to decide whether or not to save the plots to a pdf. Let's break it down. The function `is.null` returns `TRUE` if a variable is `NULL` and `FALSE` otherwise. The exclamation mark, `!`, stands for "not". Therefore the line in the `if` block is only executed if `output` is "not null".

## @knitr MC25
output <- NULL
## @knitr MC26
is.null(output)
## @knitr MC27
!is.null(output)

#Now we can use `analye` interactively, as before,
## @knitr MC28
analyze("data/inflammation-01.csv")
## @knitr end MC28

#but also use it to save plots,

## @knitr MC29
analyze("data/inflammation-01.csv", output = "inflammation-01.pdf")
## @knitr end MC29

#Before going further, we will create a directory `results` for saving our plots. It is good practice in data analysis projects to save all output to a directory separate from the data and analysis code. You can create this directory using the shell command mkdir, or the R function `dir.create()`
## @knitr MC30
dir.create("results")
## @knitr end MC30

#Now run `analyze` and save the plot in the `results` directory,
## @knitr MC31
analyze("data/inflammation-01.csv", output = "results/inflammation-01.pdf")
## @knitr end MC31

#This now works well when we want to process one data file at a time, but how can we specify the output file in `analyze_all`? We need to do two things:

#+ Substitute the filename ending "csv" with "pdf".
#+ Save the plot to the `results` directory.

#To change the extension to "pdf", we will use the function `sub`,

## @knitr MC32
f <- "inflammation-01.csv"
sub("csv", "pdf", f)
## @knitr end MC32

#To add the "data" directory to the filename use the function `file.path`,

## @knitr MC33
file.path("results", sub("csv", "pdf", f))
## @knitr end MC33

#Now let's update `analyze_all`:
## @knitr MC34
analyze_all <- function(pattern) {
  # Directory name containing the data
  data_dir <- "data"
  # Directory name for results
  results_dir <- "results"
  # Runs the function analyze for each file in the current working directory
  # that contains the given pattern.
  filenames <- list.files(path = data_dir, pattern = pattern)
  for (f in filenames) {
    pdf_name <- file.path(results_dir, sub("csv", "pdf", f))
    analyze(file.path(data_dir, f), output = pdf_name)
  }
}
## @knitr end MC34

#Now we can save all of the results with just one line of code:
## @knitr MC35
analyze_all("inflammation.*csv")
## @knitr end MC35

#Now if we need to make any changes to our analysis, we can edit the analyze function and quickly regenerate all the figures with `analyze_all`.
### Changing the Behavior of the Plot Command
#One of your collaborators asks if you can recreate the figures with lines instead of points. Find the relevant argument to `plot` by reading the documentation (`?plot`), update `analyze`, and then recreate all the figures with `analyze_all`.

## @knitr MC36
analyze <- function(filename, output = NULL) {
  # Plots the average, min, and max inflammation over time.
  # Input:
  #    filename: character string of a csv file
  #    output: character string of pdf file for saving
  if (!is.null(output)) {
    pdf(output)
  }
  dat <- read.csv(file = filename, header = FALSE)
  avg_day_inflammation <- apply(dat, 2, mean)
  plot(avg_day_inflammation, type = "l")
  max_day_inflammation <- apply(dat, 2, max)
  plot(max_day_inflammation, type = "l")
  min_day_inflammation <- apply(dat, 2, min)
  plot(min_day_inflammation, type = "l")
  if (!is.null(output)) {
    dev.off()
  }
}
## @knitr end MC36

## Key Points

#+ Save a plot in a pdf file using `pdf("name.pdf")` and stop writing to the pdf file with `dev.off()`
#+ Use `if (condition)` to start a conditional statement, `else if (condition)` to provide additional tests, and `else` to provide a default.
#+ The bodies of conditional statements must be surrounded by curly braces `{ }`.
#+ Use `==` to test for equality.
#+ `X & Y` is only true if both X and Y are true.
#+ `X | Y` is true if either X or Y, or both, are true.

