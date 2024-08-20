

# /----------------------------------------------------------------------------#
#/   Plot time duration

# unique(gwwld_pts_scoped$description)
# unique(gwwld_pts_scoped$rec_len)

barplot_rec_len <- 
  ggplot(gwwld_pts_scoped) +
  geom_histogram(aes(x=rec_len), binwidth = 1, color='white', fill='red3', size=0.01) + 
  geom_text(aes(x=30, y=60, 
                label=paste0('n= ',nrow(subset(gwwld_pts_scoped, !is.na(end_date))),' sites')),
            size=2.2) +
  xlab('Record length (years)') +
  ylab('Number of sites') + 
  line_plot_theme() +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0)) 


barplot_rec_len

# Save
ggsave('../output/barplot_rec_length.png',
       barplot_rec_len,
       width=40, height=35, dpi=700, units='mm' )

ggsave('../output/barplot_rec_length.pdf',
       barplot_rec_len,
       width=40, height=35, dpi=700, units='mm' )
