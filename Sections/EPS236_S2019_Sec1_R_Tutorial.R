#===============================================================================
#
#         FILE: EPSCI236_S2019_Sec1_R_Tutorial.R
#
#       AUTHOR: Tianning Zhao
# ORGANIZATION: Harvard University
#
#         BUGS:
#        NOTES: Modified from Joshua Benmergui's tutorial for previous years
#  DESCRIPTION: E-PSCI 236 R Tutorial for Spring 2017.
#===============================================================================

# Clear workspace
rm(list = ls())

# Set working directory
setwd("~/Desktop/Section1/wd/")

##############
# Commenting #
##############

# As you can probably tell, the '#' character is a comment character. 
# Anything typed to the right of a '#' is not run by the R console. 
# All of the text above is 'commented out' and will have no effect when run.  
# Commenting your code makes it much easier to understand and debug! 

########################
# Ways to run a script #
########################

# 1: Interactively - open R and copy and paste the code.
# 2: Interactively source - open R and type 
#    source("../EPSCI236_S2017_Sec1_R_Tutorial.R") 
# 3: Run automatically with output printed to the terminal
#    Rscript EPSCI236_S2017_Sec1_R_Tutorial.R
#    or
#    R -f EPSCI236_S2017_Sec1_R_Tutorial.R
# 4: Run in the terminal with an output file created
#    R CMD BATCH EPSCI236_S2017_Sec1_R_Tutorial.R
#    produces the output file EPSCI236_S2017_Sec1_R_Tutorial.Rout 
#    This is most often used for job submission on cluster computers.

##################
# Object Classes #
##################

# There are many classes of objects in R, here are a few: 
# "numeric", "complex", "character", "logical", "factor", and "NULL"

# Here are examples defining objects of the different types

#---------#
# Numeric #
#---------#

kNumeric <- 1.432         # Note that '=' can also define a variable, 
                          # but '<-' is considered good form
print(kNumeric)           # Prints in console or when code is run from terminal
                          # This is a funciton! It has round brackets/parentheses. 
help(print)               # Get help with any function
kNumeric                  # Only prints in console

# Side note: save an R object
save(kNumeric, file = "kNumeric.rda")
objectName <- load("kNumeric.rda")  # objectName is just the name of 
                                              # the loaded object.

# Numerics can be manipulated with binary operators
4 + 6
3 - 2.4
7 / 2
19 * 5
# There is a special numeric "Inf"
1 / 0
-1 / 0

#---------#
# Complex #
#---------#

kComplex <- 1 + 1i
print(kComplex)
kComplex <- complex(real = 1, imaginary = 1)
# You can have an infinite real or complex part 
1 / 0 + 1i
Inf + 1i
complex(real = 1, imaginary = Inf)

#-----------#
# Character #
#-----------#

kCharacter1 <- "hello"   

nchar(kCharacter1)
# Substrings
kCharacter2 <- substr(kCharacter1, 1, 4) # extract a substring from the first character to the fourth one

#---------#
# Logical #
#---------#

kLogical <- FALSE         
kLogical2 <- TRUE
# Logicals can be manipulated with binary operators
TRUE & FALSE  # And
TRUE | FALSE  # Or (inclusive)
!TRUE         # Not
# Logicals can be the result of logical expressions on objects of other data classes
kNumeric < 1
kNumeric >= 0.4
kCharacter1 == kCharacter2
kCharacter1 != kCharacter2
# There is a special logical "NA" used for flagging not-applicable data. 
NA    # More on this later
NaN   # Acts just like NA, is rarely used 

#--------#
# Factor #
#--------#

kFactor <- as.factor(1)   # Factors are used for categorical statistics. 
print(kFactor)

kFactor2 <- as.factor(c("hippo", "girrafe", "rino", "rino", "rino", "girrafe",
  "girrafe", "hippo", "rino", "girrafe"))
# Factors are sometimes the result of loading data without specifying an option 
# "stringsAsFactors = FALSE". You can always convert back to numeric, etc.
as.numeric(kFactor)

#------#
# Null # - there is nothing there!
#------#

kNULL <- NULL
print(kNULL)
kNULL * 5
c(kNULL, 5)
# When would you use a NULL object?

#---------#
# General #
#---------#

# The "class" function will tell you what class of object you have
class(kNumeric)
class(kComplex)
class(kCharacter1)
class(kLogical)
class(kFactor)
class(kNULL)

# Quesiotn: What are the classes of NA and Inf?
# NA is a logical and Inf is a numeric

# R is incredibly flexible with classes, converting them in intuitive ways:
as.logical(1)
as.logical(0)
as.logical(4)
as.numeric(FALSE)
as.numeric(TRUE)
1 + TRUE
kComplex + TRUE
# Or getting angry at you, unless you explicitly do a conversion. 
kFactor + 1
as.numeric(kFactor) + 1
"1" + 1
as.numeric("1") + 1

# R also has capabilities to create compound objects, the 
# 'vector', 'matrix', 'array', 'list' and 'data.frame'

#--------#
# Vector #
#--------#

kVector1 <- c(1, 2, 3, 4)
# Vectors have length
length(kVector1)
# You can define vectors in a few ways. The following are all the same.
kVector1 <- 1:4
kVector1 <- seq(from = 1, to = 4, by = 1) # A function with several arguements!
kVector1 <- seq(from = 1, to = 4, length = 4) 
kVector11 <- c('spades' = 11, 'diamonds' = 12, 'hearts' = 13, 'clubs' = 12)
# The class follows that of the composite object
class(kVector1)
# Vectors can be other types too
kVector2 <- c("hello", "goodbye")
kVector3 <- c(TRUE, FALSE)
# Slicing is done with square brackets. Indicies start at 1 (unlike in Python).
kVector1[1]
kVector1[1:2]
kVector1[-2]  # All entries except for the second

# Question: How do you select the last entry in the following vector?
myVec <- rep(5, length = round(runif(n = 1, min = 7, max = 15)))
myVec[length(myVec)]

#--------#
# Matrix #
#--------#

kMatrix1 <- matrix(nrow =4, ncol = 3, data = 1:12) 
print(kMatrix1)
# Change the order of input
kMatrix1 <- matrix(nrow =4, ncol = 3, data = 1:12, byrow = TRUE)
print(kMatrix1)
# cbind and rbind will bind vectors together to make matrices
kMatrix2 <- cbind(c(1, 1, 1), c(2, 2, 2), c(3, 3, 3))
kMatrix2
kMatrix3 <- rbind(c(1, 1, 1), c(2, 2, 2), c(3, 3, 3))
kMatrix3
rbind(kMatrix3, c(4, 4, 4))
# Diagonal matrices with the "diag" command
diag(4)

# Slicing examples row by column
kMatrix1[1, 1]
kMatrix1[1:2, 1:2]
kMatrix1[cbind(c(1, 2), c(1, 2))]
kMatrix1[1, ]
kMatrix1[, 2]

# Matrices have length
length(kMatrix1)
# And dimension row by column
dim(kMatrix1)

# Matrix multiplication: %*% (* is the Hadamard product)
# Matrix transpose (also works for vectors!): t()
# Matrix inverse: solve() (or chol2inv(chol()) for Choleski decomposition)
kMatrix2 <- cbind(c(23, 1, 12), c(0, 1, 0), c(0, 45, 2))
kMatrix3 <- cbind(c(2,3,4), c(6, 0, 10), c(0 , 56, 23))
t(kMatrix2) %*% kMatrix3
t(kMatrix2) * kMatrix3
solve(t(kMatrix2) %*% kMatrix3)
chol2inv(chol(diag(3, 3)))
# you can take determinants
det(t(kMatrix2) %*% kMatrix3)
# As well as log-det, which is useful for large matrices
determinant(t(kMatrix2) %*% kMatrix3, logarithm = TRUE)

# Question: Can you make a matrix out of characters?
# What about a mixture of characters and numerics?
charMat <- matrix(nrow = 2, ncol = 2, data = c("a", "b", "c", "d"))
# charMat works
mixedMat <- matrix(nrow = 2, ncol = 2, data = c("a", 2, "c", 4))
# Everyhting gets coerced to character

#-------#
# Array #
#-------#

kArray <- array(dim = c(3,4,5), data = 1:60)
# Slicing is the same as in matrices

# Custom object types can be defined. This helps for standard input to functions. 
# Many packages have custom object types - keep an eye out for them! 

#------------#
# Data frame #
#------------#

# Data frames allow you to mix data types in a neat package
kDataFrame <- data.frame(
  nums = 1:100,
  chars = c(rep("hello", 50), rep("goodbye", 50)),
  logics = rnorm(n = 100, mean = 25, sd = 10) > 18,
  rands = rnorm(n = 100, mean = 23, sd = 10)
)

# Use "str" to view data frames
str(kDataFrame)   # Notice that our characters have become factors

kDataFrame2 <- data.frame(
  nums = 1:100,
  chars = c(rep("hello", 50), rep("goodbye", 50)),
  logics = rnorm(n = 100, mean = 25, sd = 10) > 18,
  rands = rnorm(n = 100, mean = 23, sd = 10),
  stringsAsFactors = FALSE
)
str(kDataFrame2)   # Now they are characters

# Slicing special character $
head(kDataFrame$rands, 5) # head gives you the first 5 rows/values. There is also tail.

# Question: How do you coerce the "chars" column in kDataFrame into a character? 
kDataFrame2$chars <- as.character(kDataFrame2$chars)

#-------#
# Lists #
#-------#

# A list is a vector containing generic objects
# Lists are good for storing complicated objects.
n = c(2, 3, 5) 
s = c("aa", "bb", "cc", "dd", "ee") 
b = c(TRUE, FALSE, TRUE, FALSE, FALSE) 
x = list(n, s, b, 3)   # x contains copies of n, s, b

print(x)

# Slicing
x[[2]]

# Question: How do you get the third element of the second component of x?
x[[2]][3]

########################
# If, else, and elseif #
########################

# An if statement 
# indent doesn't matter
yourGrade <- 100
if(yourGrade > 80) { 
  print("=)")
}

# An if/else statement 
yourGrade <- 75
if(yourGrade > 80) {
  print("=)")
} else {
  print("=(")
}

# An if/elseif/else statement 
yourGrade <- 70
if(yourGrade > 80) {
  print("=)")
} else if(yourGrade > 60) {
  print("=|")
} else {
  print("=(")
}

#######################
# Creating a funciton #
#######################  

GradeEmoji <- function(yourGrade) {
  if(yourGrade > 80) {
    print("=)")
  } else if(yourGrade > 60) {
    print("=|")
  } else {
    print("=(")
  }
}

GradeEmoji(70)

#########
# Loops #
#########

ourGrades <- c(100, 90, 56, 73, 85, 23)

# Can our function handle this?
GradeEmoji(ourGrades)

# A for loop
ourGradeEmojis <- rep(NA, length(ourGrades))
for(tick in 1:length(ourGrades)) { 
  ourGradeEmojis[tick] <- GradeEmoji(ourGrades[tick]) 
}

# Why did I use the variable name "tick?"
# Why did I use "for(tick in 1:length(ourGrades)) {"
#  instead of "for(grade in ourGrades) {" ?
ourGradeEmojis2 <- list()
for(grade in ourGrades){
  ourGradeEmojis2 <- append(ourGradeEmojis2, GradeEmoji(grade))
}

# There is actually a better way in R
sapply(ourGrades, GradeEmoji) 
# There is a variety of apply functions for different situations. They are fast. 
# Check out a detailed description in the help page.

# Another apply example
myMat <- matrix(nrow = 5, ncol = 6, data = runif(n = 30, min = 0, max = 1))
apply(myMat, 1, sum) # This can also be done with the function rowSums. Try it!, 1 is rowSums, 2 is colSums

# A while loop
failcount <- 0
tick <- 1
while(failcount < 2) { 
  GradeEmoji(ourGrades[tick])
  if(ourGrades[tick] < 80) { 
    failcount <- failcount + 1
  }
  tick <- tick + 1
}

# Question: Can you alter the GradeEmoji function to take in a vector?
GradeEmojis <- function(yourGrades) { 
  GradeEmoji <- function(yourGrade) {
    if(yourGrade > 80) {
      return("=)")
    } else if(yourGrade > 60) {
      return("=|")
    } else {
      return("=(")
    }
  }
  print(sapply(ourGrades, GradeEmoji))
}
GradeEmojis(ourGrades)

#######################################
# Some simple plotting and statistics #
#######################################

# Set up some x and y values
xVals <- 1:100
yVals <- xVals * 5 + 6 + rnorm(n = length(xVals), mean = 0, sd = 40)

# Make a simple plot, and then manipulate some of the base functions
plot(x = xVals, y = yVals)
plot(x = xVals, y = yVals, type = "l", xlim = c(50, 100), lwd = 2, col = "red",
  main = "Main", xlab = "xlab", ylab = "ylab", bty = 'n')
points(x = c(60, 70, 80), y = c(100, 200, 300), pch = 16, cex = 1.4, col = "blue")
# Add a legend
legend("bottomright", legend = c("Data", "Nothing"), col = c("Red", "blue"),
  lty = c(1, NA), pch = c(NA, 16), lwd = c(2, NA))

# Saving your plots

# Example 1 
postscript(file = "~/Desktop/EPS236_RTutorial_Plot.eps", height = 6, width = 6)
plot(x = xVals, y = yVals, type = "l", xlim = c(50, 100), lwd = 2, col = "red",
  main = "Main", xlab = "xlab", ylab = "ylab", bty = "n")
points(x = c(60, 70, 80), y = c(100, 200, 300), pch = 16, cex = 1.4, col = "blue")
# Add a legend
legend("bottomright", legend = c("Data", "Nothing"), col = c("Red", "blue"),
  lty = c(1, NA), pch = c(NA, 16), lwd = c(2, NA))
graphics.off()

# Example 2
X11(height = 6, width = 6)
plot(x = xVals, y = yVals, type = "l", xlim = c(50, 100), lwd = 2, col = "red",
  main = "Main", xlab = "xlab", ylab = "ylab", bty = "n")
points(x = c(60, 70, 80), y = c(100, 200, 300), pch = 16, cex = 1.4, col = "blue")
# Add a legend
legend("bottomright", legend = c("Data", "Nothing"), col = c("Red", "blue"),
  lty = c(1, NA), pch = c(NA, 16), lwd = c(2, NA))
dev.copy2eps(file = "~/Desktop/EPS236_RTutorial_Plot_2.eps")
graphics.off()

# Simple statistics
mean(yVals)
sd(yVals)
var(yVals)

# Ordinary least-squares linear model
myDF <- data.frame(yVals, xVals)
myLm <- lm(yVals ~ xVals, data = myDF)
summary(myLm)

# Plot method for lm
plot(myLm)

# Residual Plot
plot(x = myLm$fitted.values, y = myLm$residuals)

# A histogram
hist(myLm$residuals)

# A q-q plot
qqnorm(myLm$residuals)
qqline(myLm$residuals)

#####################
# Loading libraries #
#####################

# install.packages("maps")
library(maps)
library(mapdata)

plot(x = c(-170, -50, -50, -170), y = c(10, 10, 80, 80), pch = 16, col = "green")
map("world", add = TRUE)
map("worldHires", add = TRUE)
map("state", add = TRUE)

#########################
# Some amazing packages #
#########################

# RColorBrewer: Great color pallettes - printer safe, colorblind safe
# See http://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3
# install.packages("RColorBrewer")
library(RColorBrewer)

x <- runif(n = 100, min = 0, max = 10)
y <- runif(n = 100, min = 0, max = 10)
z <- x * y

# A colored scatter plot
colcut <- rev(brewer.pal(n = 10, name = "Spectral"))[
  cut(z, breaks = seq(from = 0, to = 100, length = 10))]
plot(x, y, col = colcut, pch = 16)

#-------#
# dplyr #: fast and simple tools for data frame manipulation
#-------#

# install.packages("dplyr")
library(dplyr)

# Make a big data frame to play with
kDataFrame <- data.frame(
  nums = 1:100,
  chars = c(rep("hello", 50), rep("goodbye", 50)),
  logics = rnorm(n = 100, mean = 25, sd = 10) > 18,
  rands = rnorm(n = 100, mean = 23, sd = 10)
) 

# Selects rows using a logical
kDataFrame_filtered <- filter(kDataFrame, logics)
# Sorts rows according to some order
kDataFrame_filtered <- arrange(kDataFrame_filtered, rands)
# Selects only some columns  
kDataFrame_filtered <- select(kDataFrame_filtered, chars, rands)
# Preserves only unique rows
kDataFrame_filtered <- distinct(kDataFrame_filtered)
# Adds a new column according to transformation
kDataFrame_filtered <- mutate(kDataFrame_filtered, char2 = as.character(rands / 5))

# dplyr introduces piping to make things more readable 
kDataFrame <- data.frame(
  nums = 1:100,
  chars = c(rep("hello", 50), rep("goodbye", 50)),
  logics = rnorm(n = 100, mean = 25, sd = 10) > 18,
  rands = rnorm(n = 100, mean = 23, sd = 10)
)

# This does all the operations above
kDataFrame_filtered2 <- kDataFrame %>% filter(logics) %>% arrange(rands) %>% 
  select(chars, rands) %>% distinct() %>% mutate(char2 = as.character(rands / 5))

#-----------#
# Lubridate #: awesome tools for manipulating dates
#-----------#

# install.packages("lubridate")
library(lubridate)

# Set the time zone!
Sys.setenv(TZ='GMT')

# The functions are very flexible
ymd("1990-05-06")
ymd("1990/05/06")
ymd("1990 May 6")

# These are objects of class "POSIXct"
class(ymd_hms("1990-05-06 12:56:34 UTC"))

# Extracting aspects of the dates
hours(ymd_hms("1990-05-06 12:56:34 UTC"))
years(ymd_hms("1990-05-06 12:56:34 UTC"))

# Transforming to and from decimal years
date_decimal(2012.5)
decimal_date(ymd_hms("1990-05-06 12:56:34 UTC"))


