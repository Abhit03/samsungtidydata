#### install and load 'tidyr' and 'dplyr' library to run the script run_analysis.R
#### Script run_analysis.R (It reads in all the data from sub folders test and train and combines both the data into one single data frame)
#### Reads activity names from activity _label folder in main folder. It reads varialbe names from 'features' file
#### Extracts the required column names mean and standard deviation measurements
#### Cleans the variable names makes it descriptive
#### Extracts and names the required columns from combined data
#### Applies the tidy data principles and functoins from dplyr package to calculate average of each varable for each subject and each activity (Dimension of the new tidy data is 180 rows and 68 columns)
#### Writes the data into a table 'tidydata.txt' (to be read usind read.table using header=TRUE)
