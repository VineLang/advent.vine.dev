#import "raw.typ": *

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

