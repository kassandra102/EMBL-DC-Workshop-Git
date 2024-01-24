# Day 3: Manipulating, analyzing and exporting data with tidyverse

library(tidyverse)
setwd("C:/Users/k667l/Desktop/EMBL_course/EMBL-DC-Workshop-Git/")
surveys <-read_csv("data_raw/portal_data_joined.csv") 
str(surveys)
View(surveys)

# Select columns in two different ways
select(surveys, plot_id, species_id, weight)
select(surveys, -record_id, -species_id)     # leave out columns

# Filter data
filter(surveys, year == 1995, sex == "M")  
surveys2 <- filter(surveys, weight < 5)
suverys_sml <-  select(surveys2, species_id, sex, weight)

# Filter data using nested functions (internal functions first!)
suverys_sml2 <-select(filter(surveys, weight<5), species_id, sex, weight) 

# To much nesting is not easy so use this: %>%   (Ctrl + Shift + M), percented percent / pipeline symbol
surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

# Challenge 1

surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight)

# Mutate what you see: Conversion of interest will be introduced
surveys %>% 
  mutate(weight_kg = weight/1000) %>%   # == is logical operator giving T or F
  View()

surveys %>% 
  mutate(weight_kg = weight/1000, weight_lb = weight_kg * 2.2) %>% 
  View()   # alternatively use head to see the first 6 rows

surveys %>% 
  filter(!is.na(weight)) %>%    # filter out rows which do not have value for weight
  mutate(weight_kg = weight/1000, weight_lb = weight_kg * 2.2) %>% 
  View()   # alternatively use head to see the first 6 rows 

# Calculate average weights: Split-apply-combine paradigm
surveys %>% 
  filter(!is.na(sex)) %>% # NA's are filtered out
  group_by(sex) %>% 
  summarise(mean_weight = mean(weight, na.rm = T))

surveys %>% 
  filter(!is.na(weight)) %>% # NA's are filtered out
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = T)) %>% 
  tail()

surveys %>% 
  filter(!is.na(weight)) %>% # NA's are filtered out
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = T)) %>% 
  print(n = 15) #print 15 lines

surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% # NA's are filtered out for multiple columns
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = T)) %>% 
  print(n = 15) #print 15 lines

#Calculate the minimum weight
surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% # NA's are filtered out for multiple columns
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = T), min_weight = min(weight)) %>% 
  arrange(min_weight)  # Order column: automatically ascending order

#Calculate the minimum weight
surveys %>% 
  filter(!is.na(weight), !is.na(sex)) %>% # NA's are filtered out for multiple columns
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight), min_weight = min(weight)) %>% # No NA removal needed because we did it at the top
  arrange(desc(min_weight))  # Order column: descending order





