#import "../ressources/constants/units.typ": gapS

#import "../ressources/repository/states.typ": templateConfig

/// listOfCodeblocks generates the list of codeblocks page(s)
///
/// -> content
#let listOfCodeblocks( ) = {
  context {
    let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")

    heading( local.LIST_OF_CODEBLOCKS, level: 1, outlined: false, bookmarked: true)

    let codeblocks = query(figure.where(kind: "code"))
    let widestPrefix = 0cm

    for (index, codeblock) in codeblocks.enumerate() {
      let prefixWidth = measure(
        text(
          codeblock.supplement + " " + str(codeblock.counter.at(codeblock.location()).at(0)),
          weight: "bold"
        )
      ).width
      if prefixWidth > widestPrefix { widestPrefix = prefixWidth }
    }

    for (index, codeblock) in codeblocks.enumerate() {
      if codeblock.caption == none { panic( "The caption of a figure cannot be empty" ) }

      let pageNumberWidth = measure(
        text( str(counter(page).at(codeblock.location()).at(0)), weight: "bold" )
      ).width

      let lineWidth = page.width - 2.5cm - 2.5cm
      let textWidthWhenMinPoints = measure(
        width: lineWidth - 0.5cm - pageNumberWidth - widestPrefix - 0.5cm,
        text( codeblock.caption.body )
      ).width

      link(
        codeblock.location(),
        grid(
          columns: (
            widestPrefix,
            1fr,
            100% - widestPrefix - 0.5cm - textWidthWhenMinPoints - pageNumberWidth,
            auto
          ),
          column-gutter: (0.3cm, 0.1cm, 0.1cm),
          text( codeblock.supplement + " " + str(codeblock.counter.at(codeblock.location()).at(0)), weight: "bold" ),
          text( codeblock.caption.body ),
          repeat[.],
          text( str(counter(page).at(codeblock.location()).at(0)) )
        )
      )
    }
  }
}
