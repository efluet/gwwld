library(here)
library(tidyverse)
library(sf)
library(ggplot2)
library(scales)

source('theme_raster_map.r')
source('line_plot_theme.r')
source('get_country_bbox_shp_for_ggplot_map.r')

# /----------------------------------------------------------------------------#
#/

gwwld <- 
  read.csv('../data/gwwld_scope_2023.csv') %>% 
  mutate(latitude=as.numeric(latitude),
         longitude=as.numeric(longitude),
         start_date=as.numeric(start_date),
         end_date=as.numeric(end_date)) %>% 
  mutate(rec_len = end_date - start_date) %>% 
  filter(!is.na(latitude) | !is.na(longitude))


gwwld_pts <- 
  st_as_sf(gwwld, coords = c("longitude", "latitude"), crs = 4326, agr = "constant", remove=F) %>% 
  st_transform(., crs = st_crs('+proj=robin')) %>% 
  # Make column of lon/lat
  dplyr::mutate(long = sf::st_coordinates(.)[,1],
                lat = sf::st_coordinates(.)[,2])

gwwld_pts_scoped <- gwwld_pts %>% filter(!network %in% c('Ramsar','EXCHANGE','EPA - NWCA'))
gwwld_pts_aspir <- gwwld_pts %>% filter(network %in% c('Ramsar','EXCHANGE','EPA - NWCA'))


# /----------------------------------------------------------------------------#
#/

# Generate map
gwwld_site_map <-
  
  ggplot()+
  
  # countries background & outline
  geom_polygon(data=countries_robin_df, aes(long, lat, group=group), fill='grey90', color='white', size=0.12) +
  
  # Coastline
  geom_path(data=coastsCoarse_robin_df, aes(long, lat, group=group), color='grey40', size=0.1) +
  
  # Aspirational
  geom_point(data=gwwld_pts_aspir, aes(long, lat), shape=21, color='grey70', size=0.03) +
  
  # Add scoped site
  geom_point(data=gwwld_pts_scoped, aes(long, lat, color=network), size=0.25) +

  # Add outline bounding box
  geom_path(data=bbox_robin_df, aes(long, lat, group=group), color='black', size=0.08) +
  
  coord_equal() +  theme_raster_map() +
  
  theme(legend.position = 'left',
        legend.direction = 'vertical')
  # scale_color_brewer(palette='Set3')

gwwld_site_map

# /----------------------------------------------------------------------------#
#/   
ggsave('../output/gwwld_map_v0.png',
       gwwld_site_map,
       width=160, height=70, dpi=500, units='mm' )

ggsave('../output/gwwld_map_v0.pdf',
       gwwld_site_map,
       width=160, height=70, dpi=500, units='mm' )

  

