#title: "3.1. Data Types and Structures"
#author:Adapted from Software Carpentry; modified by Maina,Stephanie
#date: 13th of October 2018

#**Questions**

  #+ What are the different data types in R?
  #+ What are the different data structures in R?
  #+ How do I access data within the various data structures?
  
#**Objectives**

  #+ Expose learners to the different data types in R.
  #+ Learn how to create vectors of different types.
  #+ Be able to check the type of vector.
  #+ Learn about missing data and other special values.
  #+ Getting familiar with the different data structures(lists, matrices, data frames).
  
## Understanding Basic Data Types in R
#To make the best of the R language, 
#you'll need a strong understanding of the basic data types and data structures and how to operate on those.

#Very important to understand because these are the objects you will manipulate on a day-to-day basis in R. 
#Dealing with object conversions is one of the most common sources of frustration for beginners.

#**Everything** in R is an object.

#R has 6 (although we will not discuss the raw class for this workshop) atomic vector types.

  #+ character
  #+ numeric (real or decimal)
  #+ integer
  #+ logical
  #+ complex

#By *atomic*, we mean the vector only holds data of a single type.

  #+ **character**: '"a"', '"swc"'
  #+ **numeric**: '2', '15.5'
  #+ **integer**: '2L' (the L tells R to store this as an integer)
  #+ **logical**: 'TRUE', 'FALSE'
  #+ **complex**: '1+4i' (complex numbers with real and imaginary parts)
  
#R provides many functions to examine features of vectors and other objects, for example

  #+ 'class()' - what kind of object is it (high-level)?
  #+ 'typeof()' - what is the object's data type (low-level)?
  #+ 'length()' - how long is it? What about two dimensional objects?
  #+ 'attributes()' - does it have any metadata?

## Example
## @knitr DT1
x <- "dataset"
typeof(x)

## @knitr DT2
attributes(x)

## @knitr DT3
y <- 1:10
y

## @knitr DT4
typeof(y)

## @knitr DT5
length(y)

## @knitr DT6
z <- as.numeric(y)
z

## @knitr DT7
typeof(z)
## @knitr end DT7

#R has many **data structures**. These include

  #+ atomic vector
  #+ list
  #+ matrix
  #+ data frame
  #+ factors
  
## Atomic Vectors
#A vector is the most common and basic data structure in R and is pretty much the workhorse of R. 
#Technically, vectors can be one of two types:

  #+ atomic vectors
  #+ lists
  
#although the term "vector" most commonly refers to the atomic types not to lists.

## The Different Vector Modes

#A vector is a collection of elements that are most commonly of mode 'character', 'logical', 'integer' or 'numeric'.

#You can create an empty vector with 'vector()'. 
#(By default the mode is 'logical'. You can be more explicit as shown in the examples below.) 
#It is more common to use direct constructors such as 'character()', 'numeric()', etc.

## @knitr DT8
vector() # an empty 'logical' (the default) vector

## @knitr DT9
vector("character", length = 5) #a vector of mode 'character' with 5 elements

## @knitr DT10
character(5) #the same thing, but using the constructor directly

## @knitr DT11
numeric(5) #a numeric vector with 5 elements

## @knitr DT12
logical(5) #a logical vector with 5 elements
## @knitr end DT12

##You can also create vectors by directly specifying their content. R will then guess the appropriate mode of storage for the vector. For instance:

## @knitr DT13
x <- c(1, 2, 3)
## @knitr end DT13

#will create a vector 'x' of mode 'numeric'. 
#These are the most common kind, and are treated as double precision real numbers. 
#If you wanted to explicitly create integers, 
#you need to add an 'L' to each element (or coerce to the integer type using 'as.integer()').

## @knitr DT14
x1 <- c(1L, 2L, 3L)
## @knitr end DT14

#Using 'TRUE' and 'FALSE' will create a vector of mode 'logical':

## @knitr DT15
y <- c(TRUE, TRUE, FALSE, FALSE)
## @knitr end DT15

#While using quoted text will create a vector of mode '| character':

## @knitr DT16
z <- c("Sarah", "Tracy", "Jon")
## @knitr end DT16

##Examining Vectors

#The functions 'typeof()', 'length()', 'class()' and 'str()'..
#provide useful information about your vectors and R objects in general.

## @knitr DT17
typeof(z)

## @knitr DT18
length(z)

## @knitr DT19
class(z)

## @knitr DT20
str(z)
## @knitr end DT20

#**Question : Finding commonalities**
#Do you see a property that's common to all these vectors above?

## Adding Elements
#The function 'c()' (for combine) can also be used to add elements to a vector.

## @knitr DT21
z <- c(z, "Annette")
z

## @knitr DT22
z <- c("Greg", z)
z

## Vectors from a Sequence of Numbers
#You can create vectors as a sequence of numbers.

## @knitr DT23
series <- 1:10
## @knitr DT24
seq(10)
## @knitr DT25
seq(from = 1, to = 10, by = 0.1)
## @knitr end DT25

## Missing Data
##R supports missing data in vectors. 
##They are represented as 'NA' (Not Available) and can be used for all the vector types covered in this lesson:

## @knitr DT26
x <- c(0.5, NA, 0.7)
## @knitr DT27
x <- c(TRUE, FALSE, NA)
## @knitr DT28
x <- c("a", NA, "c", "d", "e")
## @knitr DT29
x <- c(1+5i, 2-3i, NA)
## @knitr end DT29

#The function 'is.na()' indicates the elements of the vectors that represent missing data, 
#and the function 'anyNA()' returns 'TRUE' if the vector contains any missing values:

## @knitr DT30
x <- c("a", NA, "c", "d", NA)
## @knitr DT31
y <- c("a", "b", "c", "d", "e")
## @knitr DT32
is.na(x)
## @knitr DT33
is.na(y)
## @knitr DT34
anyNA(x)
## @knitr DT35
anyNA(y)

## Other Special Values
#'Inf' is infinity. You can have either positive or negative infinity.
## @knitr DT36
1/0
## @knitr end DT36

#'NaN' means Not a Number. It's an undefined value.
## @knitr DT37
0/0
## @knitr end DT37

## What Happens When You Mix Types Inside a Vector?

#R will create a resulting vector with a mode that can most easily accommodate all the elements it contains. 
#This conversion between modes of storage is called "coercion". 
#When R converts the mode of storage based on its content, it is referred to as "implicit coercion". 
#For instance, can you guess what the following do (without running them first)?

## @knitr DT38
xx <- c(1.7, "a")
## @knitr DT39
xx <- c(TRUE, 2)
## @knitr DT40
xx <- c("a", TRUE)
## @knitr end DT40

#You can also control how vectors are coerced explicitly using the 'as.<class_name>()' functions:
## @knitr DT41
as.numeric("1")
## @knitr DT42
as.character(1:2)
## @knitr end DT42

## Objects Attributes
##Objects can have **attributes**. Attributes are part of the object. These include:

  ##+ names
  ##+ dimnames
  ##+ dim
  ##+ class
  ##+ attributes (contain metadata)
  
##You can also glean other attribute-like information such as length (works on vectors and lists) or number of characters (for character strings).

## @knitr DT43
length(1:10)
## @knitr DT44
nchar("Software Carpentry")
## @knitr end DT44

## Matrix
##In R matrices are an extension of the numeric or character vectors. 
##They are not a separate type of object but simply an atomic vector with dimensions; the number of rows and columns.

## @knitr DT45
m <- matrix(nrow = 2, ncol = 2)
m
## @knitr DT46
dim(m)
## @knitr end DT46

#Matrices in R are filled column-wise.

## @knitr DT47
m <- matrix(1:6, nrow = 2, ncol = 3)
## @knitr end DT47

#Other ways to construct a matrix
## @knitr DT48
m      <- 1:10
## @knitr DT49
dim(m) <- c(2, 5)
## @knitr end DT49

#This takes a vector and transforms it into a matrix with 2 rows and 5 columns.

#Another way is to bind columns or rows using 'cbind()' and 'rbind()'.
## @knitr DT50
x <- 1:3
## @knitr DT51
y <- 10:12
## @knitr DT52
cbind(x, y)
## @knitr DT53
rbind(x, y)
## @knitr end DT53

##You can also use the 'byrow' argument to specify how the matrix is filled. From R's own documentation:
## @knitr DT54
mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE)
mdat
## @knitr end DT54

##Elements of a matrix can be referenced by specifying the index along each dimension (e.g. "row" and "column") in single square brackets.
## @knitr DT55
mdat[2,3]
## @knitr end DT55

## List
#In R lists act as containers. Unlike atomic vectors, the contents of a list are not restricted to a single mode and can encompass any mixture of data types. 
#Lists are sometimes called generic vectors, because the elements of a list can by of any type of R object, even lists containing further lists. This property makes them fundamentally different from atomic vectors.

#A list is a special type of vector. Each element can be a different type.

#Create lists using 'list()' or coerce other objects using 'as.list()'. 
#An empty list of the required length can be created using 'vector()'
## @knitr DT56
x <- list(1, "a", TRUE, 1+4i)
x
## @knitr DT57
x <- vector("list", length = 5) ## empty list
length(x)
## @knitr end DT57

##The content of elements of a list can be retrieved by using double square brackets.
## @knitr DT58
x[[1]]
## @knitr end DT58

#Vectors can be coerced to lists as follows:

## @knitr DT59
x <- 1:10
## @knitr DT60
x <- as.list(x)
## @knitr DT61
length(x)
## @knitr end DT61

  ##+ 1. What is the class of x[1]?
  ##+ 2.What about x[[1]]?
  
#Elements of a list can be named (i.e. lists can have the names atttibute)

## @knitr DT62
xlist <- list(a = "Karthik Ram", b = 1:10, data = head(iris))
xlist

## @knitr DT63
names(xlist)
## @knitr end DT63

  #+ 1. What is the length of this object? What about its structure?

#Lists can be extremely useful inside functions. Because the functions in R are able to return only a single object,
#you can "staple" together lots of different kinds of results into a single object that a function can return.

#A list does not print to the console like a vector. Instead, each element of the list starts on a new line.

#Elements are indexed by double brackets. Single brackets will still return a(nother) list. 
#If the elements of a list are named, they can be referenced by the $ notation (i.e. xlist$data).

## Data Frame

#A data frame is a very important data type in R. It's pretty much the de facto data structure for most tabular data and what we use for statistics.

#A data frame is a special type of list where every element of the list has same length (i.e. data frame is a "rectangular" list).

#Data frames can have additional attributes such as 'rownames()', 
#which can be useful for annotating data, like 'subject_id' or 'sample_id'. But most of the time they are not used.

#Some additional information on data frames:

  #+ Usually created by 'read.csv()' and 'read.table()', i.e. when importing the data into R.
  #+ Assuming all columns in a data frame are of same type, data frame can be converted to a matrix with data.matrix() (preferred) or as.matrix(). Otherwise type coercion will be enforced and the results may not always be what you expect.
  #+ Can also create a new data frame with data.frame() function.
  #+ Find the number of rows and columns with nrow(dat) and ncol(dat), respectively.
  #+ Rownames are often automatically generated and look like 1, 2, ., n. Consistency in numbering of rownames may not be honored when rows are reshuffled or subset.

#### Creating Data Frames by Hand

#To create data frames by hand:

## @knitr DT64
dat <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
dat
## @knitr end DT64


####  Useful Data Frame Functions

  #+ 'head()' - shows first 6 rows
  #+ 'tail()' - shows last 6 rows
  #+ 'dim()' - returns the dimensions of data frame (i.e. number of rows and number of columns)
  #+ 'nrow()' - number of rows
  #+ 'ncol()' - number of columns
  #+ 'str()' - structure of data frame - name, type and preview of data in each column
  #+ 'names()' - shows the 'names' attribute for a data frame, which gives the column names.
  #+ 'sapply(dataframe, class)' - shows the class of each column in the data frame

#See that it is actually a special list:

## @knitr DT65
is.list(dat)
## @knitr DT66
class(dat)
## @knitr end DT67
#Because data frames are rectangular, elements of data frame can be referenced by 
#specifying the row and the column index in single square brackets (similar to matrix).

## @knitr DT67
dat[1,3]
## @knitr end DT67

#As data frames are also lists, it is possible to refer to columns 
#(which are elements of such list) using the list notation, i.e. either double square brackets or a '$'.

## @knitr DT68
dat[["y"]]

## @knitr DT69
dat$y
## @knitr end DT69

#The following table summarizes the one-dimensional and two-dimensional data 
#structures in R in relation to diversity of data types they can contain.


##**Dimensions**    | **Homogenous**  | **Homogenous**
------------------|-----------------|---------------
##1-D               | atomic vector   | list
##2-D               | matrix          | data frame


#Lists can contain elements that are themselves muti-dimensional 
#(e.g. a lists can contain data frames or another type of objects). Lists can also contain elements of any length, therefore list do not necessarily have to be "rectangular". However in order for the list to qualify as a data frame, the lenghth of each element has to be the same


####  Column Types in Data Frames

#Knowing that data frames are lists, can columns be of different type?

#What type of structure do you expect to see when you explore 
#the structure of the 'iris' data frame? Hint: Use 'str()'.

# The Sepal.Length, Sepal.Width, Petal.Length and Petal.Width columns are all
# numeric types, while Species is a Factor.
# Lists can have elements of different types.
# Since a Data Frame is just a special type of list, it can have columns of
# differing type (although, remember that type must be consistent within each column!).

## @knitr DT70
str(iris)
## @knitr end DT70

# Key Points

  #+ R's basic data types are character, numeric, integer, complex, and logical.
  #+ R's basic data structures include the vector, list, matrix, data frame, and factors.
  #+ Objects may have attributes, such as name, dimension, and class.



















