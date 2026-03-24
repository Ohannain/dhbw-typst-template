/// arabicToRoman returns the roman notation of an arabic number.
///
/// - num (): the number in arabic notation that should be converted to a roman notation 
/// -> str
#let arabicToRoman(num) = {
  if num >= 1000 { return "M" + arabicToRoman(num - 1000) }
  if num >=  900 { return "CM" + arabicToRoman(num -  900) }
  if num >=  500 { return "D" + arabicToRoman(num -  500) }
  if num >=  400 { return "CD" + arabicToRoman(num -  400) }
  if num >=  100 { return "C" + arabicToRoman(num -  100) }
  if num >=   90 { return "XC" + arabicToRoman(num -   90) }
  if num >=   50 { return "L" + arabicToRoman(num -   50) }
  if num >=   40 { return "XL" + arabicToRoman(num -   40) }
  if num >=   10 { return "X" + arabicToRoman(num -   10) }
  if num >=    9 { return "IX" + arabicToRoman(num -    9) }
  if num >=    5 { return "V" + arabicToRoman(num -    5) }
  if num >=    4 { return "IV" + arabicToRoman(num -    4) }
  if num >=    1 { return "I" + arabicToRoman(num -    1) }
  return ""
}