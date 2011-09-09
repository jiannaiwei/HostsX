// ==UserScript==
// @description 修正iframe
// @version v1.1
// @include http://*.cnki.net/*
// ==/UserScript==

function GetContentSize() {
    var docEl = document.documentElement, body = document.body;
    return {
        width: Math.max(docEl.scrollWidth, body.scrollWidth),
        height: Math.max(docEl.scrollHeight, body.scrollHeight)
    };
}

function AdjustSize() {
    // get self iframe
    window.randomId = Math.random().toString();
    var frm, frms = window.parent.document.getElementsByTagName("iframe");
    for(var i=0; i<frms.length; i++){
        if (frms[i].contentWindow.randomId == window.randomId) {
            frm = frms[i];
            break;
        }
    }
    // set
    if (frm){
        // get size
        var size = GetContentSize();
        // set size
        frm.style.width = size.width + "px";
        frm.style.height = size.height + "px";
    }
}

window.addEventListener("load", function(){
		AdjustSize()
}, false);