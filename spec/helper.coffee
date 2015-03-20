
ReactScript = require "../react-script"
React = require "react"
{html: beautify} = require "js-beautify"

assert_html_structure = (actual, expected)->
	options =
		indent_with_tabs: yes
		indent_inner_html: yes
		unformatted: []
	
	actual = beautify actual, options
	expected = beautify expected, options
	if actual isnt expected
		e = new Error "HTML structure doesn't match"
		e.actual = actual
		e.expected = expected
		e.showDiff = yes
		throw e

generate = (expected_html, {from: tree})->
	generated_html = React.renderToStaticMarkup tree
	assert_html_structure generated_html, expected_html

global.generate = generate
global.React = React
global.$ = ReactScript
