

#-------------------------------------------------------------------------------
### CALCULATE THE NUMBER OF SITES PER YEAR


gwwld_pts_scoped_dates <- 
  gwwld_pts_scoped %>%
  st_drop_geometry() %>% 
  select(network_id, network, start_date, end_date) %>% 
  filter(!is.na(end_date))
  

# create empty dataframe
output = data.frame()

# loop through rows (each row = a site)
for (i in 1:nrow(gwwld_pts_scoped_dates)){
  
  # Make temp variables
  site = gwwld_pts_scoped_dates[i,]
  id = site[1,'network_id']
  start = site[1,'start_date']
  end = site[1,'end_date']
  
  # Make table of tower x year  for each row
  e <- expand.grid(c(id), seq(start, end))
  
  # append rows to output
  output <- bind_rows(output, e)
  
  }


# Rename columns
names(output) <- c("id", "year")

# Get tower count per year
gwwld_pts_scoped_per_year <- 
  output %>%
  group_by(year) %>% 
  summarise(n = n())


# Make lineplot of tower count
lineplot_year_coverage <-
  
  ggplot(gwwld_pts_scoped_per_year) +
  geom_line(aes(x=year, y=n), size=0.3, color='red3') +
  geom_point(aes(x=year, y=n), size=0.25, color='red3') +
  geom_text(aes(x=1990, y=90, label=paste0('n= ',nrow(subset(gwwld_pts_scoped_dates, !is.na(end_date))),' sites')), size=2.2) +
  
  scale_x_continuous(expand=c(0,0), breaks=pretty_breaks(6)) +
  scale_y_continuous(breaks=pretty_breaks(6)) +
  line_plot_theme() +
  ylab('Number of active sites') +
  xlab('Year')

lineplot_year_coverage

#
ggsave('../output/lineplot_year_coverage.png',
       lineplot_year_coverage,
       width=40, height=35, dpi=500, units='mm' )


ggsave('../output/lineplot_year_coverage.pdf',
       lineplot_year_coverage,
       width=40, height=35, dpi=500, units='mm' )

