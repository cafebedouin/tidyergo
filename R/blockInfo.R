blockInfo <- function(height=NULL) {

  #' blockInfo
  #'
  #' @description Returns a list of 50 of the most recent transactionIds for
  #' an address or list of addresses.
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
  #' @note
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
  if (is.null(height)) {
    height <- currentHeight()
  }
  qry <- Query$new()
  qry$query('getblockinfo', paste0('query {
    blocks(height: ', height, ') {
      blockChainTotalSize
      blockCoins
      blockFee
      blockMiningTime
      blockSize
      difficulty
      headerId
      mainChain
      maxBoxGix
      maxTxGix
      minerAddress
      minerRevenue
      minerReward
      timestamp
      totalCoinsInTxs
      totalCoinsIssued
      totalFees
      totalMinersReward
      totalMiningTime
      totalTxsCount
      txsCount
      txsSize
    }
  }'))

  con <- GraphqlClient$new(url = gqlURL)
  res <- con$exec(qry$queries$getblockinfo)
  df <- jsonlite::fromJSON(res)
  df <- df$data$blocks
  df <- cbind(height, df)
  return(df)
}

