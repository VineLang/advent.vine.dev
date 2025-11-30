#import "/data/data.typ": *
#import "/lib.typ": *

// #let cB = [ #link("https://centibel.fyi")[cB]]
#let cB = [ cB]

#let show_day = (day) => {
  ref(label("day_" + day), supplement: [#day])
}

#let show_person = (person) => {
  ref(label("person_" + person), supplement: [#person])
}

#let best = (best, got, unit: []) => {
  t.span(class: if got == best { "best" } else { "" })[#got#unit]
}

#let board_overall_days() = [
  #let best_day_speedup = calc.max(..days.values().map(stats => stats.speedup))

  #table(
    columns: 5,
    align: right,
    table.header([Day], [Solves], [Best Total], [Best Depth], [Speedup]),
    ..days.pairs().map(((day, stats)) => (
      [#show_day(day)],
      [#stats.solves.keys().len()],
      [#stats.best_total],
      [#stats.best_depth],
      [#best(best_day_speedup, stats.speedup, unit: cB)],
    )).join(),
  )
]

#let board_overall_users() = [
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
]


#let board_day(day) = [
  #let stats = days.at(day)
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


#let board_person(person) = [
  #let stats = persons.at(person)
  #table(
    columns: 4,
    align: right,
    table.header([Day], [Total], [Depth], [Speedup]),
    ..stats.solves.pairs().map(((day, (total, depth))) => (
      show_day(day),
      best(days.at(day).best_total, total),
      best(days.at(day).best_depth, depth),
      best(days.at(day).best_speedup, speedup(total, depth), unit: cB),
    )).join(),
  )
]

