
React = @React ? require "react"

E = (args...)->
	
	is_plainish_object = (o)->
		o? and typeof o is "object" and not (
			o.length? or # (e.g. [])
			React.isValidElement o # (e.g. E())
		)
	
	add = (from, {to})->
		if from instanceof Array
			add thing, {to} for thing in from
		else if is_plainish_object from
			for k, v of from when v
				to.push hyphenate k
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
			if ak in ["class", "className", "classes", "classNames", "classList"]
				add av, to: classNames
			else if ak is "data"
				addAttr "data-#{hyphenate dk}", dv for dk, dv of av
			else if ak.match /^data|aria/
				addAttr (hyphenate ak), av
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
	
	args[0] ?= ""
	
	switch typeof args[0]
		when "function"
			if is_plainish_object args[1]
				[elementClass, attrArgs, childArgs...] = args
			else
				[elementClass, childArgs...] = args
				attrArgs = null
			
			createElement elementClass, {attrArgs, childArgs}
		when "string"
			if is_plainish_object args[1]
				[selector, attrArgs, childArgs...] = args
			else
				[selector, childArgs...] = args
				attrArgs = null
			
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
