library(dplyr)

data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates.csv")
year_totals <- data %>%
  group_by(year) %>%
  summarize(total_jail_pop_rate = sum(total_jail_pop_rate, na.rm = TRUE),
            total_aapi_jail_pop_rate = sum(aapi_jail_pop_rate, na.rm = TRUE))
year_percents <- year_totals %>%
  mutate(aapi_percentage = (total_aapi_jail_pop_rate / total_jail_pop_rate) * 100)

library(ggplot2)

ggplot(year_percents, aes(x = year, y = aapi_percentage)) +
  geom_line() +
  labs(x = "Year", y = "AAPI Percentage", title = "Percentage of aapi jail rate over time")
