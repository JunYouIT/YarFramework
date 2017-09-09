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
String.format = function () {
    var s = arguments[0];
    for (var i = 0; i < arguments.length - 1; i++) {
        var reg = new RegExp("\\{" + i + "\\}", "gm");
        s = s.replace(reg, arguments[i + 1]);
    }

    return s;
};


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

String.prototype.DateFormat = function () {
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

//extent easyui validate for group
$.extend($.fn.validatebox.defaults.rules, {
    group: {
        validator: function (value, param) {
            //debugger;
            var rules = $.fn.validatebox.defaults.rules;
            for (var i = 0; i < param.length; i++) {
                var mat = /([a-zA-Z_]+)(.*)/.exec(param[i]);
                //if (param[i].substr(0, 6) == 'length') {
                if (mat[1] == 'length') {
                    var pa = eval(mat[2]);
                    if (!rules.length.validator(value, pa)) {
                        rules.group.message = rules.length.message.replace("{0}", pa[0]).replace("{1}", pa[1]);
                        return false;
                    }
                }
                else if (mat[1] == 'remote') {
                    var pa = eval(mat[2]);
                    if (!rules.remote.validator(value, pa)) {
                        if (pa[2]) {
                            rules.group.message = pa[2];
                        }
                        else rules.group.message = '';
                        return false;
                    }
                }
            }
            return true;
        },
        message: ''
    }
});
//end extent easyui




//knockout bingding
//dateboxValue binding
ko.bindingHandlers.dateboxValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var modalValue = valueAccessor();
        var allBindings = allBindingsAccessor();
        var editable = allBindings.editable || false;
        var defaultvalue = allBindings.defaultvalue;
        var option = {
            editable: editable,
            onChange: function (newValue, oldValue) {
                var val = valueAccessor();
                if (ko.isObservable(val))
                    val(newValue);
            }
        };

        $(element).datebox(option);
        if (defaultvalue && ko.isObservable(modalValue) && ko.utils.unwrapObservable(modalValue) == null) modalValue(defaultvalue);

    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).datebox('getValue');
        var valueHasChanged = (newValue != elementValue);

        // JavaScript's 0 == "" behavious is unfortunate here as it prevents writing 0 to an empty text box (loose equality suggests the values are the same).
        // We don't want to do a strict equality comparison as that is more confusing for developers in certain cases, so we specifically special case 0 != "" here.
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;

        if (valueHasChanged) {
            $(element).datebox('setValue', newValue);
        }
    }
};
//comboboxValue binding
ko.bindingHandlers.comboboxValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {

        var modalValue = valueAccessor();
        var allBindings = allBindingsAccessor();
        var defaultvalue = allBindings.defaultvalue;
        var option = {
            editable: allBindings.editable || false,
            valueField: allBindings.valueField || 'ID',
            textField: allBindings.displayField || 'Name',
            data: allBindings.dataSource || [],
            onChange: function (newValue, oldValue) {
                var val = valueAccessor();
                if (ko.isObservable(val))
                    val(newValue);
            }
        };
        $(element).combobox(option);
        if (defaultvalue && ko.isObservable(modalValue) && ko.utils.unwrapObservable(modalValue) == null) modalValue(defaultvalue);

    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).combobox('getValue');
        var valueHasChanged = (newValue != elementValue);
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;

        if (valueHasChanged) {
            $(element).combobox('setValue', newValue);
        }
    }
};

//comboboxnmulValue binding (mulitple value
ko.bindingHandlers.comboboxnmulValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var modalValue = valueAccessor();
        var allBindings = allBindingsAccessor();
        var defaultvalue = allBindings.defaultvalue;
        var option = {
            multiple: true,
            editable: allBindings.editable || false,
            valueField: allBindings.valueField || 'ID',
            textField: allBindings.displayField || 'Name',
            data: allBindings.dataSource || [],
            onChange: function (newValue, oldValue) {
                var val = valueAccessor();
                if (ko.isObservable(val))
                    val(newValue);
            }
        };
        $(element).combobox(option);
        if (defaultvalue && ko.isObservable(modalValue) && ko.utils.unwrapObservable(modalValue) == null) modalValue(defaultvalue);

    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).combobox('getValues');
        var valueHasChanged = (newValue != elementValue);
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;

        if (valueHasChanged) {
            $(element).combobox('setValues', newValue);
        }
    }
};

//numberboxValue binding
ko.bindingHandlers.numberboxValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        $(element).numberbox({
            value: ko.utils.unwrapObservable(valueAccessor()),
            onChange: function (newValue, oldValue) {
                var val = valueAccessor();
                if (ko.isObservable(val))
                    val(newValue);
            }
        });

    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).numberbox('getValue');
        var valueHasChanged = (newValue != elementValue);
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;
        if (valueHasChanged) {
            $(element).numberbox('setValue', newValue);
        }
    }
};

//combogridValue binding
ko.bindingHandlers.combogridValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var modalValue = valueAccessor();
        var allBindings = allBindingsAccessor();
        var defaultvalue = allBindings.defaultvalue;
        var option = {
            editable: allBindings.editable || false,
            idField: allBindings.valueField || 'ID',
            textField: allBindings.displayField || 'Name',
            data: allBindings.dataSource || [],
            columns: allBindings.uiSource ? [allBindings.uiSource] : [],
            onChange: function (newValue, oldValue) {
                var val = valueAccessor();
                if (ko.isObservable(val)) {
                    val(newValue);
                }
            }
        };
        $(element).combogrid(option);
        if (defaultvalue && ko.isObservable(modalValue) && ko.utils.unwrapObservable(modalValue) == null) modalValue(defaultvalue);

    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).combogrid('getValue');
        var valueHasChanged = (newValue != elementValue);
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;

        if (valueHasChanged) {
            $(element).combogrid('setValue', newValue);
        }
    }
};

//lookupValue binding
ko.bindingHandlers.lookupValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var modalValue = valueAccessor();
        var allBindings = allBindingsAccessor();
        var textv = allBindings.textValue;
        var option = {
            editable: allBindings.editable || false,
            onSelect: function (target) {
                if (allBindings.selectEvent) {
                    var elementValue = $(element).lookup('getValue');
                    allBindings.selectEvent(element, elementValue, function (value, text) {
                        var val = valueAccessor();
                        if (ko.isObservable(val)) {
                            textv(text);
                            val(value);
                        }
                    });
                }
            }
        };
        $(element).lookup(option);
    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).lookup('getValue');
        var valueHasChanged = (newValue != elementValue);
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;

        if (valueHasChanged) {
            var allBindings = allBindingsAccessor();
            $(element).lookup('setValue', newValue);
            $(element).lookup('setText', ko.utils.unwrapObservable(allBindings.textValue) || '');
        }
    }
};

//InitFun binding
ko.bindingHandlers.InitFun = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var modalValue = valueAccessor();
        modalValue(element, valueAccessor, allBindingsAccessor, viewModel);
    }
};


//easyui comboxLookup
(function ($) {

    // 创建控件DOM
    function create(target) {
        var id = $(target).attr('id');

        if (!id) {
            id = 'lookup_' + new Date().getTime();
            $(target).attr('id', id);
        }

        //parse options
        var options = {};
        var s = $.trim($(target).attr('data-options'));
        if (s) {
            var first = s.substring(0, 1);
            var last = s.substring(s.length - 1, 1);
            if (first != '{') s = '{' + s;
            if (last != '}') s = s + '}';
            options = (new Function('return ' + s))();
        }

        $(target).addClass('lookup-f').hide();

        var lookup = $('<span class="combo"></span>').insertAfter(target);
        var textbox = $('<input type="text" class="combo-text" />').appendTo(lookup);
        var arrow = $("<span><span class=\"combo-arrow \"></span></span>").appendTo(lookup);
        var valbox = $("<input type=\"hidden\" class=\"combo-value\">").appendTo(lookup);

        lookup.addClass('lookup');

        var state = $.data(target, 'lookup');
        if (options.required != undefined) state.options.required = options.required;
        if (options.validType != undefined) state.options.validType = options.validType;
        textbox.validatebox($.extend({}, state.options, { deltaX: 19 }));
        // 添加图标
        if (state.options.iconCls) {
            arrow.find('.combo-arrow').addClass(state.options.iconCls);
        }
        else {
            arrow.find('.combo-arrow').addClass('icon-search');
        }

        //set width;
        var width = $(target).outerWidth();
        lookup._outerWidth(width);
        textbox._outerWidth(width - arrow._outerWidth());

        var name = $(target).attr("name");
        if (name) {
            lookup.find("input.combo-value").attr("name", name);
            $(target).removeAttr("name").attr("comboName", name);
        }
        textbox.attr("autocomplete", "off");
        if (state.options.editable != undefined) textbox.attr("readonly", !state.options.editable);

        arrow.on('click', function () {
            if (state.options.onSelect) {
                state.options.onSelect(target);
            }

        });
        state.textbox = textbox;
        state.valbox = valbox;
    };

    $.fn.lookup = function (options, param) {
        if (typeof options == 'string') {
            var method = $.fn.lookup.methods[options];
            if (method) {
                return method(this, param);
            } else {
                return this.lookup(options, param);
            }
        }

        options = options || {};

        return this.each(function () {
            var state = $.data(this, 'lookup');
            if (state) {
                $.extend(state.options, options);
                create(this);
            }
            else {
                $.data(this, 'lookup', { options: $.extend({}, $.fn.lookup.defaults, options) });
                create(this);
            }
        })

    };


    $.fn.lookup.methods = {
        setValue: function (jq, val) {
            return jq.each(function () {
                var state = $.data(this, 'lookup');
                state.valbox.val(val);
            });

        },
        getValue: function (jq) {
            var state = $.data(jq[0], 'lookup');
            return state.valbox.val();

        },
        setText: function (jq, text) {
            return jq.each(function () {
                var state = $.data(this, 'lookup');
                state.textbox.val(text);
            });

        },
        getText: function (jq) {
            var state = $.data(jq[0], 'lookup');
            return state.textbox.val();
        }
    };

    $.fn.lookup.defaults = {
        required: false,
        validType: null,
        iconCls: '',
        editable: true
    };

})(jQuery);