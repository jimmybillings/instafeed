class instagram_feed
	
	constructor:(params) ->
		@options = 
			user_id: 'USER_ID'
			access_token : 'ACCESS_TOKEN'
			target: 'instafeed' 
			get: 'popular'
			resolution: 'thumbnail'
			sortBy: 'most-recent'
			links: true
			limit: 15
			mock: false 

	if typeof params is 'object'
		@options = value for option, value of params



pics = new instagram_feed({
	user_id: 'jimmybillings',
	access_token: '1234',
	get: 'hello'
});

console.log(pics.options);

	