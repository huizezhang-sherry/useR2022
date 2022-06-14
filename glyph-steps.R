library(ggsvg)
library(patchwork)
station_url <- "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB3aWR0aD0iNzUycHQiIGhlaWdodD0iNzUycHQiIHZlcnNpb249IjEuMSIgdmlld0JveD0iMCAwIDc1MiA3NTIiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiA8Zz4KICA8cmVjdCB3aWR0aD0iNzUyIiBoZWlnaHQ9Ijc1MiIgZmlsbD0iI2E4YWFhZCIvPgogIDxwYXRoIGQ9Im01NzQuNDUgNTYyLjMgMC4xMDU0NyAyOS41OTgtMzk5LjgyIDEuNTExNy0wLjEyMTA5LTI5LjYwMnoiLz4KICA8cGF0aCBkPSJtNDQ1LjU5IDIwMC4wN2MxMS4xNDEgMC42OTUzMSA3Ljk4ODMtMi4yMzQ0IDExLjY3NiA1LjQ3NjYgMS43MTQ4IDIwLjE1NiAxLjcxNDggMjAuMTU2IDYuODUxNiA4MC42MDkgMS43NzczIDIwLjk3MyAxLjEyNSAxMy4zMzYgMS45Mzc1IDIyLjg5OCAwLjkzMzU5LTUuNDMzNiAxLjg2NzItMTAuODc5IDIuNzk2OS0xNi4zMTIgMS40MjE5LTguMzMyIDEzLjQzOC04LjE1MjMgMTQuNjA5IDAuMjA3MDMgMS44NjMzIDEzLjE3MiAzLjcyNjYgMjYuMzQ0IDUuNTc4MSAzOS41MTYgMy45MjE5IDI3Ljc1IDIuNDU3IDE3LjM3NSA0LjM5NDUgMzEuMTI1IDEuNzYxNy02LjEyODkgMy41MDc4LTEyLjI0MiA1LjI2OTUtMTguMzY3IDIuMjA3LTcuNzUzOSAxMy40OC02Ljg2NzIgMTQuNDQ1IDEuMTQwNiAxLjcxNDggMTQuMDI3IDEuNzE0OCAxNC4wMjcgNi44NTE2IDU2LjE0OGwwLjM5ODQ0IDMuMjEwOWMxLjQ0OTItOS4zMDg2IDIuODg2Ny0xOC42MTcgNC4zNTE2LTI3LjkyNmwwLjM3MTA5LTEuNDY0OGMyLjU3NDItNi44Mzk4IDIuNTc0Mi02LjgzOTggMTAuMjctMjcuMzUyIDcuNzEwOS0yMC41MjcgNy43MTA5LTIwLjUyNyAxMC4yNy0yNy4zNjNsMTMuODY3IDUuMjEwOWMtMi41NzQyIDYuODUxNi01LjE0ODQgMTMuNzAzLTcuNzIyNyAyMC41Ny00LjE4NzUgMTEuMTI5LTguMzYzMyAyMi4yNzMtMTIuNTUxIDMzLjQxOC0yLjA1ODYgMTMuMTg0LTQuMTEzMyAyNi4zNzEtNi4xNTYyIDM5LjU1OS00LjcwNyAzMC4yMzQtNC43MDcgMzAuMjM0LTYuMjc3MyA0MC4zMTItMS4zMzIgOC40OTYxLTEzLjYyOSA4LjI4OTEtMTQuNjY0LTAuMjM4MjgtMS43MTg4LTE0LjA0My0xLjcxODgtMTQuMDQzLTYuODM1OS01Ni4xNDgtMS45NTctMTUuOTIyLTEuMTQwNi05LjI5My0yLjQ0NTMtMTkuOTE4LTEuNTk3NyA1LjU3ODEtMy4xOTUzIDExLjE1Ni00Ljc3NzMgMTYuNzM4LTIuMjA3IDcuNjc5Ny0xMy4zMzYgNi45MTAyLTE0LjQ0NS0xLjAwNzgtMS44NjMzLTEzLjEyNS0xLjg2MzMtMTMuMTI1LTcuNDE0MS01Mi41MzlsLTAuODAwNzgtNS41OTM4Yy0xLjUwNzggOC44OTQ1LTMuMDMxMiAxNy43ODktNC41NTg2IDI2LjY4NC0xLjQ2NDggOC41NTQ3LTEzLjkyNiA4LjAzNTItMTQuNjY0LTAuNjIxMDktMS43MTg4LTIwLjE1Ni0xLjcxODgtMjAuMTU2LTYuODM5OC04MC42MjUtMi4wMTE3LTIzLjYzNy0xLjEzNjctMTMuMzM2LTIuNjMyOC0zMC45MTgtMy4zNzUgMTUuODk1LTYuNzYxNyAzMS43NzMtMTAuMTUyIDQ3LjY2OC0xLjYyODkgNy42NjgtMTIuNTA0IDcuODU5NC0xNC40MTQgMC4yNTM5MS0xLjk4NDQtNy45MzM2LTMuOTY0OC0xNS44NjctNS45NDkyLTIzLjc4NS0yLjg1NTUgMTMuMjkzLTEuMjczNCA1LjkyMTktNC43MzQ0IDIyLjA5OC04LjU1NDcgMzkuOTU3LTguNTU0NyAzOS45NTctMTEuNDE0IDUzLjI3Ny0xLjY5OTIgNy45NDUzLTEzLjE0MSA3LjcyNjYtMTQuNTMxLTAuMjk2ODctMC45OTIxOS01LjcyNjYtMS45ODQ0LTExLjQ1My0yLjk3MjctMTcuMTk1LTIuNzg1MiAxMi43NTgtMS4xNDA2IDUuMjIyNy00LjkyOTcgMjIuNjI5LTkuNzA3IDQ0Ljc1LTkuNzA3IDQ0Ljc1LTEyLjk0OSA1OS42NTYtMS42NDQ1IDcuNTc0Mi0xMi4zNDQgNy44NTU1LTE0LjM3MSAwLjM2NzE5LTEuODk0NS02Ljk2ODgtMy43ODkxLTEzLjk0MS01LjY4MzYtMjAuOTFsLTEuNjEzMyA3LjU2MjVjLTUuOTkyMiAyOC4wNzQtNS45OTIyIDI4LjA3NC03Ljk5MjIgMzcuNDI2LTEuNjEzMyA3LjU5MzgtMTIuMzI4IDcuODkwNi0xNC4zNjcgMC40MTc5Ny0yLjcxMDktOS45MDIzLTIuNzEwOS05LjkwMjMtMTAuODQ4LTM5LjU5LTMuNTcwMy0xMy4wMzktMS43OTMtNi41NDMtNS4zMjgxLTE5LjQ3N2wtMC4xNjQwNiAwLjM1NTQ3Yy02LjQxMDIgMTQuNTc4LTYuNDEwMiAxNC41NzgtOC41NTQ3IDE5LjQzLTIuOTE0MSA2LjYwMTYtMTIuNTk0IDUuNTY2NC0xNC4wMzEtMS41MDc4LTEuMzMyLTYuNjAxNi0yLjY3NTgtMTMuMTk5LTQuMDIzNC0xOS44MDEtMi4zOTg0IDEyLjI3LTAuOTYwOTQgNC45NTctNC4yNzczIDIxLjkwMi04LjU1NDcgNDMuNzMtOC41NTQ3IDQzLjczLTExLjQxIDU4LjMwOS0xLjU4MiA4LjA1MDgtMTMuMTQxIDcuOTMzNi0xNC41NDctMC4xNDg0NC0xLjQ5NjEtOC41NjY0LTIuOTkyMi0xNy4xMjEtNC40Njg4LTI1LjY5MS0xLjgzNTkgNi45NDE0LTAuNTM1MTYgMi0zLjkxMDIgMTQuNzg1LTkuNDI1OCAzNS42MzctOS40MjU4IDM1LjYzNy0xMi41NjIgNDcuNTIzLTEuODk0NSA3LjE5MTQtMTIuMDQ3IDcuMzgyOC0xNC4yMjMgMC4yNjU2Mi0xLjQ0OTItNC43NS0wLjYwNTQ3LTEuOTUzMS0yLjU2MjUtOC4zOTA2LTEuOTY0OCAxMC42NjgtMy45MzM2IDIxLjM1NS01LjkwMjMgMzIuMDM5bC0xNC41NjItMi42Nzk3YzEuNDMzNi03Ljc1MzkgMi44NTU1LTE1LjUwOCA0LjI4OTEtMjMuMjc3IDIuMzcxMS0xMi44NzUgNC43NTM5LTI1Ljc1NCA3LjEyMTEtMzguNjI5IDEuNDA2Mi03LjYyMTEgMTIuMDktOC4yMjY2IDE0LjM1NS0wLjgxMjUgMS4yNzM0IDQuMTcxOSAyLjU0MyA4LjM2MzMgMy44MzIgMTIuNTUxIDMuODIwMy0xNC41MDQgMS44NTE2LTcuMDU4NiA1LjkwNjItMjIuMzYzIDkuNDEwMi0zNS42MzcgOS40MTAyLTM1LjYzNyAxMi41NTEtNDcuNTA4IDIuMDI3My03LjY3OTcgMTMuMDgyLTcuMjA3IDE0LjQ0MSAwLjYyNSAxLjE0MDYgNi41MjM0IDIuMjY1NiAxMy4wNTEgMy40MDYyIDE5LjU3OCAxLjgzMi05LjM2NzIgMC41ODk4NC0zLjAzNTIgMy43MjY2LTE5LjAxNiA4LjU1NDctNDMuNzM0IDguNTU0Ny00My43MzQgMTEuNDEtNTguMzEyIDEuNTU0Ny03LjkyOTcgMTIuODkxLTcuOTc2NiAxNC41MDQtMC4wNDI5NjkgMS40Mzc1IDcuMDE1NiAxLjQzNzUgNy4wMTU2IDUuNzE0OCAyOC4wNzRsMS4wNjI1IDUuMjUzOWMyLjU3ODEtNS44NTk0IDUuMTUyMy0xMS43MDcgNy43MjY2LTE3LjU2NiAyLjgxMjUtNi4zNzg5IDEyLjA3OC01LjY4MzYgMTMuOTEgMS4wMzUyIDIuNzEwOSA5LjkwMjMgMi43MTA5IDkuOTAyMyAxMC44NTIgMzkuNTkgMi43MjI3IDkuOTU3IDEuNzg5MSA2LjUzOTEgMi44MDg2IDEwLjI3bDEuNjQ0NS03LjcxMDljNS45ODA1LTI4LjA1OSA1Ljk4MDUtMjguMDU5IDcuOTc2Ni0zNy40MjYgMS42Mjg5LTcuNTkzOCAxMi4zNDQtNy44OTA2IDE0LjM4Ny0wLjM4NjcyIDEuOTA2MiA3LjA0NjkgMy44MzIgMTQuMDkgNS43NDIyIDIxLjE0OGwzLjMxMjUtMTUuMjU4YzUuMzg2Ny0yNC44MiAxMC43NzMtNDkuNjM3IDE2LjE3Ni03NC40NTcgMS43MTg4LTcuOTQ1MyAxMy4xMjktNy43MTA5IDE0LjUyIDAuMjk2ODggMC45NzY1NiA1LjY0MDYgMS45NTMxIDExLjI3NyAyLjkyOTcgMTYuOTMgMS41MjM0LTcuMTMyOCAwLjM5ODQ0LTEuODIwMyAzLjQxOC0xNS45MzggOC41NTQ3LTM5Ljk1NyA4LjU1NDctMzkuOTU3IDExLjQxLTUzLjI2MiAxLjY0NDUtNy42NjggMTIuNTA4LTcuODU5NCAxNC40MTQtMC4yNTM5MSAxLjk4NDQgNy45MDIzIDMuOTUzMSAxNS44MDUgNS45Mzc1IDIzLjcxMSAxLjkwNjItOSAwLjcxMDk0LTMuMzQ3NyAzLjYwOTQtMTYuOTc3IDcuNzEwOS0zNi4xNjggNy43MTA5LTM2LjE2OCAxMC4yNy00OC4yM3oiLz4KIDwvZz4KPC9zdmc+Cg=="
station_svg <- paste(readLines(file.choose()), collapse = "\n")
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
  filter(id == station_id) %>% 
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

(p1 | p2) / (p4 | p3) + plot_layout(guides='collect') &
  theme(legend.position='none')

ggsave(here::here("figures/glyph-steps.png"))

