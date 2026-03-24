#import "../ressources/constants/colours.typ": rot

#import "../ressources/repository/states.typ": templateConfig

/// backcoverComponent generates an optional backcover with a negative of the DHBW logo on a red background.
///
/// -> content
#let backcoverComponent() = {
  pagebreak()
  set page( fill: rot, header: none, footer: none )
  place( right + bottom )[
      #context {
        let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")
        
        pdf.artifact[
          #image( "../ressources/images/dhbw-logo_white.svg", alt: local.LOGO_ALT_TEXT, width: 25% )
        ]
      }
  ]
}