#import "../ressources/repository/states.typ": templateConfig

/// locale provides the correct translation for a given key
///
/// - key (): the key for which the translation should be provided
/// -> str
#let locale(key) = {
  let locales = yaml(
    "../ressources/constants/localization/"
    + templateConfig.get().language
    + ".yml"
  )
  
  return locales.at(key)
}