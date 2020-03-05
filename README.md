---
pagetitle: "rfutbin"
---


# rfutbin

rfutbin: Search prices for FIFA Ultimate Team players in Futbin webpage

## Installation

This package is currently available only on GitHub. To install it, use the
`devtools` package:

```{r}
library(devtools)
install_github("danielredondo/rfut")
```
## Usage

There's just one exported function in this package, `futbin_search`. It has the following parameters:

- `name`. Optional. Name of the player. If leaved blank, it will report the 30 highest-rated players of the game.

- `version`. Optional. Version of the card. It can be "Normal", "CL" (Champions League), "IF" (In-Form), "SIF" (Second In-Form), ...

- `messages`. Optional. To show additional messages (webpage used and number of players found).

The output of the function is a dataframe with all the players found searching for `name` and  `version`.

## Examples

```{r}
futbin_search("Lionel Messi")
```

```{}
          name rating position             ver ps_price skills weak_foot work_rate pac sho pas dri def phy
1 Lionel Messi     99       RW            TOTY     4.4M      4         4    M \\ L  96  98  99  99  50  85
2 Lionel Messi     96       RW         CL TOTT    2.02M      4         4    M \\ L  91  94  94  98  42  70
3 Lionel Messi     96       RW LaLiga POTM SBC    1.86M      4         4    M \\ L  90  94  94  98  41  69
4 Lionel Messi     96       CF   ShapeShifters     2.8M      4         4    H \\ L  91  95  94  98  41  71
5 Lionel Messi     95       RW              IF    1.22M      4         4    M \\ L  89  93  93  97  40  68
6 Lionel Messi     95       RW    TOTY Nominee    1.09M      4         4    M \\ L  88  93  93  97  40  67
7 Lionel Messi     94       RW          Normal     739K      4         4    M \\ L  87  92  92  96  39  66
8 Lionel Messi     94       RW              CL     745K      4         4    M \\ L  87  92  92  96  39  66
  hei popularity base_stats in_game_stats work_rate_attack work_rate_defense wei      ps
1 170       3641        527          2519                M                 L  72 4400000
2 170       1485        489          2361                M                 L  72 2020000
3 170      -2747        486          2350                M                 L  72 1860000
4 170       1075        490          2365                H                 L  72 2800000
5 170       4009        480          2320                M                 L  72 1220000
6 170        293        478          2314                M                 L  72 1090000
7 170       6456        472          2297                M                 L  72  739000
8 170        728        472          2297                M                 L  72  745000
```


```{r}
futbin_search("Lionel Messi", version = "Normal")
```

```{}
          name rating position    ver ps_price skills weak_foot work_rate pac sho pas dri def phy hei
7 Lionel Messi     94       RW Normal     739K      4         4    M \\ L  87  92  92  96  39  66 170
  popularity base_stats in_game_stats work_rate_attack work_rate_defense wei     ps
7       6456        472          2297                M                 L  72 739000
```
```{r}
futbin_search("Luka Modric", version = "IF", messages = TRUE)
```

```{}
[1] "Reading... https://www.futbin.com/20/players?page=1&search=luka+modric"
[1] "Player(s) found: 1"
         name rating position ver ps_price skills weak_foot work_rate pac sho pas dri def phy hei
2 Luka Modric     91       CM  IF     109K      4         4    H \\ H  75  78  91  91  73  67 172
  popularity base_stats in_game_stats work_rate_attack work_rate_defense wei     ps
2        756        475          2336                H                 H  66 109000
```
