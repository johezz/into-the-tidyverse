#load libraries
library(here)
library(readr)
library(dplyr)

#join
urbanicity <- here("Documents", "Github", "into-the-tidyverse", "Data", "incarceration_trends.csv")

#Exercises
incarceration <- here("Documents", "Github", "into-the-tidyverse", "Data", "incarceration_trends.csv") %>%
                        readr::read_csv()
glimpse(incarceration)

#keep only 2018 records
incarceration <- incarceration %>% filter(year == "2018")

#keep only relevant cols
incarceration <- incarceration %>% dplyr::select(fips, total_pop, total_jail_pop)

#create a common base of comparison
incarceration <- incarceration %>% mutate(prop_jail = total_jail_pop/total_pop)

#political leanings
elections <- here("Documents", "Github", "into-the-tidyverse", "Data", "countypres_2000-2016.csv") %>%
  read_csv()
glimpse(elections)

ca_jail <- incarceration %>%
  left_join(elections)
