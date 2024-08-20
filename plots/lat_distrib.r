
library(scales)


# Get count per 1deg bin
gwwld_pts_scoped_lat <- gwwld_pts_scoped %>%
  st_drop_geometry() %>% 
  mutate(lat_rnd = round(latitude,-1) ) %>% 
  group_by(lat_rnd) %>%
  summarise(n=n()) %>% 
  as_tibble() %>% 
  mutate(status='Scoped')


# Calculate count per 10deg bins
gwwld_pts_aspir_lat <- 
  gwwld_pts_aspir %>%
  st_drop_geometry() %>% 
  mutate(lat_rnd = round(latitude,-1) ) %>% 
  group_by(lat_rnd) %>%
  summarise(n=n()) %>% 
  as_tibble() %>% 
  mutate(status='Aspirational')

# Combine together
gwwld_pts_lat <- bind_rows(gwwld_pts_scoped_lat, gwwld_pts_aspir_lat)

# /----------------------------------------------------------------------------#
#/
lat_site_count <-
  ggplot()+
  geom_line(data=gwwld_pts_lat, aes(x=lat_rnd, y=n, color=status), size=0.25) +
  geom_point(data=gwwld_pts_lat, aes(x=lat_rnd, y=n, color=status), size=0.35) +
  coord_flip() +
  xlab('Latitude 10deg bin') +
  ylab('Number of sites') +
  scale_x_continuous(limits=c(-60, 85), expand=c(0,0), breaks=pretty_breaks(12)) +
  scale_y_continuous(breaks=pretty_breaks(5)) +
  scale_color_manual(values=c('grey', 'red3')) +
  line_plot_theme() +
  theme(legend.position = c(0.06, 0.96),
        legend.title=element_blank(),
        panel.border = element_blank())



ggsave('../output/lat_site_count.png',
       lat_site_count,
       width=34, height=65, dpi=700, units='mm' )

ggsave('../output/lat_site_count.pdf',
       lat_site_count,
       width=34, height=65, dpi=700, units='mm' )

