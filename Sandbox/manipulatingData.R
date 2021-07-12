#load libraries
library(here)
library(readr)
library(dplyr)

#read data
covid <- here("Documents", "Github", "into-the-tidyverse", "Data", "time_series_covid19_confirmed_US.csv") %>%
  read_csv()

covid %>% slice()

#filter
covid %>%
  filter(Province_State == "California") %>%
  select(fips = FIPS, county = Admin2, `9/18/20`:`9/24/20`)

#select
covid %>%
  filter(Province_State == "California") %>%
  filter(Admin2 == "Yolo") %>%
  select(fips = FIPS, county = Admin2, `9/18/20`:`9/24/20`)

#mutate
covid %>%
  filter(Province_State == "California") %>%
  slice(1:20) %>%
  select(fips = FIPS, county = Admin2, latent_cases = `9/24/20`) %>%
  mutate(latest_cases_log = log(latent_cases))
  #add a new col
covid %>%
  filter(Province_State == "California") %>%
  slice(1:20) %>%
  select(fips = FIPS, county = Admin2, latent_cases = `9/24/20`) %>%
  mutate(state = "California")
  #across columns
covid %>%
  select(state = Province_State, county = Admin2, `9/18/20`:`9/24/20`) %>%
  filter(state == "California") %>%
  slice(1:10) %>%
  mutate(across(.cols = `9/18/20`:`9/24/20`,
                .fns = ~log(.x+1)))

#summarise
covid %>%
  filter(Province_State == "California") %>%
  select(fips = FIPS, county = Admin2, `9/18/20`:`9/24/20`) %>%
  summarise(across(.cols = `9/18/20`:`9/24/20`,
                   .fns = sum))
  
#group_by
covid %>%
  rename(state = Province_State, latest_cases = `9/24/20`) %>%
  group_by(state) %>%
  summarise(n_cases = sum(latest_cases)) %>%
  ungroup() %>%
  arrange(desc(n_cases))

#join
urbanicity <- here("Documents", "Github", "into-the-tidyverse", "Data", "NCHSURCodes2013.xlsx") %>%
  readxl::read_excel(na = c('.')) %>%
  janitor::clean_names() %>%
  select(fips_code, urbanicity = x2013_code, population = county_2012_pop)

elections <- here("Documents", "Github", "into-the-tidyverse", "Data", "countypres_2000-2016.csv") %>%
  read_csv() %>%
  filter(year == 2016) %>%
  filter(party %in% c("democrat", "republican")) %>%
  group_by(state, county, FIPS) %>%
  mutate(lean_republican = candidatevotes / first(candidatevotes)) %>%
  ungroup() %>%
  filter(party == "republican") %>%
  select(state, county, FIPS, lean_republican)

elections %>% 
  slice(1:10)

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

glimpse(incarceration)

#political leanings
elections <- here("Documents", "Github", "into-the-tidyverse", "Data", "countypres_2000-2016.csv") %>%
  read_csv()
glimpse(elections)

elections %>% 
  arrange(desc(lean_republican))

ca_jail <- incarceration %>%
  left_join(elections, 
            by = c("fips" = "FIPS"))
ca_jail %>%
  arrange(desc(prop_jail), lean_republican)
