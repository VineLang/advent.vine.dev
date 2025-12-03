#import "/lib.typ": *
#import "/content/lib/boards.typ": *
#import "/data/data.typ": *

= Daily

#let children = days.keys().map(day => (
  path: day + ".typ",
  title: [Day #day],
  content: [
    = Day #day #label("day_" + day)
    #link("https://adventofcode.com/2025/day/"+day)[Advent of Code Day #day]
    #board_day(day)
  ],
))
