-   [rfutbin](#rfutbin)
    -   [Installation](#installation)
    -   [Functions](#functions)
    -   [Examples](#examples)
    -   [Citation](#citation)

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

-   `name`. Optional. Vector with the names of the players. If not
    specified, it will report the 30 highest-rated players of the game.

-   `version`. Optional. Version of the cards. Some options are “Rare”,
    “Non-Rare”, “IF” (In-Form), “SIF” (Second In-Form), …

-   `verbose`. Optional. To show additional messages (webpage scraped
    and number of players found).

The output of the function is a dataframe with all the players found
searching for `name` and `version`.

### futbin\_scrap

`futbin_scrap` extracts all players of a Futbin URL. It has the
following parameters:

-   `url`. Futbin URL to web scrap. Futbin webpage
    (<https://www.futbin.com/players>) can be used to make customised
    filters, and then copy the URL here. All the players found in the
    URL (and the next pages) will be automatically detected and
    downloaded.

-   `sleep_time`. Time (in seconds) ellapsed between scraping one page
    and the next one. Please respect Futbin API.

-   `verbose`. Optional. To show additional verbose about webpage used
    and number of players found.

The output of the function is a dataframe with all the players found at
the URL.

### futbin\_plot

`futbin_plot` makes an interactive radar plot of the stats of the
players. It has the following parameters:

-   `df` dataframe generated with columns `pac`, `sho`, `pas`, `dri`,
    `def`, `phy`. This dataframe can be obtained from function
    `futbin_search`.
-   `gk` Optional. If `TRUE`, the labels of the plot are the main stats
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
#> 1 Lionel Messi     98       RW    TOTY 4750000      4         4  93  98  97  99
#> 2 Lionel Messi     95       CF   TOTGS 1800000      4         4  88  95  94  97
#> 3 Lionel Messi     94       CF      IF 1080000      4         4  86  94  93  96
#> 4 Lionel Messi     93       RW    Rare  278000      4         4  85  92  91  95
#> 5 Lionel Messi     93       RW      CL  282000      4         4  85  92  91  95
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 1  43  73 170       4859        503          2449         M          L  72
#> 2  40  68 170       1575        482          2348         M          L  72
#> 3  39  66 170       4551        474          2315         M          L  72
#> 4  38  65 170       5447        466          2273         M          L  72
#> 5  38  65 170        540        466          2273         M          L  72
```

#### Search for more than one player

``` r
futbin_search(name = c("Lionel Messi", "Cristiano Ronaldo"))
#>                 name rating position       version   price skills weak_foot pac
#> 1       Lionel Messi     98       RW          TOTY 4750000      4         4  93
#> 2       Lionel Messi     95       CF         TOTGS 1800000      4         4  88
#> 3       Lionel Messi     94       CF            IF 1080000      4         4  86
#> 4       Lionel Messi     93       RW          Rare  278000      4         4  85
#> 5       Lionel Messi     93       RW            CL  282000      4         4  85
#> 6  Cristiano Ronaldo     98       ST          TOTY 9100000      5         4  96
#> 7  Cristiano Ronaldo     94       ST           SIF 4440000      5         4  91
#> 8  Cristiano Ronaldo     93       ST            IF 3020000      5         4  90
#> 9  Cristiano Ronaldo     92       ST          Rare 1100000      5         4  89
#> 10 Cristiano Ronaldo     92       ST            CL 1090000      5         4  89
#> 11 Cristiano Ronaldo     87       RW Flashback SBC  334500      5         3  91
#>    sho pas dri def phy hei popularity base_stats in_game_stats wr_attack
#> 1   98  97  99  43  73 170       4859        503          2449         M
#> 2   95  94  97  40  68 170       1575        482          2348         M
#> 3   94  93  96  39  66 170       4551        474          2315         M
#> 4   92  91  95  38  65 170       5447        466          2273         M
#> 5   92  91  95  38  65 170        540        466          2273         M
#> 6   98  89  96  44  88 187       6728        511          2465         H
#> 7   95  85  92  37  80 187       3873        480          2339         H
#> 8   94  83  91  36  78 187       5286        472          2301         H
#> 9   93  81  89  35  77 187      10933        464          2258         H
#> 10  93  81  89  35  77 187       1545        464          2258         H
#> 11  79  75  86  30  72 187       1941        433          2091         H
#>    wr_defense wei
#> 1           L  72
#> 2           L  72
#> 3           L  72
#> 4           L  72
#> 5           L  72
#> 6           L  83
#> 7           L  83
#> 8           L  83
#> 9           L  83
#> 10          L  83
#> 11          L  83
```

#### Search for a specific version of a player

``` r
# Lewandowski rare card
futbin_search(name = "Lewandowski", version = "Rare")
#>                 name rating position version price skills weak_foot pac sho pas
#> 5 Robert Lewandowski     91       ST    Rare 85000      4         4  78  91  78
#>   dri def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 5  86  43  82 184       1896        458          2232         H          M  80
```

``` r
# Luis Suarez One to watch (OTW)
futbin_search(name = "Luis Suarez", version = "OTW")
#>          name rating position version price skills weak_foot pac sho pas dri
#> 2 Luis Suárez     89       ST     OTW 84500      3         4  73  92  86  86
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 2  53  85 182        807        475          2326         H          M  86
```

``` r
# Grealish In-Form (IF) showing verbose
futbin_search(name = "Grealish", version = "IF", verbose = TRUE)
#> [1] "Reading... https://www.futbin.com/21/players?page=1&search=grealish"
#> [1] "Player(s) found: 1"
#>            name rating position version price skills weak_foot pac sho pas dri
#> 2 Jack Grealish     83       LM      IF 44750      4         3  80  77  84  87
#>   def phy hei popularity base_stats in_game_stats wr_attack wr_defense wei
#> 2  49  64 180        513        441          2066         M          M  68
```

#### Download all players from a Futbin webpage

``` r
# All Aston Villa players -> To get the URL, go to futbin.com/players and filter
aston_villa <- futbin_scrap(url = "https://www.futbin.com/players?page=1&club=2")
#> [1] "Reading... https://www.futbin.com/players?page=1&club=2"
#> [1] "Player(s) found: 30"
#> [1] "Reading... https://www.futbin.com/players?page=2&club=2"
#> [1] "Player(s) found: 41"
#> [1] "Reading... https://www.futbin.com/players?page=3&club=2"
#> [1] "Player(s) found: 41"

head(aston_villa)
#>                name rating position              version price skills weak_foot
#> 1     Jack Grealish     87      CAM TOTY Honourable Ment     0      4         3
#> 2     Ollie Watkins     84       ST                  SIF 59000      3         4
#> 3 Emiliano Martínez     84       GK                  SIF 27000      1         3
#> 4     Jack Grealish     83       LM                   IF 44750      4         3
#> 5 Emiliano Martínez     82       GK                   IF 28000      1         3
#> 6     Ollie Watkins     81       ST                   IF 26250      3         4
#>   pac sho pas dri def phy hei popularity base_stats in_game_stats wr_attack
#> 1  85  83  89  91  53  69 180       4464        470          2217         M
#> 2  90  84  77  82  54  76 180       3754        463          2188         H
#> 3  85  86  84  86  65  85 195        395        491          1078         M
#> 4  80  77  84  87  49  64 180        513        441          2066         M
#> 5  82  84  82  83  62  82 195        176        475          1072         M
#> 6  88  79  73  78  51  73 180        818        442          2068         H
#>   wr_defense wei
#> 1          M  68
#> 2          H  70
#> 3          M    
#> 4          M  68
#> 5          M    
#> 6          H  70
```

``` r
# All English players in Bundesliga -> To get the URL, go to futbin.com/players and filter
futbin_scrap(url = "https://www.futbin.com/21/players?page=1&league=19&nation=14")
#> [1] "Reading... https://www.futbin.com/21/players?page=1&league=19&nation=14"
#> [1] "Player(s) found: 11"
#> [1] "Reading... https://www.futbin.com/21/players?page=2&league=19&nation=14"
#> [1] "Player(s) found: 11"
#>               name rating position        version  price skills weak_foot pac
#> 1     Jadon Sancho     88       RM Record Breaker 376000      5         3  87
#> 2     Jadon Sancho     87       RM           Rare  40000      5         3  83
#> 3     Jadon Sancho     87       RM             CL  41000      5         3  83
#> 4   Ryan Sessegnon     87       LM     Objectives      0      4         4  92
#> 5   Ryan Sessegnon     75       LM       non-rare    450      4         3  86
#> 6     Demarai Gray     75       LM       non-rare    500      4         3  87
#> 7  Ademola Lookman     74       RM           Rare  30000      3         4  82
#> 8  Jude Bellingham     69       CM       Non-Rare   1800      3         4  77
#> 9     Reece Oxford     66       CB       Non-Rare    600      2         3  67
#> 10    Clinton Mola     66       LB       Non-Rare    500      2         3  68
#> 11 Keanan Bennetts     63       LM           Rare      0      2         4  75
#>    sho pas dri def phy hei popularity base_stats in_game_stats wr_attack
#> 1   83  82  91  38  65 180       1921        446          2092         H
#> 2   74  81  91  37  64 180       -293        430          2015         H
#> 3   74  81  91  37  64 180         42        430          2015         H
#> 4   84  84  88  70  75 178        660        493          2325         H
#> 5   67  69  75  65  62 178         46        424          1978         H
#> 6   68  67  80  37  55 180         40        394          1803         M
#> 7   72  66  80  27  60 174         51        387          1828         H
#> 8   65  64  73  55  66 180        381        400          1837         H
#> 9   33  52  56  66  69 191          9        343          1591         M
#> 10  40  63  64  62  63 183          8        360          1670         H
#> 11  59  58  66  41  55 183          8        354          1641         H
#>    wr_defense wei
#> 1           M  76
#> 2           M  76
#> 3           M  76
#> 4           M  71
#> 5           M  71
#> 6           M  74
#> 7           M  71
#> 8           M  72
#> 9           M  78
#> 10          L  78
#> 11          M  73
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
