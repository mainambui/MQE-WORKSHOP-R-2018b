###############################################
##### Script for "Data manipulation in R" #####
###############################################

# originally prepared by David Nipperess
# modified by Matthew Kosnik

##### Preliminary 1: Set up workspace ###########
#################################################

# Set up a new project in R Studio
# Where is your working directory?
# Are the files you need in your working directory?

##### Preliminary 2: Data objects in R ##########
#################################################

# this should all be review from yesterday, but it is a good review as. it is important.

# define a vector of the numerical values 1 to 27 and assign to an object called x
x <- 1:27

# define a matrix (assign to y) with 9 rows and 3 columns using the data in x
y <- matrix()

# extract a vector from y using the numerical indices in x



# define a 3-dimensional array (assign to z) with 3 rows, 3 columns and 3 layers, using the data in x
z <- array(,dim=c())

# extract a reversed vector from z using x
 
# QUESTION: What does the function rev() do? 
# QUESTION: How can you find out?

# browse the datasets available in R, find Edgar Anderson's Iris data and load it as a dataframe 
# 50 replicate measurements for each of 3 species of Iris
data()
data(iris)

# QUESTION: what does head() do?
head(iris)

# QUESTION: what does dim() do?
dim(iris)

# QUESTION: what does mode() do?
mode(iris)

# use as.matrix() to convert the iris dataset to a matrix and use head() & mode() to check the data
iris2 <- as.matrix()
		# Question: why quotes?
		# Question: character?
		
# QUESTION: what happens when you try to take the mean of iris2[,'Sepal.Length']


# use as.matrix() to convert only the numeric columns of iris dataset. Check the data.
iris3 <-

# QUESTION: what is the mean sepal length?

# QUESTION: how might we work around this issue, hint: as.numeric()?


## using matrices instead of data frames 

# when data is all numbers (except for row and column names), I normally use matrices rather than dataframes
# if you have row names in your data file, and you want to convert to a matrix, you will need to specify which column has the row names (see the row.names argument in the read.table function)

##### Exercise 1: Reading data ##################
#################################################

##	 Use the read.table (and related functions) to read in datafiles: "carbonateMetaData.txt", "carbonateMassData.csv", "carbonateSynonomy.csv"

## ABOUT THESE DATA: These are sediment samples from Heron Reef. Students were instructed to sort the sediment into the organisms that created it, and to report the weight of each taxonomic group in grams. "carbonateMassData.csv" contains the mass by taxonomic group data. "carbonateMetaData.txt" contains metadata - information aboit the sample provided to the students. "carbonateSynonomy.csv" is a list of spelling corrections and synonomies that I use to harmonise the data without changing the original data.

##	TIP: always inspect your data BEFORE attempting to import into R 

# use read.table() to read carbonateMetaData.txt. read.table() is the generic function
cMeta <- read.table("./data/carbonateMetaData.txt", header=TRUE, sep="\t", as.is=TRUE)

# read.delim() is read.table(), but will default values set for tab-delimited files
# use it to read ./data/carbonateMetaData.txt
cMeta <- read.delim()

# read.table() is the generic function and can read csv files...
cMass <- read.table('./data/carbonateMassData.csv', header = TRUE, sep = ",", quote = "\"", fill = TRUE, comment.char = "", as.is=TRUE)

# OR: read.csv() is read.table(), but will default values set for csv files
# use it to read: ./data/carbonateSynonomy.csv
cSyn <-read.csv()

#	QUESTION: What does 'as.is' do, and why might we want to use it?
#	QUESTION: What does 'skip' do, and why might we want to use it?

##	TIP: always inspect your data AFTER importing to make sure you have imported it correctly...
#	QUESTION: What do each of these functions: head(), tail(), nrow(), dims(), summary() do?






## DIFFERENT WAYS REFERENCE COLUMNS, SHOULD ALL WORK
cMass[,"mass"] 
cMass[["mass"]] 
cMass$mass

##### Exercise 2: Subsetting data ###############
#################################################

## 	QUESTION: How many taxon occurences have a mass > 25 (in data frame cMass)?

cMass[(cMass$mass>25),]			# this lists, but does not count, the taxon occurences
# QUESTION: What does (cMass$mass>25) return?

length(cMass$mass>25) 			
# QUESTION: Why is this not the answer we want?
.
length(which(cMass$mass>25))	
# QUESTION: Why is this the answer we want?
# QUESTION: What does which() return?
which(cMass$mass>25)

## 	QUESTION: How much carbonate is from taxon occurences having a mass > 25 (in data frame cMass)?
sum(which(cMass$mass>25)) 					# does not work as intended... what does which return?
sum(cMass[which(cMass$mass>25),'mass'])		# this is the answer we want.

##	QUESTION: What is the average mass of Gastropoda in these samples?
mean(cMass$mass[(cMass$taxon == 'Gastropoda')])		# is this what we want?

#	LET'S DOUBLE CHECK THAT ALL THE "Gastropoda" will match "Gastropoda
unique(cMass$taxon)
unique(sort(cMass$taxon))		# what do each of these functions do?

# A strict match is not what we want... We could manually list all the row numbers...
cMass[c(9,21,32),] 					# but we would need to list all the rows with gastropod data
mean(cMass[c(9,21,32),'mass'])		# will work but painfully and inflexible.

# A more robust solution (we will get to an even better solution later)
?grep
grep("Gastropod", cMass$taxon, ignore.case=TRUE)
cMass[grep("Gastropod", cMass$taxon, ignore.case=TRUE),]

# Since we know taxon names are case insentitive...
cMass$taxon <- tolower(cMass$taxon)

mean(cMass$mass[grep("gastropod", cMass$taxon)])

# EXERCISE: what is the biggest bivalve mass?
# Hint: max(),grep()


##### Exercise 3: Aggregating data ##############
#################################################

# use aggregate() produce a table of the total idenfied mass from each sample

?aggregate

( sampleMass <- aggregate(cMass$mass,by=list(cMass$sample),FUN=sum) )
colnames(sampleMass) <- c('ID','massIdentified')
head(sampleMass)

# Now we have a summary table tellling us how much sample they were able to identify
# You can aggregate multiple data columns at one time (using the same function).


##### Exercise 4: Matching data #################
#################################################

# Since I know how much sample they had to start with - how much of sample did they identify?

?merge

( mergedSamples <- merge(cMeta,sampleMass) )		# What does the extra set of () do?
# now we have the original sample mass and the identified sample mass in the same dataframe.

mergedSamples$proID <- mergedSamples$massIdentified / mergedSamples$mass
# now we have the proportion of each sample identified, did big samples have less identified?
plot(mergedSamples$proID ~ mergedSamples$mass)	#no, but we have found a couple of lazy students!

# We can also use merge to clean up our names
# Let's clean up our names - are we missing any names from our synonomy list?
cMass[!(cMass$taxon%in%cSyn$badName),]
cMass[!((cMass$taxon%in%cSyn$badName)|(cMass$taxon%in%cSyn$taxonName)),]

cMass2 <- merge(cMass,cSyn, by.x='taxon',by.y='badName')
head(cMass2)

cMass2[(cMass2$taxon=='cirripedia'),]					# here lies the biggest danger of merge
nrow(cMass)
nrow(cMass2)											# we lost data

cMass[cMass$sample =='E01',]							# compare sample 1 in the oringal data
cMass2[cMass2$sample =='E01',]							# compare sample 1 in the merged data

cMass2 <- merge(cMass,cSyn, by.x='taxon',by.y='badName', all.x=TRUE) 	# the fix
nrow(cMass) == nrow(cMass2)

cMass[cMass$sample =='E01',]							# compare sample 1 in the oringal data
cMass2[cMass2$sample =='E01',]							# compare sample 1 in the merged data

cMass2[is.na(cMass2$taxonName),]
cMass2[is.na(cMass2$taxonName),'taxonName'] <- cMass2[is.na(cMass2$taxonName),'taxon']

cMass2[cMass2$sample =='E01',]							# see sample 1 in the merged data

# now we have nice dataset that we can use, but we have a strict record of the changes we made to the orignal data.
# we could download the data again and be able to quickly repeat our analyses without a lot of painfil edits.

##### Exercise 5: Tabulating data ###############
#################################################

##	NEW DATA!
##	sames of larger benthic forams from Heron Island, Great Barrier Reef.
forams <- read.csv('./data/2017foramAnon.csv')
foramNames <- read.csv('./data/codesForams.csv')

# produce an incidence (presence/absence) matrix of species for all samples

?table
incidence_table <- 
incidence_table		# give us the number of rows for each foram at each site... (abundance)

# make it a presence/absence matrix 
incidence_table <- 
incidence_table

## imagine the data in a slightly different format.... ((review of aggregate))
##	use aggregate() to determine the abundance of foram taxa by sample and taxonCode. hint: length()
foramAbundance <- aggregate()
colnames(foramAbundance) <- c('sample','taxonCode','abundance')

## use merge() to add the taxon names to the file
foramAbundance <- merge(foramAbundance,)
## check the merged file to make sure it is what we want it to be

# produce an abundance matrix of all foram species for all sites using foramAbundance
# hint: use tapply() & sum()
?tapply
abundance_table <- tapply()

# check to make sure that it looks like it should...

# how do we change the NA to 0? NA can be a pain!

# check to make sure that it looks like it should...


##### Exercise 6: Custom tabulation #############
#################################################

# using an apply function on the abundance table

# first let's define an inverse simpson function
# sum of the proportional abundances squared
# https://en.wikipedia.org/wiki/Diversity_index#Inverse_Simpson_index

# convert the matrix to proportional abundances
p <- abundance_table/sum(abundance_table) # this doesn't work
sum(p) # this is why it doesn't work
p <- abundance_table[1,]/sum(abundance_table[1,])
p
sum(p)
simp <- sum(p^2)
simp
isimp <- 1/sum(p^2)
isimp

# lets wrap that as a function
# needs: x a list of abundances
# returns: inverse simpson index
invsimp <- function(x) {
	p <- x/sum(x)
	invsimp <- 1/sum(p^2)
}

# double check that this works
isimp2 <- invsimp(abundance_table[1,])
isimp2

# get site diversity for every site with just one line of code!
# use: apply() and invsimp()
site_diversity <- apply(abundance_table,)
site_diversity


##### Exercise 6: Sorting data ##################
#################################################

# use sort() to sort the foramAbundance data by decreasing abundance

?sort
sort() # simple option for vectors

# QUESTION: how is order() different than sort()
# order() is useful if you need to sort a dataframe or matrix by the values in one column.

# EXERCISE: use order() to sort foramAbundance by decreasing abundance 



##### Exercise 7: Random sampling of data #######
#################################################

?sample
sample(1:100,size=5,replace=FALSE)

# EXERCISE: produce a 5x5 submatrix from the abundance table using random sampling
# hint: nrow() & ncol() can help

submat <-
submat # NOTE: that everyone will get a different matrix!
