
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
			$ "html",
				$ "head", $ "title", "Hello World!"
				$ "body", $ "h1.shiny", "Hello World!"
	
	it "should default to creating <div> elements", ->
		generate '
			<div class="test">
				<div>
					<div></div>
				</div>
			</div>
		', from:
			$ ".test", $ "", $()
	
	it "should fail loudly", ->
		try
			$ "um)#($%"
		catch
			return
		throw new Error "Why no error??"
	
	it "should handle boolean attributes", ->
		data_falsey = no
		data_truthy = yes
		generate '<div data-truthy="true"></div>',
			from: $ "div", {data_falsey, data_truthy}
	
	it "should transform variations to data-*", ->
		generate '<div data-foo="bar" data-baz="quux" data-norf="777"></div>',
			from: $ "div", data_foo: "bar", dataBaz: "quux", data: norf: 777
	
	it "should create elements from components", ->
		class Foo extends React.Component
			render: -> $ ".foo", @props.message
		
		generate '<div class="foo">Hello World!</div>',
			from:
				$ Foo, message: "Hello World!"
	
	it.skip "ought to support selector attributes", ->
			generate '<input type="number" min="5" max="10" autofocus>',
				from: $ "input[type=number][min=5][max=10][autofocus]"
	
	it "could support using the child > selector"
	it "would tell you to use > if you try to use the descendent selector"
