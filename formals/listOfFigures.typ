#import "../ressources/constants/units.typ": gapS

#import "../ressources/repository/states.typ": templateConfig

/// listOfFigures generates the list of figures page(s)
///
/// -> content
#let listOfFigures(  ) = {
  context {
    let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")

    heading( local.LIST_OF_FIGURES, level: 1, outlined: false, bookmarked: true )

    let figures = query(figure.where(kind: image))
    let widestPrefix = 0cm

    for (index, figure) in figures.enumerate() {
      let prefixWidth = measure(
        text(
          figure.supplement + " " + str(figure.counter.at(figure.location()).at(0)),
          weight: "bold"
        )
      ).width
      if prefixWidth > widestPrefix { widestPrefix = prefixWidth }
    }

    for (index, figure) in figures.enumerate() {
      if figure.caption == none { panic( "The caption of a figure cannot be empty" ) }

      let pageNumberWidth = measure(
        text( str(counter(page).at(figure.location()).at(0)), weight: "bold" )
      ).width

      let lineWidth = page.width - 2.5cm - 2.5cm
      let textWidthWhenMinPoints = measure(
        width: lineWidth - 0.5cm - pageNumberWidth - widestPrefix - 0.5cm,
        text( figure.caption.body )
      ).width

      link(
        figure.location(),
        grid(
          columns: (
            widestPrefix,
            1fr,
            100% - widestPrefix - 0.5cm - textWidthWhenMinPoints - pageNumberWidth,
            auto
          ),
          column-gutter: (0.3cm, 0.1cm, 0.1cm),
          text( figure.supplement + " " + str(figure.counter.at(figure.location()).at(0)), weight: "bold" ),
          text( figure.caption.body ),
          repeat[.],
          text( str(counter(page).at(figure.location()).at(0)) )
        )
      )
    }
  }
}
