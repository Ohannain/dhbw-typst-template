#import "@preview/stylized-dhbw:1.0.0": *

#show: stylized-dhbw.with(
  type: "Projektarbeit",
  title: "A modern, simplistic and stylized template for use at DHBW",
  authors: (
    (
      name: "Harry Potter",
      id: 3171980,
      orcid: "https://orcid.org/xxxx-xxxx-xxxx-xxxx",
      signedAt: "Little Whinging",
      signedOn: "",
      signature: image("store/images/signature"),
      signatureDx: 2.5cm,
      signatureDy: -0.3cm,
      signatureWidth: 4cm
    ),
  ),
  keywords: ( "Typst", "Template", "DHBW", ),
  course: "TINF23B3",
  degree: "B. Sc. Informatik",
  supervisor: (dhbw: "Professor Dumbledore", corporate: "Ollivander"),
  location: "Hogwarts",
  submissionDate: datetime(year: 1981, month: 10, day: 31),
  language: "de",
  frontmatter: ( "authorship", "contents", "abbreviations", "figures", "tables", "codeblocks" ),
  backmatter: ( "sources", ), // arrays of length 1 require a comma after the value
  abstractContent: ( [], [] ),
  preambleContent: [],
  sourcesPath: "../../store/sources/sources.yml",
  abbrPath: "../store/abbreviations/abbreviations.yml"
  // for further information refer to the templates README
)

// Include your own content below

#include "chapters/01.typ"
#include "chapters/02.typ"