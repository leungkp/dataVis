library(tidyverse)
library(RColorBrewer)
colors <- brewer.pal(n = 3, "Set1")
red <- colors[1]

data <- 
  read_csv("Desktop/slopegraph.csv") %>%
  pivot_longer(-variable, names_to = "year") %>%
  mutate_all(str_trim) %>%
  filter(!variable %in% "政府開放")

data_police <- data %>% filter(variable == "維持治安及保護人身安全")
data_np <- data %>% filter(variable != "維持治安及保護人身安全")
data_2017 <- data %>% filter(year == 2017)

ggplot(data_np, aes(x = year, y = value, group = variable, label = value)) +
  geom_line() +
  geom_line(data = data_police, colour = red) +
  geom_point(colour = "white", size = 10) +
  geom_point(data = data_police, colour = "white", size = 10) +
  geom_text(data = data_police, color = red) +
  geom_text(data = data_np) +
  geom_text(data = data_2017, aes(label = variable, family = "SimSun"), nudge_x = -0.3) +
  theme(
    panel.background = element_blank(),
    axis.ticks.y.left = element_blank(),
    axis.text.y.left = element_blank(),
    axis.line.x.bottom = element_line()
  ) +
  labs(y = "", x = "")


