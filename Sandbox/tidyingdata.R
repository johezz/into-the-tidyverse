#load libraries
library(tidyr)
library(dplyr)

billboard %>% 
  slice(1:10)

#pivot_longer
billboard %>% 
  pivot_longer(cols = starts_with("wk"),
               names_to = "week",
               values_to = "ranking") %>% 
  drop_na() %>% 
  group_by(track) %>% 
  slice(1:5)

#pivot_wider
us_rent_income %>% 
  pivot_wider(names_from = "variable",
              values_from = c("estimate", "moe")) %>% 
  select(locale = NAME, estimate_income, estimate_rent) %>% 
  group_by(locale) %>% 
  summarise(p_income_spent_on_rent = 12*estimate_rent/estimate_income) %>% 
  arrange(desc(p_income_spent_on_rent))

#separate
library(readr)
library(here)

conformity <-  here("Documents", "Github", "into-the-tidyverse", "Data", "JustCon5_TPP_Order1.csv") %>%
  read_csv() %>%
  select(sub_id = mTurkCode,
         starts_with("assault"),
         starts_with("theft")) %>% 
  slice(-1) %>% 
  type_convert()


conformity %>% 
  pivot_longer(cols = -sub_id,
               names_to = "condition",
               values_to = "rating") %>% 
  separate(col = condition,
           into = c("crime_type", "crime_severity", "n_endorsing_punishment", 
                    "repetition_number", "qualtrics_junk")) %>%
  select(-qualtrics_junk)

#unite
elections <- here("Documents", "Github", "into-the-tidyverse", "Data", "countypres_2000-2016.csv") %>% 
  read_csv() %>% 
  select(year, county, state, candidate, party, candidatevotes, totalvotes)
  
elections %>% 
  unite(col = "location",
        county, state, 
        sep = ",")

#janitor
banks <- here("Documents", "Github", "into-the-tidyverse", "Data", "BankBranchesData.txt") %>% 
  read_tsv()
banks
install.packages("janitor")
library(janitor)
banks %>%
  clean_names()

candy <- here("Documents", "Github", "into-the-tidyverse", "Data", "candyhierarchy2017.csv") %>% 
  read_csv() %>%
  clean_names()

#Exercise
  #stuck on how to clean this data
candy %>% 
  pivot_longer(cols = starts_with("q"),
               names_to = "question",
               values_to = "answer",
               values_transform = list(answer = as.character)) %>% 
  drop_na() %>% 
  separate(col = question, 
           into = c("question no.", "description"), 
           sep = "_")
dat <- as.data.frame(t(candy))
dat %>% 
  pivot_longer(cols = internal_id,
               names_to = "id",
               values_to = "num")
