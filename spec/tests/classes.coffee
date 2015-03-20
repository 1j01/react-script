
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
	
	it "could handle plural classes/classNames"
	
	context "should support conditional classes", ->
		foo = yes
		bar = no
		it.skip "should ignore void values", ->
			eg. $ "b", class: ("foobar" if condition)
			eg. $ "b", class: ["foo" if foo, "bar" if bar]
		it.skip "should support object syntax", ->
			eg. $ "b", class: {foo: yes, bar: no}
			eg. $ "b", class: {foo, bar}
