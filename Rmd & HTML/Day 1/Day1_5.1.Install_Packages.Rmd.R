
#### 3. Installing and managing packages

## @knitr Part2
#**LISTS OF PACKAGES
browseURL("http://cran.r-project.org/web/views/")  # Opens CRAN Task Views in browser
# Opens "Available CRAN Packages By Name" (from UCLA mirror) in browser
browseURL("http://cran.stat.ucla.edu/web/packages/available_packages_by_name.html")
# See also CRANtastic
browseURL("http://crantastic.org/")
#+ **See current packages**

library()  # Brings up editor list of installed packages
search()   # Shows packages that are currently loaded

#**TO INSTALL AND USE PACKAGES**

# Can use menus: Tools > Install Packages... (or use Package window)
# Or can use scripts, which can be saved in incorporated in source

install.packages("ggplot2")  # Downloads package from CRAN and installs in R
?install.packages

library("ggplot2")  # Make package available; often used for loading in scripts
require("ggplot2")  # Preferred for loading in functions; maybe better?
library(help = "ggplot2")  # Brings up documentation in editor window

#+ **UPDATE PACKAGES**
# In RStudio, Tools > Check for Package Updates
update.packages()  # Checks for updates; do periodically
?update.packages


#+ **UNLOAD/REMOVE PACKAGES**

# By default, all loaded packages are unloaded when R quits
# Can also open Packages window and manually uncheck
# Or can use this code
# To unload packages
detach("package:ggplot2", unload = TRUE)
?detach

#+ **To permanently remove (delete) package**

install.packages("psytabs")  # Adds psytabs
remove.packages("psytabs")   # Deletes it
?remove.packages


# 4. Getting help with R
#This is a summary of the information you can 
#find here https://www.r-project.org/help.html

#### R Help: 'help()' and '?'
#The 'help()' function and '?' help operator in R provide access to the documentation pages for **R functions, data sets, 
#and other objects**, both for packages in the standard R distribution and for contributed packages. 
#For example, to access documentation for the standard mean function, 
#for example, enter the command:'help(mean)' or 'help("mean")', or '?mean' or '?"mean"' (the quotes are optional).

#You may also use the 'help()' function to access information about a **package** in your library - 
#for example

help(package="MASS")

#which displays an index of available help pages for the package along with some other information.

#Help pages for functions usually include a section with executable examples illustrating how the functions work. 
#You can execute these examples in the current R session via the 'example()' 

example(mean)

#### Searching for Help Within R
#The 'help()'  function and '?' operator are useful only if you already know the name of the function that you wish to use. 
#There are also facilities in the standard R distribution for discovering functions and other objects. 
#The following functions cast a progressively wider net. Use the help system to obtain complete documentation for these functions: for example, 'apropos()'or '?apropos'.

#The 'apropos()' function searches for objects, 
#including functions, directly accessible in the current R session that have names that include a specified character string. 
#This may be a literal string or a regular expression to be used for pattern-matching. 
#By default, string matching by 'apropos()' is case-insensitive. For example, 

apropos("^glm") 

#returns the names of all accessible objects that start with the (case-insensitive) characters "glm"

#### R Help on the internet
#There are internet search sites that are specialized for R searches
#including 'search.r-project.org' (which is the site used by RSiteSearch) and 'Rseek.org'.

#It is also possible to use a general search site like **Google**,
#by qualifying the search with "R" or the name of an R package (or both). 
#**It can be particularly helpful to paste an error message into a 
#search engine** to find out whether others have solved a problem that you encountered.

