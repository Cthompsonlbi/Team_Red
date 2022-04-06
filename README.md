# Team_Red -- Module 20 Challenge

## Topic

We will analyze a Holiday package dataset to identify key market segments, and to manufacture a high level strategy to connect to target groups to sell them the getaway package at a higher success rate.

If you would like to access the slideshow for a more brief report, you can do so [here](https://docs.google.com/presentation/d/1I5h9CG6jF9-2hxQ4abF_KSPI4CQ6rH8Pa7tIWhde0Mo/edit?usp=sharing)


### Reason for Selection: 

-	One of our team members is familiar with the hospitality industry and has a passion for analyzing this specific topic.
-	The Dataset is relevant to our questions, has enough data points and features and could be easily adapted to an industry dataset.
-	The Data is mostly intact.
-	It is publicly available and updated monthly. 


### Questions We Hope to Answer:

Our client would like to answer at least one of these questions:

-	Can we predict what the ideal target customer would look like?
-	What would be a good marketing strategy?
-	What variables have the most influence on the purchase decision?


### Roles

REPLACE WITH ("Roles.png")
![image](https://user-images.githubusercontent.com/91682586/159757962-0591adf2-d16c-4401-a41f-60282c9a7377.png)

---
## Dataset

Travel.csv from the Kaggle website - [here](https://www.kaggle.com/susant4learning/holiday-package-purchase-prediction)


Travel.csv from our repo - [here](https://github.com/Cthompsonlbi/Team_Red/blob/main/Resources/Travel.csv)

The dataset contains 20 columns and 4888 rows, which includes customer and marketing information, as well as a target column that shows if the vacation package was purchased or not.

There are currently 5 types of packages the company is offering:

- Basic
- Standard
- Deluxe
- Super Deluxe
- King

---
## Technologies Used:

Language:

	- Python

Programs:

	- Jupyter Notebook

	- pgAdmin 4 (PostgreSQL)

	- Tableau

Major Libraries:

	- Pandas

	- sqlalchemy

	- Scikit-learn

	- Imblearn
 
 A full list of libraries and environmental requirements can be found [here](https://github.com/Cthompsonlbi/Team_Red/requirements.txt)


---
## Process of Data Analysis and Evaluation

The data file was loaded into the EDA notebook, where it was cleaned. From there, it was uploaded to the SQL database as a new table. The new table would then be called for the machine learning portion of the analysis, and thus needed to be preprocessed (scaled, binned, encoded, resampled). Due to the imbalanced nature of the data (19% of products pitched were purchased), we trained our models with both oversampled and original training sets to compare results. In total, we were left with four models. Once preprocessed, K-Fold cross validation was performed on each model to determine the optimal parameters. Classification reports, confusion matrices, and accuracy scores were used as metrics to determine a model's performance. Finally, feature importance was pulled for later analysis. A general flow chart of the described process can be found below.

![HighlevelProjectFlow](Images/HighlevelProjectFlow.PNG)


### Database

We use pgAdmin as our SQL database. The data was separated into two tables: a customer info table and a marketing info table. They share customer ID, which serves as the primary key, or unique identifier.

Here is a snapshot of the ERD:

![QuickDBD-export](https://user-images.githubusercontent.com/92830382/159591417-936321a5-d646-4f35-9745-389ab3cc44a4.png)

When the clean data is sent back into the database, it is loaded into a single, new table, which is later used for machine learning and Tableau.


### Exploratory Data Analysis

Quick link to our EDA Jupyter notebook file that contains code for our work with regards to cleaning the Travel dataset can be found [here](Notebooks/InsightEDA.ipynb).

The initial steps taken after pulling the Travel.csv file into a dataframe to get a better understanding of the data that we are working with were as follows:	

	* running a count function-- count() on the dataset to capture sum of rows with values
	* running a unique function -- nunique() on the dataset to see if there were values that exceeded the anticipated amount
	* running a null function -- isnull() to identify columns that contain null values and the quantity of null values
	* merge the three resulting dataframes from the functions above into a dataframe to allow ease of analysis
	* inspecting each column using the groupby and size function --groupby().size() to identify columns with erroneous values or complex groupings
	* adjusting column values to modify erroneous values and simplify complex groupings
	* Use Sklearn SimpleImputer to Manage Null Values
	
* Screenshot illustrating the combining of three dataframes created using functions count, nunique, isnull

![EDA_DF_Combine](Images/EDA_DF_Combine.PNG)

* Screenshot illustrating the use of the groupby function and replace function to modify column values

![SampleGroupFunction1](Images/SampleGroupFunction1.PNG)
	
* Additional screenshot of groupby function and replace function to modify column values

![image](https://user-images.githubusercontent.com/91682586/159763571-9262e494-9fd7-4114-9807-800b297dd0dd.png)


### Machine Learning Model

Initially, a decision tree and logisitic regression model were used as predictive models, but were eventually replaced with more complex models such as: random forest, adaptive boost, extreme gradient boost, and neural network. Ultimately, the group decided on utilizing a random forest and an extreme gradient boost, as they not only proved to be highly effective, but were capable of providing relational insight into the data; this was especially important as the data was fairly diverse between categorical and continuous data.

Below are slides individually describing the functionality and utility of both the random forest and extreme gradient boost ('XGBoost') models:

![balanced_random_ss](https://user-images.githubusercontent.com/92830382/161458358-1034062a-554c-4aeb-87f8-8717e76265a4.png)

![XGboost_ss](https://user-images.githubusercontent.com/92830382/161460256-a951ef8b-25d1-4d84-9f13-9f997acccc37.png)


### K-Fold Cross Validation

K-Fold cross validation is a technique used to ensure each model is tested against multiple subsets, called *folds*, of the data to average the accuracy scores. In a five-fold cross validation, the data is split into five folds, where the first four are the training sets, and the last is the validation set. The model is tested against the validation set for an accuracy score, the same way we use training and testing splits. The model then uses the 2nd to last fold of data as the validation set and repeats the process until each subset has been used as the validation once. The accuracy scores from each fold are then averaged.

Visualization of the K-Fold process:

INSERT IMAGE ("kfold_diagram.png")

For our models, we used both five and 10-fold cross validation to be safe - although this made the code more cumbersome to run (the ML_Master file takes over five hours to run). We passed a series of parameters through the models, adjusting one parameter at a time using for-loops. Within each model, it would use the K-Fold cross validation method, running five and 10 more times each. For example, the extreme gradient boost model iterates 2,592 times in total; one would think that it created and tested 2,592 models, but it actually tested five models per iteration for the first half, and 10 models per iteration for the last half - totalling 19,440 models.

A dictionary to store the results was created in the beginning of the code, which would contain the best set of parameters for the extreme gradient boost model. While the cross validation was run, if a new highest accuracy was discovered, all current parameters would replace the previous best parameters within this dictionary.

The block of code containing the extreme gradient boost K-Fold cross validation is provided below:

INSERT IMAGE ("XGBoost_cv.png")

To run the final model, we called the dictionary for each of the adjusted parameters. This can be observed within the XGBClassifier, as many parameters are set equal to their respective keys in the dictionary.

INSERT IMAGE ("XGBoost_Opt")


### Machine Learning Model Results

After model optimization was completed, the first measurement of success was the accuracy score, which compares the predicted targets versus actual targets. The following are the accuracy scores for each model:

- Unsampled Balanced Random Forest:			87.98%
- Oversampled Balanced Random Forest:		85.75%
- Unsampled XGBoost:						93.42%
- Oversampled XGBoost:                  	86.64%

The classification reports, as well as the confusion matrices, combined into two images are presented below:

INSERT ("total_classes.png")
INSERT ("total_cm.png")

The two models with the best performance tailored to our team's objective are provided in the next image. These models were chosen not entirely based off of their accuracy scores, but by their precision and f1 scores. What is most important to our client is acquiring new customers. If we can minimize time lost from seeking people out who will not buy our product, our client can take advantage of higher conversion rates. A false negative, also known as a type 2 error, will cause our client to miss out on a potential customer. A false positive, also known as a type 1 error, will cause our staff to waste time speaking with customers who will likely deny the product, resulting in wasted time without a sale. Ideally, the models minimize both, but that was not the case. 

Below, are the two best performing models when considering our client's objective.

REPLACE IMAGE with updated GOOGLE SLIDE
![cm_ss](https://user-images.githubusercontent.com/92830382/161461080-e2cacb1f-19fb-4659-aabc-aadf6cf48a61.png)


In addition, a chart containing the most important features, according to our oversampled random forest classifier, is provided below:

INSERT ("brfr_fi.png")

The top three features, age, monthly income, and duration of pitch, were the most weighted variables in the mix when determining if somebody purchased a getaway package. This is reflected in the charting analysis using Tableau, to be discussed later. The more accurate the machine learning model, the stronger the support provided by feature importance.

The final notebooks that display outputs can be found here:

  - [Insight EDA File](Notebooks/InsightEDA.ipynb)
  - [Insight Unsupervised File](Notebooks/InsightUnsupervised.ipynb)
  - [Machine Learning Master File](Notebooks/ML_Master.ipynb)


---
---
---
---

### WebApp Deployment  https://cthompsonlbi.github.io/TeamRedInsight/

The Machine learning model will pull data from the pgAdmin database using Heroku.
This will be set up later. Currently we have it connected through sqlalchemy to the local machine.

---
---
---
---
## Tableau Analysis

[Link to Dashboard](https://public.tableau.com/app/profile/cathleen.mai/viz/InsightsontheBeach428am/Story1?publish=yes)

In this dashboard we were able to modify the data a bit more to allow the vizualizations to be more user friendly. 

* By creating aliases, the ProdTaken column was able to Transform from 0's and 1's to 'No' and 'Yes'. 
* Through the Grouping function we were able to simplify the MonthlyIncome and Age fields by adding them to buckets based on their respective increments.
* Our plan for this dashboard is to create specialized and informative graphs that can tell a story and lead us to the final answer of "Who will buy our vacation packages?". 

![image](https://user-images.githubusercontent.com/91682586/161326165-601d8a0f-4c19-4670-a115-657d794eb461.png)

 * By creating multiple Stories we can flip through the different visualizations that progress through a story to get us to our answers!

![image](https://user-images.githubusercontent.com/91682586/161326282-0e077813-f3b3-48e9-9430-f08164ec0987.png)

![image](https://user-images.githubusercontent.com/91682586/161326703-70b81c2c-9ca3-440c-8a32-ce860bc131f6.png)

![image](https://user-images.githubusercontent.com/91682586/161326979-69aefb66-01b0-40fb-b71b-d6e484ca0392.png)


## Summary

models suggests..

tableau suggests..

ultimately suggests..

recommendation and why..


### Recommendation for Future Analysis

Where can we go from here? Add on to data? Explore hard financial numbers to make more informed decisions?
