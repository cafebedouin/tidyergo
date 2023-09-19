dateToTimestamp <- function(date) {

  #' dateToTimestamp
  #'
  #' @description Takes a date in YYYY-MM-DD format and returns a timestamp.
  #'
  #' @param timestamp Unix Epoch, which is the unit blocks are timestamped with.
  #' @usage timestampDate(1695006885506)
  #' @return [1] "2023-09-17 23:14:45 EDT"
  #' @note Easy function for those that do not know to divide by 1,000 to get
  #' the correct date.

  timestamp <- sum(as.numeric(as.POSIXct(date, origin = "1970-01-01"))*1000)
  return(timestamp)
}
