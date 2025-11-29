#import "/lib.typ": *

= Leaderboards <leaderboards>

Advent of Vine also includes a friendly competition to solve each day's puzzle as efficiently as possible.

== Measuring Results

We'll use two metrics to measure the performance of solutions:
- Total number of interactions: this represents the sequential performance
- Depth of interactions: this represents the best-possible parallel performance
We'll also calculate the speedup – the ratio between the total and the depth – which will be reported in #link("https://centibels.fyi")[centibels]. This shows how much faster a parallel processor could execute the program as compared to a sequential processor.

== How to Participate

- #todo("join discord server")
- Post your solutions to a public git repo.
- Make sure to pass `--depth` (or `-d`) when running your solution so we can see the depth. Your statistics should look something like this:
#todo("different stats")
```
Interactions
  Total               19_313
    Depth              1_568
    Breadth               12
  Annihilate           9_392
  Commute                  0
  Copy                 1_661
  Erase                2_249
  Expand               1_881
  Call                 2_969
  Branch               1_161

Memory
  Heap                24_128 B
  Allocated          405_280 B
  Freed              405_280 B

Performance
  Time                     0 ms
  Speed           39_612_997 IPS
```
- When you solve a day's puzzle, post the statistics from running your solution on the official input and ping `@AoV`.

We'll update the leaderboard with the latest stats when we can throughout the day. Feel free to post new statistics if you improve your solution.

#let children = (
  "lb-orig.typ",
)

