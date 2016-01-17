Below mentioned are the functions used in the script for analysis:
==================================================================
- **readfile(filepath)** : returns the contents of the file provided in the file path
- **data_cleanup(data)** : used to clean up the files 'test_set.txt', 'train_set.txt' and the Inertial Signals text files provided for test/train datasets. This function returns a data frame.
- **convert_dfdata_numeric(dataframe)** : converts the individual columns of a data frame to numeric data type as the data read from the initial data sets are of the character data type. This function returns a data frame.
- **create_var_name(readingscount,string)** : creates variable names for Inertial Signals text files provided for test/train datasets. Returns a character vector.
- **process_inertial_data(filepath,var_name)** : carries out a set of operations in a sequence to return data frames holds the data from inertial signal text files.
- **get_smartphone_dataset(dataset)** : takes the parameter as either train or test. Based on this input the function parses all the intial raw dataset and returns a single data frame holding the identifiers, mean feature vector measurments, standard deviation feature vector measurments and 128 readings each for gyroscope, total accelerometer and body accelerometer signals.

Output of the run_analysis.R script:
====================================
- writes a text file into the working directory with 180 records holding the average values of their multiple iterations.

Feature Selection
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (starting with "Time_") were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (Time_BodyAcc-XYZ and Time_GravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (Time_BodyAccJerk-XYZ and Time_BodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (Time_BodyAccMag, Time_GravityAccMag, Time_BodyAccJerkMag, Time_BodyGyroMag, Time_BodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing Freq_BodyAcc-XYZ, Freq_BodyAccJerk-XYZ, Freq_BodyGyro-XYZ, Freq_BodyAccJerkMag, Freq_BodyGyroMag, Freq_BodyGyroJerkMag. (Note the 'Freq_' is to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- Time_BodyAcc-XYZ
- Time_GravityAcc-XYZ
- Time_BodyAccJerk-XYZ
- Time_BodyGyro-XYZ
- Time_BodyGyroJerk-XYZ
- Time_BodyAccMag
- Time_GravityAccMag
- Time_BodyAccJerkMag
- Time_BodyGyroMag
- Time_BodyGyroJerkMag
- Freq_BodyAcc-XYZ
- Freq_BodyAccJerk-XYZ
- Freq_BodyGyro-XYZ
- Freq_BodyAccMag
- Freq_BodyAccJerkMag
- Freq_BodyGyroMag
- Freq_BodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- **mean()**: Mean value
- **std()**: Standard deviation
- mad(): Median absolute deviation (OUT OF SCOPE for this analysis)  
- max(): Largest value in array (OUT OF SCOPE for this analysis)
- min(): Smallest value in array (OUT OF SCOPE for this analysis)
- sma(): Signal magnitude area (OUT OF SCOPE for this analysis)
- energy(): Energy measure. Sum of the squares divided by the number of values.  (OUT OF SCOPE for this analysis)
- iqr(): Interquartile range  (OUT OF SCOPE for this analysis)
- entropy(): Signal entropy (OUT OF SCOPE for this analysis)
- arCoeff(): Autorregresion coefficients with Burg order equal to 4 (OUT OF SCOPE for this analysis)
- correlation(): correlation coefficient between two signals (OUT OF SCOPE for this analysis)
- maxInds(): index of the frequency component with largest magnitude (OUT OF SCOPE for this analysis)
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency (OUT OF SCOPE for this analysis)
- skewness(): skewness of the frequency domain signal  (OUT OF SCOPE for this analysis)
- kurtosis(): kurtosis of the frequency domain signal  (OUT OF SCOPE for this analysis)
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window. (OUT OF SCOPE for this analysis)
- angle(): Angle between to vectors. (OUT OF SCOPE for this analysis)

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:  (OUT OF SCOPE for this analysis)

- gravityMean
- Time_BodyAccMean
- Time_BodyAccJerkMean
- Time_BodyGyroMean
- Time_BodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt' provided in the initial data set

Inertial Signals Data:
======================
The Indertial signals contains 128 readings per window. They have been named as mentioned below during the analysis:

**Gyroscope readings**: Units in radians/second
- Gyro_X_Reading_1,Gyro_X_Reading_2,....,Gyro_X_Reading_128
- Gyro_Y_Reading_1,Gyro_Y_Reading_2,....,Gyro_Y_Reading_128
- Gyro_Z_Reading_1,Gyro_Z_Reading_2,....,Gyro_Z_Reading_128

**Total Acceleration readings**: Units in standard gravity units 'g'
- TotAcc_X_Reading_1,TotAcc_X_Reading_2,.....,TotAcc_X_Reading_128
- TotAcc_Y_Reading_1,TotAcc_Y_Reading_2,.....,TotAcc_Y_Reading_128
- TotAcc_Z_Reading_1,TotAcc_Z_Reading_2,.....,TotAcc_Z_Reading_128

**Body Acceleration readings**: Units in standard gravity units 'g'
- BodyAcc_X_Reading_1,BodyAcc_X_Reading_2,.....,BodyAcc_X_Reading_128
- BodyAcc_Y_Reading_1,BodyAcc_Y_Reading_2,.....,BodyAcc_Y_Reading_128
- BodyAcc_Z_Reading_1,BodyAcc_Z_Reading_2,.....,BodyAcc_Z_Reading_128
