#' futbin_scrap extracts all players of a Futbin URL.
#'
#' @export futbin_scrap
#' @importFrom dplyr %>%
#' @param url Futbin URL to web scrap.
#' Futbin webpage (https://www.futbin.com/players) can be used to make customised filters, and then copy the URL here.
#' All the players found in the URL (and the next pages) will be automatically detected and downloaded.
#' @param platform Platform to get the prices from. Default is `ps4`. Other options are `xone` (XBox One) and `pc`.
#' @param sleep_time Time (in seconds) ellapsed between scraping one page and the next one. Please respect Futbin API.
#' @param verbose Optional. To show additional verbose about webpage used and number of players found.
#' @return A dataframe with all the players found at the URL.
#' @examples
#' \dontrun{
#' # Aston Villa players -> To get the URL, go to futbin.com/players and filter
#' futbin_scrap(url = "https://www.futbin.com/players?page=1&club=2")
#'
#' # Spanish centre-backs from La Liga -> To get the URL, go to futbin.com/players and filter
#' futbin_scrap(url = "https://www.futbin.com/players?page=1&nation=45&league=53&position=CB")
#' }

futbin_scrap <- function(url, platform = "ps4", sleep_time = 5, verbose = TRUE) {

  url_split <- strsplit(x = url, split = "page=1", fixed = TRUE) %>% unlist

  # Initialize
  i <- 1
  tabla.i <- matrix(1)

  while(tabla.i[1, 1] != "No Results"){

    # URL creation
    if(length(url_split) == 1) url_to_scrap <- paste0(url_split, "&page=", i)
    if(length(url_split) == 2) url_to_scrap <- paste0(url_split[1], "page=", i, url_split[2])

    if (verbose == T) print(paste0("Reading... ", url_to_scrap))

    # Web scraping
    if (i == 1) {
      tabla <- httr::GET(url_to_scrap,
                         httr::set_cookies(platform = platform)) %>%
        httr::content() %>%
        rvest::html_nodes(xpath = "//table") %>%
        magrittr::extract(1) %>%
        rvest::html_table() %>%
        magrittr::extract2(1)
    } else {
      Sys.sleep(sleep_time)
      tabla.i <- httr::GET(url_to_scrap,
                           httr::set_cookies(platform = platform)) %>%
        httr::content() %>%
        rvest::html_nodes(xpath = "//table") %>%
        magrittr::extract(1) %>%
        rvest::html_table() %>%
        magrittr::extract2(1)
      if(tabla.i[1, 1] != "No Results") tabla <- rbind(tabla, tabla.i)
    }

    if (verbose == T) print(paste0("Player(s) found: ", nrow(tabla)))

    i <- i + 1
  }

  # Table names
  colnames(tabla) <- c(
    "name", "rating", "position", "version", "price", "skills", "weak_foot", "work_rate",
    "pac", "sho", "pas", "dri", "def", "phy",
    "hei", "popularity", "base_stats", "in_game_stats"
  )

  # Work rates (attack and defense)
  tabla$wr_attack <- substr(tabla$work_rate, 0, 1)
  tabla$wr_defense <- substr(tabla$work_rate, 5, 6)
  tabla <- tabla[ , -which(names(tabla) == "work_rate")]

  # Weigth and height
  tabla$wei <- substr(tabla$hei, regexpr("[(]", tabla$hei) + 1, regexpr("[k]", tabla$hei) - 1)
  tabla$hei <- substr(tabla$hei, 1, 3)

  # Fixing prices (1K = 1000, 1M = 1000000)
  aux_k <- regexpr(pattern = "K", tabla$price, fixed = TRUE)
  aux_M <- regexpr(pattern = "M", tabla$price, fixed = TRUE)
  tabla$price <- tabla$price
  tabla$price <- gsub("K", "", tabla$price)
  tabla$price <- gsub("M", "", tabla$price)
  tabla$price <- as.double(tabla$price)
  for (i in 1:nrow(tabla)) {
    if (aux_k[i] != -1) tabla$price[i] <- tabla$price[i] * 1000
    if (aux_M[i] != -1) tabla$price[i] <- tabla$price[i] * 1000000
  }

  return(tabla)
}

