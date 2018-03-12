
##title: 2.4.Reading and writing CSV files
#author: Modified by Maina, Stephanie
#date: "13th May 2018"

# 1. Reading in data
#As empirical biologists, you'll generally have data to read in. 
#You probably have your data in an Excel spreadsheet. The simplest way to load these into R is to save a copy of the data as a comma separated values file (.csv) and work with that.
#It is actually possible to read directly from Excel (but see the gdata package that has a read.xls function, and see this page for other alternatives. 
#This is usually more hassle than it's worth, and going through a comma separated file is easy enough.
#To load the data into R, use **seed_root_herbivores.csv**

#Get the files names

#You can check first if the data are in the directory:
## @knitr LM1
setwd("/Users/stephdagata/Documents/GitHub/WIO-R-WORKSHOP-2017")
file.exists("data/seed_root_herbivores.csv")
## @knitr end LM1

#if 'TRUE', load the data in the object 'data':

## @knitr LM2
setwd("/Users/stephdagata/Documents/GitHub/WIO-R-WORKSHOP-2017")
data<-read.csv("data/seed_root_herbivores.csv")
## @knitr end LM2

#This doesn't usually produce any output - the data is "just there" now.

#Clicking the little table icon next to the data in the Workspace browser will view the data. Running 'View(data)' will do the same thing.

#The 'data' variable contains 'data.frame' object. 
#It is a number of columns of the same length, arranged like a matrix. That sentence is tricky, for reasons that will become apparent.
#Often, looking at the first few rows is all you need to remind yourself about what is in a data set.

## @knitr LM3
head(data) # looking at the first 6 lines of the data
## @knitr end LM3

#You can also look at the class of the object 'data':

## @knitr LM4
class(data)
## @knitr end LM4

#You can get a vector of names of columns:

## @knitr LM5
names(data)
## @knitr end LM5

#You can get the number of rows:
## @knitr LM5a
nrow(data)
## @knitr end LM5a

#and the number of columns
## @knitr LM6
ncol(data)
## @knitr LM7
length(data)
## @knitr end LM7

#The last one is surprising to most people. 
#There is a logical (if not good) reason for this, which we will get to later.
#Aside from issues around factors and character vectors (that we'll cover shortly), 
#this is most of what you need to know about loading data.

#However, it's useful to know things about saving it.

  #+ Column names should be consistent, of the right length, and **contain no special characters**.
  #+ **For missing values, either leave them blank or use NA**. But be consistent and don't use -999 or ? or your cat's name.
  #+ Be careful with whitespace "x" will be treated differently to "x ", and Excel makes it easy to accidently do the latter. Consider the strip.white=TRUE argument to read.csv.
  #+ Think about the type of the data. We'll cover this more, but are you dealing with a TRUE/FALSE or a category or a count or measurements.
  #+ Watch out for dashes between numbers. Excel will convert these into dates. So if you have "Site-Plant" style numbers 5-20 will get converted into the 20th of May 1904 or something equally useless. Similar problems happen to gene names in bioinformatics!
  #+ Merged rows and columns will not work (or at least not in an easily predictible way.
  #+ Spare rows at the top, or double header rows will not work without jumping through hoops.
  #+ Equations will (should) convert to the value displayed in Excel on export.
  
### Exercise

#The file 'data/seed_root_herbivores.txt' has almost the same data, 
#but in tab separated format (it does have the same number of rows and columns). Look at the ?read.table help page and work out how to load this file in.

#Remember: '==' tests for equality, '!=' tests for inequality
## @knitr LM8
setwd("/Users/stephdagata/Documents/GitHub/WIO-R-WORKSHOP-2017")
data2=read.table("data/seed_root_herbivores.txt",header=T,sep=";")

## @knitr LM9
data2==data
## @knitr end LM9

#or 
## @knitr LM10
data2 != data
## @knitr end LM10

#The point here is that many of the functions and operators in R will try to do the right thing, 
#depending on what you give them.

#This won't work, because the default arguments of 
#'read.table' and 'read.csv' are different for the header.

## @knitr LM10a
setwd("/Users/stephdagata/Documents/GitHub/WIO-R-WORKSHOP-2017")
tmp<-read.table("data/seed_root_herbivores.txt",sep=";")
## @knitr LM11
head(tmp)
## @knitr end LM11

#Notice that a fake header (V1, V2, etc) has been created and the actual header is now the first row of data.
#2.Looking at your data

#There are other ways of looking at your data. The summary function works with most types, and gives a by-column summary of the data set.
## @knitr LM12
summary(data)
## @knitr end LM12

### Subsetting
#So, we see there is an issue in the file - how to we get to it?
#There a bunch of different ways of extracting bits of your data.

### Columns of data.frames

#Get the column 'Plot'

## @knitr LM13
data$Plot
## @knitr end LM13
#This does *almost* the same thing:

## @knitr LM14
data[["Plot"]]
## @knitr end LM14

#This is the main difference: if the column name is in a variable, then '$' won't work, while '[[' will. Let's define a variable 'v' that has the name if the first column as its value:
## @knitr LM15
v<-"Plot"
## @knitr end LM15

#We can extract this column of the data set using the '[[' notation:
## @knitr LM16
data[[v]]
## @knitr end LM16

#but using the '$' notation won't work as it will look for the column called 'v':

#It returns 'NULL' to indicate that the column does not exist (confusingly, this value can be difficult to work with and give cryptic error messages. More confusingly, getting a nonexistant column with '[[' generates an error instead).

#Also, 'data$P' will "expand" to make 'data$Plot', but 'data$S' will return 'NULL' because that is ambiguous. Always use the full name!

#Single square brackets also index the data, but do so differently. This returns a 'data.frame' with one column:

## @knitr LM17
head(data["Plot"])
## @knitr end LM17

#This returns a 'data.frame' with two columns.
## @knitr LM18
head(data["Plot","Weight"])
## @knitr end LM18

#(I'm just using 'head' here to keep the output under control. If you actually wanted a 'data.frame' like this you might do:

## @knitr LM19
data.sub<-data[c("Plot","Weight")]
## @knitr end LM19

#and then continue to use the new data 'data.sub'object).

#The difference between '[' and '[[' can be confusing.

#The best explanation I have seen is that imagine that the thing you are subsetting is a train with a bunch of carriages. '[x]' returns a new train with carriages represented by the variable x. So train[c(1,2)] returns a train with just the first two carriages, and train[1] returns a train with just the first c~arriage. The '[[' operator gets the contents of a single carriage. So 'train[[1]]' gets the contents of the first carriage, and 'train[[c(1,2)]]' doesn't make any sense.

#Rows of data.frames

#Extracting a row always retruns a new 'data.frame'

## @knitr LM20
data[10,]
## @knitr LM21
data[10:20,]
## @knitr LM22
data[c(1,5,10),]
## @knitr end LM22

### Be careful with indexing by location
#The above all index by name or by location (index). 
#However, you generally want to avoid referencing by number in your saved code, e.g.:

## @knitr LM23
data.height<-data[[5]]
## @knitr end LM23

#This is because if you change the order of your spreadsheet (add or delete a column), 
#everything that depends on 'data.height' may change. You may also see people do this in their code.

## @knitr LM24
data.height<-data[,5]
## @knitr end LM24

#This should really be avoided. By name is much more robust and easy to read later on, 
#even if it is more typing at first.

## @knitr LM26
data.height<-data$Height
## @knitr LM27
data.height<-data[["height"]]
## @knitr end LM27

#When should you index by location?

#When you are computing the indices. As an example: 
#suppose that you wanted every other row (perhaps you're trying to generate a nonrandom some sample of data?)
#Remember 'seq' from above? We can generate a sequence of integers 1, 3, ., up to the last (or second to last) row in our data set like this:
## @knitr LM28
idx<-seq(1,nrow(data),by=2)
## @knitr end LM28

#Then subset like this:
## @knitr LM29
data.oddrows<-data[idx,]
## @knitr end LM29

#Our new data set has half the rows of the old data set:
## @knitr LM30
nrow(data.oddrows)
## @knitr LM31
nrow(data)
## @knitr end LM31
#Because row names are preserved, you can see the odd numbers in the row names.

## @knitr LM32
head(data.oddrows)
## @knitr end LM32
#Indexing by logical vector
#This is one of the most powerful ways of indexing.

#Remember our data mismatch:
## @knitr LM33
data != data2
## @knitr end LM33

#There is one entry in the 'Height' row that disagrees. 
#How can we extract the line that the mismatch is on?
#We could do it by index:
## @knitr LM34
data[20,]
## @knitr LM35
data2[20,]
## @knitr end LM35

#But that requires us to look for the error, 
#note the row, write it down, etc. Boring, and computers are less error prone than humans. 
#Plus, I just said that we should not do that.

#This is a logical vector that indicates where the entries in vector 1 disagree with vector 2:
## @knitr LM36
data.differ<-data$Height != data2$Height
## @knitr end LM36

#We can index by this - it will return rows for which there are true values:
## @knitr LM37
data[data.differ,]
## @knitr LM38
data2[data.differ,]
## @knitr end LM38

#You can convert from a logical '(TRUE/FALSE)' vector 
#to an integer vector with the 'which' function:
## @knitr LM39
which(data.differ)
## @knitr end LM39
#This can be really useful.

### Exercise:
#1. Return all the rows in data where both data sets have the same value for Height.
#2. Return all the rows in data from plot-8

#solution

## @knitr LM40
data.same<-data$Height == data2$Height
## @knitr LM41
data[data.same,]
## @knitr end LM41
#or:
## @knitr LM42
data[!data.differ,] #read '!x' as "not x"
## @knitr LM43
data[data$Plot == "plot-8",]
## @knitr end LM43

#Subsetting can be useful when you want to look at bits of your data. 
#For example, all the rows where the Height is at least 10 and there was no seed herbivore:

## @knitr LM44
data[data$Height > 10 & data$Seed.herbivore,]
## @knitr end LM44

#The '&' operator here is a logical "and" (read 'x & y' as "x and y"):

  #+ 'TRUE & TRUE is TRUE'
  #+ 'TRUE & FALSE is FALSE'
  #+'FALSE & TRUE is FALSE'
  #+'FALSE & FALSE is FALSE'
#In contrast, the '|' operator is a logical "or" (read as "or")
  #+ 'TRUE | TRUE is TRUE'
  #+ 'TRUE | FALSE is TRUE'
  #+ 'FALSE | TRUE is TRUE'
  #+ 'FALSE | FALSE is FALSE'
  
#The other, less common, operator is the exclusive or:
  #+ 'xor(TRUE, TRUE) is FALSE'
  #+ 'xor(TRUE, FALSE) is TRUE'
  #+ 'xor(FALSE, TRUE) is TRUE'
  #+ 'xor(FALSE, FALSE) is FALSE'
  
#So you can do all sorts of crazy things like:
## @knitr LM45
data[data$Plot == "plot-2" & data$Seed.herbivore & data$Root.herbivore,]
## @knitr end LM45

#and get all the cases in plot 2 where there were both seed herbivores and root herbivores. 
#Or,
## @knitr LM46
data[data$Height > 75 & (data$Seed.herbivore | data$Root.herbivore),]
## @knitr end LM46

#and get all the plants that are quite tall in treatments with either a seed herbivore or a root herbivore (or both).

#You can build these up if you want:
## @knitr LM47
idx.tall <- data$Height > 75
## @knitr LM48
idx.herbivore <- data$Seed.herbivore | data$Root.herbivore
## @knitr LM49
idx.select <- idx.tall & idx.herbivore
## @knitr LM50
data[idx.select,]
## @knitr end LM50

#whatever you find easiest to read and write.

#**Programs should be written for people to read, and only incidentally for machines to execute** 
#*(Structure and Interpretation of Computer Programs" by Abelson and Sussman)*

### The subset function to simplify writing complex subsets

#There is a function subset that may help you write complex subsets.
## @knitr LM51
subset(data,Height > 75 & (Seed.herbivore | Root.herbivore))
## @knitr end LM51

#This can help, especially interactively, but it can also bite you. 
#It is not always obvious where the "value" of the variables in the second argument are coming from. For example:
## @knitr LM52
subset(data,idx.tall & (Seed.herbivore | Root.herbivore))
## @knitr end LM52

#This works fine, because it found 'idx.tall'. 
#So when you read your code, you need to think carefully about which values are coming from the 'data.frame' and which are coming from elsewhere.
#This is an unfortunate example of a function designed to be used by beginners, 
#but it only really understandable once you understand more of what is going on. You'll see it used widely, and it can simplify things. But be careful.

### Adding new columns

#It is easy to add new columns, perhaps based on old ones:
## @knitr LM53
data$small.plant <- data$Height < 50
## @knitr LM54
head(data)
## @knitr end LM54
#You can delete a column by setting it to 'NULL':
## @knitr LM55
data$small.plant <- NULL
## @knitr LM56
head(data)
## @knitr end LM56
#In this data set, the last column contains the number of seeds in 25 seed heads. However, there weren't always 25 seed heads on a plant:

## @knitr LM58
data[data$Seed.heads < 25,]
## @knitr end LM58
#In these three cases, the column contains the number of seeds over all seed heads.

#**Question**: How do we compute the mean number of seeds per seed head?
## @knitr LM59
data$Seeds.per.head <- data$Seeds.in.25.heads /25
## @knitr LM60
idx.few.heads <- data$Seed.heads < 25
## @knitr LM61
data$Seeds.per.head[idx.few.heads] <- data$Seeds.in.25.heads[idx.few.heads]/data$Seed.heads[idx.few.heads]
## @knitr end LM61

#R generally offers several ways of doing things:
## @knitr LM61a
alternative <- data$Seeds.in.25.heads / pmin(data$Seed.heads,25)
## @knitr LM62
alternative == data$Seeds.per.head
## @knitr end LM62

#Use the 'all' function to determine if all values are TRUE:
## @knitr LM63
all(alternative == data$Seeds.per.head)
## @knitr end LM63
### (bonus topic) 
#Indexing need not make things smaller

#Given this vector with the first give letters of the alphabet:
## @knitr LM64
x <- c("a","b","c","d","e")
## @knitr end LM64
#Repeat the first letter once, the second letter twice, etc.
## @knitr LM65
x[c(1,2,2,3,3,3,4,4,4,4,5,5,5,5,5)]
## @knitr end LM65
#Much better!

## @knitr LM66
x[rep(1:5,1:5)]
## @knitr end LM66

#'rep' is incredibly useful, and can be used in many ways. See the help page ?rep
