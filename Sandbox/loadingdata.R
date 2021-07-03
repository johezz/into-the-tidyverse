#load libraries
library(readr)
library(tibble)
library(here)
library(tictoc)

#read in data (base_r)
tic()
base_read <- here("Documents", "Github", "into-the-tidyverse", "Data", "PVD_2020_Property_Tax_Roll.csv") %>%
  read.csv()
toc()
str(base_read)
glimpse(base_read)

#read in data (tidyr)
tidy_read <- here("Documents", "Github", "into-the-tidyverse", "Data", "PVD_2020_Property_Tax_Roll.csv") %>%
  read_csv()
str(tidy_read)

  #play around with reading in a variable in a specific datatype
  tidy_read_mod <- here("Documents", "Github", "into-the-tidyverse", "Data", "PVD_2020_Property_Tax_Roll.csv") %>%
    read_csv(col_types = cols(ZIP_POSTAL = col_character(),
                              plat = col_character()))
  str(tidy_read_mod)  

#Exercise 1
is.character(tidy_read_mod$plat)
is.character(tidy_read_mod$ZIP_POSTAL)

#Exercise 2
covid_usa <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv")

#Exercise 3
bank_branches <- here("Documents", "Github", "into-the-tidyverse", "Data", "BankBranchesData.txt") %>%
  read_tsv()
