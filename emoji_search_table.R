#devtools::install_github("hadley/emo")
library(tidyverse)
library(DT)
library(emo)

b <- emo::jis %>% 
  select(name, emoji, group, subgroup, keywords, aliases) %>%
  mutate(keywords = map(keywords, toString)) %>% 
  mutate(aliases = map(aliases, toString)) %>%
  mutate(keywords = str_replace_all(keywords, "_", " ")) %>% 
  mutate(aliases = str_replace_all(aliases,"_", " "))

write_csv(b,"emoji_search_table.csv")

b %>% 
  datatable(rownames = FALSE, extensions = 'Responsive',
            caption = htmltools::tags$caption(
              style = 'caption-side: top; text-align: center;', 
              htmltools::em('Table 1: Emoji Search Table')),
            options = list(
              searchHighlight = TRUE,
              columnDefs = list(list(className = 'dt-center', 
                                     targets = 0:5)),
              lengthMenu = c(5, 10, 15, 20)
              ))
