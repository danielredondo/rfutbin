  - [rfutbin](#rfutbin)
      - [Installation](#installation)
      - [Functions](#functions)
      - [Examples](#examples)

# rfutbin

rfutbin: Search prices for FIFA Ultimate Team players in [Futbin
webpage](https://www.futbin.com).

## Installation

This package is currently available only on GitHub. To install it, use
the `devtools` package:

``` r
library(devtools)
install_github("danielredondo/rfutbin")
```

## Functions

### futbin\_search

`futbin_search` searchs players in futbin. It has the following
parameters:

  - `name`. Optional. Vector with the names of the players. If not
    specified, it will report the 30 highest-rated players of the game.

  - `version`. Optional. Version of the cards. Some options are “Rare”,
    “Non-Rare”, “IF” (In-Form), “SIF” (Second In-Form), …

  - `verbose`. Optional. To show additional messages (webpage scraped
    and number of players found).

The output of the function is a dataframe with all the players found
searching for `name` and `version`.

### futbin\_plot

`futbin_plot` makes an interactive radar plot of the stats of the
players. It has the following parameters:

  - `df` dataframe generated with columns `pac`, `sho`, `pas`, `dri`,
    `def`, `phy`. This dataframe can be obtained from function
    `futbin_search`.
  - `gk` Optional. If `TRUE`, the labels of the plot are the stats for
    goalkeepers: diving, handling, kicking, reflexes, speed and
    position.

The output of the function is an interactive radar plot of the stats.

## Examples

#### Load package

``` r
library(rfutbin)
```

#### Search for a player

``` r
futbin_search(name = "Lionel Messi")
#>           name rating position version  price skills weak_foot pac sho pas dri
#> 1 Lionel Messi     93       RW    Rare 843000      4         4  85  92  91  95
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  38  65 170        654        466          2273         M          L  72
```

#### Search for more than one player

``` r
futbin_search(name = c("Lionel Messi", "Cristiano Ronaldo"))
#>                name rating position version   price skills weak_foot pac sho
#> 1      Lionel Messi     93       RW    Rare  843000      4         4  85  92
#> 2 Cristiano Ronaldo     92       ST    Rare 1720000      5         4  89  93
#>   pas dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense
#> 1  91  95  38  65 170        654        466          2273         M          L
#> 2  81  89  35  77 187       1159        464          2258         H          L
#>   wei
#> 1  72
#> 2  83
```

#### Search for a specific version of a player

``` r
# Lewandowski rare card
futbin_search(name = "Lewandowski", version = "Rare")
#>                 name rating position version  price skills weak_foot pac sho
#> 2 Robert Lewandowski     91       ST    Rare 218000      4         4  78  91
#>   pas dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense
#> 2  78  86  43  82 184        640        458          2232         H          M
#>   wei
#> 2  80
```

``` r
# Luis Suarez One to watch (OTW)
futbin_search(name = "Luis Suarez", version = "OTW")
#>          name rating position version  price skills weak_foot pac sho pas dri
#> 2 Luis Suárez     88       ST     OTW 149000      3         4  72  91  84  84
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 2  52  84 182        245        467          2272         H          M  86
```

#### Search for an In-Form (IF) card of a player, showing verbose

``` r
futbin_search(name = "Grealish", version = "IF", verbose = TRUE)
#> [1] "Reading... https://www.futbin.com/21/players?page=1&search=grealish"
#> [1] "Player(s) found: 1"
#>            name rating position version price skills weak_foot pac sho pas dri
#> 1 Jack Grealish     83       LM      IF 11500      4         3  80  77  84  87
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  49  64 180        267        441          2066         M          M  68
```

#### Radar plot comparing Van Dijk and Messi

``` r
defenders <- futbin_search(name = c("Van Dijk", "Lionel Messi"), version = "Rare")
futbin_plot(defenders)
```

![<https://i.imgur.com/MP9cmAk.png>](https://i.imgur.com/MP9cmAk.png)
(Please note that this is a static version. Real plots are interactive.)

#### Radar plot comparing goalkeepers:

``` r
some_goalkeepers <- futbin_search(name = c("De Gea", "Kepa", "Hugo Lloris"), version = "Rare")
futbin_plot(some_goalkeepers, gk = TRUE)
```

![<https://i.imgur.com/zpD21wa.png>](https://i.imgur.com/zpD21wa.png)
(Please note that this is a static version. Real plots are interactive.)
