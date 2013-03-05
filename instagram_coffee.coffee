class Instafeed
	constructor: (params) ->
		# default options
		@options =
			user_id: "USER_ID"
			access_token : "ACCESS_TOKEN"

		# if an object is passed in, override the default options
		if typeof params is "object"
			@options[option] = value for option, value of params

	_urlBuilder: ->

		baseUrl = "https://api.instagram.com/v1/users/"
		user = "v1/users/#{@options.user_id}"
		media = "/media/recent/"
		accessToken = "?access_token=#{@options.access_token}"
		count = "&count=100"
		callback = "&callback=feed._Feedy"
		
		@script = "#{baseUrl}#{user}#{media}#{accessToken}#{count}#{callback}";
		return;

	_buildScript: ->

		instaScript = document.createElement('script');
		instaScript.src = @script;
		document.getElementsByTagName('head')[0].appendChild(instaScript);
		return;

	_run: ->

		@_urlBuilder();
		@_buildScript();
		return;


feed = new Instafeed({
	user_id: "45200455",
	access_token : "45200455.7ff53ac.2deb72ff63a64b8ab7f75afb501868d8"
});

feed._run();

