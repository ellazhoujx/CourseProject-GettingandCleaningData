# Code Book
## Variables
  * train_x: Data frame read from X_train.txt
  * train_y: Data frame read from y_train.txt
  * test_x: Data frame read from X_test.txt
  * test_y: Data frame read from y_test.txt
  * subject_train: Data frame read from subject_train.txt
  * subject_test: Data frame read from subject_test.txt
  * activity_labels: Data frame read from activity_labels.txt
  * features: Data frame read from features.txt
  * mean_std: Condition to extract only the measurements on the mean and standard deviation
  * dataset_y: Merged dataset from train_y and test_y
  * subject: Merged dataset from subject_train and subject_test
  * dataset: Complete dataset contains train and test with subjectID and activity labels
  * melt: melted data set
  * tidydata: reshaped data from melted data set, the final tidy data
