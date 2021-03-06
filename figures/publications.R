citekeys = read.csv('citekeys.csv', sep=';', comment.char = '#')
references = read.csv('references.csv', sep=';', comment.char = '#')

combined <- sort(union(levels(citekeys$key), levels(references$key)))

data <- left_join(mutate(citekeys, key=factor(key, levels=combined)),
                         mutate(references, key=factor(key, levels=combined)),
                         by = 'key')

breaks.area <- c('AS-Level', 'Caching', 'Aggregation')

p <- ggplot(data, aes(x = area,
                      y = methodology,
                      color = chapter,
                      group = reference)) +
  geom_text(aes(label=as.character(sprintf("[%d]", reference))), size = 2, show.legend = F, family=font.family, fontface="bold") +
  geom_point(y = -0.2, size = 0) +
  scale_x_continuous(breaks = c(0.5, 1.5, 2.5),
                     minor_breaks = c(1, 2),
                     labels = breaks.area) +
  scale_y_continuous(breaks = c(0.5, 1.5, 2.5),
                     minor_breaks = c(1, 2),
                     labels = c('Measurement', 'Simulation', 'Analysis')) +
  scale_colour_manual(values = c(color.palette[[2]], color.palette[[3]], color.palette[[4]], color.palette[[1]]), 
                      guide=guide_legend(override.aes=list(size=4), 
                                         ncol = 3, 
                                         byrow = T)) +
  coord_cartesian(xlim = c(0, 3), 
                  ylim = c(0, 3)) +
  labs(x = label.area,
       y = label.methodology,
       color = label.appears) +
  guides(marker = F) + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_line(colour = "white"))

save.full.row.plot(p)
print(p)