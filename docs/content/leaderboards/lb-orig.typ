
= (original)

#let persons = (
  "T6": "https://github.com/tjjfvi/AoV-2025",
  "Nils": "https://github.com/nilscrm/aoc-2025",
  "HU90m": "https://codeberg.org/HU90m/aoc-2025",
)

#let data = (
  ("T6", "1", 1000, 600),
  ("T6", "2", 4600, 777),
  ("Nils", "1", 12345, 5678),
  ("Nils", "2", 5555, 999),
  ("HU90m", "1", 900, 600),
  ("Nils", "1", 1234, 567),
)

#set text(font: "Atkinson Hyperlegible Mono", fill: white)
#set table(stroke: white + .5pt)
#let theme = rgb("#46c676")
#show heading.where(level: 1): underline.with(stroke: theme)
#show table.cell.where(y: 0): strong
#let cB = link("https://centibel.fyi")[ cB]

#[
  // #show: align.with(center)
  #set text(size: 20pt, fill: theme)
  Advent of Vine \
]

(Note: all data is currently a placeholder.)

#let speedup = (total, depth) => calc.round(calc.log(total / depth, base: 10) * 100)

#let to_dict = ((k, v)) => ((k): v)

#let days = data.map(((_, day, _, _)) => (day, ())).map(to_dict).join().keys()
#let days = days.map(day => {
  let solves = data
    .filter(((_, day_, _, _)) => day_ == day)
    .map(((person, _, total, depth)) => (person, (total, depth)))
    .map(to_dict).join().pairs()
    .sorted(key: ((person, (total, depth))) => depth)
    .map(to_dict).join();
  let best_total = calc.min(..solves.values().map(((total, depth)) => total))
  let best_depth = calc.min(..solves.values().map(((total, depth)) => depth))
  let best_speedup = calc.max(..solves.values().map(((total, depth)) => speedup(total, depth)))
  let speedup = speedup(best_total, best_depth)
  ((day): (
    solves: solves,
    best_total: best_total,
    best_depth: best_depth,
    best_speedup: best_speedup,
    speedup: speedup,
  ))
}).join()

#let persons = (persons.pairs()
  .map(((person, repo)) => {
    let solves = data
      .filter(((person_, _, _, _)) => person_ == person)
      .map(((_, day, total, depth)) => (day, (total, depth)))
      .map(to_dict).join().pairs()
      .sorted(key: ((day, _)) => day)
      .map(to_dict).join();
    let total_records = solves.pairs().filter(((day, (total, depth))) => days.at(day).best_total == total).len()
    let depth_records = solves.pairs().filter(((day, (total, depth))) => days.at(day).best_depth == depth).len()
    let best_speedup = calc.max(..solves.values().map(((total, depth)) => speedup(total, depth)))
    (person, (
      repo: repo,
      solves: solves,
      total_records: total_records,
      depth_records: depth_records,
      best_speedup: best_speedup,
    ))  
  })
  .sorted(key: ((person, stats)) => -(stats.total_records + stats.depth_records))
  .map(((person, stats)) => ((person): stats))
  .join()
)

#let show_person = (person) => {
  link(persons.at(person).repo)[#person]
}

#let best = (best, got, unit: []) => {
  if got == best [
    #set text(fill: theme)
    #got#unit
  ] else [
    #got#unit
  ]
}

= Overall

#let best_day_speedup = calc.max(..days.values().map(stats => stats.speedup))

#table(
  columns: 5,
  align: right,
  table.header([Day], [Solves], [Best Total], [Best Depth], [Speedup]),
  ..days.pairs().map(((day, stats)) => (
    [#day],
    [#stats.solves.keys().len()],
    [#stats.best_total],
    [#stats.best_depth],
    [#best(best_day_speedup, stats.speedup, unit: cB)],
  )).join(),
)

#let best_person_total_records = calc.max(..persons.values().map(stats => stats.total_records))
#let best_person_depth_records = calc.max(..persons.values().map(stats => stats.depth_records))
#let best_person_best_speedup = calc.max(..persons.values().map(stats => stats.best_speedup))

#table(
  columns: 5,
  align: right,
  table.header([User], [Solves], [Total Records], [Depth Records], [Best Speedup]),
  ..persons.pairs().map(((person, stats)) => (
    [#show_person(person)],
    [#best(days.keys().len(), stats.solves.keys().len())],
    [#best(best_person_total_records, stats.total_records)],
    [#best(best_person_depth_records, stats.depth_records)],
    [#best(best_person_best_speedup, stats.best_speedup, unit: cB)],
  )).join(),
)

= Days

#for (day, stats) in days.pairs() [
  == Day #day
  
  #table(
    columns: 4,
    align: right,
    table.header([User], [Total], [Depth], [Speedup]),
    ..stats.solves.pairs().map(((person, (total, depth))) => (
      show_person(person),
      best(stats.best_total, total),
      best(stats.best_depth, depth),
      best(stats.best_speedup, speedup(total, depth), unit: cB),
    )).join(),
  )
]

= Users

#for (person, stats) in persons.pairs() [
  == #person

  Repo: #link(stats.repo)
  
  #table(
    columns: 4,
    align: right,
    table.header([Day], [Total], [Depth], [Speedup]),
    ..stats.solves.pairs().map(((day, (total, depth))) => (
      day,
      best(days.at(day).best_total, total),
      best(days.at(day).best_depth, depth),
      best(days.at(day).best_speedup, speedup(total, depth), unit: cB),
    )).join(),
  )
]

