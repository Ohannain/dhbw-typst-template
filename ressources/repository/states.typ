/// stores the config information of the template
#let templateConfig = state("templateConfig", (:))
/// stores the levels of headings
#let headingsCounter = counter("headings")
/// determines, whether headings are numbered or not
#let doNumbering = state("doNumbering", false)
/// caches the last set page number for later use
#let pageNumberCache = state("pageNumberCache", 1)