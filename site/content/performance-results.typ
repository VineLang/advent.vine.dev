#import "/lib.typ": *

= Performance Results <results>

We'll use three statistics as the performance results of a solution:
- *Total (interactions):* represents the sequential performance
- *Depth (interactions):* represents the best-possible parallel performance
- *Speedup (#link("https://centibels.fyi")[cB]):* _(the ratio of total to depth reported in #link("https://centibels.fyi")[centibels])_ shows how much faster a parallel processor could execute the program as compared to a sequential processor 

To get the statistics necessary for the performance results, solutions must be run with `--depth`; the statistics should look similar to:
```
Interactions
  Total           715_953_136
    Depth           2_107_457
    Breadth               339
    Speedup               253 cB
  Annihilate      168_591_018
  Commute                   0
  Copy            201_808_179
  Erase            47_917_985
  Expand           21_862_374
  Call            254_961_858
  Branch           20_811_722

Memory
  Heap             61_573_600 B
  Allocated    14_633_884_496 B
  Freed        14_633_884_496 B

Performance
  Time                 33_151 ms
  Speed            21_596_307 IPS
```
