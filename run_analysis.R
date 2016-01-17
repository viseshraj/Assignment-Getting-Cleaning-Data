#Read file provided in path and return its contents
readfile <- function(filepath) {
  connection <- file(filepath)
  content <- readLines(connection)
  close(connection)
  return(content)
}

#Function to 1. Split data from text data files with " " as seperators, 2. Filter out valid data and 
#3. Load the data from large list into a DF
data_cleanup <- function(data) {
  split <- strsplit(data," ")
  filtered <- lapply(split, function(x) x[grepl(".+",x)])
  dataframe <- data.frame(filtered)
  dataframe <- data.frame(t(dataframe))
  rownames(dataframe) <- c(1:nrow(dataframe))
  dataframe
}

#Convert data in every column of data frame to numeric
convert_dfdata_numeric <- function(dataframe) {
  dataframe_num_columns <- data.frame(lapply(
    colnames(dataframe), function(x) {
      dataframe[,x] <- as.numeric(as.character(dataframe[,x]))
    }
  ))
  dataframe_num_columns
}

#Create continuous variable names
create_var_name <- function(readingscount,string) {
  readings <- as.character(c(1:readingscount))
  var_name <- lapply(readings,function(x) paste(string,"_Reading_",x,sep = ""))
  as.character(var_name)
}

#Process Inertial Signals files
process_inertial_data <- function(filepath,var_name) {
  content <- readfile(filepath)
  dataframe <- data_cleanup(content)
  dataframe_numeric <- convert_dfdata_numeric(dataframe)
  colnames(dataframe_numeric) <- create_var_name(ncol(dataframe_numeric),var_name)
  dataframe_numeric
}

get_smartphone_dataset <- function(dataset) {
  if(dataset == "test") {
    path_subject <- "./test/subject_test.txt"
    path_labels <- "./test/y_test.txt"
    path_activity_labels <- "./activity_labels.txt"
    path_set <- "./test/X_test.txt"
    path_features <- "./features.txt"
    path_gyro_x <- "./test/Inertial Signals/body_gyro_x_test.txt"
    path_gyro_y <- "./test/Inertial Signals/body_gyro_y_test.txt"
    path_gyro_z <- "./test/Inertial Signals/body_gyro_z_test.txt"
    path_totacc_x <- "./test/Inertial Signals/total_acc_x_test.txt"
    path_totacc_y <- "./test/Inertial Signals/total_acc_y_test.txt"
    path_totacc_z <- "./test/Inertial Signals/total_acc_z_test.txt"
    path_bodacc_x <- "./test/Inertial Signals/body_acc_x_test.txt"
    path_bodacc_y <- "./test/Inertial Signals/body_acc_x_test.txt"
    path_bodacc_z <- "./test/Inertial Signals/body_acc_x_test.txt"
  }else if(dataset == "train") {
    path_subject <- "./train/subject_train.txt"
    path_labels <- "./train/y_train.txt"
    path_activity_labels <- "./activity_labels.txt"
    path_set <- "./train/X_train.txt"
    path_features <- "./features.txt"
    path_gyro_x <- "./train/Inertial Signals/body_gyro_x_train.txt"
    path_gyro_y <- "./train/Inertial Signals/body_gyro_y_train.txt"
    path_gyro_z <- "./train/Inertial Signals/body_gyro_z_train.txt"
    path_totacc_x <- "./train/Inertial Signals/total_acc_x_train.txt"
    path_totacc_y <- "./train/Inertial Signals/total_acc_y_train.txt"
    path_totacc_z <- "./train/Inertial Signals/total_acc_z_train.txt"
    path_bodacc_x <- "./train/Inertial Signals/body_acc_x_train.txt"
    path_bodacc_y <- "./train/Inertial Signals/body_acc_x_train.txt"
    path_bodacc_z <- "./train/Inertial Signals/body_acc_x_train.txt"
  }else {
    return("Dataset can either be train or test")
  }
  subject_test <- readfile(path_subject)
  test_labels <- readfile(path_labels)
  activity_labels <- readfile(path_activity_labels)
  
  activity_label_mapping <- lapply(
    test_labels,function(x) {
      substr(
        grep(paste("^",x,sep = ""),activity_labels,value=TRUE)
        ,3,nchar(grep(paste("^",x,sep = ""),activity_labels,value=TRUE))
      )
    }
  )
  
  data_frame_test <- data.frame(volunteer_identifier = subject_test,
                                activity_identifier = test_labels,
                                activity_label=as.character(activity_label_mapping))
  
  #Data Frame for Feature Variable Data Set
  test_set <- readfile(path_set)
  df_feat_var <- data_cleanup(test_set)
  features <- readfile(path_features)
  features_clean <- gsub("^[0-9]+ ","",features)
  colnames(df_feat_var) <- features_clean
  
  #pick out data for mean() and std() on measurments alone
  df_feat_var_mean_std <- df_feat_var[,c(grep("mean\\(\\)|std\\(\\)",features_clean))]
  
  #Formatize feature names
  unformatted_colnames <- colnames(df_feat_var_mean_std)
  formatted_colnames <- gsub("\\(\\)","",unformatted_colnames)
  formatted_colnames <- gsub("^t","Time_",formatted_colnames)
  formatted_colnames <- gsub("^f","Freq_",formatted_colnames)
  formatted_colnames <- gsub("BodyBody","Body",formatted_colnames)
  formatted_colnames <- gsub("-","_",formatted_colnames)
  
  df_feat_var_mean_std <- convert_dfdata_numeric(df_feat_var_mean_std)
  colnames(df_feat_var_mean_std) <- formatted_colnames
  data_frame_test_conso <- cbind(data_frame_test,df_feat_var_mean_std)
  
  
  #Retrieve Triaxial Angular velocity from gyroscope data
  df_gyro_x_test <- process_inertial_data(path_gyro_x,"Gyro_X")
  df_gyro_y_test <- process_inertial_data(path_gyro_y,"Gyro_Y")
  df_gyro_z_test <- process_inertial_data(path_gyro_z,"Gyro_Z")
  
  #Retrieve Triaxial Total Acceleration data
  df_tot_acc_x_test <- process_inertial_data(path_totacc_x,"TotAcc_X")
  df_tot_acc_y_test <- process_inertial_data(path_totacc_y,"TotAcc_Y")
  df_tot_acc_z_test <- process_inertial_data(path_totacc_z,"TotAcc_Z")
  
  #Retrieve Triaxial Body Acceleration data
  df_bod_acc_x_test <- process_inertial_data(path_bodacc_x,"BodyAcc_X")
  df_bod_acc_y_test <- process_inertial_data(path_bodacc_y,"BodyAcc_Y")
  df_bod_acc_z_test <- process_inertial_data(path_bodacc_z,"BodyAcc_Z")
  
  #Consolidating data to one Data Frame
  df_test <- cbind.data.frame(data_frame_test_conso,
                              df_gyro_x_test,
                              df_gyro_y_test,
                              df_gyro_z_test,
                              df_tot_acc_x_test,
                              df_tot_acc_y_test,
                              df_tot_acc_z_test,
                              df_bod_acc_x_test,
                              df_bod_acc_y_test,
                              df_bod_acc_z_test)
  df_test
}

dataframe_test <- get_smartphone_dataset("test")
dataframe_train <- get_smartphone_dataset("train")

df_smartphone_dataset <- rbind.data.frame(dataframe_test,dataframe_train)

#Average of each variables for the subject and activity
vol_act_split <- split(df_smartphone_dataset,
               interaction(df_smartphone_dataset$volunteer_identifier,df_smartphone_dataset$activity_identifier))

list_means <- lapply(vol_act_split, function(x) apply(x[,4:1221],2,mean))
df_avg_vol_act <- data.frame(list_means)
df_avg_vol_act <- data.frame(t(df_avg_vol_act))

#Include volunteer identifier, activity identifier and activity label
rownames_avg <- rownames(df_avg_vol_act)
rownames_avg <- gsub("X","",rownames_avg)
rownames_split <- strsplit(rownames_avg,"\\.")
df_identifiers <- data.frame(rownames_split)
df_identifiers <- data.frame(t(df_identifiers))
df_identifiers[,1] <- as.numeric(as.character(df_identifiers[,1]))
df_identifiers[,2] <- as.numeric(as.character(df_identifiers[,2]))
rownames(df_identifiers) <- 1:180
colnames(df_identifiers) <- c("volunteer_identifier","activity_identifier")

#Retrieve activity lable mapping
activity_labels <- readfile("./activity_labels.txt")
activity_label_mapping <- lapply(
  df_identifiers[,2],function(x) {
    substr(
      grep(paste("^",x,sep = ""),activity_labels,value=TRUE)
      ,3,nchar(grep(paste("^",x,sep = ""),activity_labels,value=TRUE))
    )
  }
)
df_identifiers <- cbind.data.frame(df_identifiers,activity_label = as.character(activity_label_mapping))

#Consolidate data frames to hold identifier columns and variables data in one data frame
df_smartphone_dataset_avg <- cbind.data.frame(df_identifiers,df_avg_vol_act)
df_smartphone_dataset_avg <- df_smartphone_dataset_avg[order(df_smartphone_dataset_avg[,1]),]

#Write file to working dir
write.table(df_smartphone_dataset_avg,"smartphone_dataset_avg_tidy.txt",row.names = FALSE)