/*! jQuery JSON plugin 2.4.0 | code.google.com/p/jquery-json */
//$.toJSON();
(function ($) {
    'use strict'; var escape = /["\\\x00-\x1f\x7f-\x9f]/g, meta = { '\b': '\\b', '\t': '\\t', '\n': '\\n', '\f': '\\f', '\r': '\\r', '"': '\\"', '\\': '\\\\' }, hasOwn = Object.prototype.hasOwnProperty; $.toJSON = typeof JSON === 'object' && JSON.stringify ? JSON.stringify : function (o) {
        if (o === null) { return 'null'; }
        var pairs, k, name, val, type = $.type(o); if (type === 'undefined') { return undefined; }
        if (type === 'number' || type === 'boolean') { return String(o); }
        if (type === 'string') { return $.quoteString(o); }
        if (typeof o.toJSON === 'function') { return $.toJSON(o.toJSON()); }
        if (type === 'date') {
            var month = o.getUTCMonth() + 1, day = o.getUTCDate(), year = o.getUTCFullYear(), hours = o.getUTCHours(), minutes = o.getUTCMinutes(), seconds = o.getUTCSeconds(), milli = o.getUTCMilliseconds(); if (month < 10) { month = '0' + month; }
            if (day < 10) { day = '0' + day; }
            if (hours < 10) { hours = '0' + hours; }
            if (minutes < 10) { minutes = '0' + minutes; }
            if (seconds < 10) { seconds = '0' + seconds; }
            if (milli < 100) { milli = '0' + milli; }
            if (milli < 10) { milli = '0' + milli; }
            return '"' + year + '-' + month + '-' + day + 'T' +
            hours + ':' + minutes + ':' + seconds + '.' + milli + 'Z"';
        }
        pairs = []; if ($.isArray(o)) {
            for (k = 0; k < o.length; k++) { pairs.push($.toJSON(o[k]) || 'null'); }
            return '[' + pairs.join(',') + ']';
        }
        if (typeof o === 'object') {
            for (k in o) {
                if (hasOwn.call(o, k)) {
                    type = typeof k; if (type === 'number') { name = '"' + k + '"'; } else if (type === 'string') { name = $.quoteString(k); } else { continue; }
                    type = typeof o[k]; if (type !== 'function' && type !== 'undefined') { val = $.toJSON(o[k]); pairs.push(name + ':' + val); }
                }
            }
            return '{' + pairs.join(',') + '}';
        }
    }; $.evalJSON = typeof JSON === 'object' && JSON.parse ? JSON.parse : function (str) { return eval('(' + str + ')'); }; $.secureEvalJSON = typeof JSON === 'object' && JSON.parse ? JSON.parse : function (str) {
        var filtered = str.replace(/\\["\\\/bfnrtu]/g, '@').replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']').replace(/(?:^|:|,)(?:\s*\[)+/g, ''); if (/^[\],:{}\s]*$/.test(filtered)) { return eval('(' + str + ')'); }
        throw new SyntaxError('Error parsing JSON, source is not valid.');
    }; $.quoteString = function (str) {
        if (str.match(escape)) {
            return '"' + str.replace(escape, function (a) {
                var c = meta[a]; if (typeof c === 'string') { return c; }
                c = a.charCodeAt(); return '\\u00' + Math.floor(c / 16).toString(16) + (c % 16).toString(16);
            }) + '"';
        }
        return '"' + str + '"';
    };
}(jQuery));

//global javascript funtion

// 对Date的扩展，将 Date 转化为指定格式的String   
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
// 例子：   
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.Format = function (fmt) { //author: meizz   
    var o = {
        "M+": this.getMonth() + 1,                 //月份   
        "d+": this.getDate(),                    //日   
        "h+": this.getHours(),                   //小时   
        "m+": this.getMinutes(),                 //分   
        "s+": this.getSeconds(),                 //秒   
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
        "S": this.getMilliseconds()             //毫秒   
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

//string function
String.format = function () {
    var s = arguments[0];
    for (var i = 0; i < arguments.length - 1; i++) {
        var reg = new RegExp("\\{" + i + "\\}", "gm");
        s = s.replace(reg, arguments[i + 1]);
    }

    return s;
};

String.prototype.DateFormat = function () {
    if (!this) return this;
    var that = new Date(Date.parse(this.replace(/-/g, "/")));

    if (arguments.length == 0) {
        return that.Format('yyyy-MM-dd hh:mm:ss');
    }
    else {
        if (arguments[0].toLowerCase() == "d") {
            return that.Format('yyyy-MM-dd');
        } else if (arguments[0].toLowerCase() == "t") {
            return that.Format('yyyy-MM-dd hh:mm:ss');
        }
        else {
            return that;
        }
    }
};

String.prototype.InsteadSpecialChar = String.prototype.InsteadSpecialChar ? String.prototype.InsteadSpecialChar : function () {
    var lt = /</g,
        gt = />/g,
        ap = /'/g,
        ic = /"/g;
    var value = this;
    return value.toString().replace(lt, "&lt;").replace(gt, "&gt;").replace(ap, "&#39;").replace(ic, "&#34;");
};

String.prototype.trimStart = function () {
    var self = this;

    if (self.length == 0) {
        return self;
    }

    var args = new Array();

    if (!arguments || arguments.length == 0) {
        args.push(' ');
    }
        
    var idx = 0;

    for (idx = 0; idx < arguments.length; idx++) {
        if (arguments[idx]) {
            args.push(arguments[idx]);
        }
    }
    
    if (args.length == 0) {
        return self;
    }

    var count = 0;

    while (true) {
        count = 0;

        for (idx = 0; idx < args.length; idx++) {
            if (self.indexOf(args[idx]) == 0) {
                self = self.substr(args[p].length);
            }
            else {
                count++;
            }
        }

        if (count == args.length) {
            break;
        }
    }

    return self;
}

String.prototype.trimEnd = function () {
    var self = this;

    if (self.length == 0) {
        return self;
    }

    var args = new Array();

    if (!arguments || arguments.length == 0) {
        args.push(' ');
    }

    var idx = 0;

    for (idx = 0; idx < arguments.length; idx++) {
        if (arguments[idx]) {
            args.push(arguments[idx]);
        }
    }

    if (args.length == 0) {
        return self;
    }

    var count = 0;

    while (true) {
        count = 0;

        for (idx = 0; idx < args.length; idx++) {
            if (self.lastIndexOf(args[idx]) + args[idx].length == self.length) {
                self = self.substr(0, self.length - args[p].length);
            }
            else {
                count++;
            }
        }

        if (count == args.length) {
            break;
        }
    }

    return self;
}

String.prototype.trim = function () {
    return this.trimStart().trimEnd();
}

//array function
if (!Array.prototype.find) {
    Object.defineProperty(Array.prototype, 'find', {
        value: function (predicate) {
            // 1. Let O be ? ToObject(this value).
            if (this == null) {
                throw new TypeError('"this" is null or not defined');
            }

            var o = Object(this);

            // 2. Let len be ? ToLength(? Get(O, "length")).
            var len = o.length >>> 0;

            // 3. If IsCallable(predicate) is false, throw a TypeError exception.
            if (typeof predicate !== 'function') {
                throw new TypeError('predicate must be a function');
            }

            // 4. If thisArg was supplied, let T be thisArg; else let T be undefined.
            var thisArg = arguments[1];

            // 5. Let k be 0.
            var k = 0;

            // 6. Repeat, while k < len
            while (k < len) {
                // a. Let Pk be ! ToString(k).
                // b. Let kValue be ? Get(O, Pk).
                // c. Let testResult be ToBoolean(? Call(predicate, T, « kValue, k, O »)).
                // d. If testResult is true, return kValue.
                var kValue = o[k];
                if (predicate.call(thisArg, kValue, k, o)) {
                    return kValue;
                }
                // e. Increase k by 1.
                k++;
            }

            // 7. Return undefined.
            return undefined;
        }
    });
}

Array.prototype.each = function (callback) {
    for (var i = 0, j = this.length; i < j; i++) {
        callback.call(this, this[i], i);
    }
};
//end global