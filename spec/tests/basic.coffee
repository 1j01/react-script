
error_please = (fn)->
	try
		do fn
	catch
		return
	throw new Error "Function didn't throw an error"

describe "ReactScript", ->
	
	it "should create elements from CSS selectors", ->
		generate '
			<html>
				<head>
					<title>Hello World!</title>
				</head>
				<body>
					<h1 class="shiny">Hello World!</h1>
				</body>
			</html>
		', from:
			E "html",
				E "head", E "title", "Hello World!"
				E "body", E "h1.shiny", "Hello World!"
	
	it "should default to creating <div> elements", ->
		generate '
			<div class="test">
				<div>
					<div></div>
				</div>
			</div>
		', from:
			E ".test", E "", E()
	
	it "should fail loudly when it can't parse a selector", ->
		error_please ->
			E "um)#(E%"
	
	it "should handle boolean attributes", ->
		data_falsey = no
		data_truthy = yes
		generate '<div data-truthy="true"></div>',
			from: E "div", {data_falsey, data_truthy}
	
	it "should handle null as well as undefined", ->
		data_falsey = null
		data_truthy = "true-dat"
		generate '<div data-truthy="true-dat"></div>',
			from: E "div", {data_falsey, data_truthy}
		generate '<div>true-dat</div>',
			from: E "div", data_falsey, data_truthy
	
	it "should transform variations to data-*", ->
		generate '<div data-foo="bar" data-baz="quux" data-norf="777"></div>',
			from: E "div", data_foo: "bar", dataBaz: "quux", data: norf: 777
	
	it "should create elements from components", ->
		class Foo extends React.Component
			render: -> E ".foo", @props.message
		
		generate '<div class="foo">Hello World!</div>',
			from: E Foo, message: "Hello World!"
	
	it.skip "should support components that wrap children (without props)", ->
		class Window extends React.Component
			render: -> E ".window", @props.children
		class Header extends React.Component
			render: -> E ".header", @props.children
		
		generate '''
			<div class="window">
				<div class="header">
					<h1>Hello World!</h1>
				</div>
				<div class="window-content">
					<p>Hello World!</p>
				</div>
			</div>
			''',
			from:
				E Window, # {},
					E Header, # {},
						E "h1", "Hello World!"
					E ".window-content",
						E "p", "Hello World!"
	
	it "should let you function", ->
		e = E "input", onChange: -> "ok"
		e.props.onChange()
	
	it.skip "ought to support selector attributes", ->
		generate '<input type="number" min="5" max="10" autofocus>',
			from: E "input[type=number][min=5][max=10][autofocus]"
	
	it "could support using the child > selector"
	it "would tell you to use > if you try to use the descendent selector"
	
	it "should not give react warnings in normal usage"
	it "should give react warnings if you're missing a key"
