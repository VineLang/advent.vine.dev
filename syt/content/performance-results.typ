#import "/lib.typ": *

= Performance Results <results>

We'll use three statistics as the performance results of a solution:
- *Total (interactions):* represents the sequential performance
- *Depth (interactions):* represents the best-possible parallel performance
- *Speedup (#link("https://centibels.fyi")[cB]):* _(the ratio of total to depth reported as #link("https://centibels.fyi")[centibels])_ shows how much faster a parallel processor could execute the program as compared to a sequential processor 

To get the statistics necessary for the performance results, solutions must be run with `--depth` ;; the statistics should look similar to:
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
#todo("replace above stats")
