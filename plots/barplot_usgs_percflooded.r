

# /----------------------------------------------------------------------------#
#/   Plot time duration

usgs_floodperc <- read.csv('../data/sources/usgs/percent_flooded_by_ecoregion.csv')
glimpse(usgs_floodperc)

# gwwld_pts_scoped <- 
#   gwwld_pts_scoped %>% 
#   filter(type_simple != '') %>% 
#   mutate(type_group = 'Other') %>% 
#   # mutate(type_group = ifelse(type_simple %in% c('Marsh'),'Marsh', type_group)) %>% 
#   # mutate(type_group = ifelse(type_simple %in% c('Swamp'),'Swamp', type_group)) %>% 
#   mutate(type_group = ifelse(type_simple %in% c('Salt marsh', 'Mangrove','Coastal wetland','Coastal'),'Coastal', type_group)) %>% 
#   mutate(type_group = ifelse(type_simple %in% c('Peatland', 'Bog','Fen','Peat Swamp Forest'),'Peatland', type_group)) %>% 
#   mutate(type_group = ifelse(type_simple %in% c('Drained Peatland', 'Drained','Constructed','Rice'),'Constructed, disturbed, drained', type_group))
# 

barplot_percent_flooded <- 
  ggplot(usgs_floodperc) +
  geom_histogram(aes(x=percent_flooded), fill='blue3', color='white', size=0.08, bins=20) + 
  geom_text(aes(x=60, y=130, 
                label=paste0('n= ',nrow(subset(usgs_floodperc, !is.na(end_date))),' sites')),
            size=2.2) +
  
  xlab('Percentage of measurements\ninundated(% WTD >=0)') +
  ylab('Number of sites') + 
  line_plot_theme() +
  # facet_wrap(.~ type_group, scales='free') +
  
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0)) +

  theme(legend.position = 'none',
        panel.background = element_blank(),
        # panel.border = element_blank(),
        strip.background = element_blank(),
        strip.text = element_text(face='bold'),
        plot.margin = margin(1,1,1,1,'mm'))


barplot_percent_flooded



ggsave('../output/barplot_percent_flooded.png',
       barplot_percent_flooded,
       width=36, height=35, dpi=700, units='mm' )

ggsave('../output/barplot_percent_flooded.pdf',
       barplot_percent_flooded,
       width=36, height=35, dpi=700, units='mm' )
