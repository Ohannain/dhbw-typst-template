#import "../ressources/repository/states.typ": templateConfig
#import "@preview/abbr:0.3.0"

/// listOfAbbreviations generates the list of abbreviations page(s)
/// 
/// -> content 
#let listOfAbbreviations() = {
  context {
    let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")

    heading( local.LIST_OF_ABBREVIATIONS, level: 1, outlined: false, bookmarked: true)

    let abbreviations = abbr.getAbbr()
    let keys = abbreviations.keys().sorted()
    
    let widestAbbreviation = 0cm
    let widths = ()
    for key in keys {
      widths.push( measure( strong(key) ).width )
      if widths.last() > widestAbbreviation { widestAbbreviation = widths.last() }
    }
    
    columns(2, gutter: 0.5cm)[
      #let i = 0
      #for key in keys {
        [
          #let fill = widestAbbreviation - widths.at(i)
          
          #grid(
            columns: (auto, fill + 0.5cm, 1fr),
            column-gutter: (0.1cm, 0.1cm),
            strong(key),
            repeat[.],
            abbreviations.at(key).at("l")
          )
          #abbreviations.at(key).at("lbl")
        ]
        i += 1
      }
    ]
  }
}
