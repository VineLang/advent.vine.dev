#import "/lib.typ": *
#import "/content/lib/boards.typ": *
#import "/data/data.typ": *

= Participants

#let children = persons.keys().map(person => (
  path: person + ".typ",
  title: [#person],
  content: [
    = #person #label("person_" + person)
    #let repo = persons.at(person).repo
    #if repo.len() > 0 [ #link(repo)[#repo] ]
    #board_person(person)
  ],
))
