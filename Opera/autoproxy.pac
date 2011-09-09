function FindProxyForURL(url, host)
{
url = url.toLowerCase();
host = host.toLowerCase();
//代理列表,可以自己添加

proxy="PROXY 127.0.0.1:8080";
  Tor="PROXY127.0.0.1:8118";
  FG="PROXY 127.0.0.1:8580";
  ipv6="ipv6.google.com:80";
  blackhole="PROXY 0.0.0.0:0000"

//正则过滤广告
if(/[/]([^/]*?)(advert|adimage|adframe|adserv|admentor|adview|banner|popup|popunder|adimage|adinfo|bannerimg|guangg|qianming|duilian|alimama|popad|media\/subtract)(s)?[_.\/]/i.test(url)) return blackhole;
if(shExpMatch(url, "*.ad.*")) return blackhole;

//使用代理的网站，前面为网站，后面为使用的代理，可以使用通配符
if(shExpMatch(host, "*.mediafire.com*")) return proxy;
if(shExpMatch(host, "*de-world.de*")) return FG;
if(shExpMatch(host, "*mousearound.info*")) return proxy;
if(shExpMatch(url, '*.3dtin.com/*') return proxy;
if(shExpMatch(url, '*.bbc.co.uk/*') return proxy;
if(shExpMatch(url, '*.blip.tv/*')  return proxy;
if(shExpMatch(url, '*.blogblog.com/*') return proxy;
if(shExpMatch(url, '*.chinagfw.org/*') return proxy;
if(shExpMatch(url, '*.chinese.rfi.fr/*') return proxy;
if(shExpMatch(url, '*.downforeveryoneorjustme.com/*') return proxy;
if(shExpMatch(url, '*.dropbox.com/*') return proxy;
if(shExpMatch(url, '*.fc2.com*') return proxy;
if(shExpMatch(url, '*.foursquare.com/*') return proxy;
if(shExpMatch(url, '*.hecaitou.net/*') return proxy;
if(shExpMatch(url, '*.hellotxt.com/*') return proxy;
if(shExpMatch(url, '*.hkepc.com/*') return proxy;
if(shExpMatch(url, '*.imageporter.com/*') return proxy;
if(shExpMatch(url, '*.imageshack.us/*') return proxy;
if(shExpMatch(url, '*.imagevenue.com/*') return proxy;
if(shExpMatch(url, '*.izaobao.us/*') return proxy;
if(shExpMatch(url, '*.jedi.ord/*') return proxy;
if(shExpMatch(url, '*.kenengba.com/*') return proxy;
if(shExpMatch(url, '*.linkedin.com/*') return 'DIRECT';
if(shExpMatch(url, '*.megavideo.com/*') return proxy;
if(shExpMatch(url, '*.middle-way.net/*') return proxy;
if(shExpMatch(url, '*.mingpao.com/*') return proxy;
if(shExpMatch(url, '*.mirrorbooks.com/*') return proxy;
if(shExpMatch(url, '*.mousearound.info/*') return proxy;
if(shExpMatch(url, '*.multiupload.com/*')  return proxy;
if(shExpMatch(url, '*.paperb.us/*') return proxy;
if(shExpMatch(url, '*.peacehall.com/*')  return proxy;
if(shExpMatch(url, '*.rss.slashdot.com/*') return proxy;
if(shExpMatch(url, '*.searchpreview.de/*') return proxy;
if(shExpMatch(url, '*.sharebee.com/*') return proxy;
if(shExpMatch(url, '*.tinypic.com/*') return proxy;
if(shExpMatch(url, '*.tumblr.com/*') return proxy;
if(shExpMatch(url, '*.verybs.com/*') return proxy;
if(shExpMatch(url, '*.vimeo.com/*') return proxy;
if(shExpMatch(url, '*.websitepulse.com/*') return proxy;
if(shExpMatch(url, '*.wikimedia.org/*') return proxy;
if(shExpMatch(url, '*.wikipedia.org/*') return proxy;
if(shExpMatch(url, '*.wordpress.com*') return proxy;
if(shExpMatch(url, '*.wp.com*') return proxy;
if(shExpMatch(url, '*.wretch.cc/*') return proxy;
if(shExpMatch(url, '*.yamedia.tw/*') return proxy;
if(shExpMatch(url, '*.yfrog.com/*') return proxy;
if(shExpMatch(url, '*.ytimg.com/*') return proxy;
if(shExpMatch(url, '*.zuola.com/*') return proxy;
if(shExpMatch(url, '*://blogtd.org/*')) return proxy;
if(shExpMatch(url, '*://epochtimes.com/*')) return proxy;
if(shExpMatch(url, '*://hellotxt.com/*')) return proxy;
if(shExpMatch(url, '*://htxt.it/*')) return proxy;
if(shExpMatch(url, '*://nobelprize.org/*')) return proxy;
if(shExpMatch(url, '*://twitpic.com/*')) return proxy;
if(shExpMatch(url, '*://www.canyu.org/*')) return proxy;
if(shExpMatch(url, '*://www.chromeexperiments.com/*')) return proxy;
if(shExpMatch(url, '*://www.linglingfa.com/*')) return proxy;
if(shExpMatch(url, '*://zkaip.com/*')) return proxy;
if(shExpMatch(url, '*album.blog.yam.com/*') return proxy;
if(shExpMatch(url, '*blog.sina.com.tw/*') return proxy;
if(shExpMatch(url, '*friendfeed.com/*')) return proxy;
if (shExpMatch(url, '*chrome.angrybirds.com*')) return proxy;
if(shExpMatch(url, '*hotlinkimage.com/showimg.php/*') return proxy;
if(shExpMatch(url, '*identi.ca/*')) return proxy;
if(shExpMatch(url, '*minzhuzhongguo.org/*')) return proxy;
//Google
if(shExpMatch(url, '*.feedburner.com/*') return proxy;
if(shExpMatch(url, '*://feedproxy.google.com/*')) return proxy;
if(shExpMatch(host, "*plurk.com*")) return proxy;
if(shExpMatch(url, '*.blogger.com/*') return proxy;
if(shExpMatch(url, '*.blogspot.com/*') return proxy;
if(shExpMatch(url, '*googleartproject.com/*')) return proxy;
if(shExpMatch(url, '*://docs*.google.com/*')) return 'DIRECT';
if(shExpMatch(url, '*://spreadsheets*.google.com/*')) return 'DIRECT';
if(shExpMatch(url, '*://picasaweb.google.com/*')) return '203.208.39.104:80';
if(shExpMatch(url, '*.appspot.com/*') return '203.208.39.104:80';
if(shExpMatch(host, "*.ggpht.com*")) return '203.208.39.104:80';
if(shExpMatch(url, '*://groups.google.com/*')) return ipv6;
if(shExpMatch(url, '*://sites.google.com/*')) return ipv6;
if(shExpMatch(url, '*://video.google.com/*')) return ipv6;
if(shExpMatch(url, '*.youtube.com*') return ipv6;
if(shExpMatch(url, '*://youtu.be/*')) return ipv6;
if(shExpMatch(url, '*://www.google.com/search*')) return ipv6;
if(shExpMatch(url, '*://www.google.com/url*')) return ipv6;
if (shExpMatch(url, '*.youtube.com*')) return proxy;
if (shExpMatch(url, '*webcache.googleusercontent.com*')) return 'DIRECT';
if(shExpMatch(url, '*://webcache.googleusercontent.com/*')) return ipv6;
if(shExpMatch(url, "*clients1.google.com/complete/search*")) return ipv6;//Google搜索建议
if(shExpMatch(url, "*www.google.com.hk/complete/search*")) return ipv6;//Google搜索建议
if(/youtu\.be/i.test(url)) return PROXY;
if(/\.youtube\.com/i.test(url)) return PROXY;
if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?youtube\.com/i.test(url)) return PROXY;
if(/\.youtube\-nocookie\.com/i.test(url)) return PROXY;
if(/\.youtubecn\.com/i.test(url)) return PROXY;
//Tweet
if(shExpMatch(url, '*twibbon.com/*')) return proxy;
if(shExpMatch(url, '*twitter.com/*')) return proxy;
if(shExpMatch(url, '*.twitlonger.com/*') return proxy;
if(shExpMatch(url, '*.twitpic.com/*') return proxy;
if(shExpMatch(url, '*.tweetmeme.com/*') return proxy;
if(shExpMatch(url, '*.twimg.com/*') return proxy;
if(shExpMatch(url, '*.twitbrowser.com/*') return proxy;
//Yahoo
if(shExpMatch(url, 'hk.*.yahoo.com/*') return proxy;
if(shExpMatch(url, 'tw.*.yahoo.com/*') return proxy;
if(shExpMatch(url, '*ytimg.com/*') return proxy;
if(shExpMatch(url, 'meme.yahoo.com/*') return proxy;
//FB
if(shExpMatch(url, '*.facebook.com*') return proxy;
if(shExpMatch(url, '*.fbcdn.net/*') return proxy;
//Shoturl
if(shExpMatch(url, '*://img.ly/*')) return proxy;
if(shExpMatch(url, '*://ow.ly/*')) return proxy;
if(shExpMatch(url, '*://t.co/*')) return proxy;
if(shExpMatch(url, '*://ff.im/*')) return proxy;
//其他的
if(/\.ziddu\.com\/download/i.test(url)) return PROXY;
else return "Direct";
}