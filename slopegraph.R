library(tidyverse)
library(RColorBrewer)
colors <- brewer.pal(n = 3, "Set1")
red <- colors[1]

data <- read_csv("slopegraph.csv") 

data2 <- data %>%
  pivot_longer(-variable, names_to = "year") %>%
  mutate_all(str_trim) %>%
  mutate(police = variable == "維持治安及保護人身安全")
 
ggplot(data2, aes(x = year, y = value, 
                  group = variable, label = value, 
                  color = police)) +
  geom_line() +
  geom_point(colour = "white", size = 9) +
  geom_text() +
  geom_text(
    data = data2 %>% filter(year == 2017), 
    aes(label = variable, family = "SimSun"), 
    colour = "black",
    nudge_x = -0.35
  ) +
  scale_color_manual(values = c("black", red)) +
  theme(
    panel.background = element_blank(),
    axis.ticks.y.left = element_blank(),
    axis.text.y.left = element_blank(),
    axis.line.x.bottom = element_line(),
    legend.position = "none"
  ) +
  labs(y = NULL, x = NULL)
