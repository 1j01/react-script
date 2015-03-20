
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
				<div></div>
			</div>
		', from:
			$ ".test", $ ""
	
	it.skip "should fail loudly", ->
		(->
			$ "um)#($%"
		).should.throw Error
	
	it.skip "should handle boolean attributes", ->
		falsey = no
		truthy = yes
		generate '<div truthy>',
			from:
				$ "div", {falsey, truthy, data_foo: "bar", style: width: "5px"}
	
	it "should create elements from components", ->
		class Foo extends React.Component
			render: -> $ ".foo", @props.message
		
		generate '<div class="foo">Hello World!</div>',
			from:
				$ Foo, message: "Hello World!"
	
	it.skip "ought to support selector attributes", ->
			generate '<input type="number" min="5" max="10" disabled>',
				from: $ "input[type=number][min=5][max=10][disabled]"
	
	it "could support using the child > selector"
	it "would tell you to use > if you try to use the descendent selector"
