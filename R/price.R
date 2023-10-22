price <- function(ticker="ergo",
                  currency="usd") {

  #' price
  #'
  #' @description This function returns the current price of a cryptocurrency.
  #' Checks CoinGecko for cryptocurrency price and if it fails,
  #' it checks Ergopad prices, which are derived from the Spectrum DEX. If there
  #' are no matches, NULL
  #' @param ticker character. This is the cryptocurrency ticker.
  #' @usage price("ticker")
  #' @return 0.05063884
  #' @details Checks CoinGecko for cryptocurrency price and if it fails,
  #' it checks Ergopad prices, which are derived from the Spectrum DEX. If there
  #' are no matches, NULL
  #' @note Ergopad's API is used because it has a cleaner interface with more
  #' prices. If the CoinGecko price fails, the prices returned from Ergopad are
  #' all in USD. The CoinGecko currency can be denominated in the following
  #' currencies: "btc","eth","ltc","bch","bnb","eos","xrp","xlm","link","dot",
  #' "yfi","usd","aed","ars","aud","bdt","bhd","bmd","brl","cad","chf","clp",
  #' "cny","czk","dkk","eur","gbp","hkd","huf","idr","ils","inr","jpy","krw",
  #' "kwd","lkr","mmk","mxn","myr","ngn","nok","nzd","php","pkr","pln","rub",
  #' "sar","sek","sgd","thb","try","twd","uah","vef","vnd","zar","xdr","xag",
  #' "xau","bits","sats".
  #'
  #' Current list can be accessed at the following URL.
  #' https://api.coingecko.com/api/v3/simple/supported_vs_currencies
  #' @examples
  #' price("ergo", "btc")
  #' price("comet")
  #' price("bitcoin")

  source("./R/config.R")
  source("./R/utils.R")
  price <- NULL

  req <- request(paste0(coingeckoURL,
                        "api/v3/simple/price?ids=",
                        ticker,
                        "&amp;vs_currencies=",
                        currency))  %>%
    req_headers("Content-Type" = "application/json") %>%
    req_headers("accept" = "application/json")
  resp <- req_perform(req)
  df <- resp_body_json(resp, check_type = TRUE, simplifyVector = TRUE)
  str <- eval(paste0("df$", ticker, "$", currency))
  price <- eval(parse(text = str))

  if (is.null(price)) {
    req <- request(paste0(ergopadURL, "asset/price/", ticker)) %>%
      req_headers("Content-Type" = "application/json") %>%
      req_headers("accept" = "application/json")

    resp <- req_perform(req)
    df <- resp_body_json(resp, check_type = TRUE, simplifyVector = TRUE)
    price <- df$price
  }
  return(price)
}
