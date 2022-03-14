## DATA 608 module 3

library(tidyverse)

## Get data from url 
raw.data <- read.csv('https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module3/data/cleaned-cdc-mortality-1999-2010-2.csv', 
                     stringsAsFactors = FALSE)

## Question 1 dataset
q1.sub <- raw.data %>%
  filter(Year == 2010) %>%
  select(State, Crude.Rate, ICD.Chapter) %>%
  rename('state' = 'State', 'rate' = 'Crude.Rate', 'cause' = 'ICD.Chapter') %>%
  arrange(rate)

## Question 2 dataset
q2.sub <- raw.data %>%
  group_by(ICD.Chapter, Year) %>%
  mutate(Nat.Avg = round((sum(Deaths) / sum(Population)) * 100000, 1)) %>%
  select(ICD.Chapter, State, Year, Crude.Rate, Nat.Avg) %>%
  rename('state' = 'State', 'cause' = 'ICD.Chapter', 'State.Avg' = 'Crude.Rate') %>%
  ungroup()

## References
# https://cran.r-project.org/web/packages/googleVis/googleVis.pdf
# https://cran.r-project.org/web/packages/googleVis/vignettes/googleVis_examples.html