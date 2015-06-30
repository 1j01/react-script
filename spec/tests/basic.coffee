
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
		error_please /Unhandled/, ->
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
	
	it "should let you function", ->
		e = E "input", onChange: -> "ok"
		e.props.onChange()
	
	it.skip "ought to support selector attributes", ->
		generate '<input type="number" min="5" max="10" autofocus>',
			from: E "input[type=number][min=5][max=10][autofocus]"
	
	it.skip "could support using the child > selector", ->
		generate '<li><a href="http"></a></li>',
			from: E "li > a", href: "http"
		generate '<table><tbody><tr><td><div>Tables are annoying</div></td></tr></tbody></table>',
			from: E "table > tbody > tr > td > div", "Tables are annoying"
	
	it.skip "would tell you to use > if you try to use the descendent selector", ->
		error_please /descendent/, ->
			E ".inexplicit .arbitrary .undefined"
	
	it "should not give react warnings in normal usage"
	it "should give react warnings if you're missing a key"
