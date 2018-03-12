#set working directory
setwd("C:/Users/Maina/Dropbox/WIO R Workshop/Workshop Material/Github_WIO_R_WORKSHOP_2017/WIO-R-WORKSHOP-2017/data/")

## 1. Using R as a calculator
### 1.1. Doing arithmetic with R
#The simplest thing you could do with R is to arithmetic

## @knitr Arit1
1+100
## @knitr end Arit1 

##Here, we've added 1 and and 100 together to make 101. The [1] preceeding this we will explain in a minute. 
##For now, think of it as something that indicates output.
##of operations is same as in maths class (from highest to lowest precedence)

##+ Brackets
##+ Exponents
##+ Divide
##+ Multiply
##+ Add
##+ Subtract

##What will this evaluate to?

## @knitr Arit2
3+5*2
## @knitr end Arit2

##The "caret" symbol (or "hat") is the exponent (to-the-power-of) operator (read `x ^ y` as "x to the power of y"). What will this evaluate to?
## @knitr Arit3
3+5*2^2
## @knitr end Arit3 


##Use brackets (actually parentheses) to group to force the order of evaluation if it differs from the default, or to set your own order.
## @knitr Arit4
(3+5)*2
## @knitr end Arit4


##But this can get unweidly when not needed:
## @knitr Arit5
(3+(5*(2^2))) # hard to read

## @knitr Arit6
3+5*2^2 #easier to read, once you know some rules

## @knitr Arit7
3+5*(2^2) # if you forget some rules, this might help
## @knitr end Arit7

##See ?Arithmetic for more information, and two more operators (you can also get there by `?"+"` (note the quotes)
##?Arithmetic
##If R thinks that the statement is incomplete, it will change the prompt from `>` to `+` indicating that it is expecting more input. This is not an addition sign! 
##Try:

## @knitr Arit8
3+5*(2^2
## @knitr end Arit8
     
#Press `"Esc"` if you want to cancel this statement and return to the prompt.
     
### 1.2. Comparing objects with R
#The usual sort of comparison operators are available:

## @knitr Arit9
1 == 1 #equality (note two equals signs, read as "is equal to")

## @knitr Arit10
1 == 2

## @knitr Arit11
1 != 2 #inequality (read as "is not equal to")

## @knitr Arit12
1<2 # less than

## @knitr Arit13
1<=1 # less than or equal to"

## @knitr Arit14
1>0 # greater than

## @knitr Arit15
1>= -9 # greater than or equal to
## @knitr Arit15

##See `?Comparison` for more information (you can also get there by `help("==")`.

### 1.3. Scientific notation with R

##Really small numbers get a scientific notation:

## @knitr Arit16
2/10000
## @knitr end Arit16

##which you can write in too:

## @knitr Arit17
2e-04
## @knitr end Arit17

##Read `e-XX` as "multiplied by `10^XX"`, so `2e-4` is `2 * 10^(-4)`.

### 1.4. Mathematical functions with R

##R has many built in mathematical functions that will work as you would expect:

## @knitr Arit18
sin(1) # trigonometric functions

## @knitr Arit19
asin(1) # inverse sin (also for cos and tan)"

## @knitr Arit20
log(1) #natural logarithm

## @knitr Arit21
log10(100) # base-10 logarithm 

## @knitr Arit22
log2(100) # base-2 logarithm 

## @knitr Arit23
exp(0.5) #e^(1/2)
## @knitr end Arit23

##Plus things like probability density functions for many common distributions, and other mathematical functions (e.g., Gamma, Beta, Bessel). If you need it, it's probably there

##2. Data objects in R

### 2.1. Variables and assignment
##You can assign values to variables using the assignment operator `<-`, like this:

## @knitr Arit24
x <-1/40
## @knitr end Arit24

##and now the variable `x` contains the **value** `0.025`

## @knitr Arit25
x
## @knitr end Arit25

##(note that it does not contain the fraction 1/40, it contains a decimal approximation of this fraction. This appears exact in this case, but it is not. These decimal approximations are called "floating point numbers" and at some point you will probably end up having to learn more about them than you'd like).
##Look up at the top right pane of RStudio, and you'll see that this has appeared in the "Workspace" pane.

##Our variable `x` can be used in place of a number in any calculation that expects a number.

## @knitr Arit26
log(x)

## @knitr Arit27
sin(x)
## @knitr end Arit27

##The right hand side of the assignment can be any valid R expression.

##It is also possible to use the `=` operator for assignment:

## @knitr Arit28
x=1/40
## @knitr end Arit28

#but this is much less common among R users. The most important thing is to be **consistent** with the operator you use. There are occasionally places where it is less confusing to use `<-` than `=`, and it is the most common symbol used in the community. So I'd recommend `<-`.

#Notice that assignment does not print a value.

## @knitr Arit29
x<-100
## @knitr end Arit29

#Notice also that variables can be reassigned.
##`x`used to contain the value 0.025 and and now it has the value 100).

## @knitr Arit30
x
## @knitr end Arit30

##Assignment values can contain the variable being assigned to: What will `x` contain after running this?

## @knitr Arit31
x<-x+1
x
## @knitr end Arit31

## Clean up

## @knitr Arit32
rm(x)  # Remove an object from workspace
## @knitr end Arit32

## Remove more than one
## @knitr Arit33
a<-5
b<-10
rm(a, b)  
## @knitr end Arit33

## Clear entire workspace

## @knitr Arit34
rm(list = ls()) 
## @knitr end Arit34

###2.2. Vectors

##R was designed for people who do data analysis. There is a reason why "data" is a more common term than "datum" - generally you have more than one piece of data (although the Guardian argues that this distinction is old fashioned). As a result in R all data types are actually vectors. 
##So the number '1' is actually a vector of numbers that happens to be of length 1.

## @knitr Arit35
x=1

## @knitr Arit36
length(x) # length(): get the length of a vector
## @knitr end Arit36

### Build a specific vector
##To build a vector, use the c(). function (`c` stands for "concatenate")

## @knitr Arit37
x<- c(1,2,40,1234)
x
## @knitr end Arit37

## @knitr Arit38
length(x)
## @knitr end Arit38

##(notice how RStudio has updated its description of x. If you click it, you'll get an option to alter it, which is rarely what you want to do).
##This is a deep piece of engineering in the design; most of R thinks quite happily in terms of vectors. If you wanted to double all the values in the vector, just multiply it by 2:

## @knitr Arit39
2*x
## @knitr end Arit39

#You can get the maximum value:
## @knitr Arit40
max(x)
## @knitr end Arit40

##... the minimum value 
## @knitr Arit41
min(x)
## @knitr end Arit41

## @knitr Arit42
sum(x) ## the sum

## @knitr Arit43
mean(x) ## the mean
## @knitr end Arit43

##and so on. There are huge numbers of functions that operate on vectors. It is more common that functions will than that they won't.


## @knitr Arit44
y<- c(0.1,0.2,0.3,0.4) 

## @knitr Arit45
x+y  #Vectors can be summed together:

## @knitr Arit46
c(x,y) #and they can be concatenate together

## @knitr Arit47
x+0.1 #... and scalars can be added to them

## @knitr Arit48
x
## @knitr end Arit48

##**Be careful** though: if you add/multiply together vectors that are of different lengths, but the lengths factor, R will silently "recycle" the length of the shorter one:
## @knitr Arit49
x*c(-2,2)
## @knitr end Arit49

##The **first** and **third** element have been multiplied by **-2** while the **second** and **fourth** element are multiplied by *2*.

##If the length of the shorter vector is not a factor of the length of the longer vector, you will get a warning, but **the calculation will happen anyway**:

## @knitr Arit50
x*c(-2,0,2)
## @knitr end Arit50

##This is almost never what you want. Pay attention to warnings. Note that Warnings are different to Errors. We just saw a warning, where what happened is (probably) undesirable but not fatal. You'll get Errors where what happened has been deemed unrecoverable. For example:

## @knitr Arit51
x+z
## @knitr end Arit51

##Just as with the scalars, we can do comparisons. This returns a new vector of TRUE and FALSE indicating which elements are less than 10:

## @knitr Arit52
x<10 

## @knitr Arit53
x<y #You can do a vector-vector comparison too:
## @knitr end Arit53

#And combined arithmetic operations with comparison operations. Both sides of the expression are fully evaluated before the comparison takes place:
## @knitr Arit54
x>1/Y
## @knitr end Arit54
##Be careful with comparisons: This compares the first element with -20, the second with 20, the third with -20 and the fourth with 20.

## @knitr Arit55
x>=c(-20,20)

## @knitr Arit56
x == c(-2,0,2) #This does nothing sensible, really, and warns you again:
## @knitr end Arit56

##All the comparison operators work in fairly predictible ways:

## @knitr Arit57
x == 40

## @knitr Arit58
x != 2
## @knitr end Arit58

#### Define a vector with a sequence

##Sequences are easy to make, and often useful. Integer sequences can be made with the colon operator:

## @knitr Arit59
3:10 # sequence 3,4,5,...,10
## @knitr end Arit59

#Which also works backwards:

## @knitr Arit60
10:3
## @knitr end Arit60

##Step in different sizes with `seq()`
## @knitr Arit61
seq(3,10,by=2)

## @knitr Arit62
seq(3,10,length=10)
## @knitr end Arit62

#Now we will see the meaning of the [1] term - this indicates that you're looking at the first element of a vector. If you make a really long vector, you'll see new numbers:

## @knitr Arit63
seq(3,by=2,length=100)
## @knitr end Arit63

#### Finding specific elements in a vector

##First, assign an element to x

## @knitr Arit64
x=seq(3,by=2,length=100) # x is assigned a vector of length 100, starting from 3, with an increment of 2
x
## @knitr end Arit64

##Find the 1st element of x using `[]`
## @knitr Arit65
x[1] # 1st element

## @knitr Arit66
x[2] # 2nd element

## @knitr Arit67
x[100] # 100th element
## @knitr end Arit67

###2.3. Matrix

##Define a matrix (assign to y) with 9 rows and 3 columns using the data in x
##**Note**: x has been used several time previously. If you wish to assign a new value to x, clean x first by removing it from the workspace.

## @knitr Arit68
x  

## @knitr Arit69
rm(x)

## @knitr Arit70
x # if an error meesage "object x not found", x has been removed succesfully

## @knitr Arit71
x=1:27

## @knitr Arit72
y <- matrix(data=x,nrow=9,ncol=3)
y
## @knitr end Arit72

##Dimension of y with `dim()`
## @knitr Arit73
dim(y)
## @knitr end Arit73

##Result provides a vector of 2. The first element is the number of lines (here 9) and the second element is the number of columns (here 3 columns).

##Extract a value from y with []

## @knitr Arit74
y[1,2] # The element at the crossroad between the line 1 and column 2
## @knitr end Arit74

##Extract a line from y with []
## @knitr Arit75
y[1,] # line 1
## @knitr end Arit75

##Extract a column from y with []
## @knitr Arit76
y[,1] # column 1
## @knitr end Arit76

#### Extract a vector from y using the numerical indices in x
## @knitr Arit77
y[x]  # referencing an object with another object

#### Define a 3-dimensional array (assign to z) with 3 rows, 3 columns and 3 layers, using the data in x
## @knitr Arit78
z <- array(data=x,dim=c(3,3,3))
z

## @knitr Arit79
z[x]

## @knitr Arit80
z[rev(x)] # What does the function rev() do? How can you find out?
## @knitr end Arit80

#### Browse the datasets available in R, find Edgar Anderson's Iris data and load it as a dataframe 

## @knitr Arit81
data(iris)

## @knitr Arit82
head(iris)

## @knitr Arit83
dim(iris)

## @knitr Arit84
view(iris)
## @knitr end Arit84

#### Convert the iris dataset to a matrix and check the data types
## @knitr Arit85
iris2 <- as.matrix(iris)

## @knitr Arit86
head(iris2)

## @knitr Arit87
mode(iris2)

## @knitr Arit88
iris3 <- as.matrix(iris[,1:4])

## @knitr Arit89
head(iris3)

## @knitr Arit90
mode(iris3)
## @knitr end Arit90

#### Using matrices instead of data frames 

#When data is all numbers (except for row and column names), I normally use matrices rather than dataframes
##If you have row names in your data file, and you want to convert to a matrix, you will need to specify which column has the row names (see the row.names argument in the read.table function)

