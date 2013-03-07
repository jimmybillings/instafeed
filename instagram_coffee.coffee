class Instafeed
	constructor: (params) ->
		
		@options =
			user_id: "USER_ID"
			access_token : "ACCESS_TOKEN"

		if typeof params is "object"
			@options[option] = value for option, value of params

	_urlBuilder: ->
		baseUrl = "https://api.instagram.com/"
		user = "v1/users/#{@options.user_id}"
		media = "/media/recent/"
		accessToken = "?access_token=#{@options.access_token}"
		count = "&count=50"
		callback = "&callback=feed._feed"
		
		@script = "#{baseUrl}#{user}#{media}#{accessToken}#{count}#{callback}";
		return;

	_buildScript: ->
		instaScript = document.createElement('script');
		instaScript.src = @script;
		document.getElementsByTagName('head')[0].appendChild(instaScript);
		return;

	_feed: (response) ->
  	if typeof response isnt 'object'
      if @options.error? and typeof @options.error is 'function'
        @options.error.call(this, 'Invalid JSON data')
        return false
      else
        throw new Error 'Invalid JSON response'

    if response.meta.code isnt 200
      if @options.error? and typeof @options.error is 'function'
        @options.error.call(this, response.meta.error_message)
        return false
      else
        throw new Error "Error from Instagram: #{response.meta.error_message}"

    if response.data.length is 0
      if @options.error? and typeof @options.error is 'function'
        @options.error.call(this, 'No images were returned from Instagram')
        return false
      else
        throw new Error 'No images were returned from Instagram'
  	for result in response.data
	    a = document.createElement 'a'
	    a.href = result.images.standard_resolution.url

	    img = document.createElement 'img'
	    img.src = result.images.low_resolution.url

	    a.appendChild img
	    document.body.appendChild a

	_run: ->
		if typeof @options.user_id isnt 'string'
			 throw new Error('your need to enter a user id')
		else if typeof @options.access_token isnt 'string'
			throw new Error('your need to enter a access token')
		else
			@_urlBuilder();
			@_buildScript();
		return;

root = exports ? window
root.Instafeed = Instafeed




