#import "ressources/constants/colours.typ": weiß, rot, blaugrau100
#import "ressources/constants/units.typ": gapXS, gapS, gapXL, sizeM, sizeL, sizeXL
#import "ressources/components/header.typ": header
#import "ressources/repository/states.typ": templateConfig, headingsCounter, doNumbering, pageNumberCache

#import "formals/abstract.typ": abstract
#import "formals/authorship.typ": authorship
#import "formals/backcover.typ": backcoverComponent
#import "formals/confidentiality.typ": confidentiality
#import "formals/cover.typ": coverComponent
#import "formals/listOfAbbreviations.typ": listOfAbbreviations
#import "formals/listOfCodeblocks.typ": listOfCodeblocks
#import "formals/listOfContents.typ": listOfContents
#import "formals/listOfFigures.typ": listOfFigures
#import "formals/listOfSources.typ": listOfSources
#import "formals/listOfTables.typ": listOfTables
#import "formals/preamble.typ": preamble

#import "@preview/zebraw:0.6.1": *
#import "@preview/abbr:0.3.0"
// #import "@preview/tidy:0.4.3"
// #import "@preview/transl:0.2.0"
// #import "@preview/linguify:0.5.0"

/// The template
#let template(
  // Paper information
  type: "",
  title: "",
  authors: (),
  course: "",
  degree: "",
  tutor: "",
  supervisor: "",
  location: "",
  submissionDate: datetime(year: 2004, month: 3, day: 28),
  keywords: (),
  // Document Settings
  language: "de",
  region: "de",
  frontmatter: ("authorship", "confidentiality", "abstract", "preamble", "contents", "abbreviations", "figures", "tables", "codeblocks"),
  backmatter: ("sources", "legalSources", "attachments"),
  cover: true,
  backcover: true,
  // Document Content
  abstractContent: ( [], [] ),
  preambleContent: [],
  sourcesPath: "",
  abbrPath: "",
  content
) = {
  context templateConfig.update((
    type: type,
    title: title,
    authors: authors,
    course: course,
    degree: degree,
    tutor: tutor,
    supervisor: supervisor,
    location: location,
    submissionDate: submissionDate,
    keywords: keywords,
    language: language,
    region: region,
    frontmatter: frontmatter,
    backmatter: backmatter,
    cover: cover,
    backcover: backcover,
    abstractContent: abstractContent,
    preambleContent: preambleContent,
    sourcesPath: sourcesPath,
    abbrPath: abbrPath,
  ))

  let local = yaml("ressources/constants/localization/" + language + ".yml")

  show: abbr.show-rule
  abbr.load(abbrPath)

  set document(
    title: title,
    author: authors.filter( it => it.keys().contains("name") ).map(it => it.name),
    date: datetime.today(),
    keywords: keywords
  )

  set page(
    paper: "a4",
    margin: ( top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm ),
    fill: weiß
  )

  set text(
    font: "Inclusive Sans",
    style: "normal",
    weight: "regular",
    size: sizeM,
    lang: language,
    region: region
  )

  set heading(numbering: "1.1.1.1.1.1")

  show heading.where(level: 1): it => {
    set text( weight: "bold", size: sizeXL )
    set pad( top: 5cm, bottom: gapXS)

    pagebreak()

    if doNumbering.get() {
      pad(
        grid(
          columns: 2,
          column-gutter: 1em,
          text( context { counter(heading).display() } ),
          text( it.body )
        )
      )
    } else {
      pad( text( it.body ) )
    }
  }

  show heading.where( level: 2 ): it => {
    set text( weight: "bold", size: sizeL )
    set pad( top: gapXS )

    context {
      if doNumbering.get() {
        pad(
          grid(
            columns: 2,
            column-gutter: 1em,
            text( context { counter(heading).display() } ),
            text( it.body )
          )
        )
      } else {
        pad( text( it ) )
      }
    }
  }

  show heading.where( level: 3 ): it => {
    set text( weight: "bold", size: sizeM )
    set pad( top: gapXS )

    if doNumbering.get() {
      pad( it.body )
    } else {
      pad( text( it ) )
    }
  }

  set list(
    marker: context {
      let h = measure([H]).height
      
      box(height: h)[
        #align(horizon)[
          #rect(width: 0.35em, height: 0.35em, stroke: none, fill: rot)
        ]
      ]
    }
  )

  set enum(numbering: n => {
    set text(fill: blaugrau100)
    str(n) + ")"
  })

  set cite(style: "nature")
  show cite: it => {
    set text( fill: rot )
    it
  }

  show raw: set text( font: "JetBrains Mono" )

  show: zebraw.with(
    lang-color: rot,
    radius: 0pt,
    numbering-font-args: (
      font: "JetBrains Mono",
      fill: blaugrau100
    ),
    lang-font-args: (
      font: "JetBrains Mono",
      weight: "black",
      fill: weiß
    )
  )

  show figure.where(kind: image): it => {
    pad( top: gapXS, bottom: gapS)[
      #it.body
      #align(center)[
        #text(
          local.IMAGE + " " + it.counter.display(),
          weight: "bold",
          fill: blaugrau100
        )
        #linebreak()
        #it.caption.body
      ]
    ]
  }

  show figure.where(kind: table): it => {
    pad( top: gapXS, bottom: gapS)[
      #it.body
      #align(center)[
        #text(
          local.TABLE + " " + it.counter.display(),
          weight: "bold",
          fill: blaugrau100
        )
        #linebreak()
        #it.caption.body
      ]
    ]
  }

  show figure.where(kind: "code"): it => {
    pad( top: gapXS, bottom: gapS)[
      #it.body
      #align( center )[
        #text(
          local.CODEBLOCK + " " + it.counter.display(),
          weight: "bold",
          fill: blaugrau100
        )
        #linebreak()
        #it.caption.body
      ]
    ]
  }

  if cover { coverComponent() }

  let matterDict = (
    "authorship": authorship(),
    "confidentiality": confidentiality(),
    "abstract": abstract(),
    "preamble": preamble(),
    "contents": listOfContents(),
    "abbreviations": listOfAbbreviations(),
    "figures": listOfFigures(),
    "tables": listOfTables(),
    "codeblocks": listOfCodeblocks(),
    "sources": listOfSources(),
    // "legalSources": legalSources(),
    // "attachments": attachments()
  )

  // Prints out every selected frontmatter type in the defined order
  if frontmatter.contains("authorship") {
    authorship()
    if frontmatter.contains("confidentiality") { confidentiality() }
  }

  
  let cIndex = frontmatter.position(it => it == "contents")
  let preContents = frontmatter
  let postContents = ()
  
  if cIndex != none {
    preContents = frontmatter.slice(0, cIndex + 1)
    postContents = frontmatter.slice(cIndex + 1)
  }
  
  set page(header: header("roman", chapterNaming: false )) if cIndex == none
  if cIndex == none { counter(page).update(1) }
  
  for entry in preContents {
    if entry == "authorship" or entry == "confidentiality" { continue }
    [
      #matterDict.at(entry, default: none)
      #label(entry)
    ]
  }

  set page(header: header("roman", chapterNaming: false )) if cIndex != none
  if cIndex != none { counter(page).update(1) }

  for entry in postContents {
    if entry == "authorship" or entry == "confidentiality" { continue }
    [
      #matterDict.at(entry, default: none)
      #label(entry)
    ]
  }

  context { pageNumberCache.update(counter(page).get()) }

  set page( header: header("arabic", chapterNaming: true) )
  set par( justify: true )
  counter(page).update(1)
  doNumbering.update(true)
  counter(heading).update(0)

  content

  doNumbering.update(false)

  // Prints out every selected backmatter type in the defined order
  context { counter(page).update( pageNumberCache.get().at(0)) }
  set page( header: header("roman", chapterNaming: false))
  for entry in backmatter {
    if entry == "authorship" or entry == "confidentiality" { continue }
    [
      #matterDict.at(entry, default: none)
      #label(entry)
    ]
  }
  if backmatter.contains("authorship") {
    authorship()
    if backmatter.contains("confidentiality") {
      confidentiality()
    }
  }

  // Appendices

  if backcover { pdf.artifact(backcoverComponent()) }
}
