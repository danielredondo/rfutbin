
  - [rfutbin](#rfutbin)
      - [Installation](#installation)
      - [Usage](#usage)
      - [Examples](#examples)

# rfutbin

rfutbin: Search prices for FIFA Ultimate Team players in Futbin webpage

## Installation

This package is currently available only on GitHub. To install it, use
the `devtools` package:

``` r
library(devtools)
install_github("danielredondo/rfutbin")
```

## Usage

There’s just one exported function in this package, `futbin_search`. It
has the following parameters:

  - `name`. Optional. Optional. Vector with the names of the players. If
    not specified it will report the 30 highest-rated players of the
    game.

  - `version`. Optional. Version of the cards. It can be “Normal”, “CL”
    (Champions League), “IF” (In-Form), “SIF” (Second In-Form), …

  - `messages`. Optional. To show additional messages (webpage used and
    number of players found).

The output of the function is a dataframe with all the players found
searching for `name` and `version`.

## Examples

``` r
library(rfutbin)
```

``` r
futbin_search(name = "Lionel Messi")
#>           name rating position             ver ps_price skills weak_foot
#> 1 Lionel Messi     99       RW            TOTY    4.29M      4         4
#> 2 Lionel Messi     96       RW         CL TOTT     1.9M      4         4
#> 3 Lionel Messi     96       RW LaLiga POTM SBC    1.86M      4         4
#> 4 Lionel Messi     96       CF   ShapeShifters    2.73M      4         4
#> 5 Lionel Messi     95       RW              IF    1.13M      4         4
#> 6 Lionel Messi     95       RW    TOTY Nominee    1.05M      4         4
#> 7 Lionel Messi     94       RW          Normal     700K      4         4
#> 8 Lionel Messi     94       RW              CL     709K      4         4
#>   work_rate pac sho pas dri def phy hei popularity base_stats in_game_stats
#> 1    M \\ L  96  98  99  99  50  85 170       3655        527          2519
#> 2    M \\ L  91  94  94  98  42  70 170       1487        489          2361
#> 3    M \\ L  90  94  94  98  41  69 170      -2746        486          2350
#> 4    H \\ L  91  95  94  98  41  71 170       1105        490          2365
#> 5    M \\ L  89  93  93  97  40  68 170       4014        480          2320
#> 6    M \\ L  88  93  93  97  40  67 170        290        478          2314
#> 7    M \\ L  87  92  92  96  39  66 170       6500        472          2297
#> 8    M \\ L  87  92  92  96  39  66 170        730        472          2297
#>   work_rate_attack work_rate_defense wei      ps
#> 1                M                 L  72 4290000
#> 2                M                 L  72 1900000
#> 3                M                 L  72 1860000
#> 4                H                 L  72 2730000
#> 5                M                 L  72 1130000
#> 6                M                 L  72 1050000
#> 7                M                 L  72  700000
#> 8                M                 L  72  709000
```

``` r
futbin_search(name = c("Lionel Messi", "Griezmann"), version = "Normal")
#>                name rating position    ver ps_price skills weak_foot work_rate
#> 7      Lionel Messi     94       RW Normal     700K      4         4    M \\ L
#> 3 Antoine Griezmann     89       CF Normal   43.25K      4         3    H \\ H
#>   pac sho pas dri def phy hei popularity base_stats in_game_stats
#> 7  87  92  92  96  39  66 170       6500        472          2297
#> 3  81  86  84  89  57  72 176       5001        469          2326
#>   work_rate_attack work_rate_defense wei     ps
#> 7                M                 L  72 700000
#> 3                H                 H  73  43250
```

``` r
futbin_search(name = "Luka Modric", version = "IF", messages = TRUE)
#> [1] "Reading... https://www.futbin.com/20/players?page=1&search=luka+modric"
#> [1] "Player(s) found: 1"
#>          name rating position ver ps_price skills weak_foot work_rate pac sho
#> 2 Luka Modric     91       CM  IF     109K      4         4    H \\ H  75  78
#>   pas dri def phy hei popularity base_stats in_game_stats work_rate_attack
#> 2  91  91  73  67 172        756        475          2336                H
#>   work_rate_defense wei     ps
#> 2                 H  66 109000
```
