#' futbin_search searchs players in futbin.
#'
#' @export futbin_search
#' @importFrom dplyr %>%
#' @param name Optional. Vector with the names of the players. If not specified
#' it will report the 30 highest-rated players of the game.
#' @param version Optional. Version of the cards. Some options are "Normal",
#' "CL" (Champions League), "IF" (In-Form), "SIF" (Second In-Form), ...
#' @param messages Optional. To show additional messages about webpage used and number of players found.
#' @return A dataframe with all the players found searching for \code{name} and  \code{version}.
#' @examples
#' futbin_search(name = "Lionel Messi")
#' futbin_search(name = c("Lionel Messi", "Griezmann"), version = "Normal")
#' futbin_search(name = "Luka Modric", version = "IF", messages = TRUE)

futbin_search <- function(name = "", version = NULL, messages = F) {
  if (length(name) == 1) {

    # Name transformation
    name <- name %>%
      tolower() %>%
      gsub(pattern = " ", replacement = "+")

    # URL creation
    url <- paste0("https://www.futbin.com/20/players?page=1&search=", name)

    # Web scraping
    tabla <- xml2::read_html(url) %>%
      rvest::html_nodes(xpath = "//table") %>%
      magrittr::extract(3) %>%
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

    # Filter version of the player
    if (is.null(version) == FALSE) tabla <- subset(tabla, tabla$version == version)

    if (messages == T) print(paste0("Reading... ", url))
    if (messages == T) print(paste0("Player(s) found: ", nrow(tabla)))

    return(tabla)
  } else {
    # Recursive search
    first.name <- name[1]
    other.names <- name[-1]
    return(rbind(futbin_search(first.name, version, messages), futbin_search(other.names, version, messages)))
  }
}

