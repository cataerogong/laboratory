"use strict";

// windows 7 chs cmd prompt encoding
phantom.outputEncoding="gbk";

var page=require('webpage').create(),
    system=require('system');

page.onConsoleMessage = function(msg) {
    console.log("<onConsoleMessage> "+msg);
};

function printTitle(p) {
    console.log("<Title>: "+p.title);
}

function printCookies(p) {
    var cookies = p.cookies;
    console.log('<Cookies>:');
    for(var i in cookies) {
        console.log(cookies[i].name + '=' + cookies[i].value);
    }
}

// 处理提取码页面
function processPage1() {
    /*
    page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
        page.evaluate(function() {
            console.log("$(\".explanation\").text() -> " + $(".explanation").text());
        });
        phantom.exit(0);
    });
    */
    if (page.title.indexOf("提取密码") !== -1) {
        //console.log("bingo");
        page.injectJs("jquery-2.2.4.min.js");
        nextPageProcessor=processPage2;
        page.onLoadFinished=processPage;
        page.evaluate(function() {
            console.log("I'm in!");
            $("dd.clearfix > :text").val("euaa");
            $(".g-button.g-button-blue-large").click();
            //console.log($(".g-button.g-button-blue-large").html());
        });
    } else {
        console.log("Incorrect page!");
        phantom.exit(0);
    }
}

function processPage2() {
    page.evaluate(function() {
        console.log($("a.filename").html());
        console.log(navigator.userAgent);
        console.log(navigator.platform);
    });
    //phantom.exit(0);
}

var nextPageProcessor=processPage1;

function processPage(status) {
    console.log("-----------------------------------------");
    if (status==="success") {
        printTitle(page);
        printCookies(page);
        page.injectJs("jquery-2.2.4.min.js");
        nextPageProcessor();
    } else {
        console.log("ERROR!");
        phantom.exit(1);
    }
}

function detectSniff() {
    page.evaluate(function () {

        (function () {
            var userAgent = window.navigator.userAgent,
                platform = window.navigator.platform;

            window.navigator = {
                appCodeName: 'Mozilla',
                appName: 'Netscape',
                cookieEnabled: false,
                sniffed: false
            };

            window.navigator.__defineGetter__('userAgent', function () {
                window.navigator.sniffed = true;
                console.log("<DetectSniff> userAgent");
                return "Mozilla/5.0 (Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/53.0.2785.143 Chrome/53.0.2785.143 Safari/537.36";
                //return userAgent;
            });

            window.navigator.__defineGetter__('platform', function () {
                window.navigator.sniffed = true;
                console.log("<DetectSniff> platform");
                return "Linux i686";
                //return platform;
            });

            window.navigator.javaEnabled = function() {
                console.log("<DetectSniff> javaEnabled");
                return false;
            };
        })();
    });
}

page.onInitialized = detectSniff;

var url="https://pan.baidu.com/s/18PzhN3Vr1KBVpOfesxHc2A";
//var url="http://www.zhfund.com/";

//page.outputEncoding="gbk";
page.settings.userAgent="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36";
page.settings.loadImages =false;
page.onLoadFinished=processPage;
page.open(url);
