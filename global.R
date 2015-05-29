require('RCurl', quietly = TRUE, warn.conflicts = FALSE)
require('dplyr', quietly = TRUE, warn.conflicts = FALSE)
require('futile.logger', quietly = TRUE, warn.conflicts = FALSE)


# Source required functions
source('functions.R')


################################################################################
# Kimonolabs Data URL
################################################################################

csv.url <- "https://www.kimonolabs.com/api/csv/28crs8le?apikey=JgN4UsyEGSZ0ogyTSDnJPCCObZ7lEbHa"


################################################################################
# Retrieves data from given URL
################################################################################

get.data.from.url <- function(url, on.success = NULL, on.error = NULL) {
  rval <- ""
  tryCatch({
    rval <- RCurl::getURL(url, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
  if (is.function(on.success))
    on.success()
  }, error = function(e) {
    if (is.function(on.error))
      on.error(e)
  })
  return(rval)
}

on.success.get.data.from.url <- function() {
  flog.debug("Retrieved data from given url.")
}

on.error.get.data.from.url <- function(e) {
  flog.error("Error retrieving data from url: %s", e$message)
}


################################################################################
# Converts text into data.frame 
# Logs error message, if any.
################################################################################

csv.text.to.data.frame <- function(csv.text, on.success = NULL, on.error = NULL) {
  rval <- data.frame()
  tryCatch({
    rval  <- read.csv(text = csv.text, skip = 1, header = TRUE, as.is = TRUE, stringsAsFactors = FALSE)
    if (is.function(on.success))
      on.success()
  }, error = function(e) {
    if (is.function(on.error))
      on.error(e)
  })
  return(rval)
}

on.success.csv.text.to.data.frame <- function() {
  flog.debug("Parsed data retrieved from url")
}

on.error.csv.text.to.data.frame <- function(e) {
  flog.error("Error parsing data retrieved from url: %s. Data: %s", e$message, csv.text)
}


################################################################################
# Data
################################################################################

earthquakes <- csv.url %>% 
  get.data.from.url(on.success.get.data.from.url, on.error.get.data.from.url) %>% 
  csv.text.to.data.frame(on.success.csv.text.to.data.frame, on.error.csv.text.to.data.frame) %>% 
  mutate(date_time = sprintf("%s %s", date, time)) %>%
  transform(time_posixct = as.POSIXct(time, tz = "Asia/Katmandu", format = "%H:%M"), 
            date_time_posixct = as.POSIXct(date_time, tz = "Asia/Katmandu"))


################################################################################
# Transformed Data
################################################################################

earthquakes.from.2015.4.25 <- earthquakes %>% 
  filter.earthquakes(from = "2015/04/25")

earthquakes.from.2015.4.25.to.2015.5.12 <- earthquakes.from.2015.4.25 %>% 
  filter.earthquakes(to = "2015/05/12")

inter.earthquake.time.from.2015.4.25.to.2015.5.12 <- earthquakes.from.2015.4.25.to.2015.5.12 %>% 
  inter.earthquake.time()

plot.inter.earthquake.time.from.2015.4.25.to.2015.5.12 <- function() {
  inter.earthquake.time.from.2015.4.25.to.2015.5.12 %>% 
    plot.inter.quake.times(main = "Inter-quake time\nFrom 2015-04-25 to 2015-05-12")
}

earthquakes.from.2015.5.13 <- earthquakes %>% 
  filter.earthquakes(from = "2015/05/13")

inter.earthquake.time.from.2015.5.13 <- earthquakes.from.2015.5.13 %>% 
  inter.earthquake.time()

plot.inter.earthquake.time.from.2015.5.13 <- function() {
  inter.earthquake.time.from.2015.5.13 %>% 
    plot.inter.quake.times(main = "Inter-quake Time\nFrom 2015-05-13")
}
