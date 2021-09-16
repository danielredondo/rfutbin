#' futbin_search searchs players in futbin.
#'
#' @export futbin_search
#' @importFrom dplyr %>%
#' @param name Optional. Vector with the names of the players. If not specified
#' it will report the 30 highest-rated players of the game.
#' @param platform Platform to get the prices from. Default is `ps4`. Other options are `xone` (XBox One) and `pc`.
#' @param version Optional. Version of the cards. Some options are "Rare",
#' "Non-Rare", "IF" (In-Form), "SIF" (Second In-Form), ...
#' @param verbose Optional. To show additional verbose about webpage used and number of players found.
#' @return A dataframe with all the players found searching for \code{name} and  \code{version}.
#' @examples
#'
#' \dontrun{
#' # Search for a player
#' futbin_search(name = "Lionel Messi")
#'
#' # Search for a player and get the PC price
#' futbin_search(name = "Lionel Messi", platform = "pc")
#'
#' # Search for a player and get the XBox One price
#' futbin_search(name = "Lionel Messi", platform = "xone")
#'
#' # Search for more than one player
#' futbin_search(name = c("Lionel Messi", "Cristiano Ronaldo"))
#'
#' # Search for a specific version of a player
#' futbin_search(name = "Lewandowski", version = "Rare")
#' futbin_search(name = "Luis Suarez", version = "OTW")
#'
#' # Search for an In-Form card of a player, showing verbose
#' futbin_search(name = "Grealish", version = "IF", verbose = TRUE)
#' }

futbin_search <- function(name = "", platform = "ps4", version = NULL,verbose = F) {
  if (length(name) == 1) {

    # Name transformation
    name <- name %>%
      tolower() %>%
      gsub(pattern = " ", replacement = "+") %>%
      chartr(old = "\u00e1\u00e9\u00ed\u00f3\u00fa", new = "aeiou") %>%
      chartr(old = "\u00e0\u00e8\u00ec\u00f2\u00f9", new = "aeiou") %>%
      chartr(old = "\u00e2\u00ea\u00ee\u00f4\u00fb", new = "aeiou") %>%
      chartr(old = "\u00f1", new = "n")

    # URL creation
    url <- paste0("https://www.futbin.com/21/players?page=1&search=", name)

    # Web scraping
    web <- httr::GET(url, httr::set_cookies(platform = platform)) # To download only once
    tabla <- web %>%
      httr::content() %>%
      rvest::html_nodes(xpath = "//table") %>%
      magrittr::extract(1) %>%
      rvest::html_table() %>%
      magrittr::extract2(1)

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

    for(i in 1:nrow(tabla)){
      tabla$team[i]   <- table_team_nation_league[3 * i - 2]
      tabla$nation[i] <- table_team_nation_league[3 * i - 1]
      tabla$league[i] <- table_team_nation_league[3 * i]
    }

    # Filter version of the player
    if (is.null(version) == FALSE){
      version_selected <- version
      tabla <- subset(tabla, version == version_selected)
    }

    if (verbose == T) print(paste0("Reading... ", url))
    if (verbose == T) print(paste0("Player(s) found: ", nrow(tabla)))

    return(tabla)
  } else {
    # Recursive search
    first.name <- name[1]
    other.names <- name[-1]
    return(rbind(futbin_search(first.name, platform, version, verbose), futbin_search(other.names, platform, version, verbose)))
  }
}

