require('ggplot2', quietly = TRUE, warn.conflicts = FALSE)
require('scales', quietly = TRUE, warn.conflicts = FALSE)


plot.earthquake.mag.vs.datetime <- function() {
  ggplot(data = earthquakes, 
         mapping = aes(x = time_posixct, y = mag, size = mag), 
         height = 960, width = 540) + 
    geom_point() + 
    scale_x_datetime("Time of Day", breaks = date_breaks("3 hour"),
                     labels = date_format("%H:%M")) + 
    scale_y_continuous("Magnitude") + 
    facet_wrap(~date, ncol = 7) + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
}


# Filter earthquakes by date.
filter.earthquakes <- function(earthquakes, from = NA, to = NA) {
  eqs <- earthquakes %>% arrange(date_time_posixct)
  from <- ifelse(is.na(from), eqs$date_time_posixct[1], from)
  to <- ifelse(is.na(to), eqs$date_time_posixct[nrow(eqs)], to)
  eqs %>% filter(date_time_posixct >= from & eqs$date_time_posixct <= to)
}
