$(document).ready(
        function () {
            $.extend($.fn.validatebox.defaults.rules, {
                web: {
                    validator: function (value) {
                        return /^(http[s]{0,1}|ftp):\/\//i.test($.trim(value));
                    },
                    message: '网址格式错误.'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                date: {
                    validator: function (value) {
                        return /^[0-9]{4}[-][0-9]{2}[-][0-9]{2}$/i.test($.trim(value));
                    },
                    message: '日期格式错误,如2012-09-11.'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                email: {
                    validator: function (value) {
                        return /^[a-zA-Z0-9_+.-]+\@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9]{2,4}$/i.test($.trim(value));
                    },
                    message: '电子邮箱格式错误.'
                }
            });


            $.extend($.fn.validatebox.defaults.rules, {
                PositiveInteger: {
                    validator: function (value) {
                        return /^[1-9]\d*$/i.test($.trim(value));
                    },
                    message: '请输入一个正整数'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                precision: {
                    validator: function (value, param) {
                        return new RegExp("^\\d+(\\.\\d{1," + param[0] + "})?$").test(value)
                    },
                    message: '请保留{0}位小数'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                PositiveNumber_TwoDecimal: {
                    validator: function (value) {
                        if (value == 0.00) {
                            return false;
                        }
                        return /^[0-9]+(\.[0-9]{2})?$/i.test($.trim(value));
                    },
                    message: '请输入一个正数(保留两位小数)'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                Money: {
                    validator: function (value) {
                        if (value == 0.00) {
                            return false;
                        }
                        return /^[1-9]{1}\d*(.\d{1,2})?$|^0.\d{1,2}$/i.test($.trim(value));
                    },
                    message: '请输入正确的金额(保留两位小数)'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                MaxIntValidate: {
                    validator: function (value) {
                        var maxValue = $(this).parent().parent().find('input[max]').attr('max');
                        return parseInt(value) <= parseInt(maxValue);
                    },
                    message: '请小于限额'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                MinValue: {
                    validator: function (value, param) {
                        if (value >= param[0]) {
                            return true;
                        } else {
                            $.fn.validatebox.defaults.rules.MinValue.message = param[1];
                            return false;
                        }
                    }
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                MaxValue: {
                    validator: function (value, param) {
                        if (value <= param[0]) {
                            return true;
                        } else {
                            $.fn.validatebox.defaults.rules.MaxValue.message = param[1];
                            return false;
                        }
                    }
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                integer: {
                    validator: function (value, param) {
                        var validResult = /^[+|-]?(([1-9][0-9]*)|[0-9])$/.test(value);
                        if (!validResult) {
                            return validResult;
                        }
                        var num = parseInt(value);

                        return validResult && num >= param[0] && num <= param[1];
                    },
                    message: '请输入 {0} 到 {1} 之间的整数'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                MinDate: {
                    validator: function (value, param) {
                        var minData = param[0];
                        return value >= minData;
                    },
                    message: '请输入 {0} 之后的日期;'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                price: {
                    validator: function (value, param) {
                        return /^(0|(0.\d{0,9}(\.\d{1,2})?)|([1-9]\d{0,9}(\.\d{1,2})?))$/.test(value);
                    },
                    message: '价格格式不正确，格式：0.00'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                maxLength: {
                    validator: function (value, param) {
                        return param[0] >= value.length;
                    },
                    message: '请输入最大{0}位字符.'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                mobile: {
                    validator: function (value) {
                        var reg = /^1[2|3|4|5|6|7|8|9]\d{9}$/;
                        return reg.test(value);
                    },
                    message: '请输入正确的手机号码.'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                phone: {
                    validator: function (value) {
                        var reg = /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/;
                        return reg.test(value);
                    },
                    message: '请输入正确的电话号码.'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                number: {
                    validator: function (value) {
                        return /^[0-9]{0,32}$/.test($.trim(value));
                    },
                    message: '只能输入32位以内的数字.'
                }
            });

            $.extend($.fn.validatebox.defaults.rules, {
                website: {
                    validator: function (value) {
                        var rangReg = /^[\s\S]{1,100}$/;
                        var reg = /^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/;
                        return reg.test($.trim(value)) && rangReg.test($.trim(value));
                    },
                    message: '这网址不是以http://或https:// 开头，或者不是网址或者长度超过100.'
                }
            });
			//extent easyui validate for compare
/*
 * @desc: 比较两个日期的大小(传入的参数推荐是"yyyy-mm-dd"的格式，其他的日期格式也可以，但要保证一致)
 * @param: date1:目标日期;date2:被比较日期
 */
var dateCompare = function (date1, date2) {
    if (date1 && date2) {
        var a = new Date(date1);
        var b = new Date(date2);
        return a < b;
    }
};
/* 
 * @desc: 比较两个时间的大小（传入的参数是"HH:mm"的格式，）
 * @param: time1:目标时间;time2:被比较时间
 */
var timeCompare = function (time1, time2) {
    //console.info(time1+"-"+time2);
    try {
        if (time1 && time2) {
            var t1 = parseInt(time1.split(":")[0] * 60) + parseInt(time1.split(":")[1]);
            var t2 = parseInt(time2.split(":")[0] * 60) + parseInt(time2.split(":")[1]);
            return t1 < t2;
        }
        return false;
    } catch (e) {
        return false;
    }
};
/* 
 * @desc: 比较两个时间的大小，支持的格式可在formatArr扩展
 * @param: datetime1:目标时间;datetime2:被比较时间
 */
var dateTimeCompare = function (datetime1, datetime2) {

    var formatArr = new Array('YYYY-MM-DD',
            'YYYY-MM-DD HH:mm',
            'YYYY-MM-DD HH:mm:ss'
            );//支持的格式
    try {
        if (datetime1 && datetime2) {
            var dt1 = moment(datetime1, formatArr);
            var dt2 = moment(datetime2, formatArr);
            //            console.info(dt1+","+dt2);
            return dt1 < dt2;
        }
        return false;
    } catch (e) {
        return false;
    }
};

$.extend($.fn.validatebox.defaults.rules, {
    //比较日期选择器
    compareDate: {
        validator: function (value, param) {
            //debugger;
            return dateCompare($(param[0]).datebox("getValue"), value);
        },
        message: "结束日期不能小于或等于开始日期"
    },
    //比较时间选择器（时分秒）
    compareTime: {
        validator: function (value, param) {
            return timeCompare($(param[0]).timespinner("getValue"), value);
        },
        message: "结束时间不能小于或等于开始时间"
    },
    //比较时间选择器（时分秒）
    compareDateTime: {
        validator: function (value, param) {
            return dateTimeCompare($(param[0]).timespinner("getValue"), value);
        },
        message: "结束时间不能小于或等于开始时间"
    }

});
//end extent easyui validate
$.extend($.fn.validatebox.defaults.rules, {
    cremote: {
        validator: function (value, param) {
            var postdata = {};
            postdata[param[1]] = value;
            var mResult = $.ajax({ url: param[0], dataType: "json", data: postdata, async: false, cache: false, type: "post" }).responseText;
            if (mResult == "false") {
                $.fn.validatebox.defaults.rules.cremote.message = param[2];
                return false;
            }
                // 2016.10.12 modified by liuzhuang 
                // start 
            else if (mResult && JSON.parse(mResult).hasOwnProperty("msg")) {
                $.fn.validatebox.defaults.rules.cremote.message = JSON.parse(mResult).msg;
                return false;
            }
                // end
            else {
                return true;
            }
        },
        message: ''
    }
});

        });
		
		
$.fn.datebox.defaults.formatter = function (date) {
    //debugger;
    return date.Format('yyyy-MM-dd');
}

//reoverride datebox parser
$.fn.datebox.defaults.parser = function (s) {
    if (!s) return new Date();
    var t = Date.parse(s.replace(/-/g, "/"));
    if (!isNaN(t)) {
        return new Date(t);
    } else {
        return new Date();
    }
}
