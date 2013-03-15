// ==UserScript==
// @name YoukuAntiADs
// @author Harv
// @description 通过替换swf播放器的方式来解决优酷的黑屏广告
// @version 0.1.5.1
// @namespace http://userscripts.org/users/Harv
// @updateURL https://userscripts.org/scripts/source/119622.meta.js
// @include http://*/*
// @include https://*/*
// ==/UserScript==
/* History
 * 2013-2-7 v0.1.5.1 修正css，修正opera兼容性
 */

(function(document) {
    var loader = 'http://hostsx.googlecode.com/svn/trunk/Player/loader.swf';
    var ku6 = 'http://hostsx.googlecode.com/svn/trunk/Player/ku6.swf';
    var players = [{
        find: /http:\/\/static\.youku\.com(\/v[\d\.]*)?\/v\/swf\/(player.*|loader)\.swf/,
        replace: loader
    },{
        find: /http:\/\/player\.youku\.com\/player\.php\/(.*\/)?sid\/([\w=]+)\/v\.swf/,
        replace: loader + '?showAd=0&VideoIDS=$2'
    },{
        find: /http:\/\/player\.ku6cdn\.com\/default\/common\/player\/\d*\/player\.swf/,
        replace: ku6
    }];

    var done = [];

    function reloadPlugin(elem) {
        var nextSibling = elem.nextSibling;
        var parentNode = elem.parentNode;
        parentNode.removeChild(elem);
        var newElem = elem.cloneNode(true);
        done.push(newElem);
        if(nextSibling) {
            parentNode.insertBefore(newElem, nextSibling);
        } else {
            parentNode.appendChild(newElem);
        }
    }

    function replace(elem) {
        if(done.indexOf(elem) != -1) return;
        done.push(elem);

        var find, replace;
        var player = elem.data || elem.src;
        if(!player) return;

        for(var i = 0; i < players.length; i++) {
            find = players[i].find;
            replace = players[i].replace;
            if(find.test(player)) {
                elem.data && (elem.data = elem.data.replace(find, replace)) || elem.src && ((elem.src = elem.src.replace(find, replace)) && (elem.style.display = 'block'));
                reloadPlugin(elem);
                break;
            }
        }
    }
    
    function addAnimations() {
        var style = document.createElement('style');
        style.type = 'text/css';
        style.innerHTML = 'object,embed{\
-webkit-animation-duration:.001s;-webkit-animation-name:playerInserted;\
-ms-animation-duration:.001s;-ms-animation-name:playerInserted;\
-o-animation-duration:.001s;-o-animation-name:playerInserted;\
animation-duration:.001s;animation-name:playerInserted;}\
@-webkit-keyframes playerInserted{from{opacity:0.99;}to{opacity:1;}}\
@-ms-keyframes playerInserted{from{opacity:0.99;}to{opacity:1;}}\
@-o-keyframes playerInserted{from{opacity:0.99;}to{opacity:1;}}\
@keyframes playerInserted{from{opacity:0.99;}to{opacity:1;}}';
      
        document.getElementsByTagName('head')[0].appendChild(style);
    }
    
    function animationsHandler(e) {
        if(e.animationName === 'playerInserted') {
            replace(e.target);
        }
    }
    
    document.body.addEventListener('webkitAnimationStart', animationsHandler, false);
    document.body.addEventListener('msAnimationStart', animationsHandler, false);
    document.body.addEventListener('oAnimationStart', animationsHandler, false);
    document.body.addEventListener('animationstart', animationsHandler, false);
  
    addAnimations();

})(window.document);