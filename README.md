-   [rfutbin](#rfutbin)
    -   [Installation](#installation)
    -   [Usage](#usage)
        -   [futbin\_search](#futbin_search)
        -   [futbin\_plot](#futbin_plot)
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

Usage
-----

In `rfutbin` there are two functions: `futbin_search` and `futbin_plot`.

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
#>           name rating position         version ps_price skills weak_foot
#> 1 Lionel Messi     99       RW            TOTY    4.24M      4         4
#> 2 Lionel Messi     96       RW         CL TOTT    1.89M      4         4
#> 3 Lionel Messi     96       RW LaLiga POTM SBC    1.86M      4         4
#> 4 Lionel Messi     96       CF   ShapeShifters    2.64M      4         4
#> 5 Lionel Messi     95       RW              IF    1.17M      4         4
#> 6 Lionel Messi     95       RW    TOTY Nominee    1.01M      4         4
#> 7 Lionel Messi     94       RW          Normal     687K      4         4
#> 8 Lionel Messi     94       RW              CL     695K      4         4
#>   work_rate pac sho pas dri def phy hei popularity base_stats in_game_stats
#> 1    M \\ L  96  98  99  99  50  85 170       3690        527          2519
#> 2    M \\ L  91  94  94  98  42  70 170       1494        489          2361
#> 3    M \\ L  90  94  94  98  41  69 170      -2745        486          2350
#> 4    H \\ L  91  95  94  98  41  71 170       1123        490          2365
#> 5    M \\ L  89  93  93  97  40  68 170       4022        480          2320
#> 6    M \\ L  88  93  93  97  40  67 170        297        478          2314
#> 7    M \\ L  87  92  92  96  39  66 170       6575        472          2297
#> 8    M \\ L  87  92  92  96  39  66 170        736        472          2297
#>   work_rate_attack work_rate_defense wei      ps
#> 1                M                 L  72 4240000
#> 2                M                 L  72 1890000
#> 3                M                 L  72 1860000
#> 4                H                 L  72 2640000
#> 5                M                 L  72 1170000
#> 6                M                 L  72 1010000
#> 7                M                 L  72  687000
#> 8                M                 L  72  695000
```

``` r
futbin_search(name = c("Lionel Messi", "Griezmann"), version = "Normal")
#>                 name rating position         version ps_price skills weak_foot
#> 1       Lionel Messi     99       RW            TOTY    4.24M      4         4
#> 2       Lionel Messi     96       RW         CL TOTT    1.89M      4         4
#> 3       Lionel Messi     96       RW LaLiga POTM SBC    1.86M      4         4
#> 4       Lionel Messi     96       CF   ShapeShifters    2.64M      4         4
#> 5       Lionel Messi     95       RW              IF    1.17M      4         4
#> 6       Lionel Messi     95       RW    TOTY Nominee    1.01M      4         4
#> 7       Lionel Messi     94       RW          Normal     687K      4         4
#> 8       Lionel Messi     94       RW              CL     695K      4         4
#> 9  Antoine Griezmann     90       CF             OTW     227K      4         3
#> 10 Antoine Griezmann     90       LW              IF     195K      4         3
#> 11 Antoine Griezmann     89       CF          Normal      36K      4         3
#> 12 Antoine Griezmann     89       CF              CL   36.75K      4         3
#>    work_rate pac sho pas dri def phy hei popularity base_stats in_game_stats
#> 1     M \\ L  96  98  99  99  50  85 170       3690        527          2519
#> 2     M \\ L  91  94  94  98  42  70 170       1494        489          2361
#> 3     M \\ L  90  94  94  98  41  69 170      -2745        486          2350
#> 4     H \\ L  91  95  94  98  41  71 170       1123        490          2365
#> 5     M \\ L  89  93  93  97  40  68 170       4022        480          2320
#> 6     M \\ L  88  93  93  97  40  67 170        297        478          2314
#> 7     M \\ L  87  92  92  96  39  66 170       6575        472          2297
#> 8     M \\ L  87  92  92  96  39  66 170        736        472          2297
#> 9     H \\ H  82  88  86  90  58  73 176       1202        477          2357
#> 10    H \\ H  82  88  86  90  58  73 176       1569        477          2357
#> 11    H \\ H  81  86  84  89  57  72 176       5018        469          2326
#> 12    H \\ H  81  86  84  89  57  72 176        194        469          2326
#>    work_rate_attack work_rate_defense wei      ps
#> 1                 M                 L  72 4240000
#> 2                 M                 L  72 1890000
#> 3                 M                 L  72 1860000
#> 4                 H                 L  72 2640000
#> 5                 M                 L  72 1170000
#> 6                 M                 L  72 1010000
#> 7                 M                 L  72  687000
#> 8                 M                 L  72  695000
#> 9                 H                 H  73  227000
#> 10                H                 H  73  195000
#> 11                H                 H  73   36000
#> 12                H                 H  73   36750
```

``` r
futbin_search(name = "Luka Modric", version = "IF", messages = TRUE)
#> [1] "Reading... https://www.futbin.com/20/players?page=1&search=luka+modric"
#> [1] "Player(s) found: 5"
#>          name rating position      version ps_price skills weak_foot work_rate
#> 1 Luka Modric     92       CM   FUTmas SBC   141.6K      4         4    H \\ H
#> 2 Luka Modric     91       CM           IF    99.5K      4         4    H \\ H
#> 3 Luka Modric     91       CM TOTY Nominee      91K      4         4    H \\ H
#> 4 Luka Modric     90       CM       Normal    49.5K      4         4    H \\ H
#> 5 Luka Modric     90       CM           CL      50K      4         4    H \\ H
#>   pac sho pas dri def phy hei popularity base_stats in_game_stats
#> 1  77  80  92  92  74  69 172        158        484          2377
#> 2  75  78  91  91  73  67 172        758        475          2336
#> 3  75  77  90  91  73  67 172         87        473          2324
#> 4  74  76  89  90  72  66 172        937        467          2308
#> 5  74  76  89  90  72  66 172         36        467          2308
#>   work_rate_attack work_rate_defense wei     ps
#> 1                H                 H  66 141600
#> 2                H                 H  66  99500
#> 3                H                 H  66  91000
#> 4                H                 H  66  49500
#> 5                H                 H  66  50000
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
