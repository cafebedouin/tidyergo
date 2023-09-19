timestampToDate <- function(timestamp) {

  #' timestampDate
  #'
  #' @description Takes a timestamp and returns a date and time in POSIXct.
  #'
  #' @param timestamp Unix Epoch, which is the unit blocks are timestamped with.
  #' @usage timestampDate(1695006885506)
  #' @return [1] "2023-09-17 23:14:45 EDT"
  #' @note Easy function for those that do not know to divide by 1,000 to get
  #' the correct date.

  date <- as.POSIXct(sum(timestamp/1000), origin = "1970-01-01", tz="UTC")
  return(date)
}
