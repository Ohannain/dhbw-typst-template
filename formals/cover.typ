#import "@preview/datify:1.0.1": *

#import "../ressources/constants/colours.typ": blaugrau100, rot
#import "../ressources/constants/units.typ": *

#import "../ressources/repository/states.typ": templateConfig

/// coverComponent generates the documents title cover page
///
/// -> content
#let coverComponent() = {
  context {
    let local = yaml("../ressources/constants/localization/" + templateConfig.get().language + ".yml")
    
    place( right + top, dx: 0.5cm, dy: -1cm )[
      #image(
        "../ressources/images/dhbw-logo.svg",
        alt: local.LOGO_ALT_TEXT,
        width: 25%,
      )
    ]
    
    place(center, dy: 20%)[
      #block[
        #align(center)[
          #let thesisMap = (
            "Studienarbeit": "STUDENT_RESEARCH_PROJECT",
            "Projektarbeit": "PROJECT_REPORT",
            "Bachelorarbeit": "BACHELORS_THESIS",
            "Masterarbeit": "MASTERS_THESIS"
          )
          #text( 
            context {
              upper(
                local.at(thesisMap.at(templateConfig.get().type))
              ) 
            }
          )
          #linebreak()
          #text( context templateConfig.get().degree, fill: blaugrau100)
          #v( gapS )
          #show title: set text( size: sizeXXL, weight: 500 )
          #title()
        ]
      ]
      
      #block(width: 100%)[
        #let hint = rect(radius: 100%, stroke: rot + 1pt, inset: 0.5em)[
          #text(local.at("CONFIDENTIAL"), size: sizeS)
        ]
        #if templateConfig.get().frontmatter.contains("confidentiality") {
          hint
          v( gapL - measure(hint).height )
        } else { v( gapL ) }
      ]
      
      #block(width: 100%)[
        #set par( leading: 1.5em )
        #set box( inset: (left: gapS, right: gapS), height: 1em )
        #context {
          let authorsRemaining = templateConfig.get().authors
          
          for (i, author) in authorsRemaining.enumerate() {
            let providedKeys = author.keys()
            
            if providedKeys.len() == 0 { continue }
            if providedKeys.len() == 1 and providedKeys.contains("orcid") {
              panic( "Only ORCID-Link was provided. Name or Student-ID needed." )
            }
            if providedKeys.contains("orcid") and providedKeys.contains("name") and providedKeys.contains("id") {
              box[
                #link( author.orcid )[
                  #box(inset: 0em)[ #text( author.name ) ]
                  #h( gapXS / 2 )
                  #box(inset: 0em)[
                    #pdf.artifact(
                      image( "../ressources/images/orcid-logo.svg", alt: "ORCID iD icon", height: 0.9em )
                    )
                  ]
                ]
                #h( gapXS / 2)
                #box(inset: 0em)[ #text( str(author.id), fill: blaugrau100 ) ]
              ]
            } else if providedKeys.contains("name") and providedKeys.contains("id") {
              box[
                #text( author.name )
                #h( gapXS / 2 )
                #text( str(author.id), fill: blaugrau100 )
              ]
            } else if providedKeys.contains("name") {
              if providedKeys.contains("orcid") {
                box( inset: (left: gapS, right: gapS) )[
                  #link( author.orcid )[
                    #box(inset: 0em)[ #text( author.name ) ]
                    #h( gapXS / 2 )
                    #box(inset: 0em)[
                      #pdf.artifact(
                        image( "../ressources/images/orcid-logo.svg", alt: "ORCID iD icon", height: 0.9em )
                      )
                    ]
                  ]
                ]
                continue
              }
              box[ #text(author.name)]
            } else if providedKeys.contains("id") {
              if providedKeys.contains("orcid") {
                box[
                  #link( author.orcid )[
                    #box(inset: 0em)[
                      #pdf.artifact(
                        image( "../ressources/images/orcid-logo.svg", alt: "ORCID iD icon", height: 0.9em )
                      )
                    ]
                    #h(gapXS / 2)
                    #box(inset: 0em)[ #text( str(author.id), fill: blaugrau100 ) ]
                  ]
                ]
                continue
              }
              box[ #text( str(author.id), fill: blaugrau100 ) ]
            }
          }
        }
      ]
    ]
    
    align( right + bottom )[
      #move( dx: 0.5cm, dy: 1cm )[
        #box( width: 40% )[
          #align( center )[
            #text( local.CLASS, fill: blaugrau100 ) #linebreak()
            #text( context templateConfig.get().course )
            #v( gapXS )
            #text( local.SUBMISSION_DATE, fill: blaugrau100 ) #linebreak()
            #context {
              let dateTimeObject = templateConfig.get().submissionDate
              let languageString = templateConfig.get().language
              if languageString == "de" {
                text( custom-date-format( dateTimeObject, lang: languageString, pattern: "dd. MMMM yyyy" ) )
              } else if languageString == "en" {
                text(
                  custom-date-format(
                    dateTimeObject,
                    lang: languageString,
                    pattern: "MMMM d, yyyy"
                  )
                )
              }
            }
            #v( gapXS )
            #text( local.ADVISOR, fill: blaugrau100 ) #linebreak()
            #text( context templateConfig.get().tutor )
            #if templateConfig.get().supervisor != "" {
              v( gapXS )
              text( local.SUPERVISOR, fill: blaugrau100 )
              linebreak()
              text( context templateConfig.get().supervisor )
            }
            #v( gapXS )
            #text( local.LOCATION, fill: blaugrau100 ) #linebreak()
            #text( context templateConfig.get().location )
          ]
        ]
      ]
    ]
  }

  pdf.artifact(
    kind: "other",
  )[
    #place( bottom + left )[
      #move( dx: -4cm, dy: 4cm)[
        #image(
          "../ressources/images/dhbw-icon.svg",
          width: 75%
        )
      ]
    ]
  ]
}
