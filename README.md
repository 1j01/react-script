
# ReactScript

An elegant, flexible DSL for React
for use with CoffeeScript
(and maybe other languages)

With CoffeeScript:

```coffee
# Alias it as whatever you want (maybe _ or $?)
E = ReactScript or require "react-script"

class Message extends React.Component
	render: ->
		E ".message", class: (if @props.author is you then "from-you"),
			E ".info",
				"From "
				E "span.author", @props.author
				" at "
				E "span.time", @props.time
			E "p.body",
				@props.text
				if @props.fileTransfers
					E ".transfers",
						"Sent files:"
						E "ul.files",
							for transfer in @props.fileTransfers
								E "li", E "a",
									href: transfer.downloadLink
									download: transfer.fileName
									transfer.fileName

message = E Message,
	author: "John"
	time: "5:47 PM"
	text: "Hello world!"
	fileTransfers: [
		{fileName:  "virus.exe", downloadLink: "#"}
	]

React.render message, document.body

```

By simply supporting arrays and ignoring nully values,
it works with all forms of conditionals and comprehensions.

All the functionality of [classnames](https://github.com/JedWatson/classnames)
is built in. Just provide any
class, classes, className, classNames or classList.
All those properties are treated the same and can be
a single class name,
a single string with multiple class names,
an object where the keys are the class names and the values are whether they should be present,
or an array of any of the preceeding.
Nully values are ignored, allowing for conditionals.

The whole library tries to be pretty flexible.

If you find something that doesn't work as you'd hope,
feel free to [open an issue](https://github.com/1j01/react-script/issues).


## Install

`npm i react-script --save`


## Run tests

`npm test`


## Similar Projects

* [hyperscript](https://github.com/dominictarr/hyperscript)
  (generates HTML)
* [react-hyperscript](https://github.com/mlmorg/react-hyperscript)
  (hyperscript for React)
* [virtual-hyperscript](https://github.com/Matt-Esch/virtual-dom/tree/master/virtual-hyperscript)
  (hyperscript for [virtual-dom](https://github.com/Matt-Esch/virtual-dom))
* [zorium](https://github.com/Zorium/zorium)
  (framework for virtual-dom)
* [hyper](https://github.com/xixixao/hyper)
  ("React.js wrapper for CoffeeScript", part library, part transformer)
* [coffee-react](https://github.com/jsdf/coffee-react)
  (JSX for CoffeeScript
  (plus [related projects](https://github.com/jsdf/coffee-react#related-projects)))
* [react-no-jsx](https://www.npmjs.com/package/react-no-jsx)
  (uses arrays rather than function calls; not enough CoffeeScript)

