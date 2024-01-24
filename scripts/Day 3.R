# Day 3: Manipulating, analyzing and exporting data with tidyverse

library(tidyverse)
setwd("C:/Users/k667l/Desktop/EMBL_course")
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




