// ==UserScript==
// @include http://update.microsoft.com/*
// @include http://www.windowsupdate.com/*
// @include http://author.skycn.com/*
// @include http://xueli.upol.cn/*
// @include http://*.cccpan.com/*
// @include http://*.ys168.com/*
// @include http://www.bxbtv.com/*
// @include http://www.he.10086.cn/*
// @include http://*.ccb.com/*
// @include http://www.yaoyuan.com/live.php
// @include https://mybank.icbc.com.cn/icbc/perbank/index.jsp
// @include http://*.95599.cn/*
// @include http://*.icbc.com.cn/*
// @include https://*.alipay.com/*
// @include http://fzlm.com/*
// @include http://www.2651.cn/*
// @include http://www.iistv.com/*
// @include http://www.kds8.com/*
// @include http://bt.csze.com/*
// @include http://dakao*.htexam.net/*
// @include http://www.yaoyuan.com/live.php
// @include http://www.cwb.gov.tw/V6/observe/webcam/*
// @include http://www.sport.ccu.edu.tw/sportscenter/*

//
// @exclude *.wmv
// @exclude *.mp3
// @exclude *.avi
// ==/UserScript==

document.write(
	'<html>' +
		'<head>' +
			'<title>' + (document.title ? document.title : location.href).replace(/</g, '&lt;') + ' - view in ie</title>' +
			'<style type="text/css">' +
				'body {' +
					'margin: 0; padding: 0;' +
				'}' +
				'embed {' +
					'width: 100%; height: 100%;' +
				'}' +
			'</style>' +
		'</head>' +
		'<body>' +
			'<script type="text/javascript"' + 'src="data:text/javascript,' + encodeURIComponent('document.write(\'<embed type="application/viewinie" param-location="' + location.href +'\x22  cookies=\x22'+document.cookie+ '"></embed>\');') + '">' + '</script>' +
		'</body>' +
	'</html>'
);
