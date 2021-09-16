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
    web <-  httr::GET(url_to_scrap,
                      httr::set_cookies(platform = platform))
    data_page <- web %>%
      httr::content() %>%
      rvest::html_nodes(xpath = "//table") %>%
      magrittr::extract(1) %>%
      rvest::html_table() %>%
      magrittr::extract2(1)

    if (i == 1) {
      tabla <- data_page

      # Add team, nation and league of each player
      web %>%
        httr::content() %>%
        rvest::html_nodes(xpath = "//table") %>%
        magrittr::extract(1) %>%
        rvest::html_elements(".players_club_nation") %>%
        xml2::xml_contents() %>%
        xml2::xml_attr("data-original-title") %>%
        stats::na.omit() %>%
        as.vector() -> table_team_nation_league

      tabla$team <- NA
      tabla$nation <- NA
      tabla$league <- NA

      for(j in 1:nrow(tabla)){
        tabla$team[j]   <- table_team_nation_league[3 * j - 2]
        tabla$nation[j] <- table_team_nation_league[3 * j - 1]
        tabla$league[j] <- table_team_nation_league[3 * j]
      }
    } else {
      Sys.sleep(sleep_time)
      tabla.i <- data_page

      # Add team, nation and league of each player
      web %>%
        httr::content() %>%
        rvest::html_nodes(xpath = "//table") %>%
        magrittr::extract(1) %>%
        rvest::html_elements(".players_club_nation") %>%
        xml2::xml_contents() %>%
        xml2::xml_attr("data-original-title") %>%
        stats::na.omit() %>%
        as.vector() -> table_team_nation_league

      tabla.i$team <- NA
      tabla.i$nation <- NA
      tabla.i$league <- NA

      for(j in 1:nrow(tabla.i)){
        tabla.i$team[j]   <- table_team_nation_league[3 * j - 2]
        tabla.i$nation[j] <- table_team_nation_league[3 * j - 1]
        tabla.i$league[j] <- table_team_nation_league[3 * j]
      }

      if(tabla.i[1, 1] != "No Results") tabla <- rbind(tabla, tabla.i)
    }

    if (verbose == T) print(paste0("Player(s) found: ", nrow(tabla)))

    i <- i + 1
  }

  # Table names
  colnames(tabla) <- c(
    "name", "rating", "position", "version", "price", "skills", "weak_foot", "work_rate",
    "pac", "sho", "pas", "dri", "def", "phy",
    "hei", "popularity", "base_stats", "in_game_stats", "team", "nation", "league"
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

  # Reorder variables
  tabla <- tabla %>%
    dplyr::select("name", "rating", "position", "version", "price", "skills", "weak_foot",
    "pac", "sho", "pas", "dri", "def", "phy",
    "hei", "popularity", "base_stats", "in_game_stats", "wr_attack", "wr_defense",
    "wei", "team", "nation", "league"
  )

  return(tabla)
}


