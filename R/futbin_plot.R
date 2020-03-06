#' futbin_plot makes an interactive radar plot of the stats of the players.
#'
#' @export futbin_plot
#' @importFrom magrittr %>%
#' @param df dataframe generated with columns `pac`, `sho`, `pas`, `dri`, `def`, `phy`.
#' This dataframe can be obtained from function \code{\link{futbin_search}}.
#' @param gk Optional. If `TRUE`, the labels of the plot are the stats
#' for goalkeepers: diving, handling, kicking, reflexes, speed and position.
#' @return An interactive radar plot of the stats.
#' @examples
#'
#' defenders <- futbin_search(name = c("Militao", "Gerard Pique"), version = "Normal")
#' futbin_plot(defenders)
#'
#' some_goalkeepers <- futbin_search(name = c("De Gea", "Kepa", "Hugo Lloris"), version = "Normal")
#' futbin_plot(some_goalkeepers, gk = TRUE)
#'

futbin_plot <- function(df, gk = FALSE){
  df_radar <- data.frame(
    stats = c("Pace", "Shooting", "Passing", "Dribbling", "Defending", "Physical"),
    t(cbind(df$pac, df$sho, df$pas, df$dri, df$def, df$phy))
  )

  if(gk == TRUE) df_radar$stats <- c("Diving", "Handling", "Kicking", "Reflexes", "Speed", "Positioning")

  colnames(df_radar) <- c("stats", paste0(df$name, " (", df$rat, ", ", df$ver, ")"))

    radarchart::chartJSRadar(
      scores = df_radar,
      polyAlpha = 0,
      maxScale = 99,
      scaleLineWidth=20
    )
}

#barcelona_defenders <- c("Jordi Alba", "Pique", "Lenglet", "Sergi Roberto")
#futbin_plot(futbin_search(barcelona_defenders, version = "Normal"))
#
#goalkeepers_chelsea <- c("Kepa", "Willy Caballero")
#futbin_plot(futbin_search(goalkeepers_chelsea, version = "Normal"), gk = T)

