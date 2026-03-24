#import "../ressources/constants/units.typ": sizeXL
#import "../ressources/repository/states.typ": templateConfig

/// confidentiality generates the confidentiality note section of a paper.
///
/// -> content
#let confidentiality() = {
  context {
    let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")
    
    text( weight: "bold", size: sizeXL, local.NON_DISCLOSURE_NOTICE_TITLE )
  
    par[
      #local.NON_DISCLOSURE_NOTICE
    ]
  }
}