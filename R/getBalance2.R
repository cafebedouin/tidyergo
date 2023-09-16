getBalance2 <- function(addresses, tokenId = NULL) {

  #' getBalance
  #'
  #' Gets current amount of nanoErg, amount of a token, or complete nanoErg and
  #' token balances of an address in a data frame.  nanoErgs are listed with a
  #' tokenId of 64 zeros.
  #'
  #' @param address Required: the P2PK address.
  #' @param tokenId: Filters returned values to nanoErgs or supplied tokenId,
  #' passing NULL provides the address balance in a dataframe.
  #'
  #' @return the amount of nanoErg, the amount of a token or a dataframe with
  #' the columns: address, tokenId, amount, decimals, name, and tokenType.
  #'
  #' @import jsonlite
  #'
  #' @examples
  #' getbalance(address = "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3")
  #' getbalance(address = "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3", NULL)
  #' getbalance(address = "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3",
  #' "3abaf9df62c6810b0198333b122d130c29d76d64c6d7f4d57108afc5aaa95efb5")

  library(jsonlite)
  library(httr2)
  library(purrr)
  library(gqlr)
  library(dplyr)

  source("./R/env.R")
  addresses <- toJSON(addresses)
  print(addresses)
  print(tokenId)
  qry <- Query$new()
  qry$query('getbalance', paste0('query {
  addresses(addresses: ', addresses, ') {
    address
    balance {
      nanoErgs
      assets(tokenId: ', tokenId, ') {
        amount
        decimals
        name
        tokenId
      }
    }
  }
}'))
  print(qry$queries$getbalance)
  con <- GraphqlClient$new(url = gqlURL)
  res <- con$exec(qry$queries$getbalance)
  df <- jsonlite::fromJSON(res)
  return(df)
}

#  df = jsonData
#  addnanoErg <- c("0000000000000000000000000000000000000000000000000000000000000000",
#                  jsonData$nanoErgs, "9", "nanoErgs", "Coin")
#  addTokens <- jsonData$tokens
#  df <- rbind(addnanoErg, addTokens)
#  df <- cbind(address = address, df)

#  df$amount <- as.double(df$amount)
#  df$decimals <- as.double(df$decimals)
#  df$calc <- df$amount / 10^df$decimals

#  if (!is.null(tokenId)) {
#    df <- df[df$tokenId == tokenId, ]
#    df <- subset(df, select = (amount))
#    if (nrow(df) == 0){
#      df <- 0
#    }
#  }
#  return(df)
# }
