#import "../ressources/repository/states.typ": templateConfig
#import "../ressources/constants/units.typ": sizeXL

#import "../ressources/repository/states.typ": templateConfig

/// authorship generates the declaration of authorship section of the paper. 
/// 
/// It supports both the texts required by classes of 23 and classes from 24.
///
/// -> content
#let authorship() = {
  pagebreak()
  
  context {
    let declarationTitle = ""
    let declarationText = []
    let authors = templateConfig.get().authors
    let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")
    let thesisMap = (
      "Studienarbeit": "STUDENT_RESEARCH_PROJECT",
      "Projektarbeit": "PROJECT_REPORT",
      "Bachelorarbeit": "BACHELORS_THESIS",
      "Masterarbeit": "MASTERS_THESIS"
    )
    
    if templateConfig.get().course.contains("TINF23") {
      declarationTitle = local.DECLARATION_AUTHORSHIP_23_TITLE
      let text = local.DECLARATION_AUTHORSHIP_23
        .replace("{type}", local.at(thesisMap.at(templateConfig.get().type)))
        .replace("{title}", templateConfig.get().title)
      declarationText = [ #text ]
    } else {
      declarationTitle = local.DECLARATION_AUTHORSHIP_24_TITLE
      declarationText = [ #local.DECLARATION_AUTHORSHIP_24 ]
    }
    
    text( weight: "bold", size: sizeXL, declarationTitle)
    
    par[ #declarationText ]
    
    for author in authors {
      columns(2)[
        #let keys = author.keys()
        #block(height: 1.5cm, width: 100%)[
          #align( horizon )[
            #block(width: 100%)[
              #if keys.contains("signedAt") and keys.contains("signedOn") {
                text( author.signedAt + ", " + author.signedOn )
              } else if keys.contains("signedAt") {
                text( author.signedAt )
              } else if keys.contains("signedOn") {
                text( author.signedOn)
              }
            ]
            #v(-0.3cm)
            #line( length: 80% )
            #v(-0.3cm)
            #block(width: 100%)[
              #text( local.LOCATION + ", " + local.DATE )
            ]
          ]
        ]
        
        #colbreak()
        
        #align( right + horizon )[
          #if author.keys().contains("signaturePath") {
            place(
              scope: "column",
              dx: author.at("signatureDx", default: 0cm),
              dy: author.at("signatureDy", default: 0cm),
              image(
                author.at("signaturePath"),
                alt: local.SIGNED_BY + author.name,
                width: author.at("signatureWidth", default: 5cm)
              )
            )
          }
          #block(height: 1.5cm, width: 100%)[
            
            #let measuredText = measure(block(width: 100%)[
              #if keys.contains("signedAt") and keys.contains("signedOn") {
                text( author.signedAt + "," + author.signedOn )
              } else if keys.contains("signedAt") {
                text( author.signedAt )
              } else if keys.contains("signedOn") {
                text( author.signedOn)
              }
            ]).height
            #block(height: measuredText )
            #v(-0.3cm)
            #line( length: 80% )
            #v(-0.3cm)
            #block(width: 100%)[
              #text( local.SIGNATURE )
            ]
          ]
        ]
      ]
    }
  }
}