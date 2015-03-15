
# ReactScript

An elegant DSL for React
for use with CoffeeScript
(and other languages)

With CoffeeScript:

```coffee
# Alias it as whatever you want (maybe _ or $? )
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

Feel free.


## Install

`npm i react-script --save`

## Other Projects

Compare/contrast with
* [hyperscript](https://github.com/mlmorg/react-hyperscript)
* [hyper](https://github.com/xixixao/hyper)
* [coffee-react](https://github.com/jsdf/coffee-react), CoffeeScript JSX
