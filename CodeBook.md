CodeBook
================
Johnson Lim
March 6th, 2017

Introduction
------------

The 'run\_analysis.R' code performs the five (5) steps as per required in the project description. The following explains the list of variables defined in the code, as well as the chronology of how the the code performs its operation.

List of Variables
-----------------

-   During raw data reading
    -   **x\_train** is the training data
    -   **y\_train** is the training labels
    -   **subject\_train** is the training subject
    -   **x\_test** is the test data
    -   **y\_test** is the test labels
    -   **subject\_test** is the test subject
    -   **features** contains a list of feature labels/names for data
    -   **activities** contains the names for activity labels
-   During data merging operation
    -   **x\_data** is the merged data
    -   **y\_data** is the merged labels
    -   **subject\_data** is the merged subject
    -   **mean\_and\_sd\_features** serves as an indexing vector to extract the desired data that contains mean and standard deviation for each measurement
    -   **all\_data** is the merged dataset that consists of **x\_data**,**y\_data** and **subject\_data** combined.
    -   **averaged\_data** is the second dataset created based on the column average of each variable, sorted according to each combination of subject and activity

Code Explained
--------------

The code is explicitly divided into five(5) sections.The detailed explanation for each section are as explained below:

1.  First of all, the code reads all the training and test data into the corresponding variables, and these raw data are merged using the **rbind()** function.
2.  By using a regular expression, columns that end with either *mean()* or *std()* in their variable names are identified and being indexed into a specific variable named **mean\_and\_sd\_features**. This vector function as an indexing label to extract the desired measurement data as well as to label the feature names of the extracted dataset.
3.  The **activities** variable reads the activity ID and names. Next, the activity IDs in the merged dataset are substituted with activity names.
4.  Data set are labelled with descriptive variable names acoordingly. A merged overall data set in orders of subject, activity and data is produced.
5.  A function is defined to calculate the column average for all the columns except the first two (which contains nominal values of the subject and types of activity). **ddply** function is then applied to generate a dataset with all the average measures according to each subject and activity type. The output is later written as a text file named **averaged\_data.txt**.
