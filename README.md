# tidyergo

## Overview

[Ergo](https://ergoplatform.org/en/) is a resilient blockchain platform for contractual money. In addition to [Bitcoin](https://bitcoin.org/en/)-like blockchain architecture, the Ergo protocol provides advanced contractual capabilities based on the eUTXO model which is not possible with Bitcoin.

This R/Tidyverse package leverages the API endpoints from the official Ergo [Node](http://128.253.41.49:9053/) Ergo [Explorer](https://api.ergoplatform.com/api/v1/docs/) and Ergo [GraphQL](https://gql.ergoplatform.com/) instances. It also incorporates the APIs from [ErgoWatch](https://api.ergo.watch/docs), [Spectrum](https://api.spectrum.fi/v1/docs/), [Tokenjay](https://api.tokenjay.app/swagger-ui/index.html?), [ErgoPad](https://github.com/ergo-pad/ergopad-api/tree/dev/app/api/v1/routes) and [SkyHarbor](https://app.swaggerhub.com/apis-docs/SKYHARBORNFT_1/marketplace-api/1.0.0) to retrieve blockchain data across the ecosystem.

## Installation
```r
# install.packages("devtools")
devtools::install_github("Eeysirhc/tidyergo")
```

## Usage

`library(tidyergo)` will load the API endpoints for each service with their own prefix identifier. 

* Ergo Explorer: `ee_`
* [ErgoWatch](https://github.com/Eeysirhc/tidyergo/blob/main/R/ergowatch.R): `ew_`
* [ErgoDEX](https://github.com/Eeysirhc/tidyergo/blob/main/R/ergodex.R): `ed_`
* ErgoPad: `ep_`

## Examples

### ErgoWatch

#### Balance history of an address
```r
bearwhale <- "9hyDXH72HoNTiG2pvxFQwxAhWBU8CrbvwtJDtnYoa4jfpaSk1d3"
ew_addressesBalanceHistory(bearwhale)
```

#### Current P2PK address count
```r
# addresses holding >= 1M+ $MiGoreng
migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
ew_p2pkCount(bal_ge = 1000000, token_id = migoreng)
```

#### Token supply: emitted, circulating, and burned
```r
migoreng <- "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2"
ew_tokensSupply(migoreng)
```

### ErgoDEX

#### Retrieve AMM platform statistics
```r
ed_platformStats()
```

#### Retrieve statistics for all liquidity pools
```r
ed_allPoolStats()
```


## Packages

Installing this package also installs a selection of other R packages as dependencies. 

* [httr](https://github.com/r-lib/httr), web APIs
* [jsonlite](https://github.com/jeroen/jsonlite), JSON handling
* [dplyr](https://dplyr.tidyverse.org/), data manipulation
* [tidyr](https://tidyr.tidyverse.org/), data tidying
* [purrr](https://purrr.tidyverse.org/), functional programming

## Contributing

Contributions make the open source community an amazing place to inspire, learn, and create. Thus, any improvements to this package is highly appreciated.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/new-stuff`)
3. Commit your changes (`git commit -am "Add new stuff improvements"`)
4. Push to branch (`git push origin feature/new-stuff`)
5. Open a pull request

