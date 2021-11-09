# Step-1
# Identify the Problem Statement, What are you trying to solve?
# This project predicts the likelihood of whether an ad will be clicked or not

# Step-2
#Loading the raw Data
advertising <- read.csv(choose.files(),stringsAsFactors = T)

head(advertising)

str(advertising)



# out of the 14 columns which is the target variable 
#Clicked 


###now understand which variable is useful or not and removing variable which are not useful

#visit id 
# it is continuous variable
#visit id would help to identify whether the person ,  not required (removing column) 

#time spend 
# it is continuous variable
#consumer time on site in minutes 

#age
# it is continuous variable
# customer age in years , it would help us to detect  the age group 

#average income 
# it is continuous variable
# average income not important removing 


#internet usage
# it is continuous variable
# average minutes a day consumer is on the internet 

#ad topic 
# it is categorical variable
# this column tells about the headline of the advertisement, not required (removing column)

#country name 
# it is categorical variable
# country of consumer

#city_code 
# it is categorical variable
# city code of consumer  not required (removing column)

#male 
# it is categorical variable
# whether or not consumer was male 

#time period 
# it is categorical variable
# time period at which consumer clicked on ad or not 

# weekday
# it is categorical variable
# day of the week at which consumer clicked on ad or not

#month
# it is categorical variable
# month at which consumer clicked on ad or not


# year 
# it is categorical variable
#year at which consumer clicked on ad or not

# clicked 
# it is categorical variable
# 0 or 1 indicated clicking on ad

# Reomoving useless column 
#########
library(dplyr)

advertising[, c("VistID","Ad_Topic","Time_Period" ,"City_code","Country_Name","Weekday","Month","Year")] = NULL
head(advertising,10)
str(advertising)

###########All Categorical are factors

advertising$Clicked <- as.factor(advertising$Clicked)

# step 3 Data pre processing
## checking missing values

colSums(is.na(advertising))

##### there is no missing value 

#### checking is there is any outlier or not 



boxplot(advertising$Avg_Income) # outlier found
quantile(advertising$Avg_Income, seq(0,1,0.01))
advertising$Avg_Income <- ifelse(advertising$Avg_Income<23000,23000,advertising$Avg_Income)

boxplot(advertising$Age) # no outlier
boxplot(advertising$Internet_Usage) # no outlier
boxplot(advertising$Male) # no outlier
boxplot(advertising$Time_Spent) # no outlier
boxplot(advertising$Clicked) # no outlier


################### outlier treatment done



#Step 4 univariate and bivariate analysis 

##continuous column- histogram
##categorical column- bar plot


#univariate

# Exploring MULTIPLE CONTINUOUS features


ColsForHist=c("Time_Spent","Age","Avg_Income","Internet_Usage")

#Splitting the plot window
par(mfrow=c(2,2))

library(RColorBrewer)

# looping to create the histograms for each column
for (contCol in ColsForHist){
  hist(advertising[,c(contCol)], main=paste('Histogram of:', contCol), 
       col=brewer.pal(8,"Paired"))
}

######################
# Exploring multiple categorical features


ColsForBar=c("Male","Clicked")
par(mfrow=c(2,1))

# looping to create the Bar-Plots for each column
for (catCol in ColsForBar){
  barplot(table(advertising[,c(catCol)]), main=paste('Barplot of:', catCol), 
          col=brewer.pal(8,"Paired"))
}

########3
##bivariate analysis

# Visual Relationship between predictors and target variable
##Regression- 2 scenarios
# Continuous Vs Continuous ---- Scatter Plot
# Continuous Vs Categorical --- Box Plot

# Continuous Vs Continuous --- Scatter plot

# For multiple columns at once
ContinuousCols = c("Time_Spent","Age","Avg_Income","Internet_Usage")
par(mfrow=c(1,1))
plot(advertising[, ContinuousCols], col='blue')


# Continuous Vs Categorical Visual analysis: Boxplot

CategoricalCols = c("Clicked","Age")
library(RColorBrewer)

for (bar_cols in CategoricalCols){
  boxplot(Time_Spent~ (advertising[,c(bar_cols)]), data = advertising, 
          main=paste('Box plot of:',bar_cols),col=brewer.pal(8,"Paired"))
  
}

# Statistical Relationship between target variable (Categorical) and predictors

# Categorical Vs Continuous --- ANOVA
# Categorical Vs Categorical -- Chi-square test


# Continuous Vs Categorical relationship strength: ANOVA
# Analysis of Variance(ANOVA)
# H0: Variables are NOT correlated
# Small P-Value <5%--> Variables are correlated(H0 is rejected)
# Large P-Value--> Variables are NOT correlated (H0 is accepted)

summary(aov(Age~Clicked, data = advertising))

summary(aov(Time_Spent~Clicked, data = advertising))


#### Categorical Vs Categorical relationship strength: Chi-Square test
# H0: Variables are NOT correlated
# Small P-Value--> Variables are correlated(H0 is rejected)
# Large P-Value--> Variables are NOT correlated (H0 is accepted)


##It takes crosstabulation as the input and gives you the result
Chisqcols=c("Male","Clicked")

for(chi_cols in ColsForBar ){
  CrossTabResult=table(advertising[,c('Clicked',chi_cols)])
  ChiResult=chisq.test(CrossTabResult)
  print(ColsForBar)
  print(ChiResult)
}

# Step 6 splitting the data into training and test

library(caTools)

set.seed(101)
split <- sample.split(advertising$Clicked, SplitRatio = 0.70)
split

training <- subset(advertising, split==TRUE)
test <- subset(advertising, split==FALSE)
nrow(training)
nrow(test)

###Step 7 Model building

logit <- glm(Clicked~., data=training, family='binomial')
summary(logit)

logit2 <- glm(Clicked~.-VistID-Ad_Topic-Country_Name, data=training, family='binomial')
summary(logit2)

pred <- predict(logit2, newdata = test, type='response')
pred
pred_thresh_value <- ifelse(pred>=0.5,1,0)

##Step8 Multicollinearity check

logit2 <- glm(Clicked~.-VistID-Ad_Topic-Country_Name, data=training, family='binomial')
summary(logit2)
library(car)
VIF=vif(logit2)
data.frame(VIF)

barplot(VIF,main="VIF",horiz = TRUE,col = "steelblue")


### Step 9


library(caret)

cm <- table(test$Clicked, pred_thresh_value)
confusionMatrix(cm)

pred_40 <- ifelse(pred>=0.40,1,0)
cm <- table(test$Clicked, pred_40)
confusionMatrix(cm)


pred_50 <- ifelse(pred>=0.50,1,0)
cm <- table(test$Clicked, pred_50)
confusionMatrix(cm)

pred_60 <- ifelse(pred>=0.60,1,0)
cm <- table(test$Clicked, pred_60)
confusionMatrix(cm)


pred_70 <- ifelse(pred>=0.70,1,0)
cm <- table(test$Clicked, pred_70)
confusionMatrix(cm)

pred_80 <- ifelse(pred>=0.80,1,0)
cm <- table(test$Clicked, pred_80)
confusionMatrix(cm)

pred_90 <- ifelse(pred>=0.90,1,0)
cm <- table(test$Clicked, pred_90)
confusionMatrix(cm)



###Step 10

pred_50 <- ifelse(pred>=0.50,1,0)
cm <- table(test$Clicked, pred_50)
confusionMatrix(cm)


# Note : this approach is called "Maximum Likelihood Estimation"

# NOTE : threshold = 50%, accuracy - 92% 

# please use k-fold method to improve your accuracy

# ROC-AUC 


library(ROCR)
rocprediction <- prediction(test$Clicked,pred_50)
rocprediction

rocperformance <- performance(rocprediction,'tpr','fpr')

rocperformance

plot(rocperformance, col='red', print.cutoffs.at=seq(0.1, by=.1))
abline(a=0,b=1)









