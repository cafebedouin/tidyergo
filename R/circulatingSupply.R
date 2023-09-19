circulatingSupply <- function() {

  #' circulatingSupply
  #'
  #' @description Returns current circulating supply.
  #' @usage circulatingSupply()
  #' @return [1] 73675797

  height <- currentHeight()
  df <- blockInfo(height)
  totalCoinsIssued <- as.numeric(df$totalCoinsIssued)
  totalCoinsIssued <- totalCoinsIssued / 10^9
  return(totalCoinsIssued)
}
