addressesBalance <- function(addresses,
                             tokenId = "0000000000000000000000000000000000000000000000000000000000000000") {

  #' addressesBalance
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
  #' @import gqlr
  #'
  #' @note Some Ergo GraphQL servers will give an error
  #'
  #' @examples
  #' getbalance(address = "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3")
  #' getbalance(address = "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3", NULL)
  #' getbalance(address = "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3",
  #' "3abaf9df62c6810b0198333b122d130c29d76d64c6d7f4d57108afc5aaa95efb5")

  library(jsonlite)
  library(gqlr)

  source("./R/env.R")
  addresses <- toJSON(addresses)
  qry <- Query$new()
  qry$query('getbalance', paste0('query {
    addresses(addresses: ', addresses, ') {
      address
      balance {
        nanoErgs
        assets {
          amount
          decimals
          name
          tokenId
        }
      }
    }
  }'))

  con <- GraphqlClient$new(url = gqlURL)
  res <- con$exec(qry$queries$getbalance)
  df <- jsonlite::fromJSON(res)
  View(df)

  tmp <- as.data.frame(df$data$addresses$address)
  colnames(tmp) <- c("address")
  tmp$amount <- df$data$addresses$balance$nanoErgs
  tmp$decimals <- 9
  tmp$name <- "nanoErgs"
  tmp$tokenId <-"0000000000000000000000000000000000000000000000000000000000000000"

  for (i in 1:length(df$data$addresses$balance$assets)) {
    assets <-  df$data$addresses$balance$assets[[i]]
    assets$address <- c(tmp[i,1])
    assets <- assets[,c(5,1,3,2,4)]
    tmp <- rbind(tmp, assets)
    assets = NULL
  }
  df <- tmp[order(tmp$address, tmp$name), ]


  if (!is.null(tokenId)) {
    df <- df[df$tokenId == tokenId, ]
    if (nrow(df) == 0) {
        return(NULL)
       }
    }
  return(df)
}
