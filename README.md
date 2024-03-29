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
#> # A tibble: 9 x 23
#>   name   rating position version  price skills weak_foot   pac   sho   pas   dri
#>   <chr>   <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Lione~     99 RW       Summer~ 8.53e5      4         4    96    99    98    99
#> 2 Lione~     99 CAM      Futtie~ 6.85e5      5         4    98    99    99    99
#> 3 Lione~     98 RW       TOTY    7.06e5      4         4    93    98    97    99
#> 4 Lione~     98 ST       TOTS    2.9 e5      4         4    91    99    96    99
#> 5 Lione~     96 CF       LaLiga~ 1.71e6      4         4    90    96    95    98
#> 6 Lione~     95 CF       TOTGS   9.05e4      4         4    88    95    94    97
#> 7 Lione~     94 CF       IF      1.1 e5      4         4    86    94    93    96
#> 8 Lione~     93 RW       Rare    4.58e4      4         4    85    92    91    95
#> 9 Lione~     93 RW       CL      5.2 e4      4         4    85    92    91    95
#> # ... with 12 more variables: def <int>, phy <int>, hei <chr>,
#> #   popularity <int>, base_stats <int>, in_game_stats <int>, wr_attack <chr>,
#> #   wr_defense <chr>, wei <chr>, team <chr>, nation <chr>, league <chr>
```

#### The default platform is PS4, but you can get the price in other platforms (XBox One/PC)

``` r
futbin_search(name = "Lionel Messi", platform = "xone")
#> # A tibble: 9 x 23
#>   name   rating position version  price skills weak_foot   pac   sho   pas   dri
#>   <chr>   <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Lione~     99 RW       Summer~ 8.97e5      4         4    96    99    98    99
#> 2 Lione~     99 CAM      Futtie~ 7.34e5      5         4    98    99    99    99
#> 3 Lione~     98 RW       TOTY    6.45e5      4         4    93    98    97    99
#> 4 Lione~     98 ST       TOTS    3.1 e5      4         4    91    99    96    99
#> 5 Lione~     96 CF       LaLiga~ 1.59e6      4         4    90    96    95    98
#> 6 Lione~     95 CF       TOTGS   1.19e5      4         4    88    95    94    97
#> 7 Lione~     94 CF       IF      1.81e5      4         4    86    94    93    96
#> 8 Lione~     93 RW       Rare    5.1 e4      4         4    85    92    91    95
#> 9 Lione~     93 RW       CL      6.3 e4      4         4    85    92    91    95
#> # ... with 12 more variables: def <int>, phy <int>, hei <chr>,
#> #   popularity <int>, base_stats <int>, in_game_stats <int>, wr_attack <chr>,
#> #   wr_defense <chr>, wei <chr>, team <chr>, nation <chr>, league <chr>
futbin_search(name = "Lionel Messi", platform = "pc")
#> # A tibble: 9 x 23
#>   name   rating position version  price skills weak_foot   pac   sho   pas   dri
#>   <chr>   <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Lione~     99 RW       Summer~ 1.5 e6      4         4    96    99    98    99
#> 2 Lione~     99 CAM      Futtie~ 7.67e5      5         4    98    99    99    99
#> 3 Lione~     98 RW       TOTY    1.24e6      4         4    93    98    97    99
#> 4 Lione~     98 ST       TOTS    3.3 e5      4         4    91    99    96    99
#> 5 Lione~     96 CF       LaLiga~ 1.93e6      4         4    90    96    95    98
#> 6 Lione~     95 CF       TOTGS   1.43e5      4         4    88    95    94    97
#> 7 Lione~     94 CF       IF      1.8 e5      4         4    86    94    93    96
#> 8 Lione~     93 RW       Rare    7.35e4      4         4    85    92    91    95
#> 9 Lione~     93 RW       CL      8.4 e4      4         4    85    92    91    95
#> # ... with 12 more variables: def <int>, phy <int>, hei <chr>,
#> #   popularity <int>, base_stats <int>, in_game_stats <int>, wr_attack <chr>,
#> #   wr_defense <chr>, wei <chr>, team <chr>, nation <chr>, league <chr>
```

#### Search for more than one player

``` r
futbin_search(name = c("Lionel Messi", "Cristiano Ronaldo"))
#> # A tibble: 19 x 23
#>    name  rating position version  price skills weak_foot   pac   sho   pas   dri
#>    <chr>  <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#>  1 Lion~     99 RW       Summer~ 8.53e5      4         4    96    99    98    99
#>  2 Lion~     99 CAM      Futtie~ 6.85e5      5         4    98    99    99    99
#>  3 Lion~     98 RW       TOTY    7.06e5      4         4    93    98    97    99
#>  4 Lion~     98 ST       TOTS    2.9 e5      4         4    91    99    96    99
#>  5 Lion~     96 CF       LaLiga~ 1.71e6      4         4    90    96    95    98
#>  6 Lion~     95 CF       TOTGS   9.05e4      4         4    88    95    94    97
#>  7 Lion~     94 CF       IF      1.1 e5      4         4    86    94    93    96
#>  8 Lion~     93 RW       Rare    4.58e4      4         4    85    92    91    95
#>  9 Lion~     93 RW       CL      5.2 e4      4         4    85    92    91    95
#> 10 Cris~     99 ST       Summer~ 7   e5      5         4    96    99    92    98
#> 11 Cris~     99 ST       Premiu~ 1.01e6      5         5    98    99    95    99
#> 12 Cris~     98 ST       TOTY    4.45e5      5         4    96    98    89    96
#> 13 Cris~     98 ST       TOTS    4.15e5      5         4    95    99    90    95
#> 14 Cris~     95 ST       TIF     3.1 e5      5         4    92    96    87    93
#> 15 Cris~     94 ST       SIF     9.5 e5      5         4    91    95    85    92
#> 16 Cris~     93 ST       IF      2.34e5      5         4    90    94    83    91
#> 17 Cris~     92 ST       Rare    6.15e4      5         4    89    93    81    89
#> 18 Cris~     92 ST       CL      5.9 e4      5         4    89    93    81    89
#> 19 Cris~     87 RW       Flashb~ 3.34e5      5         3    91    79    75    86
#> # ... with 12 more variables: def <int>, phy <int>, hei <chr>,
#> #   popularity <int>, base_stats <int>, in_game_stats <int>, wr_attack <chr>,
#> #   wr_defense <chr>, wei <chr>, team <chr>, nation <chr>, league <chr>
```

#### Search for a specific version of a player

``` r
# Lewandowski rare card
futbin_search(name = "Lewandowski", version = "Rare")
#> # A tibble: 1 x 23
#>   name    rating position version price skills weak_foot   pac   sho   pas   dri
#>   <chr>    <int> <chr>    <chr>   <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Robert~     91 ST       Rare    25250      4         4    78    91    78    86
#> # ... with 12 more variables: def <int>, phy <int>, hei <chr>,
#> #   popularity <int>, base_stats <int>, in_game_stats <int>, wr_attack <chr>,
#> #   wr_defense <chr>, wei <chr>, team <chr>, nation <chr>, league <chr>
```

``` r
# Luis Suarez One to watch (OTW)
futbin_search(name = "Luis Suarez", version = "OTW")
#> # A tibble: 1 x 23
#>   name    rating position version price skills weak_foot   pac   sho   pas   dri
#>   <chr>    <int> <chr>    <chr>   <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Luis S~     90 ST       OTW     31000      3         4    75    94    87    88
#> # ... with 12 more variables: def <int>, phy <int>, hei <chr>,
#> #   popularity <int>, base_stats <int>, in_game_stats <int>, wr_attack <chr>,
#> #   wr_defense <chr>, wei <chr>, team <chr>, nation <chr>, league <chr>
```

``` r
# Grealish In-Form (IF) showing verbose
futbin_search(name = "Grealish", version = "IF", verbose = TRUE)
#> [1] "Reading... https://www.futbin.com/21/players?page=1&search=grealish"
#> [1] "Player(s) found: 1"
#> # A tibble: 1 x 23
#>   name    rating position version price skills weak_foot   pac   sho   pas   dri
#>   <chr>    <int> <chr>    <chr>   <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Jack G~     83 LM       IF      29750      4         3    80    77    84    87
#> # ... with 12 more variables: def <int>, phy <int>, hei <chr>,
#> #   popularity <int>, base_stats <int>, in_game_stats <int>, wr_attack <chr>,
#> #   wr_defense <chr>, wei <chr>, team <chr>, nation <chr>, league <chr>
```

#### Download all players from a Futbin webpage

``` r
# All Aston Villa players -> To get the URL, go to futbin.com/players and filter
aston_villa <- futbin_scrap(url = "https://www.futbin.com/players?page=1&club=2")
#> [1] "Reading... https://www.futbin.com/players?page=1&club=2"
#> [1] "Player(s) found: 30"
#> [1] "Reading... https://www.futbin.com/players?page=2&club=2"
#> [1] "Player(s) found: 45"
#> [1] "Reading... https://www.futbin.com/players?page=3&club=2"
#> [1] "Player(s) found: 45"
head(aston_villa)
#> # A tibble: 6 x 23
#>   name   rating position version  price skills weak_foot   pac   sho   pas   dri
#>   <chr>   <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#> 1 Jack ~     95 LW       FOF PT~ 246500      4         3    97    94    97    99
#> 2 Jack ~     87 CAM      TOTY H~      0      4         3    85    83    89    91
#> 3 Ollie~     84 ST       SIF      35000      3         4    90    84    77    82
#> 4 Emili~     84 GK       SIF     136000      1         3    85    86    84    86
#> 5 Jack ~     83 LM       IF       29750      4         3    80    77    84    87
#> 6 Emili~     82 GK       IF           0      1         3    82    84    82    83
#> # ... with 12 more variables: def <int>, phy <int>, hei <chr>,
#> #   popularity <int>, base_stats <int>, in_game_stats <int>, wr_attack <chr>,
#> #   wr_defense <chr>, wei <chr>, team <chr>, nation <chr>, league <chr>
```

``` r
# All English players in Bundesliga -> To get the URL, go to futbin.com/players and filter
futbin_scrap(url = "https://www.futbin.com/21/players?page=1&league=19&nation=14")
#> [1] "Reading... https://www.futbin.com/21/players?page=1&league=19&nation=14"
#> [1] "Player(s) found: 17"
#> [1] "Reading... https://www.futbin.com/21/players?page=2&league=19&nation=14"
#> [1] "Player(s) found: 17"
#> # A tibble: 17 x 23
#>    name  rating position version  price skills weak_foot   pac   sho   pas   dri
#>    <chr>  <int> <chr>    <chr>    <dbl>  <int>     <int> <int> <int> <int> <int>
#>  1 Jado~     96 RM       TOTS     23500      5         4    96    94    93    98
#>  2 Jado~     92 RM       What If  20000      5         3    91    87    86    95
#>  3 Jude~     91 CM       TOTS M~ 219900      4         4    88    87    89    89
#>  4 Dema~     90 LW       ShowDo~ 199850      4         4    96    89    86    96
#>  5 Jado~     89 LM       Bundes~ 134500      5         3    87    78    83    93
#>  6 Jado~     88 RM       Record~  71000      5         3    87    83    82    91
#>  7 Jado~     87 RM       Rare     23000      5         3    83    74    81    91
#>  8 Jado~     87 RM       CL       24500      5         3    83    74    81    91
#>  9 Ryan~     87 LM       Object~      0      4         4    92    84    84    88
#> 10 Ryan~     75 LM       non-ra~   8800      4         3    86    67    69    75
#> 11 Dema~     75 LM       non-ra~   1300      4         3    87    68    67    80
#> 12 Adem~     74 RM       Rare      5000      3         4    82    72    66    80
#> 13 Omar~     70 LB       non-ra~   8900      3         3    82    45    55    68
#> 14 Jude~     69 CM       Non-Ra~   2500      3         4    77    65    64    73
#> 15 Reec~     66 CB       Non-Ra~    700      2         3    67    33    52    56
#> 16 Clin~     66 LB       Non-Ra~   7400      2         3    68    40    63    64
#> 17 Kean~     63 LM       Rare      4400      2         4    75    59    58    66
#> # ... with 12 more variables: def <int>, phy <int>, hei <chr>,
#> #   popularity <int>, base_stats <int>, in_game_stats <int>, wr_attack <chr>,
#> #   wr_defense <chr>, wei <chr>, team <chr>, nation <chr>, league <chr>
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

    Redondo-Sanchez, Daniel (2021). rfutbin (v1.0.2): R package to get price and stats of FIFA Ultimate Team players in Futbin. https://github.com/danielredondo/rfutbin
