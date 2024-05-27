library(dplyr)

data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates.csv")

state_year_aapi_pop <- data %>%
  group_by(year, state) %>%
  summarize(total_aapi_pop_rate = mean(aapi_jail_pop_rate, na.rm = TRUE))
View(state_year_aapi_pop)

state_year_percents <- data %>%
  group_by(year, state) %>%
  summarize(total_jail_pop_rate = sum(total_jail_pop_rate, na.rm = TRUE),
            total_aapi_jail_pop_rate = sum(aapi_jail_pop_rate, na.rm = TRUE)) %>%
  mutate(aapi_percentage = (total_aapi_jail_pop_rate / total_jail_pop_rate) * 100)
View(state_year_percents)

year_totals <- data %>%
  group_by(year) %>%
  summarize(total_jail_pop_rate = sum(total_jail_pop_rate, na.rm = TRUE),
            total_aapi_jail_pop_rate = sum(aapi_jail_pop_rate, na.rm = TRUE))
year_percents <- year_totals %>%
  mutate(aapi_percentage = (total_aapi_jail_pop_rate / total_jail_pop_rate) * 100)
View(year_percents)

year_urban_avg_aapi <- data %>%
  group_by(year, urbanicity) %>%
  summarize(avg_aapi_rate = mean(aapi_jail_pop_rate, na.rm = TRUE))
View(year_urban_avg_aapi)

state_max_aapi <- data %>%
  group_by(state) %>%
  summarize(max_aapi_jail_pop_rate = max(aapi_jail_pop_rate, na.rm = TRUE))
View(state_max_aapi)

test <- data %>% filter(county_name == "Irwin County")
View(test)
