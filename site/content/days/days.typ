#import "/lib.typ": *
#import "/content/lib/boards.typ": *
#import "/data/data.typ": *

= Daily

#let children = days.keys().map(day => (
  path: day + ".typ",
  title: [Day #day],
  content: [
    = Day #day #label("day_" + day)
    #board_day(day)
  ],
))
