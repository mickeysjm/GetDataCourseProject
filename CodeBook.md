Data Summary
---
"tidyData.txt" is the output tidy dataset. It contains a header line, with another 180 rows and 68 columns. 
Each row represents an observation of the same combination of activity and volunter id.
Each colunmn represents a variable. 

Variables
---
* activity: factor with six levels, "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
* person_id: factor with thirty levels, represent thirty different volunteer
* another 66 variables: numeric values, the mean and standard deviation for each of following 33 measurements. For details, please refer to "features_info.txt"
	* tBodyAcc-XYZ
	* tGravityAcc-XYZ
	* tBodyAccJerk-XYZ
	* tBodyGyro-XYZ
	* tBodyGyroJerk-XYZ
	* tBodyAccMag
	* tGravityAccMag
	* tBodyAccJerkMag
	* tBodyGyroMag
	* tBodyGyroJerkMag
	* fBodyAcc-XYZ
	* fBodyAccJerk-XYZ
	* fBodyGyro-XYZ
	* fBodyAccMag
	* fBodyAccJerkMag
	* fBodyGyroMag
	* fBodyGyroJerkMag 

Transformation Steps
---
This is basically the code explanations. 

1. Load data, including train & test dataset, a file of activity name and feature names.
2. Step-1: Merge train and test feature dataset, this is just a row combine. *Please notice here I did not add a lable column*.
3. Step-2: Add the colunm names, as a representation of feature names. Select the the mean and standard deviation for each measurement, using grepl. *Here I extract the feature names we need, namely "measurements"*
4. Step-3: Uses descriptive activity names to name the activities in the data set. Here I use a dummy way as I have limited time and can't figure out a nicer&simpler method. I use activity.name as a map from integer 1-6 to an activity name. I also add two factor columns -- activity and person_id.
5. Step-4: Appropriately labels the data set with descriptive variable names. This is done before.
6. Step-5: First melt the dataset using id = c("activity","person_id") with all the remaining variables the "measure.vars". Then, for each combination of activity and person_id, I calculate the mean of each remaing variable's value, and get the output tidy dataset.
7. Write data to "tidyData.txt"





