# Stylized DHBW
A modern, simplistic and stylized [Typst](https://typst.app) template for use at DHBW. This is NOT an official template. For an official template refer to [Clean DHBW](https://typst.app/universe/package/clean-dhbw) by Roland Schätzle.

# Usage

In the **Typst web app** click on "Start from template" on the dashboard and search for `stylized-dhbw`.

For **local development** you can use the following command to get yourself started: `typst init @preview/stylized-dhbw <directory>`. 

## Fonts

This template utilizes the following fonts:

- Inclusive Sans ([Official Homepage](https://www.oliviaking.com/inclusivesans/feature) / [GitHub](https://github.com/LivKing/Inclusive-Sans) / [Google Fonts](https://fonts.google.com/specimen/Inclusive+Sans) / [Adobe Fonts](https://fonts.adobe.com/fonts/inclusive-sans))
- JetBrains Mono ([Official Homepage](https://www.jetbrains.com/mono) / [GitHub](https://github.com/jetbrains/jetbrainsmono) / [Google Fonts](https://fonts.google.com/specimen/JetBrains+Mono))

For local use of the template, you will need to download and install the required fonts to your machine. 

Instructions on installing fonts on:
- [Windows](https://support.microsoft.com/office/add-a-font-b7c5f17c-4426-4b53-967f-455339c564c1)
- [macOS](https://support.apple.com/guide/font-book/fntbk1000/mac)
- [Linux](https://wiki.archlinux.org/title/Fonts) (or refer to your respective package manager)

## Configuration

`type (string)`:\
The type of the document.

```typ
type = "Projektarbeit" | "Studienarbeit" | "Bachelorarbeit" | "Masterarbeit"
```

`title (string)`:\
The title of the document.

`authors (array)`:\
A list of authors.

```typ
author = (
  name: string,
  id: number,
  orcid: string,
  signedAt: string,
  signedOn: datetime(),
  signature: image(),
  signatureDx: length,
  signatureDy: length,
  signatureWidth: length
)
```

`keywords (array)`:\
A list of keywords to be printed alongside the abstract(s).

`course (string)`:\
The course of the students.

`degree (string)`:\
The degree of the students.

`supervisor (dictionary)`:\
The names of the supervisors at the DHBW and the partner company.

```typ
supervisor = ( dhbw: string, corporate: string )
```

`location (string)`:\
The location of the DHBW.

`submissionDate (datetime)`:\
The date of submission provided as a [datetime](https://typst.app/docs/reference/foundations/datetime/) object

`language (string)`:\
The main language a paper is written in.

```typ
language = "de" | "en"
```

`frontmatter (array)`:\
A list of formal pages that should be included inside the frontmatter. The pages are printed in insertion order, except for the authorship and confidentiality sections, which are printed on the same page.

```typ
frontmatter = "abbreviations" | "abstract" | "authorship" | "codeblocks" | "confidentiality" | "contents" | "figures" | "preamble" | "sources" | "tables"
```


`backmatter (array)`:\
A list of formal pages that should be included inside the backmatter. The pages are printed in insertion order, except for the authorship and confidentiality sections, which are printed on the same page.

```typ
frontmatter = "abbreviations" | "abstract" | "authorship" | "codeblocks" | "confidentiality" | "contents" | "figures" | "preamble" | "sources" | "tables"
```

`abstractContent (array)`:\
The contents that should be printed inside the abstract section.

`preambleContent (content)`:\
The content that should be printed inside the preamble section.

`sourcesPath`:\
The path to a file containing sources used. Can either be a Hayagriva file or a legacy BibTeX file.

`abbrPath`:\
The path to a file containing a list of abbreviations. Can either be .yml, .json or .csv (Refer to [abbr](https://typst.app/universe/package/abbr) for further information on the file format)

# Questions? Suggestions? Issues?

If you need help or want to contribute refer to my [GitHub Repository](https://github.com/Ohannain/stylized-dhbw). As I am also just a student at the DHBW Karlsruhe in my now third year, I might not be able to respond quickly or attend to issues as frequently. For pressing issues, consider the contact information laid out on my GitHub profile page.

For information on contributing to projects on GitHub you can find official information here: [Contributing to a project](https://docs.github.com/get-started/exploring-projects-on-github/contributing-to-a-project). Also consider following common git conventions: [Git Commit Guidelines](https://ec.europa.eu/component-library/v1.14.2/ec/docs/conventions/git/)

For general questions about Typst or the Typst web app, please refer to the [Typst Documentation](https://typst.app/docs), the [Typst Book](https://sitandr.github.io/typst-examples-book/book/about.html) or use the [Typst Forum](https://forum.typst.app).

# Attribution

Without these packages this template wouldn't be what it is

- [abbr](https://typst.app/universe/package/abbr)
- [zebraw](https://typst.app/universe/package/zebraw)
- [datify](https://typst.app/universe/package/datify)

