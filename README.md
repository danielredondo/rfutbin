-   [rfutbin](#rfutbin)
    -   [Installation](#installation)
    -   [Examples](#examples)
    -   [Functions](#functions)
    -   [Citation](#citation)

<img src='man/figures/logo.png' align="right" height="139" />

# rfutbin

R package to get price and stats of FIFA Ultimate Team players in
[Futbin](https://www.futbin.com) for all platforms (PS4/XBox One/PC).

## Installation

This package is available only on GitHub. To install it, use the
`devtools` package:

``` r
library(devtools)
install_github("danielredondo/rfutbin")

library(rfutbin)
```

## Examples

#### Load package

``` r
library(rfutbin)
```

#### Search for a player

``` r
futbin_search(name = "Lionel Messi")
#> # A tibble: 7 x 20
#>   name   rating position version  price skills weak_foot   pac   sho   pas   dri
#>   <chr>   <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Lione…     98 RW       TOTY    3.35e6      4         4    93    98    97    99
#> 2 Lione…     98 ST       TOTS    3.9 e6      4         4    91    99    96    99
#> 3 Lione…     96 CF       LaLiga… 1.71e6      4         4    90    96    95    98
#> 4 Lione…     95 CF       TOTGS   8.86e5      4         4    88    95    94    97
#> 5 Lione…     94 CF       IF      5.84e5      4         4    86    94    93    96
#> 6 Lione…     93 RW       Rare    1.28e5      4         4    85    92    91    95
#> 7 Lione…     93 RW       CL      1.27e5      4         4    85    92    91    95
#> # … with 9 more variables: def <int>, phy <int>, hei <chr>, popularity <int>,
#> #   base_stats <int>, in_game_stats <int>, wr_attack <chr>, wr_defense <chr>,
#> #   wei <chr>
```

#### The default platform is PS4, but you can get the price in other platforms (XBox One/PC)

``` r
futbin_search(name = "Lionel Messi", platform = "xone")
#> # A tibble: 7 x 20
#>   name   rating position version  price skills weak_foot   pac   sho   pas   dri
#>   <chr>   <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Lione…     98 RW       TOTY    3.1 e6      4         4    93    98    97    99
#> 2 Lione…     98 ST       TOTS    3.69e6      4         4    91    99    96    99
#> 3 Lione…     96 CF       LaLiga… 1.59e6      4         4    90    96    95    98
#> 4 Lione…     95 CF       TOTGS   7.8 e5      4         4    88    95    94    97
#> 5 Lione…     94 CF       IF      5.2 e5      4         4    86    94    93    96
#> 6 Lione…     93 RW       Rare    1.3 e5      4         4    85    92    91    95
#> 7 Lione…     93 RW       CL      1.28e5      4         4    85    92    91    95
#> # … with 9 more variables: def <int>, phy <int>, hei <chr>, popularity <int>,
#> #   base_stats <int>, in_game_stats <int>, wr_attack <chr>, wr_defense <chr>,
#> #   wei <chr>
futbin_search(name = "Lionel Messi", platform = "pc")
#> # A tibble: 7 x 20
#>   name   rating position version  price skills weak_foot   pac   sho   pas   dri
#>   <chr>   <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Lione…     98 RW       TOTY    4   e6      4         4    93    98    97    99
#> 2 Lione…     98 ST       TOTS    4.76e6      4         4    91    99    96    99
#> 3 Lione…     96 CF       LaLiga… 1.93e6      4         4    90    96    95    98
#> 4 Lione…     95 CF       TOTGS   0           4         4    88    95    94    97
#> 5 Lione…     94 CF       IF      1.08e6      4         4    86    94    93    96
#> 6 Lione…     93 RW       Rare    1.88e5      4         4    85    92    91    95
#> 7 Lione…     93 RW       CL      1.98e5      4         4    85    92    91    95
#> # … with 9 more variables: def <int>, phy <int>, hei <chr>, popularity <int>,
#> #   base_stats <int>, in_game_stats <int>, wr_attack <chr>, wr_defense <chr>,
#> #   wei <chr>
```

#### Search for more than one player

``` r
futbin_search(name = c("Lionel Messi", "Cristiano Ronaldo"))
#> # A tibble: 14 x 20
#>    name  rating position version  price skills weak_foot   pac   sho   pas   dri
#>    <chr>  <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#>  1 Lion…     98 RW       TOTY    3.35e6      4         4    93    98    97    99
#>  2 Lion…     98 ST       TOTS    3.9 e6      4         4    91    99    96    99
#>  3 Lion…     96 CF       LaLiga… 1.71e6      4         4    90    96    95    98
#>  4 Lion…     95 CF       TOTGS   8.86e5      4         4    88    95    94    97
#>  5 Lion…     94 CF       IF      5.84e5      4         4    86    94    93    96
#>  6 Lion…     93 RW       Rare    1.28e5      4         4    85    92    91    95
#>  7 Lion…     93 RW       CL      1.27e5      4         4    85    92    91    95
#>  8 Cris…     98 ST       TOTY    7.59e6      5         4    96    98    89    96
#>  9 Cris…     95 ST       TIF     3.67e6      5         4    92    96    87    93
#> 10 Cris…     94 ST       SIF     2.57e6      5         4    91    95    85    92
#> 11 Cris…     93 ST       IF      1.3 e6      5         4    90    94    83    91
#> 12 Cris…     92 ST       Rare    1.73e5      5         4    89    93    81    89
#> 13 Cris…     92 ST       CL      1.77e5      5         4    89    93    81    89
#> 14 Cris…     87 RW       Flashb… 3.34e5      5         3    91    79    75    86
#> # … with 9 more variables: def <int>, phy <int>, hei <chr>, popularity <int>,
#> #   base_stats <int>, in_game_stats <int>, wr_attack <chr>, wr_defense <chr>,
#> #   wei <chr>
```

#### Search for a specific version of a player

``` r
# Lewandowski rare card
futbin_search(name = "Lewandowski", version = "Rare")
#> # A tibble: 1 x 20
#>   name    rating position version price skills weak_foot   pac   sho   pas   dri
#>   <chr>    <int> <chr>    <chr>   <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Robert…     91 ST       Rare    68500      4         4    78    91    78    86
#> # … with 9 more variables: def <int>, phy <int>, hei <chr>, popularity <int>,
#> #   base_stats <int>, in_game_stats <int>, wr_attack <chr>, wr_defense <chr>,
#> #   wei <chr>
```

``` r
# Luis Suarez One to watch (OTW)
futbin_search(name = "Luis Suarez", version = "OTW")
#> # A tibble: 1 x 20
#>   name    rating position version price skills weak_foot   pac   sho   pas   dri
#>   <chr>    <int> <chr>    <chr>   <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Luis S…     89 ST       OTW     56500      3         4    73    92    86    86
#> # … with 9 more variables: def <int>, phy <int>, hei <chr>, popularity <int>,
#> #   base_stats <int>, in_game_stats <int>, wr_attack <chr>, wr_defense <chr>,
#> #   wei <chr>
```

``` r
# Grealish In-Form (IF) showing verbose
futbin_search(name = "Grealish", version = "IF", verbose = TRUE)
#> [1] "Reading... https://www.futbin.com/21/players?page=1&search=grealish"
#> [1] "Player(s) found: 1"
#> # A tibble: 1 x 20
#>   name    rating position version price skills weak_foot   pac   sho   pas   dri
#>   <chr>    <int> <chr>    <chr>   <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Jack G…     83 LM       IF      29000      4         3    80    77    84    87
#> # … with 9 more variables: def <int>, phy <int>, hei <chr>, popularity <int>,
#> #   base_stats <int>, in_game_stats <int>, wr_attack <chr>, wr_defense <chr>,
#> #   wei <chr>
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
#> # A tibble: 6 x 20
#>   name   rating position version  price skills weak_foot   pac   sho   pas   dri
#>   <chr>   <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Jack …     87 CAM      TOTY Ho…     0      4         3    85    83    89    91
#> 2 Ollie…     84 ST       SIF      26000      3         4    90    84    77    82
#> 3 Emili…     84 GK       SIF      26000      1         3    85    86    84    86
#> 4 Jack …     83 LM       IF       29000      4         3    80    77    84    87
#> 5 Emili…     82 GK       IF       30000      1         3    82    84    82    83
#> 6 Ollie…     81 ST       IF       16000      3         4    88    79    73    78
#> # … with 9 more variables: def <int>, phy <int>, hei <chr>, popularity <int>,
#> #   base_stats <int>, in_game_stats <int>, wr_attack <chr>, wr_defense <chr>,
#> #   wei <chr>
```

``` r
# All English players in Bundesliga -> To get the URL, go to futbin.com/players and filter
futbin_scrap(url = "https://www.futbin.com/21/players?page=1&league=19&nation=14")
#> [1] "Reading... https://www.futbin.com/21/players?page=1&league=19&nation=14"
#> [1] "Player(s) found: 13"
#> [1] "Reading... https://www.futbin.com/21/players?page=2&league=19&nation=14"
#> [1] "Player(s) found: 13"
#> # A tibble: 13 x 20
#>    name  rating position version  price skills weak_foot   pac   sho   pas   dri
#>    <chr>  <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#>  1 Jado…     92 RM       What If 279000      5         3    91    87    86    95
#>  2 Jado…     89 LM       Bundes… 134500      5         3    87    78    83    93
#>  3 Jado…     88 RM       Record…  84000      5         3    87    83    82    91
#>  4 Jado…     87 RM       Rare     29000      5         3    83    74    81    91
#>  5 Jado…     87 RM       CL       29500      5         3    83    74    81    91
#>  6 Ryan…     87 LM       Object…      0      4         4    92    84    84    88
#>  7 Ryan…     75 LM       non-ra…   1400      4         3    86    67    69    75
#>  8 Dema…     75 LM       non-ra…   1300      4         3    87    68    67    80
#>  9 Adem…     74 RM       Rare     29500      3         4    82    72    66    80
#> 10 Jude…     69 CM       Non-Ra…   1100      3         4    77    65    64    73
#> 11 Reec…     66 CB       Non-Ra…    750      2         3    67    33    52    56
#> 12 Clin…     66 LB       Non-Ra…    900      2         3    68    40    63    64
#> 13 Kean…     63 LM       Rare         0      2         4    75    59    58    66
#> # … with 9 more variables: def <int>, phy <int>, hei <chr>, popularity <int>,
#> #   base_stats <int>, in_game_stats <int>, wr_attack <chr>, wr_defense <chr>,
#> #   wei <chr>
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

## Functions

### futbin\_search

`futbin_search` searchs players in Futbin. It has the following
parameters:

-   `name`. Optional. Vector with the names of the players. If not
    specified, it will report the 30 highest-rated players of the game.

-   `platform`. Platform to get the prices from. Default is `ps4`. Other
    options are `xone` (XBox One) and `pc`.

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

-   `platform`. Platform to get the prices from. Default is `ps4`. Other
    options are `xone` (XBox One) and `pc`.

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

## Citation

If you use this package, you can cite it as:

    Redondo-Sanchez, Daniel (2021). rfutbin (v1.0.1): R package to get price and stats of FIFA Ultimate Team players in Futbin. https://github.com/danielredondo/rfutbin
