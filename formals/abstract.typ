#import "../ressources/constants/units.typ": gapS, gapXS, sizeS, sizeXL
#import "../ressources/repository/states.typ": templateConfig

/// abstract generates the abstracts and keywords list
/// 
/// Keywords are shown if at least one keyword is given in the templates parameters
/// 
/// There are either one or two abstracts generated depending on the languages set in the document. An English abstract is always generated. A second one is generated if a second language, not English, is given.
///
/// -> content
#let abstract() = {
  pagebreak()  
  set par( justify: true )
  context{
    let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")
    
    if (templateConfig.get().keywords.len() > 0) {
      align( top + center )[
        #set text( size: sizeS )
        #text( "Keywords:", weight: "bold")
        #linebreak()
        #text( document.keywords.join( ", " ) )
      ]
    }
    if templateConfig.get().language == "en" {
      align( horizon )[
        #set text( size: sizeS )
        #align( center)[ #text( weight: "bold", size: sizeXL, "Abstract" ) ]
        #v( gapXS )
        #templateConfig.get().abstractContent.at(1)
      ]  
    } else {
      align( horizon )[
        #set text( size: sizeS )
        #align( center )[ #text( weight: "bold", size: sizeXL, local.ABSTRACT ) ]
        #v( gapXS )
        #templateConfig.get().abstractContent.at(0)
        #v( gapS )
        #align( center)[ #text( weight: "bold", size: sizeXL, "Abstract" ) ]
        #v( gapXS )
        #templateConfig.get().abstractContent.at(1)
      ]
    }
  }
}
