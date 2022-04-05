# Team_Red
Module 20 Challenge

### Roles

![image](https://user-images.githubusercontent.com/91682586/161858674-f6bb0084-8c4b-42c2-bc13-785bcc050e59.png)


---

---
#### Technologies used for this Project:

- Python
- Pandas
- Sklearn
- Tableau
- PostgreSQL

---
### Topic of our Project

We will analyze a Holiday package Dataset. The purpose of this analysis is to look at past events and use Data analysis and Machine learning to give business recommendations to our client on which demographic would most likely purchase a newly introduced vacation package.


Update2: additional slides were added and existing updated to align with model changes 
Link to Google Slideshow: https://docs.google.com/presentation/d/1I5h9CG6jF9-2hxQ4abF_KSPI4CQ6rH8Pa7tIWhde0Mo/edit?usp=sharing


---
#### Reason for Selection: 

-	One of our team members is familiar with the industry and has a passion for analyzing this specific topic.
-	The Dataset is relevant to our questions, has enough data points and features and could be easily adapted to an industry dataset.
-	The Data seems, at first glance, to be quite clean.
-	It is publicly available and updated monthly. 

---
#### Questions we Hope to Answer:

Our client is introducing a new vacation package. They would like to answer at least one of these questions:

-	Can we predict what the ideal target customer would look like?
-	What would be a good marketing strategy?
-	What variables have the most influence on the purchase decision?

---
#### Process of Data Analysis and Evaluation

Description of preliminary feature engineering and preliminary feature selection, including decision-making process

![3](https://user-images.githubusercontent.com/91682586/159799327-5b62152f-a315-4818-a306-0a7ef502ec29.png)

![balanced_random_ss](https://user-images.githubusercontent.com/92830382/161458358-1034062a-554c-4aeb-87f8-8717e76265a4.png)

![XGboost_ss](https://user-images.githubusercontent.com/92830382/161460256-a951ef8b-25d1-4d84-9f13-9f997acccc37.png)




##### UPDATE: Heroku App  https://teamredpetpals.herokuapp.com/

#### Update: We have further integrated the SQL database. The dataset is now connected to not only read from the DB, but also write the result of the EDA (clean file) back into our Database. 



![HighlevelProjectFlow](Images/HighlevelProjectFlow.PNG)

---
#### Dataset

Travel.csv from the Kaggle website
https://www.kaggle.com/susant4learning/holiday-package-purchase-prediction

Click here to get directly to the CSV file:  https://github.com/Cthompsonlbi/Team_Red/blob/main/Resources/Travel.csv

The dataset contains 20 columns and 4888 rows.
It includes Customer and Marketing information and a column that shows if the vacation package was purchased or not.
There are currently 5 types of packages the company is offering - Basic, Standard, Deluxe, Super Deluxe, King.

---
#### Machine learning Model

##### **Update**:

We added some visuals to the machine learning part of our presentation.


![cm_ss](https://user-images.githubusercontent.com/92830382/161461080-e2cacb1f-19fb-4659-aabc-aadf6cf48a61.png)




##### **Update**:
We found that our dataset is very unbalanced (ProdTaken yes/no). Therefore we have adjusted our approach.
In addition to our regular Decision Tree and RandomForest Classifier we explored a BalancedRandomForest as well as Over and Undersampling in the code.
We also added a Neural Network Model to the Mix. We used the K-fold Random Forest Classifier to help make a final decision on what model we will use.

features by importance:
![image](https://user-images.githubusercontent.com/91682586/159939057-ba9491c7-6fa3-4787-8f5d-0313e93ea2d1.png)


The updated Machine Learning models can be found here:

  - [Insight EDA File](Notebooks/InsightEDA.ipynb)
  - [Insight Unsupervised File](Notebooks/InsightUnsupervised.ipynb)
  - [Machine Learning Master File](Notebooks/ML_Master.ipynb)

This is how we split the Data using the train_test_split method ![image](https://user-images.githubusercontent.com/91682586/159809128-c81e74f5-5687-4ddd-a23f-1455d21b5fc2.png)

--- 
We decided to use a Supervised Learning Model, because our data has labeled input and output data.
It has a target column and features.
As a model we used an Extreme Gradient Boost Model and investigate further for class imbalances.
As a second validation we will be using a RandomForest classifier model.

The Machine learning model will pull data from the PG Admin database which is connected through sqlalchemy to the local machine.

---
---
#### Mockup Database

We use PG Admin as our Database.
We have seperated the Dataset into two tables a Customer table and a Marketing table.
The 2 tables are connected through the Customer ID.

Here is a preliminary ERD:

As you can see, we have setup the tables based on the different information pertaining to both the consumer and the marketing information.
We have made the Primary Key CustomerID as this is the identifier for each piece of information per each consumer and their relative marketing info.


![QuickDBD-export](https://user-images.githubusercontent.com/92830382/159591417-936321a5-d646-4f35-9745-389ab3cc44a4.png)


---
#### Exploratory Data Analysis

Quick link to our EDA Jupyter notebook file that contains code for our work with regards to cleaning the Travel dataset can be found below:

[Travel Dataset Initial Clean](Notebooks/InsightEDA.ipynb)

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

---
### Tableau Dashboard

[Link to Dashboard]https://public.tableau.com/app/profile/cathleen.mai/viz/InsightsontheBeach428am/Story1?publish=yes

In this dashboard we were able to modify the data a bit more to allow the vizualizations to be more user friendly. 

* By creating aliases, the ProdTaken column was able to Transform from 0's and 1's to 'No' and 'Yes'. 
* Through the Grouping function we were able to simplify the MonthlyIncome and Age fields by adding them to buckets based on their respective increments.
* Our plan for this dashboard is to create specialized and informative graphs that can tell a story and lead us to the final answer of "Who will buy our vacation packages?". 

![image](https://user-images.githubusercontent.com/91682586/161326165-601d8a0f-4c19-4670-a115-657d794eb461.png)

 * By creating multiple Stories we can flip through the different visualizations that progress through a story to get us to our answers!

![image](https://user-images.githubusercontent.com/91682586/161326282-0e077813-f3b3-48e9-9430-f08164ec0987.png)

![image](https://user-images.githubusercontent.com/91682586/161326703-70b81c2c-9ca3-440c-8a32-ce860bc131f6.png)

![image](https://user-images.githubusercontent.com/91682586/161326979-69aefb66-01b0-40fb-b71b-d6e484ca0392.png)



