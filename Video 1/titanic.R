rm(list = ls())
setwd("D:\\R\\Intro to R/Video 1/")
# VARIABLE DESCRIPTIONS:
#   survival        Survival
# (0 = No; 1 = Yes)
# pclass          Passenger Class
# (1 = 1st; 2 = 2nd; 3 = 3rd)
# name            Name
# sex             Sex
# age             Age
# sibsp           Number of Siblings/Spouses Aboard
# parch           Number of Parents/Children Aboard
# ticket          Ticket Number
# fare            Passenger Fare
# cabin           Cabin
# embarked        Port of Embarkation
# (C = Cherbourg; Q = Queenstown; S = Southampton)
# 
# SPECIAL NOTES:
#   Pclass is a proxy for socio-economic status (SES)
# 1st ~ Upper; 2nd ~ Middle; 3rd ~ Lower
# 
# Age is in Years; Fractional if Age less than One (1)
# If the Age is Estimated, it is in the form xx.5
# 
# With respect to the family relation variables (i.e. sibsp and parch)
# some relations were ignored.  The following are the definitions used
# for sibsp and parch.
# 
# Sibling:  Brother, Sister, Stepbrother, or Stepsister of Passenger Aboard Titanic
# Spouse:   Husband or Wife of Passenger Aboard Titanic (Mistresses and Fiances Ignored)
# Parent:   Mother or Father of Passenger Aboard Titanic
# Child:    Son, Daughter, Stepson, or Stepdaughter of Passenger Aboard Titanic
# 
# Other family relatives excluded from this study include cousins,
# nephews/nieces, aunts/uncles, and in-laws.  Some children travelled
# only with a nanny, therefore parch=0 for them.  As well, some
# travelled with very close friends or neighbors in a village, however,
# the definitions do not support such relations.

train <- read.csv(file = "train.csv", header = TRUE, stringsAsFactors = TRUE)
test <- read.csv(file = "test.csv", header = TRUE, stringsAsFactors = TRUE)

# Note :- Created the survived as List of All the data in test data frame
survived <- rep("None", nrow(test))

# Append the Survived Column as there is new column PassengerId is there on first 
# column in train and test data frame.
test <- as.data.frame(append(test, list(Survived = survived), after = 1))

data.combine <- rbind(train, test)

str(data.combine)

data.combine$Survived <- factor(data.combine$Survived)
data.combine$Pclass <- as.factor(data.combine$Pclass)
