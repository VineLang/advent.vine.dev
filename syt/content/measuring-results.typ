#import "/lib.typ": *

= Measuring Results <results>

We'll use two metrics to measure the performance of solutions:
- Total number of interactions: this represents the sequential performance
- Depth of interactions: this represents the best-possible parallel performance
We'll also calculate the speedup – the ratio between the total and the depth – which will be reported in #link("https://centibels.fyi")[centibels]. This shows how much faster a parallel processor could execute the program as compared to a sequential processor.

Solutions must be run with 
- Run your solutions with `--depth` (or `-d`) so we can @results[measure the results].
  Your statistics should look something like this:
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

