spectrumTVL <- function() {

  #' spectrumTickers
  #'
  #' @description Ranks the value of an Ergo address relative to others.
  #'
  #' By using the description tag you'll notice that I
  #' can have multiple paragraphs in the description section
  #'
  #' @param address character. This is the Ergo address variable.
  #' @param y character. The second item to paste Defaults to "!" but
  #' "?" would be pretty great too
  #' @usage AddressRanking("address")
  #' @return The inputs pasted together as a character string.
  #' @details The inputs can be anything that can be input into
  #' the paste function.
  #' @note And here is a note. Isn't it nice?
  #' @section I Must Warn You:
  #' The reference provided is a good read.
  #' \subsection{Other warning}{
  #'   It is completely irrelevant to this function though.
  #' }
  #'
  #' @references Tufte, E. R. (2001). The visual display of
  #' quantitative information. Cheshire, Conn: Graphics Press.
  #' @examples
  #' mypaste(1, 3)
  #' mypaste("hey", "you")
  #' mypaste("single param")
  #' @export
  #' @importFrom base paste
  #'
  #'
  #'
  #'
  source("./R/config.R")

  req <- request(paste0(spectrumURL, "v1/amm/platform/stats")) %>%
    req_headers("Content-Type" = "application/json") %>%
    req_headers("accept" = "application/json")

  resp <- req_perform(req)
  df <- resp_body_json(resp, check_type = TRUE, simplifyVector = TRUE)
  View(df)
  tvl <- df$tvl$value
  return(tvl)
}

