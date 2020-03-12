#' futbin_scrap extract players in a URL in Futbin.
#'
#' @export futbin_scrap
#' @importFrom dplyr %>%
#' @param url Futbin URL to web scrap. All pages of the URL will be automatically detected and downloaded.
#' Futbin webpage (futbin.com/players) can be used to make customised filters, and then copy the URL here.
#' @param sleep_time Time ellapsed between one download and the next. Please respect Futbin API.
#' @param messages Optional. To show additional messages about webpage used and number of players found.
#' @return A dataframe with all the players found searching for \code{name} and  \code{version}.
#' @examples
#' futbin_scrap(url = "https://www.futbin.com/players?page=1&club=2")
#' futbin_scrap(url = "https://www.futbin.com/players?page=1&nation=45&league=53&position=CB")

futbin_scrap <- function(url, sleep_time = 5, messages = TRUE) {

  url_split <- strsplit(x = url, split = "page=1", fixed = TRUE) %>% unlist

  # Initialize
  i <- 1
  tabla.i <- matrix(1)

  while(tabla.i[1, 1] != "No Results"){

    # URL creation
    if(length(url_split) == 1) url_to_scrap <- paste0(url_split, "&page=", i)
    if(length(url_split) == 2) url_to_scrap <- paste0(url_split[1], "page=", i, url_split[2])

    if (messages == T) print(paste0("Reading... ", url_to_scrap))

    # Web scraping
    if (i == 1) {
      tabla <- xml2::read_html(url_to_scrap) %>%
        rvest::html_nodes(xpath = "//table") %>%
        magrittr::extract(3) %>%
        rvest::html_table() %>%
        magrittr::extract2(1)
    } else {
      Sys.sleep(sleep_time)
      tabla.i <- xml2::read_html(url_to_scrap) %>%
        rvest::html_nodes(xpath = "//table") %>%
        magrittr::extract(3) %>%
        rvest::html_table() %>%
        magrittr::extract2(1)
      if(tabla.i[1, 1] != "No Results") tabla <- rbind(tabla, tabla.i)
    }

    if (messages == T) print(paste0("Player(s) found: ", nrow(tabla)))

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

