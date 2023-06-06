# So saw this video of Alex the Analyst where he was cleaning this Nashville Housing 
#data-set with SQL so i decided t clean the same data-set using R programming:

#First loading all the libraries

library("tidyverse")
library("lubridate")
library("ggplot2")
library("skimr")
library("readr")
library("janitor")
library("dplyr")
library("here")
install.packages("lubridate")

# import csv file
Data<- read.csv("NashvilleData.csv")

View(Data)

Data_New <- Data

View(Data_New)

# convert Datetime format from 	May 9, 2014 to mdy

Data_New$SaleDate <- mdy(Data_New$SaleDate)

options(max.print = 805025)

head(Data_New)

skim_without_charts(Data_New)

str(Data_New)

# Converting the 'N' value to 'No' and the 'Y' values to 'Yes'

Data_New %>% 
  select("SoldAsVacant")

 Data_New$SoldAsVacant[Data_New$SoldAsVacant == 'N']
 Data_New$SoldAsVacant[Data_New$SoldAsVacant == 'N'] <- 'No'
 Data_New$SoldAsVacant[Data_New$SoldAsVacant == 'No']
 Data_New$SoldAsVacant[Data_New$SoldAsVacant == 'Y']
 Data_New$SoldAsVacant[Data_New$SoldAsVacant == 'Y']<- 'Yes'
 Data_New$SoldAsVacant[Data_New$SoldAsVacant == 'Yes']


View(Data_New)



#installing package for the split function

install.packages("stringr")
library(stringr)

# Code for splitting PropertyAddress syntax from one column to multiple columns

Data_New %>% 
  select(PropertyAddress)

# Code for splitting PropertyAddress into Address and City

str_split_fixed(Data_New$PropertyAddress, ", ", 2)

Data_New [c('propertySplitAddress','propertySplitCity')] <- str_split_fixed(Data_New$PropertyAddress, ", ", 2)


# Code for splitting OwnerAddress into Address, City and State 
 
 str_split_fixed(Data_New$OwnerAddress, ", ",2)
 
 Data_New [c('OwnerSplitAddress22','OwnerSplitCity21')] <- str_split_fixed(Data_New$OwnerAddress, ", ",2)
 
 str_split_fixed(Data_New$OwnerSplitCity21, ", ",2)
 Data_New [c('OwnerSplitCity1','OwnerSplitState')] <- str_split_fixed(Data_New$OwnerSplitCity21, ", ",2)
 
 str_split_fixed(Data_New$OwnerAddress, ", ",2)
 
 Data_New [c('OwnerSplitAddress2','OwnerSplitCity2')] <- str_split_fixed(Data_New$OwnerAddress, ", ",2)
 
View(Data_New)


 #searching for NA's in Dataframe

Data_New1 <- Data_New
 
View(Data_New1)

str(Data_New1) 


is.na(Data_New1)
 sum(is.na(Data_New1))


  # To view and remove duplicates
 
 duplicated(Data_New1)
 
 which(duplicated(Data_New1))
 
 Data_New1[Data_New1$UniqueID > 1,]
 
 Data_New1 <- unique(Data_New1)
 
 
 #To delete unwanted columns
 Data_New1 <- Data_New1[, !(names(Data_New1) %in% c('OwnerSplitState2'))]
 
 
 #Re-frame data set
 
 NashvilleHousingData  <- Data_New1
 
 head(NashvilleHousingData )
 
View(NashvilleHousingData ) 

NashvilleHousing <- NashvilleHousingData %>% 
  select(UniqueID, ParcelID, SaleDate, SalePrice, 
         SoldAsVacant, OwnerName,propertySplitAddress, propertySplitCity, 
         OwnerSplitAddress, OwnerSplitCity, OwnerSplitState) %>% View()

View(NashvilleHousing)
