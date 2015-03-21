
describe "ReactScript", ->
	
	it "should let you specify multiple classes", ->
		generate '<div class="classy classington"></div>',
			from: $ ".classy.classington"
	
	it "should let you specify classes like attributes", ->
		generate '<div class="class-name class classy classington"></div>',
			from: $ ".classy.classington",
				className: "class-name"
				class: "class"
	
	it "should handle lists of classes", ->
		generate '<div class="foo bar baz qux fubar"></div>',
			from: $ ".fubar",
				className: "foo bar"
				class: ["baz", "qux"]
	
	it "could support plural classes/classNames", ->
		generate '<div class="food barf foo bar baz qux fubar"></div>',
			from: $ ".fubar",
				className: "food"
				class: "barf"
				classNames: ["foo", "bar"]
				classes: ["baz", "qux"]
	
	context "should support conditional classes", ->
		foo = yes
		bar = no
		it "should ignore void values", ->
			generate '<b></b>',
				from: $ "b", class: ("bar" if bar)
			generate '<b class="foo"></b>',
				from: $ "b", class: ["foo" if foo, "bar" if bar]
		it "should support object syntax", ->
			generate '<b class="bar"></b>',
				from: $ "b", class: {foo: no, bar: yes}
			generate '<b class="foo"></b>',
				from: $ "b", class: {foo, bar}
