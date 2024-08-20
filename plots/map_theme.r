

### Create map ggplot theme_opts ---------------------------------------------------- 

theme_fig <- function(base_size = 8){ 
  theme_bw(base_size=base_size) +
    theme(plot.title =   element_text(face='bold',size=9,hjust=0.5),
          plot.background = element_rect(fill='white'),
          
          # PANEL
          panel.grid =  element_line(colour = "white"), #element_blank(),
          panel.background = element_rect(fill='white'),
          panel.border = element_blank(),
          
          # AXIS
          axis.text =  element_blank(), 
          axis.title = element_blank(), 
          axis.line = element_line(colour='white'),
          axis.ticks = element_blank(),
          
          # LEGEND
          #legend.title = element_blank(), 
          legend.key =   element_blank(), 
          legend.position="bottom", 
          legend.box="horizontal",
          legend.text=element_text(size=7), 
          legend.spacing = unit(0, "mm"),
          legend.key.size = unit(3, "mm")) }
