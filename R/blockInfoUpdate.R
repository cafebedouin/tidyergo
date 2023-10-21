blockInfoUpdate <- function() {

  #' blockInfoUpdate
  #'
  #' @description Updates the saved block information from
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
  cached_file = paste0('./data/blockInfo.csv')

  if (file.exists(cached_file)) {

    # Read in previously run data
    cache <- read.csv(paste0(cached_file), skip=0, header=TRUE)
    cache <- cache[ -c(1) ]
    height <- sum(cache[nrow(cache),1] + 1)
    df <- blockInfo(height)
    df <- rbind(cache,df)

  } else {
    df <- blockInfo(height = 2)

    # Cache data
    write.csv(df, file=paste0('./data/blockInfo.csv'))
  }
  write.csv(df, file=paste0('./data/blockInfo.csv'))
}

