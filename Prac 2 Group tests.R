### Practical 2: Simple group comparisons with R



#############################################################
##    Problem 2.1   - t-tests
#############################################################


#Here we will run some simple group comparison tests in R. The data is height and shoe size of 158 college students. 
#For each college student, we have the following data: gender,country, height (cm), shoe size (cm). We are going to do the following tests:
#1)	Is the average height of students greater than 150 cm? (1-sample t-test)
#2)	Does the average height of male and female students differ?  (2-sample t-test; 2-tailed)
#3)	Are females shorter than males? (2-sample t-test; 1-tailed)


#(A) Read the data into R and check it


#First, point to the location where you will source the data file
#setwd("/Users/kyletomlinson/Dropbox/Teaching/Environmental education/Lesson 2")

getwd()

setwd("/Users/linxiying/Desktop/AFEC/R/Lesson 2 Group tests")

size <- read.csv(file = "height_shoesize.csv", header =T)
str(size)
size$Gender <- as.factor(size$Gender)
size$Country <- as.factor(size$Country)

t.test(size$Height, mu=150, alternative = "greater")
t.test(size$Height~size$Gender, var.equal = TRUE)
t.test(size$Height~size$Gender, alternative = "less", var.equal = TRUE) ##F在M之前
t.test(Shoe_Size~Gender, size, alternative = "less", var.equal = TRUE)

library(ggplot2)
ggplot(size, aes(x = Height, fill = Country)) +
   geom_histogram(color ="white", alpha = 0.6, position = 'stack') +
  theme_bw()+
  theme(panel.grid = element_blank())+
  scale_y_continuous(expand=c(0,0))+
  theme(panel.background = element_blank())

## 行列转置 +coord_flip()
## 分组 +facet_grid(.~Gender)
## position identity=高度表示绝对数量的柱状图；fill=百分比堆积柱状图；dodge=高度表示绝对数量的分组柱状图;stack=高度表示绝对数量的堆积柱状图
## color ="white"描边
plot(size$Country,size$Height)

anova_size <- aov(Height~Country, data = size)
summary(anova_size)
TukeyHSD(anova_size, "Country", ordered = FALSE) ##ordered为T则因子的水平递增排序，从而使得因子间差异均以正值出现。


#Second, open a new script file and save it with an appropriate name.  Import the data into R via a .csv file. Please remember that R is fussy about the titles of the columns. Assign the data to a dataframe called ‘size’ in R. Check the data using the summary() command. Make sure that each data column is of the correct type.
read.table(file="height_shoesize.csv",header=T,row.names=NULL,sep=",")
#this is not very useful

size <-read.table(file="height_shoesize.csv",header=T,row.names=NULL,sep=",")

#check full data
size

str(size)

#get dimensions of data
dim(size)  #shows you the sample size (rows) and the number of columns 

#get summary of data
summary(size)

#ordinaly/numerical traits have min and max values.
#factors have levels with counts of individuals per level
#some of you may end up with columns called characters. these are actually the grouping traits, so need to be changed to factors

size$Gender <- as.factor(size$Gender)
size$Country <- as.factor(size$Country)

#now rerun summary()
summary(size)
#now Gender and Country are recognised as factors with respectively 2 and 3 levels (cases)


#1) Look at the distribution of the height data using a histogram 

#show a histogram of the height data
hist(size$Height)



#2) Perform a 1-sample t-test checking whether humans are on average taller than 150 cm (1-tailed test)

#perform a 1-sample t-test checking whether humans are on average taller than 150 cm. (this is a 1-tail test)

t.test(size$Height,mu=150,alternative="greater")

dim(size)

#Note the output given by the test (mean, confidence intervals and significance of tests)



#3) Perform 2-sample t-test checking whether males differ in height from females (2-tailed test) 

#perform a 2-sample t-test checking whether males differ in height from females 
#here we ignore the 'alternative' argument and take its default case (a two-tailed test)
#two different formulations in R
t.test(size$Height~size$Gender,var.equal = TRUE)

t.test(Height~Gender,data=size,var.equal = TRUE)

#note the results are identical



#4) Perform 2-sample t-test checking whether females are shorter than males (1-tailed test)

#Note that now we specify the direction of the relationship using the ‘alternative’ argument. 

#perform a 2-sample t-test checking whether females are shorter than males 
#here we require the 'alternative' argument to specify this is a one-tailed test
summary(size)


t.test(size$Height~size$Gender, alternative="less",var.equal = TRUE)

t.test(Height~Gender,data=size, alternative="less",var.equal = TRUE)

t.test(Height~Gender,size, alternative="less",var.equal = TRUE)

#Please note that the t-value does not change but the p-value changes. How does it change?

#what happens if we get the order wrong??
t.test(Height~Gender,size, alternative="greater",var.equal = TRUE)



#5) Perform a 2-sample t-test checking whether females have smaller shoe-sizes than males

#Adapt the code above to do this…

summary(size)

t.test(Shoe_Size~Gender,data=size, alternative="less",var.equal = TRUE)

t.test(Shoe_Size~Gender,data=size, alternative="greater",var.equal = TRUE)

#############################################################
##    Problem 2.2   - ANOVA
#############################################################

#Now let's deal with a factor with more than 2 levels: country

summary(size)

#plot hist of height
hist(size$Height)

#now lets plot height by country

#now we need to get a new package
# first, find a CRAN mirror
chooseCRANmirror()
#install the package
install.packages("ggplot2")

library(ggplot2)

ggplot(size,aes(x=Height, fill=Country)) +
  geom_histogram(colour="white",alpha=0.6, position = 'identity')
 
#plot height against country
plot(size$Country,size$Height) #boxplot


#now lets run anova 
#save the result in an ANOVA OBJECT
anova1 <- aov(Height~Country,data=size)
str(anova1)
summary(anova1)
#THIS TELLS US THE AT LEAST 2 GROUPS DIFFER SIGNIFICANTLY.

#BUT WHICH GROUPS?  -> posthoc tests!

#there are many possible tests. A commonly-used one is Tukey HSD
TukeyHSD(anova1, "Country", ordered = TRUE)
#output shows comparisons between each pair of groups
#result indicates that China is significantly different from Japan and Thailand, but Japan and Thailand do not differ significantly from one another. 

summary(size)



