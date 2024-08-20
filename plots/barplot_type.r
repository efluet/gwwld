

# /----------------------------------------------------------------------------#
#/   Plot site type

gwwld_pts_scoped_typecnt <- 
  gwwld_pts_scoped %>% 
  st_drop_geometry() %>% 
  filter(type_simple != '') %>% 
  mutate(type_group = 'Other') %>% 
  # mutate(type_group = ifelse(type_simple %in% c('Marsh'),'Marsh', type_group)) %>% 
  # mutate(type_group = ifelse(type_simple %in% c('Swamp'),'Swamp', type_group)) %>% 
  mutate(type_group = ifelse(type_simple %in% c('Salt marsh', 'Mangrove','Coastal wetland','Coastal'),'Coastal', type_group)) %>% 
  mutate(type_group = ifelse(type_simple %in% c('Peatland', 'Bog','Fen','Peat Swamp Forest'),'Peatland', type_group)) %>% 
  mutate(type_group = ifelse(type_simple %in% c('Drained Peatland', 'Drained','Constructed','Rice'),'Constructed, disturbed\nand drained', type_group)) %>% 
  group_by(type_group, type_simple) %>% 
  summarize(n=n()) %>% 
  ungroup() 
  # To represent 1s
  # mutate(n=ifelse(n==0, 1, n))



glimpse(gwwld_pts_scoped_typecnt)

barplot_type <- 
  ggplot(gwwld_pts_scoped_typecnt) +
  geom_bar(aes(x=reorder(type_simple, n), y=n, fill=type_group), stat='identity', width=0.75) + 

  xlab('Site type') +
  ylab('Number of sites') + 
  line_plot_theme() +
  facet_wrap(.~ type_group, scales='free') +

  coord_flip() +
  # scale_y_continuous() +
  scale_y_log10(expand=c(0,0)) + #, breaks=pretty_breaks()) +
  scale_x_discrete()+ #labels = wrap_format(10)) +
  scale_fill_brewer(palette = 'Set2') +
  line_plot_theme() +
  theme(legend.position = 'none',
        panel.background = element_blank(),
        panel.border = element_blank(),
        strip.background = element_blank(),
        strip.text = element_text(face='bold'))


barplot_type



ggsave('../output/barplot_type.png',
       barplot_type,
       width=80, height=52, dpi=700, units='mm' )

ggsave('../output/barplot_type.pdf',
       barplot_type,
       width=80, height=52, dpi=700, units='mm' )
