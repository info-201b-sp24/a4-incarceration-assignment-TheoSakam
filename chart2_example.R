state_year_comparison <- data %>%
  group_by(year, state) %>%
  summarize(total_jail_pop_rate = sum(total_jail_pop_rate, na.rm = TRUE),
            total_aapi_jail_pop_rate = sum(aapi_jail_pop_rate, na.rm = TRUE),
            aapi_percentage = (total_aapi_jail_pop_rate / total_jail_pop_rate) * 100)

state_year_comparison

library(ggplot2)

ggplot(state_year_comparison, aes(x = total_aapi_jail_pop_rate, y = total_jail_pop_rate)) +
  geom_point() +
  labs(x = "AAPI Jail Population Rate", y = "Total Jail Population Rate", title = "Total Jail Population Rate vs AAPI Jail Population Rate")
