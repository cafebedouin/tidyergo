currentDifficulty <- function() {

  #' addressDifficulty
  #'
  #' @description Returns current network difficulty
  #'
  #' @usage addressDifficulty()
  #' @return The
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

  qry <- Query$new()
  qry$query('getdifficultyinfo', 'query { state { difficulty } }')

  con <- GraphqlClient$new(gqlURL)
  res <- con$exec(qry$queries$getdifficultyinfo)
  json <- as.vector(jsonlite::fromJSON(res))
  difficulty <- json$data$state$difficulty

  if (!is.null(difficulty)) {
    return(difficulty)
  } else {
    return(NULL)
  }
}
