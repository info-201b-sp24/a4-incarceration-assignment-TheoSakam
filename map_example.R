library(ggplot2)
library(maps)

states_map <- map_data("state")

data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates.csv")

maapi <- data %>%
  group_by(state) %>%
  summarize(max_aapi_jail_pop_rate = max(aapi_jail_pop_rate, na.rm = TRUE))

state_mapping <- data.frame(
  state = c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", 
            "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", 
            "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", 
            "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", 
            "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"),
  full_state = c("alabama", "alaska", "arizona", "arkansas", "california", 
                 "colorado", "connecticut", "delaware", "florida", "georgia", 
                 "hawaii", "idaho", "illinois", "indiana", "iowa", "kansas", 
                 "kentucky", "louisiana", "maine", "maryland", "massachusetts", 
                 "michigan", "minnesota", "mississippi", "missouri", "montana", 
                 "nebraska", "nevada", "new hampshire", "new jersey", "new mexico", 
                 "new york", "north carolina", "north dakota", "ohio", "oklahoma", 
                 "oregon", "pennsylvania", "rhode island", "south carolina", 
                 "south dakota", "tennessee", "texas", "utah", "vermont", 
                 "virginia", "washington", "west virginia", "wisconsin", "wyoming")
)

aapi_data_full <- merge(maapi, state_mapping, by = "state", all.x = TRUE)

aapi_data_full$max_aapi_jail_pop_rate <- replace(aapi_data_full$max_aapi_jail_pop_rate, 
                                                 is.infinite(aapi_data_full$max_aapi_jail_pop_rate), 
                                                 0)

mp <- ggplot(aapi_data_full, aes(map_id=full_state)) + geom_map(aes(fill=max_aapi_jail_pop_rate), map=states_map)
  mp <- mp + expand_limits(x = states_map$long, y = states_map$lat)
  mp <- mp + scale_fill_gradient(limits = c(0, NA), low='grey90', high='darkgreen')
  mp <- mp + labs(x = "Longitude", y = "Latitude", title = "Max AAPI jail population rate by state in US")
mp

