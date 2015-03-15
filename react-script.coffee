
E = (args...)->
	
	add = (from, {to})->
		if from instanceof Array
			add thing, {to} for thing in from
		else if from?
			to.push from
	
	hyphenate = (v)->
		"#{v}"
			.replace /_/g, "-"
			.replace /([a-z])([A-Z])/g, (m, az, AZ)->
				"#{az}-#{AZ.toLowerCase()}"
	
	createElement = (elementType, {attrArgs, childArgs, selAttrs, selector})->
		finalAttrs = {}
		classNames = []
		
		addAttr = (ak, av)->
			# Why doesn't React handle boolean attributes?
			finalAttrs[ak] = av unless av is false
		
		for ak, av of attrArgs
			if ak in ["class", "className"]
				add (hyphenate av), to: classNames
			else if ak is "data"
				addAttr "data-#{hyphenate dk}", dv for dk, dv of av
			else
				addAttr ak, av
		
		if selAttrs
			unhandled = selAttrs
				.replace /\.([a-z][a-z0-9\-_]*)/gi, (m, className)->
					classNames.push className
					""
				.replace /#([a-z][a-z0-9\-_]*)/gi, (m, id)->
					finalAttrs.id = id
					""
		
		if unhandled
			throw new Error "Unhandled selector fragment '#{unhandled}' in selector: '#{selector}'"
		
		finalAttrs.className = classNames.join " " if classNames.length
		
		finalChildren = []
		add childArgs, to: finalChildren
		
		React.createElement elementType, finalAttrs, finalChildren
	
	switch typeof args[0]
		when "function"
			[elementClass, attrArgs, childArgs...] = args
			createElement elementClass, {attrArgs, childArgs}
		when "string"
			if typeof args[1] is "object" and not args[1].length and not args[1]._isReactElement
				[selector, attrArgs, childArgs...] = args
			else
				[selector, childArgs...] = args
				attrArgs = {}
			
			tagName = "div"
			selAttrs = selector.replace /^[a-z][a-z0-9\-_]*/i, (match)->
				tagName = match
				""
			
			createElement tagName, {attrArgs, childArgs, selAttrs, selector}
		else
			throw new Error "Invalid first argument to ReactScript: #{args[0]}"

if module?.exports?
	module.exports = E
else
	@ReactScript = E