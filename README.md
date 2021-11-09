# Ad-Click-Project
Ranging from high-profile platforms to local listings, online directories cover a range of audiences as well as additional details about your business or organization. This helps promote your website by boosting its search engine ranking, increasing the chances that they’ll get paid by Google by drawing traffic to google ad on the website. The goal of the case study is to Predict who is likely going to click on the Advertisement so it can contribute to the more revenue generation to the organization.
# Steps 
1.	Identify the Problem Statement - what are you trying to solve?
2.	Import the dataset and identify the Target variable in the data.
Identifying the type of variables: Identifying the nature of different columns (Continuous / Categorical ), removing garbage columns (if any) and conversion of categorical variables to factors if they are not in factors.
3.	Data pre-processing: Checking and treating the missing values with appropriate measures. Checking the presence of outliers by creating boxplots and treating the outliers (if any).
4.	Univariate and Bivariate Analysis: Explore each "Potential" predictor for distribution (visual analysis –histogram/bar plot) and also explore their relationship with the target variable (visual analysis –boxplot/grouped bar chart and statistical tests – ANOVA/Chi-square).
5.	Feature selection: Finalize the set of potential predictors to be used in the logistic regression algorithm.
6.	Splitting the data into train & test: Divide the data into two parts: Train sample (70%) and test sample (30%). The machine learning algorithm will be applied on the Train set and the model will be validated on the test set.
7.	Model Building: Form the logistic regression model with the set of potential predictors identified from Exploratory data analysis and obtain the significant predictors.
8.	Multicollinearity check: Check the presence of Multicollinearity in your final model and remove the variables with high multicollinearity one by one from your final model to arrive at the model which will be used to generate predictions on the test data.
9.	Predictions: Using the obtained model, generate the prediction probabilities on the test data. Considering the threshold, obtain the predictions on the test data set.
10.	Accuracy measures: Obtain the confusion matrix. Obtain the “overall” value of accuracy, Precision, Recall/Sensitivity, Specificity, Balanced accuracy, F1-score.
# Variable Description
This data set contains the following features:
'Time_Spent': Average time spent by user on site in minutes
'Age': User age in years
'Area_Income': Average Income of geographical area of user
'Internet_Usage': Average minutes a day user spent on the internet
'Ad_Topic’: Headline of the advertisement
'Country_Name': Country of user
'City_Code': City of user
'Male': Whether or not user was male
‘Time_Period’: Time at which consumer clicked on Ad
‘Weekday’: Name of the day
‘Month’: Name of the months
‘Year’: Which year the data is collected
'Clicked': 0 means not clicked and 1 means that user clicked the Ad.
