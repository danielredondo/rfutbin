-   [rfutbin](#rfutbin)
    -   [Installation](#installation)
    -   [Usage](#usage)
        -   [futbin\_search](#futbin_search)
        -   [futbin\_plot](#futbin_plot)
    -   [Examples](#examples)

rfutbin
=======

rfutbin: Search prices for FIFA Ultimate Team players in
[https://www.futbin.com](Futbin%20webpage).

Installation
------------

This package is currently available only on GitHub. To install it, use
the `devtools` package:

``` r
library(devtools)
install_github("danielredondo/rfutbin")
```

Usage
-----

### futbin\_search

`futbin_search` searchs players in futbin. It has the following
parameters:

-   `name`. Optional. Vector with the names of the players. If not
    specified it will report the 30 highest-rated players of the game.

-   `version`. Optional. Version of the cards. It can be “Normal”, “CL”
    (Champions League), “IF” (In-Form), “SIF” (Second In-Form), …

-   `messages`. Optional. To show additional messages (webpage used and
    number of players found).

The output of the function is a dataframe with all the players found
searching for `name` and `version`.

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

``` r
library(rfutbin)
```

``` r
futbin_search(name = "Lionel Messi")
#>           name rating position             ver ps_price skills weak_foot
#> 1 Lionel Messi     99       RW            TOTY    4.39M      4         4
#> 2 Lionel Messi     96       RW         CL TOTT    1.99M      4         4
#> 3 Lionel Messi     96       RW LaLiga POTM SBC    1.86M      4         4
#> 4 Lionel Messi     96       CF   ShapeShifters    2.77M      4         4
#> 5 Lionel Messi     95       RW              IF    1.19M      4         4
#> 6 Lionel Messi     95       RW    TOTY Nominee    1.05M      4         4
#> 7 Lionel Messi     94       RW          Normal     709K      4         4
#> 8 Lionel Messi     94       RW              CL     712K      4         4
#>   work_rate pac sho pas dri def phy hei popularity base_stats in_game_stats
#> 1    M \\ L  96  98  99  99  50  85 170       3675        527          2519
#> 2    M \\ L  91  94  94  98  42  70 170       1491        489          2361
#> 3    M \\ L  90  94  94  98  41  69 170      -2747        486          2350
#> 4    H \\ L  91  95  94  98  41  71 170       1116        490          2365
#> 5    M \\ L  89  93  93  97  40  68 170       4018        480          2320
#> 6    M \\ L  88  93  93  97  40  67 170        294        478          2314
#> 7    M \\ L  87  92  92  96  39  66 170       6546        472          2297
#> 8    M \\ L  87  92  92  96  39  66 170        735        472          2297
#>   work_rate_attack work_rate_defense wei      ps
#> 1                M                 L  72 4390000
#> 2                M                 L  72 1990000
#> 3                M                 L  72 1860000
#> 4                H                 L  72 2770000
#> 5                M                 L  72 1190000
#> 6                M                 L  72 1050000
#> 7                M                 L  72  709000
#> 8                M                 L  72  712000
```

``` r
futbin_search(name = c("Lionel Messi", "Griezmann"), version = "Normal")
#>                name rating position    ver ps_price skills weak_foot work_rate
#> 7      Lionel Messi     94       RW Normal     709K      4         4    M \\ L
#> 3 Antoine Griezmann     89       CF Normal   37.25K      4         3    H \\ H
#>   pac sho pas dri def phy hei popularity base_stats in_game_stats
#> 7  87  92  92  96  39  66 170       6546        472          2297
#> 3  81  86  84  89  57  72 176       5007        469          2326
#>   work_rate_attack work_rate_defense wei     ps
#> 7                M                 L  72 709000
#> 3                H                 H  73  37250
```

``` r
futbin_search(name = "Luka Modric", version = "IF", messages = TRUE)
#> [1] "Reading... https://www.futbin.com/20/players?page=1&search=luka+modric"
#> [1] "Player(s) found: 1"
#>          name rating position ver ps_price skills weak_foot work_rate pac sho
#> 2 Luka Modric     91       CM  IF     100K      4         4    H \\ H  75  78
#>   pas dri def phy hei popularity base_stats in_game_stats work_rate_attack
#> 2  91  91  73  67 172        759        475          2336                H
#>   work_rate_defense wei    ps
#> 2                 H  66 1e+05
```

``` r
defenders <- futbin_search(name = c("Militao", "Gerard Pique"), version = "Normal")
futbin_plot(defenders)
```

![<a href="https://i.imgur.com/0zw5zKG.png" class="uri">https://i.imgur.com/0zw5zKG.png</a>](https://i.imgur.com/0zw5zKG.png)
(Please note that this is a static version. Real plots are interactive.)

``` r
some_goalkeepers <- futbin_search(name = c("De Gea", "Kepa", "Hugo Lloris"), version = "Normal")
futbin_plot(some_goalkeepers, gk = TRUE)
```

![<a href="https://i.imgur.com/jmEMRYC.png" class="uri">https://i.imgur.com/jmEMRYC.png</a>](https://i.imgur.com/jmEMRYC.png)
(Please note that this is a static version. Real plots are interactive.)
