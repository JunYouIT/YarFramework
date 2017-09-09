__CreateJSPath = function (js) {
    var scripts = document.getElementsByTagName("script");
    var path = "";
    for (var i = 0, l = scripts.length; i < l; i++) {
        var src = scripts[i].src;
        if (src.indexOf(js) != -1) {
            var ss = src.split(js);
            path = ss[0];
            break;
        }
    }
    var href = location.href;
    href = href.split("#")[0];
    href = href.split("?")[0];
    var ss = href.split("/");
    ss.length = ss.length - 1;
    href = ss.join("/");
    if (path.indexOf("https:") == -1 && path.indexOf("http:") == -1 && path.indexOf("file:") == -1 && path.indexOf("\/") != 0) {
        path = href + "/" + path;
    }
    return path;
}

var bootPATH = __CreateJSPath("sysboot-1.1.js");

window.top.SystemLanguage = window.top.SystemLanguage || 'zh_CN';

document.write('<script src="' + bootPATH + 'jquery.min.js" type="text/javascript"></sc' + 'ript>');
document.write('<script src="' + bootPATH + 'knockout-2.2.1.js" type="text/javascript"></sc' + 'ript>');
document.write('<script src="' + bootPATH + 'knockout.mapping.js" type="text/javascript"></sc' + 'ript>');
document.write('<script src="' + bootPATH + 'EasyUI-1.4/jquery.easyui.min.js" type="text/javascript" ></sc' + 'ript>');
document.write('<script src="' + bootPATH + 'EasyUI-1.4/locale/easyui-lang-' + window.top.SystemLanguage +'.js" type="text/javascript" ></sc' + 'ript>');
document.write('<link href="' + bootPATH + '../Content/Site.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + bootPATH + 'EasyUI-1.4/themes/bootstrap/easyui1.4.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + bootPATH + 'EasyUI-1.4/themes/icons.css" rel="stylesheet" type="text/css" />');
document.write('<script src="' + bootPATH + 'ComJS.min.js" type="text/javascript"></sc' + 'ript>');
document.write('<script src="' + bootPATH + 'MainApp.js" type="text/javascript"></sc' + 'ript>');



////////////////////////////////////////////////////////////////////////////////////////
function getCookie(sName) {
    var aCookie = document.cookie.split("; ");
    var lastMatch = null;
    for (var i = 0; i < aCookie.length; i++) {
        var aCrumb = aCookie[i].split("=");
        if (sName == aCrumb[0]) {
            lastMatch = aCrumb;
        }
    }
    if (lastMatch) {
        var v = lastMatch[1];
        if (v === undefined) return v;
        return unescape(v);
    }
    return null;
}