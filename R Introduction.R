

# is called a hash, * is called an asterisk
#####Built-in functions: 
#wide range of built-in functions 
#functions have a name and a variable number of arguments;
3^(1/2)
sqrt(3)
log(10) #natural log 自然常数Natural constant
?log
log(100,10) #10的对数
log10(100)

log(exp(3))
#DONE COMPOUND FUNCTION: G(F(x))


## arguments can be passed to a function either by using the names of arguments as above or:
log(c(100, 10)) ## in order c()组成向量
log(100)
log(10)

###Assignment operators:
 x <- 4     #Assigns 4 to x; note the assignment operator "<-"
 x          #Prints x
 y <- x + 2 #use the object name to perform calculations
 y  #scalar

 t <- c(100,10)
 log(t)
 
 v1 <- c(58,21,-79) #vector
 v2 <- c("a","b","a") #character
 v3 <- c("monkey","gorilla","ostrich")
 v4 <- c(23,45)
 
 df1 <- cbind(v1,v2,v3) #column bind
 df1
 str(df1) #structure
 
 df4<- rbind(v1,v2,v3)
 df4
 
 df2 <- data.frame(v1,v2,v3)
 df2
 str(df2)
 
 df3 <- data.frame(v1,v2,v3,v4) 
 #functions only work when you give them the right inputs!!

 
 #two matrices
 m1 <- matrix(c(1,2,3,4,5,6,7,8,9,10),2,5)
 m1
 dim(m1)
 
 ?matrix( )
 m2 <- matrix(c(3,4,5,6,7),5,1)
 m2
 dim(m2)
 
 #multiply m1 by m2??
 
 m3 <- m1 %*% m2 # 2x5, 5x1
 m3
 
 m4 <- m2 %*% m1 
 
 
#####Querying functions

#?function name: to query a specific built-in function
 ?sqrt      
 ?lm

#which is equivalent to help(function name)
 help("sqrt")
 help("lm")

## functions: lm(), anova(), hist() ... (you can write your own functions!) & sets of functions (packages)



########## R language structure: 

## everything within R is an object
objects() #lists all objects in your environment
ls()

### R accesses objects by their name (alpha/alpha-numeric, case sensitive, no.space.allowed!)
## operators (+ - <- * %*% …)
	
## Every object has a mode and a class
## Class: the structure of the object - vector, matrix, array, data.frame, & special classes created by specific functions
## Mode: the data type inside the object structure - character, numeric, logical, factor, list, & function 

a <- 1 #scalar
b <- c(1,2,3) #vector



################ Read file into R ############


###Your workspace:

#getwd() shows the path of your current working directory
getwd()

#setwd(path) allows you to set a new path for your current working directory
setwd("/Users/linxiying/Desktop/AFEC/R/Lesson 1 Introduction")
#setwd("C:/...")

diver <- read.table(file="DIVER.csv",header=T,row.names=NULL,sep=",")
diver
str(diver)
summary(diver)
dim(diver)  # dimension of the DF
dim(diver)[1]
#numerous other options for reading in data files
diver<-read.csv(file="DIVER.csv",header=T,row.names=NULL,sep=",")
diver <- read.table(pipe("pbpaste"), sep="\t", header=T) #copy paste import for Mac
#diver <- read.delim("clipboard", header = T) #copy paste for Windows

# checking the read.table command
help(read.table)
?read.table
?read.csv


#list all variables
ls() #objects()
#rm(x,y) #removes objects x & y
#rm(list=ls())

#check the diver data you just imported: 
diver
summary(diver) #display summary of an object
dim(diver)  #dimension of the data frame
ls()

experience
diver$experience

attach(diver) #makes the variables of a data frame accessible by their name
experience
detach(diver) #the inverse
experience #should not work
diver$experience
#use attach() with caution! better to reference data by names inside names..

######check data
str(diver)#str() a useful summary of the structure of a data frame
dim(diver)#dim() dimentionality of a dataframe
summary(diver)
summary(diver$experience)

names(diver) #displays the names of the variables in a data frame 
head(diver) #displays the first 5 rows in a data frame;  head(diver, 10L) returns first 10rows in the data frame
tail(diver) #displays the last 5 rows in a data frame;  tail(diver, 10L) returns last 10rows in the data frame
summary(diver)
head(diver,n=10)
#reassign type from ordinal to factor
diver$experience<-as.factor(diver$experience)
summary(diver)

levels((diver$experience)) #displays unique values in a vector (column)

#reassign type from ordinal to factor
diver$experience<-as.numeric(diver$experience)
summary(diver)


dim(diver)
diver$experience_sq <- (diver$experience)^2 # create a new column of data containing the square of the experience level
summary(diver)
head(diver,n=10)



diver$experience_sq
names(diver) #experience_sqr has been added to the diver data
summary(diver)

## categorical vs. ordinal variables (i.e. mode)
str(diver)
diver$experience <- as.factor(diver$experience)
summary(diver)
hist(diver$respiration)
hist(log(diver$respiration))

##EXIT
q()

 