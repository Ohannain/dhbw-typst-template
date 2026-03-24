#import "../constants/colours.typ": rot, blaugrau100

#import "@preview/chomp:0.1.0": truncate-to-fit

/// header generates the header of the document
///
/// Todo: Currently PDF-UA/1 support does not allow links inside of pdf artifacts. This limits the planned functionality of the header, as I cannot provide links inside the header to e.g. the table of contents for quick navigation inside the document.
/// 
/// - numbering (): The type of numbering provided determines wether a header is shown or not.
/// - chapterNaming (): determines wether the name of a parent chapter should be visible
/// - links (): determines wether the header should provide links to the table of contents
/// -> 
#let header(
  numbering,
  chapterNaming: false,
  links: false
) = {
  align( top + left )[
    #block( width: 100%, height: 2.5cm )[
      #place( left + horizon )[
        #context {
          set text( fill: rot )
          if chapterNaming {
            // This should hold a link to the table of contents
            // #link(<figures>)[
            //   #set text( fill: rot )
            //   #text( "Inhaltsverzeichnis" )
            //   #text( "a" )
            // ] // This shouldn't through an error when used in foreground of page
            // #text( "Inhaltsverzeichnis" )
            // #text( "a" ) 
            let headings = query( heading.where(level: 1, outlined: true) )
            let pageNumbers = headings.map( it => counter(page).at(it.location()) )
            
            if counter(page).get() not in pageNumbers {
              let currentHeading = headings.position( it => counter(page).at(it.location()) > counter(page).get())
              if currentHeading != none { currentHeading -= 1 } else { currentHeading = headings.len() - 1 }
              truncate-to-fit( headings.at(currentHeading).body.text, width: (( page.width - 5cm) * 3 / 4), suffix: "..." ) 
            }
          }
        }
      ]
      #place( right + horizon )[
        #set text( weight: "bold" )
        #stack(
          dir: rtl,
          if ( numbering == "roman" ) {
            context str( counter(page).display("I") )
          } else if ( numbering == "arabic" ) {
            context str( counter(page).get().at(0) )
          },
          h(0.5em),
          align( bottom )[
            #rect( fill: rot, width: 0.5em, height: 0.5em )
          ]
        )
      ]
    ]
  ]
}