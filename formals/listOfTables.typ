#import "../ressources/constants/units.typ": gapS

#import "../ressources/repository/states.typ": templateConfig

/// listOfTables generates the list of tables page(s)
///
/// -> content
#let listOfTables(  ) = {
  context {
    let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")

    heading( local.LIST_OF_TABLES, level: 1, outlined: false, bookmarked: true )

    let tables = query(figure.where(kind: table))
    let widestPrefix = 0cm

    for (index, table) in tables.enumerate() {
      let prefixWidth = measure(
        text(
          table.supplement + " " + str(table.counter.at(table.location()).at(0)),
          weight: "bold"
        )
      ).width
      if prefixWidth > widestPrefix { widestPrefix = prefixWidth }
    }

    for (index, table) in tables.enumerate() {
      if table.caption == none { panic( "The caption of a figure cannot be empty" ) }

      let pageNumberWidth = measure(
        text( str(counter(page).at(table.location()).at(0)), weight: "bold" )
      ).width

      let lineWidth = page.width - 2.5cm - 2.5cm
      let textWidthWhenMinPoints = measure(
        width: lineWidth - 0.5cm - pageNumberWidth - widestPrefix - 0.5cm,
        text( table.caption.body )
      ).width

      link(
        table.location(),
        grid(
          columns: (
            widestPrefix,
            1fr,
            100% - widestPrefix - 0.5cm - textWidthWhenMinPoints - pageNumberWidth,
            auto
          ),
          column-gutter: (0.3cm, 0.1cm, 0.1cm),
          text( table.supplement + " " + str(table.counter.at(table.location()).at(0)), weight: "bold" ),
          text( table.caption.body ),
          repeat[.],
          text( str(counter(page).at(table.location()).at(0)) )
        )
      )
    }
  }
}
