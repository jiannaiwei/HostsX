function FindProxyForURL(url, host){

var port_1="DIRECT; PROXY 127.0.0.1:1998"; //想换代理在这里改端口，不用重启的

var port_2="PROXY 127.0.0.1:1998";

var patterns = new Array(
//墙与未墙之间
"wikibooks.org",
"wikileaks.info",
"wikileaks.org",
"wikimedia.org",
"wikipedia.org",
"wikisource.org",
"yahoo.com",
"www.google.com",
"www.google.com.hk",
"webcache.googleusercontent.com"
);

var patterns2 = new Array(
//明确的穿，待瘦身

"facebook.com",
"fbcdn.net",
"akamaihd.net",
"174.37.164.71/image/",
"70.38.64.248/image/",
"aol.com",
"appspot.com",
"archive.org",
"google.co.jp",
"thepiratebay.se",
"atnext.com",
"chinagfw.org",
"is.gd",
"bbc.co.uk",
"bit.ly",
"blip.tv",
"blog.sina.com.tw",
"blogger.com",
"blogspot.com",
"box.net",
"chinadigitaltimes.net",
"chinesepen.org",
"clients1.google.com/complete/search",
"cnd.org",
"cnn.com",
"www.rfa.org",
"rsf-chinese.org",
"cuhkacs.org",
"dailymotion.com",
"discuss.com.hk",
"downforeveryoneorjustme.com",
"dropbox.com",
"dwnews.com",
"eyny.com",
"fc2.com",
"feedburner.com",
"ff.im",
"flickr.com",
"foursquare.com",
"friendfeed.com",
"ftchinese.com",
"gamer.com.tw",
"ggpht.com",
"goo.gl",
"googleusercontent.com",
"gov.tw",
"groups.google.com",
"gutenberg.org",
"hellotxt.com",
"hotlinkimage.com/showimg.php",
"hrw.org",
"i1.hk",
"imageporter.com",
"imageshack.us",
"imagevenue.com",
"imdb.com",
"img.ly",
"iphone-dev.org",
"j.mp",
"jaiku.com",
"kenengba.com",
"komica.org",
"libertytimes.com.tw",
"mashable.com",
"mediafire.com",
"megavideo.com",
"multiupload.com",
"myspace.com",
"nicovideo.jp",
"open.com.hk",
"ow.ly",
"panoramio.com",
"picasaweb.google.com",
"pixnet.net",
"plurk.com",
"plus.google.com",
"rcinet.ca",
"reuters.com",
"roodo.com",
"rsf.org",
"rthk.hk",
"rti.org.tw",
"sharebee.com",
"sites.google.com",
"skype.com",
"t.co",
"technorati.com",
"thepiratebay.org",
"tinypic.com",
"tumblr.com",
"twimg.com",
"twitpic.com",
"twitter.com",
"twitter.jp",
"udn.com",
"uwants.com",
"video.google.com",
"vimeo.com",
"voanews.com",
"websitepulse.com",
"wenxuecity.com",
"wordpress.com",
"wordpress.org",
"worldjournal.com",
"wormsculptor.com",
"wp.com",
"wp.me",
"wpoforum.com",
"wretch.cc",
"wsj.com",
"xuite.net",
"yam.com",
"yamedia.tw",
"yimg.com",
"youtu.be",
"youtube.com",
"yzzk.com",
"zaobao.com",
"zdnet.com.tw",
"ziddu.com",
"ytimg.com"


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
"*atm.youku.com*",
"*hz.youku.com*",
"*nc.youku.com*",
"*stat.youku.com*",
"*doubleclick*",
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
	if(shExpMatch(url.toLowerCase(),"*" + adblocklist[k].toLowerCase() + "*")){return Blackhole;};
	};

	{return port_1;};
};
