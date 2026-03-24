#import "../ressources/constants/units.typ": gapXS, sizeXL
#import "../ressources/constants/colours.typ": rot

#import "../ressources/repository/states.typ": templateConfig

/// preamble generates the preamble page(s)
///
/// -> content
#let preamble() = {
  pagebreak()
  context {
    let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")
    align( horizon )[
      #align( center )[ #text( weight: "bold", size: sizeXL, local.PREAMBLE ) ]
      #v( gapXS )
      #set par( justify: true )
      #context state("templateConfig").get().preambleContent
    ]
  }
}