  - [rfutbin](#rfutbin)
      - [Installation](#installation)
      - [Functions](#functions)
      - [Examples](#examples)
      - [Citation](#citation)

<img src='man/figures/logo.png' align="right" height="139" />

# rfutbin

R package to get price and stats of FIFA Ultimate Team players in
[Futbin](https://www.futbin.com).

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
#>           name rating position version   price skills weak_foot pac sho pas dri
#> 1 Lionel Messi     95       CF   TOTGS 1470000      4         4  88  95  94  97
#> 2 Lionel Messi     94       CF      IF  948000      4         4  86  94  93  96
#> 3 Lionel Messi     93       RW    Rare  414000      4         4  85  92  91  95
#> 4 Lionel Messi     93       RW      CL  414000      4         4  85  92  91  95
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  40  68 170        861        482          2348         M          L  72
#> 2  39  66 170       3932        474          2315         M          L  72
#> 3  38  65 170       3308        466          2273         M          L  72
#> 4  38  65 170        347        466          2273         M          L  72
```

#### Search for more than one player

``` r
futbin_search(name = c("Lionel Messi", "Cristiano Ronaldo"))
#>                name rating position version   price skills weak_foot pac sho
#> 1      Lionel Messi     95       CF   TOTGS 1470000      4         4  88  95
#> 2      Lionel Messi     94       CF      IF  948000      4         4  86  94
#> 3      Lionel Messi     93       RW    Rare  414000      4         4  85  92
#> 4      Lionel Messi     93       RW      CL  414000      4         4  85  92
#> 5 Cristiano Ronaldo     93       ST      IF 2650000      5         4  90  94
#> 6 Cristiano Ronaldo     92       ST    Rare 1290000      5         4  89  93
#> 7 Cristiano Ronaldo     92       ST      CL 1300000      5         4  89  93
#>   pas dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense
#> 1  94  97  40  68 170        861        482          2348         M          L
#> 2  93  96  39  66 170       3932        474          2315         M          L
#> 3  91  95  38  65 170       3308        466          2273         M          L
#> 4  91  95  38  65 170        347        466          2273         M          L
#> 5  83  91  36  78 187       4216        472          2301         H          L
#> 6  81  89  35  77 187       5985        464          2258         H          L
#> 7  81  89  35  77 187        685        464          2258         H          L
#>   wei
#> 1  72
#> 2  72
#> 3  72
#> 4  72
#> 5  83
#> 6  83
#> 7  83
```

#### Search for a specific version of a player

``` r
# Lewandowski rare card
futbin_search(name = "Lewandowski", version = "Rare")
#>                 name rating position version price skills weak_foot pac sho pas
#> 3 Robert Lewandowski     91       ST    Rare 70000      4         4  78  91  78
#>   dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 3  86  43  82 184       1672        458          2232         H          M  80
```

``` r
# Luis Suarez One to watch (OTW)
futbin_search(name = "Luis Suarez", version = "OTW")
#>          name rating position version price skills weak_foot pac sho pas dri
#> 2 Luis Suárez     88       ST     OTW 84000      3         4  72  91  84  84
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 2  52  84 182        560        467          2272         H          M  86
```

``` r
# Grealish In-Form (IF) showing verbose
futbin_search(name = "Grealish", version = "IF", verbose = TRUE)
#> [1] "Reading... https://www.futbin.com/21/players?page=1&search=grealish"
#> [1] "Player(s) found: 1"
#>            name rating position version price skills weak_foot pac sho pas dri
#> 1 Jack Grealish     83       LM      IF 25000      4         3  80  77  84  87
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  49  64 180        443        441          2066         M          M  68
```

#### Download all players from a Futbin webpage

``` r
# All Aston Villa players -> To get the URL, go to futbin.com/players and filter
aston_villa <- futbin_scrap(url = "https://www.futbin.com/players?page=1&club=2")
#> [1] "Reading... https://www.futbin.com/players?page=1&club=2"
#> [1] "Player(s) found: 30"
#> [1] "Reading... https://www.futbin.com/players?page=2&club=2"
#> [1] "Player(s) found: 38"
#> [1] "Reading... https://www.futbin.com/players?page=3&club=2"
#> [1] "Player(s) found: 38"

head(aston_villa)
#>                name rating position  version price skills weak_foot pac sho pas
#> 1     Ollie Watkins     84       ST       IF 65000      3         4  90  84  77
#> 2     Jack Grealish     83       LM       IF 25000      4         3  80  77  84
#> 3 Emiliano Martínez     82       GK       IF 10500      1         3  82  84  82
#> 4     Ollie Watkins     81       ST       IF 13750      3         4  88  79  73
#> 5     Jack Grealish     80       LW     Rare  1800      4         3  76  74  80
#> 6        Tom Heaton     78       GK Non-Rare   600      1         3  78  77  74
#>   dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  82  54  76 180       3303        463          2188         H          H  70
#> 2  87  49  64 180        443        441          2066         M          M  68
#> 3  83  62  82 195        109        475          1072         M          M    
#> 4  78  51  73 180        773        442          2068         H          H  70
#> 5  84  46  61 180        166        421          1989         M          M  68
#> 6  79  56  78 187         11        442           980         M          M  92
```

``` r
# All English players in Bundesliga -> To get the URL, go to futbin.com/players and filter
futbin_scrap(url = "https://www.futbin.com/21/players?page=1&league=19&nation=14")
#> [1] "Reading... https://www.futbin.com/21/players?page=1&league=19&nation=14"
#> [1] "Player(s) found: 9"
#> [1] "Reading... https://www.futbin.com/21/players?page=2&league=19&nation=14"
#> [1] "Player(s) found: 9"
#>              name rating position        version  price skills weak_foot pac
#> 1    Jadon Sancho     88       RM Record Breaker 243000      5         3  87
#> 2    Jadon Sancho     87       RM           Rare  30000      5         3  83
#> 3    Jadon Sancho     87       RM             CL  30000      5         3  83
#> 4  Ryan Sessegnon     75       LM       non-rare   1300      4         3  86
#> 5 Ademola Lookman     74       RM           Rare  25250      3         4  82
#> 6 Jude Bellingham     69       CM       Non-Rare   1600      3         4  77
#> 7    Reece Oxford     66       CB       Non-Rare    900      2         3  67
#> 8    Clinton Mola     66       LB       Non-Rare    700      2         3  68
#> 9 Keanan Bennetts     63       LM           Rare      0      2         4  75
#>   sho pas dri def phy hei popularity base_stats in_game_stats wr_attack
#> 1  83  82  91  38  65 180       1365        446          2092         H
#> 2  74  81  91  37  64 180       -328        430          2015         H
#> 3  74  81  91  37  64 180         33        430          2015         H
#> 4  67  69  75  65  62 178         38        424          1978         H
#> 5  72  66  80  27  60 174         45        387          1828         H
#> 6  65  64  73  55  66 180        161        400          1837         H
#> 7  33  52  56  66  69 191          6        343          1591         M
#> 8  40  63  64  62  63 183          5        360          1670         H
#> 9  59  58  66  41  55 183          7        354          1641         H
#>   wr_defense wei
#> 1          M  76
#> 2          M  76
#> 3          M  76
#> 4          M  71
#> 5          M  71
#> 6          M  72
#> 7          M  78
#> 8          L  78
#> 9          M  73
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
