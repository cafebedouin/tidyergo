getTokenCommon <- function(x) {

    #' addressTransactions
    #'
    #' @description Returns a list of transactionIds for a given address or list
    #' of addresses.
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
    #'
    #'
    #'

    df <- data.frame(tokenId = c("03faf2cb329f2e90d6d23b58d91bbb6c046aa143261cc21f52fbe2824bfcbf04",
                                 "003bd19d0187117f130b62e1bcab0939929ff5c7709f843c5c4dd158949285d0",
                                 "0cd8c9f416e5b1ca9f986a7f10a84191dfb85941619e49e53c0dc30ebf83324b",
                                 "36aba4b4a97b65be491cf9f5ca57b5408b0da8d0194f30ec8330d1e8946161c1",
                                 "fbbaac7337d051c10fc3da0ccb864f4d32d40027551e1c3ea3ce361f39b91e40",
                                 "e91cbc48016eb390f8f872aa2962772863e2e840708517d1ab85e57451f91bed",
                                 "669e24e2b39b06b6134bc0dd67ee57f4ce2cbc1a5b552e39d655737a05f6f384",
                                 "74d7745b32e895008027a853ea7a6974ba3cbd1efa986537563c12d6ab22c506",
                                 "406e36ea72acf055057acb11dc36b37456cab0cc9e78ae52402eb8ad3509790f",
                                 "5a34d53ca483924b9a6aa0c771f11888881b516a8d1a9cdc535d063fe26d065e",
                                 "47959eb4a860ea11a29b09d5034c781d97549e50705bd0f3a6ea0303e03af6f0",
                                 "472c3d4ecaa08fb7392ff041ee2e6af75f4a558810a74b28600549d5392810e8",
                                 "d71693c49a84fbbecd4908c94813b46514b18b67a99952dc1e6e4791556de413",
                                 "0b7c3cd3145209c6f455e2a0b890195eafcde934e09ca3d54d7972d1f1ce3c44",
                                 "6e6547eb720ac46703d20a2903fc588c9a7079d2f32897b6f222cf443c5cdac7",
                                 "863b62d8734dd8693337e042bc167da87e5f79ec6539a0e831f75535e33bafd0",
                                 "45b546c5ddb90b647b0b96b1bf96e0f2e819015b5c300da6cff3c1a2863222c1",
                                 "0e73d5604bbd5cf9647ce23e229a129bae587d11a4fc11ed5068aec3a2f62c06",
                                 "0779ec04f2fae64e87418a1ad917639d4668f78484f45df962b0dec14a2591d2",
                                 "185e217d80d797800bfa699afda708ee101ae664f8ea237d9fc3a3824b7c3ecb",
                                 "45623c86e3b301157ebefab7901465a2b458be2e8f4e3b64c35e329b43068ef0",
                                 "9dbc8dd9d7ea75e38ef43cf3c0ffde2c55fd74d58ac7fc0489ec8ffee082991b",
                                 "007fd64d1ee54d78dd269c8930a38286caa28d3f29d27cadcb796418ab15c283",
                                 "02f31739e2e4937bb9afb552943753d1e3e9cdd1a5e5661949cb0cef93f907ea",
                                 "00b1e236b60b95c2c6f8007a9d89bc460fc9e78f98b09faec9449007b40bccf3",
                                 "00bd762484086cf560d3127eb53f0769d76244d9737636b2699d55c56cd470bf",
                                 "94180232cc0d91447178a0a995e2c14c57fbf03b06d5d87d5f79226094f52ffc",
                                 "6de6f46e5c3eca524d938d822e444b924dbffbe02e5d34bd9dcd4bbfe9e85940",
                                 "1fd6e032e8476c4aa54c18c1a308dce83940e8f4a28f576440513ed7326ad489",
                                 "e8b20745ee9d18817305f32eb21015831a48f02d40980de6e849f886dca7f807",
                                 "18c938e1924fc3eadc266e75ec02d81fe73b56e4e9f4e268dffffcb30387c42d",
                                 "3405d8f709a19479839597f9a22a7553bdfc1a590a427572787d7c44a88b6386",
                                 "4c8ac00a28b198219042af9c03937eecb422b34490d55537366dc9245e85d4e1",
                                 "9a06d9e545a41fd51eeffc5e20d818073bf820c635e2a9d922269913e0de369d",
                                 "d1d2ae2ac0456aa43550dd4fda45e4f866d523be9170d3a3e4cab43a83926334",
                                 "ba553573f83c61be880d79db0f4068177fa75ab7c250ce3543f7e7aeb471a9d2",
                                 "91289d5cefb9d78e3ea248d4e9c5b0e3c3de54f64bfae85c0070580961995262",
                                 "2a4db3601ab5835392d5202b3f88c13932f338c539ba5f131fb1370bf60f32b3",
                                 "0fdb7ff8b37479b6eb7aab38d45af2cfeefabbefdc7eebc0348d25dd65bc2c91",
                                 "089990451bb430f05a85f4ef3bcb6ebf852b3d6ee68d86d78658b9ccef20074f"),
                   tokenName = c("SigUSD", "SigRSV", "COMET", "Erdoge", "kushti",
                                 "Ergold", "Have_A_Nice_Day", "thisguyfucks",
                                 "ErgTip", "LunaDog", "LambChops","NETA",
                                 "ergopad", "ValleyDAO","ChickenNuggies",
                                 "CyberPixels", "commons token", "EASA token", "Mi Goreng",
                                 "  🍆💦", "Hopium 2.0", "ErMoon", "EXLE",
                                 "TeraHertz","EGIO", "EPOS", "eTOSI", "ogre",
                                 "Paideia", "Flux", "AHT", "love",
                                 "Wooden Nickels", "SPF", "GreasyCex", "$BASS",
                                 "PEPERG", "Gyros", "$Lambo", "QUACKS"))

    if (nchar(x) == 64) {
      result <- grep(x, df$tokenId)
      if (length(result) > 0) {
        return(df$tokenName[result])
      } else {
        return(NULL)
      }
    } else {
      result <- grep(x, df$tokenName)
      if (length(result) > 0) {
        return(df$tokenId[result])
      } else {
        return(NULL)
      }
  }
}
