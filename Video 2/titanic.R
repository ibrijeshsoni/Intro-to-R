# Video 2
library(ggplot2)
rm(list = ls())
setwd("D:\\R\\Intro to R/Video 2/")
# What's the distribution of females to males across train & test?
table(data.combine$Sex)

# Visualize the 3-way relationship of sex, pclass, and survival, compare to analysis of title
ggplot(data.combine[1:891,], aes(x = Sex, fill = Survived)) +
  stat_count(width = 0.5) +
  facet_wrap(~Pclass) + 
  ggtitle("Pclass") +
  xlab("Sex") +
  ylab("Total Count") +
  labs(fill = "Survived")

# OK, age and sex seem pretty important as derived from analysis of title, let's take a closer 
# look at the distibutions of age over entire data set
summary(data.combine$Age)
summary(train[1:891,"Age"])

# Just to be thorough, take a look at survival rates broken out by sex, pclass, and age
ggplot(data.combine[1:891,], aes(x = Age, fill = Survived)) +
  facet_wrap(~Sex + Pclass) +
  geom_histogram(binwidth = 10) +
  xlab("Age") +
  ylab("Total Count")

# Validate that "Master." is a good proxy for male children
boys <- data.combine[which(data.combine$title == "Master."),]
summary(boys$Age)

# We know that "Miss." is more complicated, let's examine further
misses <- data.combine[which(data.combine$title == "Miss."),]
summary(misses$Age)

# misses Plot
ggplot(misses[misses$Survived != "None",], aes(x = Age, fill = Survived)) +
  facet_wrap(~Pclass) +
  geom_histogram(binwidth = 5) +
  ggtitle("Age for 'Miss.' by Pclass") + 
  xlab("Age") +
  ylab("Total Count")

# Boys Plot
ggplot(boys[boys$Survived != "None",], aes(x = Age, fill = Survived)) +
  facet_wrap(~Pclass) +
  geom_histogram(binwidth = 5) +
  ggtitle("Age for 'Master.' by Pclass") + 
  xlab("Age") +
  ylab("Total Count")

# OK, appears female children may have different survival rate, 
# could be a candidate for feature engineering later
misses.alone <- misses[which(misses$SibSp == 0 & misses$Parch == 0),]
summary(misses.alone$Age)
length(which(misses.alone$Age <= 14.5))


# Move on to the sibsp variable, summarize the variable
summary(data.combine$SibSp)

# Can we treat as a factor?
length(unique(data.combine$SibSp))

data.combine$SibSp <- as.factor(data.combine$SibSp)

# We believe title is predictive. Visualize survival reates by sibsp, pclass, and title
ggplot(data.combine[1:891,], aes(x = SibSp, fill = Survived)) +
  stat_count(width = 1) +
  facet_wrap(~Pclass + title) + 
  ggtitle("Pclass, Title") +
  xlab("SibSp") +
  ylab("Total Count") +
  ylim(0,300) +
  labs(fill = "Survived")

# Treat the parch vaiable as a factor and visualize
data.combine$Parch <- as.factor(data.combine$Parch)
ggplot(data.combine[1:891,], aes(x = Parch, fill = Survived)) +
  stat_count(width = 1) +
  facet_wrap(~Pclass + title) + 
  ggtitle("Pclass, Title") +
  xlab("ParCh") +
  ylab("Total Count") +
  ylim(0,300) +
  labs(fill = "Survived")

# Let's try some feature engineering. What about creating a family size feature?
temp.sibsp <- c(train$SibSp, test$SibSp)
temp.parch <- c(train$Parch, test$Parch)
data.combine$family.size <- as.factor(temp.sibsp + temp.parch + 1)


# Visualize it to see if it is predictive
ggplot(data.combine[1:891,], aes(x = family.size, fill = Survived)) +
  stat_count(width = 1) +
  facet_wrap(~Pclass + title) + 
  ggtitle("Pclass, Title") +
  xlab("family.size") +
  ylab("Total Count") +
  ylim(0,300) +
  labs(fill = "Survived")