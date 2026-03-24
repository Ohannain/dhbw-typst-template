// Fork with proposed changes
// MIT License

// Copyright (c) 2024 Jonathan Halmen

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "abbr-impl.typ": (
	a, pla, asf,
	s, pls,
	l, pll, lsf,
	lo, pllo,
	getAbbr,
	list,
	load, load-alt,
	config,
	add, add-alt,
	make,
)

/// reference show rule for QoL improved usage
#let show-rule(body) = {
	import "abbr-impl.typ": abbr
	import "abbr.typ" as exported
	let specs = dictionary(exported)
	for r in ("list", "load", "load-alt", "config", "add", "add-alt", "make", "show-rule") {
		let _ = specs.remove(r)
	}
	show ref: it => context {
		let abbreviations = abbr.final()
		let (key, ..spec) = str(it.target).split(":")
		if key in abbreviations {
			if spec.len() != 0 {
				let func = spec.first()
				if func not in specs {
					panic("unknown specifier ':"+func+"' used on abbreviation ["+key+"]")
				}
				specs.at(func)(key)
			} else {
				(specs.a)(key)
			}
		} else {it}
	}
	body
}
