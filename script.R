library(tidyverse)
library(sf)
library(tsibble)
library(cubble)

raw <- weatherdata::historical_tmax %>% 
  filter(between(stringr::str_sub(id, 7, 8), 46, 75))

stations <- raw %>% 
  select(id: wmo_id) %>% 
  ungroup()
stations_sf <- stations %>% 
  st_as_sf(coords = c("long", "lat"), crs = 4283, remove = FALSE)

ts <- raw %>% face_temporal() %>% as_tibble()

map <- ozmaps::abs_ste %>% rmapshaper::ms_simplify()
nsw <- map %>% filter(NAME == "New South Wales")

# nsw_stations <- stations_sf %>% 
#   st_filter(nsw, .predicate = st_within)
# nsw_ts <- ts %>% filter(id %in% nsw_stations$id)

weather <- as_cubble(list(spatial = stations_sf, 
                          temporal = ts),
                    key = id, index = date, 
                    coords = c("long", "lat"))

class(weather)
weather_long <- weather %>% face_temporal()
class(weather_long)

weather_full <- weather %>% 
  filter(between(stringr::str_sub(id, 7, 8), 46, 75)) %>% 
  filter(!id %in% c("ASN00067033", "ASN00072091")) %>% 
  face_temporal() %>% 
  filter(lubridate::year(date) %in% c(1971:1975, 2016:2020)) %>% 
  group_by(month = lubridate::month(date),
           group = as.factor(ifelse(lubridate::year(date) > 2015,
                                    "2016 ~ 2020", "1971 ~ 1975"))) |>
  summarise(tmax = mean(tmax, na.rm = TRUE)) %>% 
  unfold(long, lat)
  
weather_full %>% 
  ggplot(aes(x_major = long, x_minor = month, 
             y_major = lat, y_minor = tmax, 
             group = interaction(id, group), color = group)) + 
  geom_sf(data = nsw, inherit.aes = FALSE, fill = "transparent") + 
  geom_glyph(width = 1, height = 0.5) + 
  scale_color_brewer(palette = "Dark2") + 
  theme_bw() + 
  # coord_sf(xlim = c(141, 154), ylim = c(-36, -29)) + 
  theme(legend.position = "bottom") +
  labs(x = "Longitude", y = "Latitude")



#####################################
library(cubble)
library(tidyverse)
library(GGally)

ncs <- weatherdata::historical_tmax %>%
  filter(long > 151, lat < -32.5, lat > -33)
tmax <- weatherdata::historical_tmax %>%
  filter(!id %in% c("ASN00071032", "ASN00071041", "ASN00063039")) %>%
  # remove sydney nearby (only leave sydney airport)
  filter(!id %in% c("ASN00063039", "ASN00066062", "ASN00066124",
                    "ASN00066137", "ASN00067033")) %>%
  filter(!id %in% c("ASN00072091")) %>%
  # remove newcastle around area (only leave Nelson Bay)
  filter(!id %in% ncs$id[-1]) %>%
  filter(lat > -36) %>%
  filter(between(stringr::str_sub(id, 7, 8), 46, 75)) %>%
  face_temporal() 

class(tmax) <- class(tmax)[c(1, 3:6)]
tmax <- tmax %>% 
  filter(lubridate::year(date) %in% c(1971:1975, 2016:2020)) %>%
  mutate(month = lubridate::month(date)) %>%
  group_by(month, group = as.factor(ifelse(lubridate::year(date) > 2015,
                                           "2016 ~ 2020", "1971 ~ 1975"))) %>%
  summarise(tmax = mean(tmax, na.rm = TRUE)) %>%
  face_spatial() %>%
  filter(nrow(ts) == 24) %>%
  face_temporal() %>%
  unfold(long, lat) %>%
  arrange(id, month)


nsw <- ozmaps::abs_ste %>% filter(NAME %in% c("New South Wales")) %>% rmapshaper::ms_simplify()

p1 <- ggplot() +
  geom_sf(data = nsw, fill = "transparent", color = "black") +
  geom_glyph_box(data = tmax,
                 aes(x_major = long, x_minor = month,
                     y_major = lat, y_minor = tmax,
                     group = interaction(id, group), color = group),
                 width = 0.8, height = 0.35) +
  geom_glyph(data = tmax,
             aes(x_major = long, x_minor = month,
                 y_major = lat, y_minor = tmax,
                 group = interaction(id, group), color = group),
             width = 0.8, height = 0.35, alpha = 1.2) +
  scale_color_brewer(palette = "Dark2") +
  theme_bw() +
  coord_sf(xlim = c(141, 154),  ylim = c(-36, -28.7)) +
  theme(legend.position = "bottom") +
  labs(x = "Longitude", y = "Latitude")

tmax %>% filter(id == "ASN00048027") %>%
  ggplot(aes(x = month,
             y = tmax,
             color = group)) +
  geom_line(size = 1.5) +
  scale_color_brewer(palette = "Dark2", guide = "none") +
  scale_x_continuous(breaks = 1:12, label = map_chr(month.abb, ~str_sub(.x, 1, 1))) +
  labs(x = "Month", y  = "Temperature", title = "ASN00048027: Cobar") +
  theme_bw() +
  theme(
    aspect.ratio = 0.3,
    axis.text = element_text(size = 20),
    title =  element_text(size = 20)
  )

#ggsave(filename = here::here("figures/cobar-inset.png"), width = 7)

box_df <- tmax %>% face_spatial() %>% filter(id == "ASN00048027")
single <-
  tibble::tibble(img = here::here("figures/cobar-inset.png"))
p1 +
  geom_rect(
    data = box_df,
    aes(
      xmin = long - 0.6,
      xmax = long + 0.6,
      ymin = lat - 0.26,
      ymax = lat + 0.29
    ),
    fill = "transparent",
    color = "black"
  ) +
  ggimg::geom_point_img(data = single,
                        aes(x = 143, y = -30, img = img), size = 6) +
  guides(color = guide_legend(override.aes = list(size=5))) +
  theme(legend.text = element_text(size = 20),
        legend.title = element_text(size = 20),
        axis.text = element_text(size = 20),
        axis.title = element_text(size = 20))

#ggsave(filename = "figures/glyphmap.png", width = 10, height = 10)

