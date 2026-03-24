#import "../ressources/repository/states.typ": templateConfig, headingsCounter
#import "../ressources/constants/units.typ": gapS, gapXS
#import "../util/convertNumerals.typ": arabicToRoman
#import "../util/localize.typ": locale

/// tocEntry generates the links to front and backmatter pages.
///
/// - entry (): the name of the frontmatter
/// -> block
#let tocEntry(entry) = {
  block[
    #let entryMap = (
      "abbreviations": "LIST_OF_ABBREVIATIONS",
      "figures": "LIST_OF_FIGURES",
      "tables": "LIST_OF_TABLES",
      "codeblocks": "LIST_OF_CODEBLOCKS",
      "sources": "LIST_OF_SOURCES",
      "legalSource": "LIST_OF_LEGAL_SOURCES",
      "attachments": "LIST_OF_ATTACHMENTS"
    )

    #context{
      set text( weight: "bold" )
      link(label(entry))[
        #text( locale(entryMap.at(entry)) )
      ]
      h(1fr)
      text( arabicToRoman(counter(page).at(label(entry)).first()) )
    }
  ]
}

/// pWidth calculates the width of the page number for an entry in the table of contents
///
/// - contentHeading (): a queried heading from the document
/// -> length
#let pWidth(contentHeading) = {
  measure(
    text( str(counter(page).at(contentHeading.location()).at(0)), weight: "bold" )
  ).width
}

/// maxNumberingWidth 
///
/// - contentHeadings (): an array containing queried headings of the document
/// - numberingFn (): a function describing how a heading the in table of contents should be numbered
/// - weight (): a font weight of the numbering/heading inside the table of contents.
/// -> length
#let maxNumberingWidth(contentHeadings, numberingFn, weight: "regular") = {
  let maxWidth = 0cm
  for heading in contentHeadings {
    let width = measure(
      text( numberingFn(heading), weight: weight )
    ).width
    if width > maxWidth { maxWidth = width }
  }
  return maxWidth
}

/// listOfContents generates the list of contents page(s)
///
/// -> content
#let listOfContents() = {
  context {
    heading( locale("LIST_OF_CONTENTS"), level: 1, outlined: false, bookmarked: false )

    set block(
      above: gapXS,
      below: 0.9em
    )

    for entry in templateConfig.get().frontmatter {
      if entry in ("authorship", "preamble", "confidentiality", "abstract", "contents") { continue }
      tocEntry(entry)
    }

    v(gapS)

    // Generate links to content headings
    let contentHeadings = (
      "all": query(heading.where(outlined: true)),
      "l1": query(heading.where(level: 1, outlined: true)),
      "l2": query(heading.where(level: 2, outlined: true)),
      "l3": query(heading.where(level: 3, outlined: true)),
      "l4": query(heading.where(level: 4, outlined: true)),
      "l5": query(heading.where(level: 5, outlined: true)),
      "l6": query(heading.where(level: 6, outlined: true))
    )
    let numberingWidths = (l1: 0cm, l2: 0cm, l3: 0cm, l4: 0cm, l5: 0cm, l6: 0cm)
    let numberings = (
      l1: (h) => str(counter(heading).at(h.location()).at(0)),
      l2: (h) => counter(heading).at(h.location()).map(str).join("."),
    )
    let lineWidth = page.width - 2.5cm - 2.5cm

    numberingWidths.l1 = maxNumberingWidth(contentHeadings.l1, numberings.l1, weight: "bold")
    numberingWidths.l2 = maxNumberingWidth(contentHeadings.l2, numberings.l2)
    
    for contentHeading in contentHeadings.all {
      if contentHeading in contentHeadings.l1 {
        let pageNumberWidth = pWidth(contentHeading)

        let textWidthWhenMinPoints = measure(
          width: lineWidth - 0.5cm - pageNumberWidth - numberingWidths.l1 - 0.5cm,
          text( contentHeading.body.text, weight: "bold" )
        ).width

        link(
          contentHeading.location(),
          grid(
            columns: (
              numberingWidths.l1,
              1fr,
              100% - numberingWidths.l1 - 0.5cm - textWidthWhenMinPoints - pageNumberWidth,
              auto
            ),
            column-gutter: (0.3cm, 0.1cm, 0.1cm),
            text( (numberings.l1)(contentHeading), weight: "bold" ),
            text( contentHeading.body.text, weight: "bold" ),
            [],
            text( str(counter(page).at(contentHeading.location()).at(0)), weight: "bold" )
          )
        )
      } else if contentHeading in contentHeadings.l2 {
        let pageNumberWidth = pWidth(contentHeading)
        
        let textWidthWhenMinPoints = measure(
          width: lineWidth - 0.3cm - numberingWidths.l1 - 0.5cm - pageNumberWidth - numberingWidths.l2 - 0.5cm,
          text( contentHeading.body.text )
        ).width

        link(
          contentHeading.location(),
          grid(
            columns: (
              numberingWidths.l1 + 0.3cm,
              numberingWidths.l2,
              1fr,
              100% - numberingWidths.l2 - 0.5cm - textWidthWhenMinPoints - pageNumberWidth - (numberingWidths.l1 + 0.3cm),
              auto
            ),
            column-gutter: (0cm, 0.3cm, 0.1cm, 0.1cm),
            [],
            text( (numberings.l2)(contentHeading) ),
            text( contentHeading.body ),
            repeat[.],
            text( str(counter(page).at(contentHeading.location()).at(0)))
          )
        )
      }
    }

    v(gapS)

    for entry in templateConfig.get().backmatter {
      if entry in ("authorship", "preamble", "confidentiality", "abstract", "contents") { continue }
      tocEntry(entry)
    }
  }
}
