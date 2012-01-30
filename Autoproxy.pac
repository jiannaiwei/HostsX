function FindProxyForURL(url, host){

var port_1="PROXY 127.0.0.1:8087"; //想换代理在这里改端口，不用重启的

var port_2="PROXY 127.0.0.1:8000;DIRECT";

var patterns = new Array(
//下面可以添加你需要用代理的网站地址

"t.co",
"tinypic.com",
"twimg.com",
"twitpic.com",
"twitter.com",
"twitter.jp",
"facebook.com",
"fbcdn.net",
"ff.im",
"plurk.com",
"archive.org",
"dwnews.com",
"atnext.com",
"bit.ly",
"chinadigitaltimes.net",
"chinesepen.org",
"cnd.org",
"cuhkacs.org",
"dailymotion.com",
"discuss.com.hk",
"eyny.com",
"flickr.com",
"friendfeed.com",
"ftchinese.com",
"gamer.com.tw",
"gutenberg.org",
"hrw.org",
"i1.hk",
"imdb.com",
"jaiku.com",
"kenengba.com",
"komica.org",
"libertytimes.com.tw",
"mashable.com",
"myspace.com",
"nicovideo.jp",
"open.com.hk",
"panoramio.com",
"rcinet.ca",
"reuters.com",
"roodo.com",
"rsf.org",
"rthk.hk",
"rti.org.tw",
"technorati.com",
"thepiratebay.org",
"udn.com",
"uwants.com",
"vimeo.com",
"voanews.com",
"wenxuecity.com",
"wikia.com",
"wikileaks.info",
"wikileaks.org",
"worldjournal.com",
"wsj.com",
"yzzk.com",
"174.37.164.71/image/",
"70.38.64.248/image/",
"aol.com",
"bbc.co.uk",
"blip.tv",
"box.net",
"cnn.com",
"downforeveryoneorjustme.com",
"dropbox.com",
"foursquare.com",
"hellotxt.com",
"hotlinkimage.com/showimg.php",
"imageporter.com",
"imageshack.us",
"imagevenue.com",
"img.ly",
"iphone-dev.org",
"j.mp",
"mediafire.com",
"megavideo.com",
"multiupload.com",
"ow.ly",
"sharebee.com",
"tumblr.com",
"zaobao.com",
"ziddu.com",
"yahoo.com",
"yimg.com",
"wretch.cc",
"yahoo.com.tw",
"yahoo.co.jp",
"yahoo.com.hk",
"zdnet.com.tw",
"fc2.com",
"blog.sina.com.tw",
"yam.com",
"yamedia.tw",
"xuite.net",
"pixnet.net",
"gov.tw",
"wordpress.com",
"wordpress.org",
"wormsculptor.com",
"wp.com",
"wp.me",
"wpoforum.com",
"websitepulse.com",
"wikibooks.org",
"wikimedia.org",
"wikipedia.org",
"wikisource.org",
"appspot.com",
"blogger.com",
"blogspot.com",
"clients1.google.com/complete/search",
"feedburner.com",
"ggpht.com",
"googleusercontent.com",
"groups.google.com",
"picasaweb.google.com",
"plus.google.com",
"sites.google.com",
"video.google.com",
"webcache.googleusercontent.com",
"www.google.com.hk",
"www.google.com",
"youtu.be",
"youtube.com",
"ytimg.com"

);

var patterns2 = new Array(
//下面可以添加上面代理不管的网站地址



);

var Blackhole="PROXY 255.255.255.0:3421";//屏蔽广告，代理黑洞设置

if (typeof(navigator) != 'undefined'
	&& navigator.appVersion.indexOf("Mac") != -1) {
    Blackhole = "PROXY 0.0.0.0:3421";}

var adblocklist = new Array(

".ad.",
".ad?.",
"/ad.",
".ad-",
"/ad?.",
"/ad/",
"/ads",
"/gg/",
"/gg.",
"/gg?.",
".gg?.",
".gg.",
"778669.",
"1133.cc",
"114.",
"adpic.",
"/cpro/",
"_ad_"
);

//正则表达式规则
//if(/[/]([^/]*?)(advert|adverts?|adimage|adinfo|adframe|adserver|admentor|adview|banner|bannerimg|popup|popunder|alimama|popad)(s)?[_.\/]/i.test(url)) return Blackhole;

for (i in patterns) {
	if(shExpMatch(url.toLowerCase(),"*" + patterns[i].toLowerCase() + "*")){return port_1;};
	};

for (j in patterns2) {
	if(shExpMatch(url.toLowerCase(),"*" + patterns2[j].toLowerCase() + "*")){return port_2;};
	};

for (k in adblocklist) {
//	if(shExpMatch(url.toLowerCase(),"*" + adblocklist[k].toLowerCase() + "*")){return Blackhole;};
	};

	return "DIRECT";
};
