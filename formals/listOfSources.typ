#import "../ressources/repository/states.typ": templateConfig

/// listOfSources generates the bibliography page(s)
///
/// -> content
#let listOfSources() = {
  context {
    let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")
  
    heading( local.LIST_OF_SOURCES, level: 1, outlined: false, bookmarked: true )
  
    let templateConfig = templateConfig.final()
    
    set text( size: 10pt )
    
    bibliography(
      templateConfig.sourcesPath,
      title: none,
      style: templateConfig.at( "citationStyle", default: "ieee" )
    )
  }
}