==================================================================
Human Activity Recognition Using Smartphones Dataset - tidy dataset

==================================================================

The script executes cleaning of initial data sets. It follows this sequence:

1. All data were read from the files and assigned to corresponding variables (see the description of the variables below)
2. Each set was mutated to add id with labels, and is merged with activity labels, which results in a a set, containing both activity id and activity labels
3. Training and test sets were merged into one megaset, that contains data across all subjects, activities and features
4. Set was processed to look tidy: 
	a) only features containing standard deviation or mean were selected
	b) set was grouped by activity and subject
	c) mean was calculated by groups, using summarise_each function
	d) melt function helped bring data into a tidy set, where each observation is on a 	separate row
	e) feature values are rounded to 4 decimal points

==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket 


testSet - test set
trainSet - training set
testLabel - test labels
trainLabel - training labels
features - all features
activLab - activity labels
subjTest - subjects who performed the activity for test set
subjTrain - subjects who performed the activity for training set
observ - features with parentheses removed from the name
set - megaset, which is training and test set combined


Notes: 
======
- Features are normalized and bounded within [-1,1] and rounded to 4 decimal points

