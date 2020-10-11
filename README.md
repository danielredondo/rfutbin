-   [rfutbin](#rfutbin)
    -   [Installation](#installation)
    -   [Functions](#functions)
    -   [Examples](#examples)

rfutbin
=======

rfutbin: Search prices for FIFA Ultimate Team players in [Futbin
webpage](https://www.futbin.com).

Installation
------------

This package is currently available only on GitHub. To install it, use
the `devtools` package:

``` r
library(devtools)
install_github("danielredondo/rfutbin")
```

Functions
---------

### futbin\_search

`futbin_search` searchs players in futbin. It has the following
parameters:

-   `name`. Optional. Vector with the names of the players. If not
    specified it will report the 30 highest-rated players of the game.

-   `version_selected`. Optional. Version of the cards. It can be
    “Rare”, “IF” (In-Form), “SIF” (Second In-Form), …

-   `messages`. Optional. To show additional messages (webpage used and
    number of players found).

The output of the function is a dataframe with all the players found
searching for `name` and `version_selected`.

### futbin\_plot

`futbin_plot` makes an interactive radar plot of the stats of the
players. It has the following parameters:

-   `df` dataframe generated with columns `pac`, `sho`, `pas`, `dri`,
    `def`, `phy`. This dataframe can be obtained from function
    `futbin_search`.
-   `gk` Optional. If `TRUE`, the labels of the plot are the stats for
    goalkeepers: diving, handling, kicking, reflexes, speed and
    position.

The output of the function is an interactive radar plot of the stats.

Examples
--------

#### Load package

``` r
library(rfutbin)
```

#### Search for a player

``` r
futbin_search(name = "Lionel Messi")
#>           name rating position version  price skills weak_foot pac sho pas dri
#> 1 Lionel Messi     93       RW    Rare 830000      4         4  85  92  91  95
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  38  65 170        573        466          2273         M          L  72
```

#### Search for more than one player

``` r
futbin_search(name = c("Lionel Messi", "Cristiano Ronaldo"))
#>                name rating position version   price skills weak_foot pac sho
#> 1      Lionel Messi     93       RW    Rare  830000      4         4  85  92
#> 2 Cristiano Ronaldo     92       ST    Rare 1690000      5         4  89  93
#>   pas dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense
#> 1  91  95  38  65 170        573        466          2273         M          L
#> 2  81  89  35  77 187       1057        464          2258         H          L
#>   wei
#> 1  72
#> 2  83
```

#### Search for a specific version of two or more players

``` r
futbin_search(name = c("Lionel Messi", "Griezmann"), version_selected = "Rare")
#>                name rating position version  price skills weak_foot pac sho pas
#> 1      Lionel Messi     93       RW    Rare 830000      4         4  85  92  91
#> 2 Antoine Griezmann     87       ST    Rare 108000      4         3  79  85  84
#>   dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  95  38  65 170        573        466          2273         M          L  72
#> 2  88  57  72 176        290        465          2314         M          M  73
```

#### Search for an In-Form card of a player, showing verbose

``` r
futbin_search(name = "Grealish", version_selected = "IF", verbose = TRUE)
#> [1] "Reading... https://www.futbin.com/21/players?page=1&search=grealish"
#> [1] "Player(s) found: 1"
#>            name rating position version price skills weak_foot pac sho pas dri
#> 1 Jack Grealish     83       LM      IF 11250      4         3  80  77  84  87
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  49  64 180        249        441          2066         M          M  68
```

#### Radar plot comparing Militao and Piqué

``` r
defenders <- futbin_search(name = c("Militao", "Gerard Pique"), version_selected = "Rare")
futbin_plot(defenders)
```

![<a href="https://i.imgur.com/0zw5zKG.png" class="uri">https://i.imgur.com/0zw5zKG.png</a>](https://i.imgur.com/0zw5zKG.png)
(Please note that this is a static version. Real plots are interactive.)

#### Radar plot comparing goalkeepers:

``` r
some_goalkeepers <- futbin_search(name = c("De Gea", "Kepa", "Hugo Lloris"), version_selected = "Rare")
futbin_plot(some_goalkeepers, gk = TRUE)
```

![<a href="https://i.imgur.com/jmEMRYC.png" class="uri">https://i.imgur.com/jmEMRYC.png</a>](https://i.imgur.com/jmEMRYC.png)
(Please note that this is a static version. Real plots are interactive.)
