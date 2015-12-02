
React = @React ? require "react"

is_plainish_object = (o)->
	o? and typeof o is "object" and not (
		o instanceof Array or # (e.g. [])
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

E = (elementType, args...)->
	
	elementType ?= ""
	
	if is_plainish_object args[0]
		[attrArgs, childArgs...] = args
	else
		[childArgs...] = args
		attrArgs = null
	
	switch typeof elementType
		when "string"
			selector = elementType
			elementType = "div"
			selAttrs = selector.replace /^[a-z][a-z0-9\-_]*/i, (match)->
				elementType = match
				""
			
			finalAttrs = {}
			classNames = []
			
			addAttr = (attr_k, attr_v, aria)->
				# Why doesn't React handle boolean attributes?
				# @TODO: warn if attribute already added
				finalAttrs[attr_k] = attr_v unless attr_v is false and not aria
			
			for attr_k, attr_v of attrArgs
				if attr_k in ["class", "className", "classes", "classNames", "classList"]
					add attr_v, to: classNames
				else if attr_k is "data"
					for data_k, data_v of attr_v
						addAttr "data-#{hyphenate data_k}", data_v
				else if attr_k is "aria"
					for aria_k, aria_v of attr_v
						addAttr "aria-#{hyphenate aria_k}", aria_v, yes
				else if attr_k.match /^data/
					addAttr (hyphenate attr_k), attr_v
				else if attr_k.match /^aria/
					addAttr (hyphenate attr_k), attr_v, yes
				else
					addAttr attr_k, attr_v
			
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
			
		when "function"
			finalAttrs = attrArgs
		else
			throw new Error "Invalid first argument to ReactScript: #{elementType}"
	
	finalChildren = []
	add childArgs, to: finalChildren
	
	React.createElement elementType, finalAttrs, finalChildren


if module?.exports?
	module.exports = E
else
	@ReactScript = E
