library(ggsvg)
library(patchwork)
station_svg <- paste(readLines(here::here("figures/station-icon.svg")), collapse = "\n")
grid::grid.draw(svg_to_rasterGrob(station_svg))

nsw <- ozmaps::abs_ste %>% filter(NAME %in% c("New South Wales")) %>% rmapshaper::ms_simplify()

stations_small <- stations_sf %>% head(1)
stations_ts <- ts %>% 
  filter(id %in% stations_small$id) %>% 
  filter(lubridate::year(date) == 2020, 
         lubridate::month(date) == 1)
stations_joined <- stations_ts %>% 
  left_join(stations_sf)

p1 <- ggplot() + 
  geom_sf(data = nsw,fill = "transparent", linetype = "dotted")+ 
  geom_point_svg(
    data = stations_small, 
    aes(long, lat,
        css("path:nth-child(1)", fill = as.factor(long)),
        css("path:nth-child(2)", fill = as.factor(long)),
        css("path:nth-child(3)", fill = as.factor(long)),
        css("path:nth-child(4)", fill = as.factor(long)),
        css("path:nth-child(5)", fill = as.factor(long))
        ), 
    svg = station_svg) + 
  theme_bw() +
  scale_svg_default() + 
  scale_svg_fill_manual("css_path:nth-child(1)_fill", values = "#443750") + 
  scale_svg_fill_manual("css_path:nth-child(2)_fill", values = "#443750") + 
  scale_svg_fill_manual("css_path:nth-child(3)_fill", values = "#443750") + 
  scale_svg_fill_manual("css_path:nth-child(4)_fill", values = "#443750") + 
  scale_svg_fill_manual("css_path:nth-child(5)_fill", values = "#443750") + 
  coord_sf(xlim = c(140.5, 143), ylim = c(-35, -33)) + 
  scale_x_continuous(breaks = seq(140, 143, 1)) + 
  scale_y_continuous(breaks = seq(-35, -33, 1))
  
p2 <- stations_ts %>% 
  ggplot(aes(x = date, y = tmax)) + 
  geom_line(color = "#443750") + 
  theme_bw() + 
  theme(axis.line = element_line(color = "#840032"),
        axis.text = element_text(color = "#840032"),
        aspect.ratio = 0.3,
        title =  element_text(color = "#840032")
  )

glyph <- stations_joined %>% 
  ggplot(aes(x_major = long, x_minor = as.numeric(date),
             y_major = lat, y_minor = tmax)) + 
  geom_glyph()

p3 <- layer_data(glyph) %>% 
  ggplot(aes(x = x, y = y)) + 
  geom_line(color = "#443750") + 
  theme_bw() + 
  theme(axis.line = element_line(color = "#840032"),
        axis.text = element_text(color = "#840032"),
        aspect.ratio = 0.3,
        title =  element_text(color = "#840032")
  )

p4 <- ggplot() + 
  geom_sf(data = nsw, fill = "transparent", linetype = "dotted", inherit.aes = FALSE) + 
  geom_glyph_box(
    data = stations_joined,
    aes(x_major = long, x_minor = as.numeric(date),
        y_major = lat, y_minor = tmax, color = as.factor(long)),
    width = 1, height = 0.3, color= "#840032") + 
  geom_glyph(
    data = stations_joined, 
    aes(x_major = long, x_minor = as.numeric(date),
        y_major = lat, y_minor = tmax, color = as.factor(long)),
    width = 1, height = 0.3) + 

  theme_bw() + 
  scale_color_manual(values = "#443750") + 
  coord_sf(xlim = c(140.5, 143), ylim = c(-35, -33)) + 
  scale_x_continuous(breaks = seq(140, 143, 1)) + 
  scale_y_continuous(breaks = seq(-35, -33, 1))

g1 <- (p1 | plot_spacer()) / (plot_spacer() | plot_spacer()) + plot_layout(width = c(1,3), guides='collect') &
  theme(legend.position='none')

g2 <- (p1 | p2) / (plot_spacer()| plot_spacer()) + plot_layout(width = c(1,3), guides='collect') &
  theme(legend.position='none')

g3 <- ((p1 / plot_spacer()) | (p2 / p3))  + plot_layout(width = c(1,3), guides='collect') &
  theme(legend.position='none')

g4 <- (p1 | p2) / (p4 | p3) + plot_layout(guides='collect') &
  theme(legend.position='none')

ggsave(g1, filename = here::here("figures/glyph-steps1.png"), height = 4)
ggsave(g2, filename = here::here("figures/glyph-steps2.png"), height = 4)
ggsave(g3, filename = here::here("figures/glyph-steps3.png"), height = 4)
ggsave(g4, filename = here::here("figures/glyph-steps4.png"), height = 4)

