blockInfo <- function(height=NULL,
                      gqlLimit=0) {

  #' blockInfo
  #'
  #' @description Returns a list of attributes of a block from the Ergo
  #' blockchain using GraphQL, including: blockChainTotalSize, blockCoins,
  #' blockFee, blockMiningTime, blockSize, difficulty, headerId, mainChain,
  #' maxBoxGix, maxTxGix, minerAddress, minerRevenue, minerReward, timestamp,
  #' totalCoinsInTxs, totalCoinsIssued, totalFees, totalMinersReward,
  #' totalMiningTime, totalTxsCount, txsCount, and txsSize.
  #'
  #' @param height integer. This is to specify the box to retrieve.
  #' @param gqlLimit integer. Max of requested block plus 9.
  #' @usage blockInfo(height)
  #' @return A single row dataframe with a column for each attribute is default.
  #' With the second parameter can call up to ten total.
  #' @examples
  #' blockInfo(1000000)
  #' blockInfo(1000000, 9)

  source("./R/config.R")
  source("./R/functions/currentHeight.R")

  if (is.null(height)) {
    height <- currentHeight()
  }
  qry <- Query$new()
  qry$query('getblockinfo', paste0('query {
    blocks(minHeight: ', height, ' maxHeight: ', sum(height + gqlLimit), ') {
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
  height <- seq.int(height, sum(height + gqlLimit))
  df <- cbind(height, df)
  return(df)
}

blockInfoUpdate <- function(block = currentHeight()) {

  #' blockInfoUpdate
  #'
  #' @description Repeats update of 10 rows of block information until the block
  #' height of the data equals current height.
  #' @usage blockInfoUpdate()
  #' @return There is no return. Data is written to disk on exit and in 10000
  #' block intervals.
  #' @examples blockInfoUpdate()

  source("./R/config.R")
  source("./R/functions/currentHeight.R")

  tic()
  options(scipen=999)
  cached_file = paste0('./data/blockInfo.csv')

  if (file.exists(cached_file)) {

    # Read in previously run data
    cache <- read.csv(paste0(cached_file), skip=0, header=TRUE)
    cache <- cache[ -c(1) ]
    height <- sum(cache[nrow(cache),1] + 1)
    print(height)
    df <- blockInfo(height)
    df <- rbind(cache, df)

  } else {
    df <- blockInfo(height = 2)
    # Cache data
    write.csv(df, file=paste0('./data/blockInfo.csv'))
  }

  count <- 1
  repeat{
    height <- sum(df[nrow(df),1] + 1)
    if (sum(block - height) >= 10) {
      rows <- blockInfo(height, 9)
    } else {
      rows <- blockInfo(height, 0)
    }
    df <- rbind(df, rows)
    if (count %% 10 == 0) {
      write.csv(df, file=paste0('./data/blockInfo.csv'))
    }
    print(height)
    if (height >= block) {
      write.csv(df, file=paste0('./data/blockInfo.csv'))
      toc()
      break
    }
    count <- count + 1
    Sys.sleep(runif(n=1, min=1, max=3))
  }
}

blockHeaders <- function(height=NULL,
                         limit=1) {

  #' blockHeaders
  #'
  #' @description Returns either the header id for a specific block, or
  #' a dataframe of up to 50 header ids starting from a specific block.
  #'
  #' @param height integer. This is to specify the block header to retrieve.
  #' @param limit integer. Max of 50, which includes height header.
  #' @usage blockHeaders(height)
  #' @return Returns either the header id for a specific block, or
  #' a dataframe of up to 50 header ids starting from a specific block.
  #' @examples
  #' blockheaders(1000000)
  #' blockheaders(1000000, 50)

  source("./R/config.R")
  req <- request(paste0(nodeURL,
                        "blocks?limit=", limit,
                        "&offset=", height))  %>%
    req_headers("Content-Type" = "application/json") %>%
    req_headers("accept" = "application/json")
  resp <- req_perform(req)
  headers <- resp_body_json(resp, check_type = TRUE, simplifyVector = TRUE)

  if (limit == 1) {
    return(headers)
  } else {
    height <- seq.int(height, sum(height + sum(limit - 1)))
    df <- cbind(height, headers)
    View(df)
    return(df)
  }
}
