################################
##### This script generates species performance for a global and a local adapted species, in relation to climatic  annomalies
################################

library(tidyverse)
library(ggplot2)
library(ggnewscale)

Osylvanys<-read.csv2("Data/O_sylvanus.csv", sep=",")
Osylvanys <- Osylvanys %>%
  mutate(across(c(1,2), as.numeric))
predicted<-read.delim2("Data/O_sylvanus_predicted.txt", sep=";")
predicted <- predicted %>%
  mutate(across(c(1:5), as.numeric))

Os_pts<-ggplot(data = Osylvanys, aes(y = resid, x = local.anomaly))+ theme_bw()+ theme(legend.position = "none")+
  theme(panel.grid.minor = element_blank(),panel.border = element_blank(),axis.line = element_line(colour = "black"))+
  geom_point(aes(colour = res.color), alpha=0.3)+scale_colour_identity(name = "points")+
  ylim(c(-2, 2.2))+xlim(c(-3,4))
Os_plt<-Os_pts+new_scale_color()+geom_line(predicted, mapping = aes(x, predicted, colour = group), size=0.5) + 
  scale_color_manual(name = "lines",values=rev(c("#FF0000FF","#FF0000FF", "#FF2A00FF" ,"#FF5500FF" ,"#FF8000FF" ,"#FFAA00FF" ,"#FFD500FF","#FFFF00FF" ,"#FFFF40FF", "#FFFFBFFF", "#FFFFBFFF", "#F7FBFF" ,"#DEEBF7" ,"#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6", "#2171B5", "#08519C", "#08306B","#08306B")))+
  annotate("text", x = -7, y = 2.2, label = expression(italic("Ochlodes sylvanus")) , vjust = 0.3, hjust = 0)+
  ylab("Population change")+
  xlab("Climatic anomaly of the year") + theme_bw()+ theme(legend.position = "none")+
  theme(panel.grid.minor = element_blank(),panel.grid = element_blank(),panel.border = element_blank(),axis.line = element_line(colour = "black"))
Os_plt
