# utils.R
# functions: currentDifficulty, currentHeight, gqlURL, gqlVersion, mempool,
#            state, timestampToDate

source("./R/config.R")

currentDifficulty <- function() {

  #' currentDifficulty
  #'
  #' @description The program uses an Ergo GraphQL instance to retrieve the
  #' current difficulty of the blockchain.
  #' @usage currentDifficulty()
  #' @return "2157271878467584"

  gqlURL <- gqlURL()
  qry <- Query$new()
  qry$query('difficulty', 'query { state { difficulty } }')

  con <- GraphqlClient$new(gqlURL)
  res <- con$exec(qry$queries$difficulty)
  json <- as.vector(jsonlite::fromJSON(res))
  difficulty <- json$data$state$difficulty

  if (!is.null(difficulty)) {
    return(difficulty)
  } else {
    return(NULL)
  }
}

currentHeight <- function() {

  #' currentHeight
  #'
  #' @description The program uses an Ergo GraphQL instance to retrieve the
  #' current height of the blockchain.
  #' @usage currentHeight()
  #' @return [1] 1117448

  gqlURL <- gqlURL()
  qry <- Query$new()
  qry$query('height', 'query { state { height } }')

  con <- GraphqlClient$new(gqlURL)
  res <- con$exec(qry$queries$height)
  json <- as.vector(jsonlite::fromJSON(res))
  View(json)
  height <- json$data$state$height

  if (!is.null(height)) {
    return(height)
  } else {
    return(NULL)
  }
}

gqlURL <- function() {

  #' gqlURL
  #'
  #' @description Returns a single, random Ergo GraphQL instance from list
  #' @usage gqlURL()
  #' @return a URL string for an Ergo GraphQL instance

  gqlList <- c("https://explorer-graphql.ergohost.io/",
               "https://gql.ergoplatform.com",
               "https://explore.sigmaspace.io/api/graphql",
               "https://graphql.erg.zelcore.io/",
               "https://graphql.ergo.aap.cornell.edu/")

  gqlURL <- sample(gqlList, 1)

  return(gqlURL)
}

gqlVersion <- function() {

  #' gqlVersion
  #'
  #' @description The program uses an Ergo GraphQL instance to retrieve the
  #' version of the GraphQL instance.
  #' @usage gqlVersion
  #' @return "2157271878467584"

  gqlURL <- gqlURL()
  qry <- Query$new()
  qry$query('getversioninfo', 'query { info { version } }')

  con <- GraphqlClient$new(gqlURL)
  res <- con$exec(qry$queries$getversioninfo)
  json <- as.list(jsonlite::fromJSON(res))
  version <- as.character(json$data$info$version)

  if (!is.null(version)) {
    return(version)
  } else {
    return(NULL)
  }
}

mempool <- function() {

  #' mempool
  #'
  #' @description Returns size of the mempool in bytes and number of transactions.
  #' @usage mempool()
  #' @return A dataframe with mempool size and transactionsCount

  gqlURL <- gqlURL()
  qry <- Query$new()
  qry$query('mempool',
            'query { mempool { size,
                               transactionsCount } }')

  con <- GraphqlClient$new(gqlURL)
  res <- con$exec(qry$queries$mempool)
  mempool <- as.data.frame(jsonlite::fromJSON(res))
  names(mempool) <- gsub("data.mempool.", "", names(mempool))

  if (!is.null(mempool)) {
    return(mempool)
  } else {
    return(NULL)
  }
}

state <- function() {

  #' state
  #'
  #' @description Returns a GraphQL query that returns the state of the
  #' Ergo blockchain including: blockId, height, boxGlobalIndex,
  #' transactionGlobalIndex, network and difficulty in a dataframe.
  #' @usage state()
  #' @return Returns the state of the in a dataframe with the following columns:
  #' blockId, height, boxGlobalIndex, transactionGlobalIndex, network and
  #' difficulty.

  gqlURL <- gqlURL()

  qry <- Query$new()
  qry$query('state', 'query
  { state
    { blockId
      height
      boxGlobalIndex
      transactionGlobalIndex
      network
      difficulty} }')

  con <- GraphqlClient$new(gqlURL)
  res <- con$exec(qry$queries$state)
  df <- as.data.frame(jsonlite::fromJSON(res))
  names(df) <- gsub("data.state.", "", names(df))

  if (nrow(df) != 0) {
    return(as.data.frame(df))
  } else {
    return(NULL)
  }
}

timestampToDate <- function(timestamp) {

  #' timestampDate
  #'
  #' @description Takes a timestamp and returns a date and time in POSIXct.
  #' @param timestamp Unix Epoch, which is the unit blocks are timestamped with.
  #' @usage timestampDate(1695006885506)
  #' @return "2023-09-17 23:14:45 EDT"
  #' @note Need to divide by 1,000 to get the correct date.

  date <- as.POSIXct(sum(timestamp/1000), origin = "1970-01-01", tz="UTC")
  return(date)
}



