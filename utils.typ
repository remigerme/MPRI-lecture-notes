#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *


#let notes(body, title: none) = {
  show: codly-init.with()
  codly(languages: codly-languages)

  // Font setting
  set text(font: "Linux Libertine")

  // Custom show rules
  show "ie.": [_i.e._]
  show "eg.": [_e.g._]
  show "TODO": text(fill: red, weight: "bold", style: "italic", "TODO")

  set page(
    header: if title == none { none } else { align(center, text(fill: gray, title)) },
    numbering: "1 / 1",
  )

  set heading(numbering: "I.1. ")

  body
}

#let custom-block(name, color, title: none, body) = {
  rect(
    radius: (left: 0pt, right: 2pt),
    fill: color.lighten(90%),
    stroke: (left: 2pt + color.darken(40%), rest: none),
    width: 100%,
    inset: 10pt,
  )[
    #set par(spacing: 0.9em)
    #text(fill: black, weight: "bold")[
      #name
      #if title != none { [(#title)] }
    ]

    // #set par(leading: 0.65em)
    #body
  ]
}

#let def(title: none, body) = custom-block("Definition", blue, title: title, body)
#let ex(title: none, body) = custom-block("Example", purple, title: title, body)
#let prop(title: none, body) = custom-block("Prop", yellow, title: title, body)
#let th(title: none, body) = custom-block("Theorem", orange, title: title, body)
#let lemma(title: none, body) = custom-block("Lemma", silver, title: title, body)

#let lsum = $limits(sum)$
