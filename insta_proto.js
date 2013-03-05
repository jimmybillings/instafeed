var Instagram_feed;

Instagram_feed = (function() {

  function Instagram_feed(params) {
    var option, value;
      this.options = {
        user_id: 'USER_ID',
        access_token : 'ACCESS_TOKEN',
        target: 'instafeed',
        get: 'popular',
        resolution: 'thumbnail',
        sortBy: 'most-recent',
        links: true,
        limit: 15,
        mock: false
      };
      if (typeof params === 'object') {
        for (option in params) {
          value = params[option];
          this.options[option] = value;
        }
      }
  }

  Instagram_feed.prototype._buildUrl = function() {
    var feed_url;
    return feed_url = "https://api.instagram.com/v1/users/"+this.options.user_id+"/media/recent/?access_token="+this.options.access_token+"&count=100&callback=feed._Feedy";
  };

  Instagram_feed.prototype._buildScript = function (url){
	// Create script tag
	var scriptTag = document.createElement('script');

	scriptTag.src = url;

	// Inject script tag into the head of the web document
	document.getElementsByTagName('head')[0].appendChild(scriptTag);
  }

  Instagram_feed.prototype._Run = function() {
    var url = this._buildUrl();
     this._buildScript(url);
    
  }

  Instagram_feed.prototype._Feedy = function(results) {
    for (var i = 0; i < results.data.length; i++) {
            
          //size = results.data[i].images.thumbnail.url;
          //size = results.data[i].images.low_resolution.url;
          //image = "<a target='_blank' href='" + results.data[i].link + "'><img src='" + size + "'></img></a>";
          //size = results.data[i].images.standard_resolution.url;
          var a = document.createElement('a');
          a.href = results.data[i].images.standard_resolution.url;

          //results.data[i].link;
          var img = document.createElement("img");
          img.src = results.data[i].images.low_resolution.url;
          a.appendChild(img);
          document.getElementsByTagName('body')[0].appendChild(a);
        }
  }

  return Instagram_feed;

})();


var feed = new Instagram_feed({
	user_id :'45200455',
	access_token : '45200455.7ff53ac.2deb72ff63a64b8ab7f75afb501868d8'
});

feed._Run();

$(function() {
  $('body').on('click', 'a', function(e) {
    e.preventDefault();
    
    var img = document.createElement("img");
    img.src = this.href;
    var div = document.createElement("div");
    div.appendChild(img);
    document.getElementsByTagName('body')[0].appendChild(div);
  });
});