getTokenName <- function(tokenId) {

  #' addressTransactions
  #'
  #' @description Returns a list of transactionIds for a given address or list
  #' of addresses.
  #'
  #' Uses an Ergo GraphQL instance to retrieve the following columns:
  #' "transactionId", inclusionHeight", "timestamp"
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

  source("./R/env.R")

  tokenId <- list(tokenId = tokenId)
  View(tokenId)

  qry <- Query$new()
  qry$query('gettokeninfo', 'query getTokenInfo($tokenId: String!){
  tokens(tokenId: $tokenId) {
    name
  }
}')

  con <- GraphqlClient$new(gqlURL)
  res <- con$exec(qry$queries$gettokeninfo, tokenId)
  df <- as.data.frame(jsonlite::fromJSON(res))

  if (nrow(df) != 0) {
    return(as.vector(df))
  } else {
    return(NULL)
  }
}
