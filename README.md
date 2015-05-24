##install and load 'tidyr' and 'dplyr' library to run the script run_analysis.R
##then script run_analysis.R 
##it reads in all the data from sub folders test and train
##combines both the data into one single data frame
##reads activity names from activity _label folder in main folder 
##reads varialbe names from 'features' file
##extracts the required column names mean and standard deviation measurements
##cleans the variable names makes it descriptive
##extracts and names the required columns from combined data
##Applies the tidy data principles and functoins from dplyr package to calculate average of each varable for each subject and each activity
##Dimension of the new tidy data is 180 rows and 68 columns
##writes the data into a table 'tidydata.txt'
##to be read usind read.table using header=TRUE