
wells_wtd <- 
  read.csv('../data/combined_wells_wtd.csv') %>%
  mutate(datetime = as.Date(datetime)) %>% 
  filter(datetime >= as.Date("2006-01-01")) %>% 
  filter(datetime <= as.Date("2007-01-01")) %>% 
  # Calculate daily mean
  group_by(site_no, datetime) %>% 
  summarise(watpos=mean(watpos, na.rm=T)) %>% 
  ungroup() %>% 
  # Get values fo ones that cross 0
  group_by(site_no) %>% 
  mutate(site_watpos_max= max(watpos, na.rm=T)) %>% 
  mutate(site_watpos_min= min(watpos, na.rm=T)) %>% 
  ungroup() %>% 
  mutate(cross0 = ifelse(site_watpos_max>0 & site_watpos_min<0, TRUE, FALSE)) %>% 
  arrange(site_no, datetime) %>% 
  filter(cross0 == T)
  

# Subset to get 
wells_wtd <- 
  wells_wtd %>% 
  filter(site_no %in% sample(wells_wtd$site_no, 10))


glimpse(wells_wtd)
unique(wells_wtd$site_no)


lineplot_watpos_example_ts <- 
  ggplot(wells_wtd) +
  geom_line(aes(x=datetime, y=watpos, color=factor(site_no)), size=0.3) + 
  geom_hline(aes(yintercept=0), color='black', size=0.4) +
  xlab('Date of year 2006') +
  ylab('Daily mean water table\nposition (cm)') + 
  line_plot_theme() +
  scale_x_date(expand=c(0,0), breaks=pretty_breaks(12)) +
  scale_y_continuous(expand=c(0,0)) +
  scale_fill_brewer(palette = 'Set2') +
  theme(legend.position = 'none',
        panel.background = element_blank(),
        panel.border = element_blank(),
        strip.background = element_blank(),
        strip.text = element_text(face='bold'),
        plot.margin = unit(c(1,2,1,1), "mm"))

lineplot_watpos_example_ts

# /----------------------------------------------------------------------------#
#/   
ggsave('../output/lineplot_watpos_example_ts.png',
       lineplot_watpos_example_ts,
       width=80, height=40, dpi=500, units='mm' )

ggsave('../output/lineplot_watpos_example_ts.pdf',
       lineplot_watpos_example_ts,
       width=80, height=40, dpi=500, units='mm' )


