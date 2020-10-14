  - [rfutbin](#rfutbin)
      - [Installation](#installation)
      - [Functions](#functions)
      - [Examples](#examples)
      - [Citation](#citation)

# rfutbin

rfutbin: R package to get price and stats of FIFA Ultimate Team players
in [Futbin](https://www.futbin.com).

## Installation

This package is available only on GitHub. To install it, use the
`devtools` package:

``` r
library(devtools)
install_github("danielredondo/rfutbin")

library(rfutbin)
```

## Functions

### futbin\_search

`futbin_search` searchs players in Futbin. It has the following
parameters:

  - `name`. Optional. Vector with the names of the players. If not
    specified, it will report the 30 highest-rated players of the game.

  - `version`. Optional. Version of the cards. Some options are “Rare”,
    “Non-Rare”, “IF” (In-Form), “SIF” (Second In-Form), …

  - `verbose`. Optional. To show additional messages (webpage scraped
    and number of players found).

The output of the function is a dataframe with all the players found
searching for `name` and `version`.

### futbin\_scrap

`futbin_scrap` extracts all players of a Futbin URL. It has the
following parameters:

  - `url`. Futbin URL to web scrap. Futbin webpage
    (<https://www.futbin.com/players>) can be used to make customised
    filters, and then copy the URL here. All the players found in the
    URL (and the next pages) will be automatically detected and
    downloaded.

  - `sleep_time`. Time (in seconds) ellapsed between scraping one page
    and the next one. Please respect Futbin API.

  - `verbose`. Optional. To show additional verbose about webpage used
    and number of players found.

The output of the function is a dataframe with all the players found at
the URL.

### futbin\_plot

`futbin_plot` makes an interactive radar plot of the stats of the
players. It has the following parameters:

  - `df` dataframe generated with columns `pac`, `sho`, `pas`, `dri`,
    `def`, `phy`. This dataframe can be obtained from function
    `futbin_search`.
  - `gk` Optional. If `TRUE`, the labels of the plot are the main stats
    for goalkeepers: diving, handling, kicking, reflexes, speed and
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
#> 1 Lionel Messi     93       RW    Rare 849000      4         4  85  92  91  95
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  38  65 170        693        466          2273         M          L  72
```

#### Search for more than one player

``` r
futbin_search(name = c("Lionel Messi", "Cristiano Ronaldo"))
#>                name rating position version   price skills weak_foot pac sho
#> 1      Lionel Messi     93       RW    Rare  849000      4         4  85  92
#> 2 Cristiano Ronaldo     92       ST    Rare 1790000      5         4  89  93
#>   pas dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense
#> 1  91  95  38  65 170        693        466          2273         M          L
#> 2  81  89  35  77 187       1222        464          2258         H          L
#>   wei
#> 1  72
#> 2  83
```

#### Search for a specific version of a player

``` r
# Lewandowski rare card
futbin_search(name = "Lewandowski", version = "Rare")
#>                 name rating position version  price skills weak_foot pac sho
#> 2 Robert Lewandowski     91       ST    Rare 215000      4         4  78  91
#>   pas dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense
#> 2  78  86  43  82 184        654        458          2232         H          M
#>   wei
#> 2  80
```

``` r
# Luis Suarez One to watch (OTW)
futbin_search(name = "Luis Suarez", version = "OTW")
#>          name rating position version  price skills weak_foot pac sho pas dri
#> 2 Luis Suárez     88       ST     OTW 144000      3         4  72  91  84  84
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 2  52  84 182        253        467          2272         H          M  86
```

``` r
# Grealish In-Form (IF) showing verbose
futbin_search(name = "Grealish", version = "IF", verbose = TRUE)
#> [1] "Reading... https://www.futbin.com/21/players?page=1&search=grealish"
#> [1] "Player(s) found: 1"
#>            name rating position version price skills weak_foot pac sho pas dri
#> 1 Jack Grealish     83       LM      IF 11750      4         3  80  77  84  87
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  49  64 180        283        441          2066         M          M  68
```

#### Download all players from a Futbin webpage

``` r
# All Aston Villa players -> To get the URL, go to futbin.com/players and filter
aston_villa <- futbin_scrap(url = "https://www.futbin.com/players?page=1&club=2")
#> [1] "Reading... https://www.futbin.com/players?page=1&club=2"
#> [1] "Player(s) found: 30"
#> [1] "Reading... https://www.futbin.com/players?page=2&club=2"
#> [1] "Player(s) found: 36"
#> [1] "Reading... https://www.futbin.com/players?page=3&club=2"
#> [1] "Player(s) found: 36"

head(aston_villa)
#>                name rating position  version price skills weak_foot pac sho pas
#> 1     Jack Grealish     83       LM       IF 11750      4         3  80  77  84
#> 2     Ollie Watkins     81       ST       IF 13250      3         4  88  79  73
#> 3     Jack Grealish     80       LW     Rare  3100      4         3  76  74  80
#> 4        Tom Heaton     78       GK Non-Rare   500      1         3  78  77  74
#> 5 Emiliano Martínez     78       GK Non-Rare   500      1         3  78  80  78
#> 6      Ross Barkley     78       CM     Rare   900      4         5  70  74  78
#>   dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  87  49  64 180        283        441          2066         M          M  68
#> 2  78  51  73 180        458        442          2068         H          H  70
#> 3  84  46  61 180        132        421          1989         M          M  68
#> 4  79  56  78 187          2        442           980         M          M  92
#> 5  77  58  77 195         45        448          1064         M          M    
#> 6  80  57  73 186         37        432          2040         M          M  87
```

``` r
# All English players in Bundesliga -> To get the URL, go to futbin.com/players and filter
futbin_scrap(url = "https://www.futbin.com/21/players?page=1&league=19&nation=14")
#> [1] "Reading... https://www.futbin.com/21/players?page=1&league=19&nation=14"
#> [1] "Player(s) found: 7"
#> [1] "Reading... https://www.futbin.com/21/players?page=2&league=19&nation=14"
#> [1] "Player(s) found: 7"
#>              name rating position  version price skills weak_foot pac sho pas
#> 1    Jadon Sancho     87       RM     Rare 38000      5         3  83  74  81
#> 2  Ryan Sessegnon     75       LM non-rare   500      4         3  86  67  69
#> 3 Ademola Lookman     74       RM     Rare  6000      3         4  82  72  66
#> 4 Jude Bellingham     69       CM Non-Rare  1200      3         4  77  65  64
#> 5    Reece Oxford     66       CB Non-Rare   850      2         3  67  33  52
#> 6    Clinton Mola     66       LB Non-Rare   500      2         3  68  40  63
#> 7 Keanan Bennetts     63       LM     Rare  5700      2         4  75  59  58
#>   dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  91  37  64 180       -460        430          2015         H          M  76
#> 2  75  65  62 178         29        424          1978         H          M  71
#> 3  80  27  60 174         10        387          1828         H          M  71
#> 4  73  55  66 180         71        400          1837         H          M  72
#> 5  56  66  69 191          0        343          1591         M          M  78
#> 6  64  62  63 183          0        360          1670         H          L  78
#> 7  66  41  55 183          2        354          1641         H          M  73
```

#### Radar plot comparing Van Dijk and Messi

``` r
players <- futbin_search(name = c("Van Dijk", "Lionel Messi"), version = "Rare")
futbin_plot(players)
```

![<https://i.imgur.com/MP9cmAk.png>](https://i.imgur.com/MP9cmAk.png)
*(Please note that this is a static version. Real plots are
interactive.)*

#### Radar plot comparing goalkeepers:

``` r
some_goalkeepers <- futbin_search(name = c("De Gea", "Kepa", "Hugo Lloris"), version = "Rare")
futbin_plot(some_goalkeepers, gk = TRUE)
```

![<https://i.imgur.com/zpD21wa.png>](https://i.imgur.com/zpD21wa.png)
*(Please note that this is a static version. Real plots are
interactive.)*

## Citation

If you use this package, you can cite it as:

    Redondo-Sanchez, Daniel (2020). rfutbin: R package to get price and stats of FIFA Ultimate Team players in Futbin
