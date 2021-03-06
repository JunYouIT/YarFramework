﻿;(function(factory) {
    if ( 'function' === typeof define && (define.amd || define.cmd) ) {
        // Register as an anonymous module.
        define([], function(){
            return factory;
        });
    } else {
        factory(jQuery);
    }
}(function($, undefined) {
	$.Yar = $.Yar || {};
	
	var YarDialog = {};
    YarDialog.Show = function (eleId, title, width, height, okcall, cancelcall, onshown) {
        //debugger;
            var closable = cancelcall ? false : true;
            if (typeof App != 'undefined') {
                //debugger;
                var e = document.documentElement || document.body;
                var client = {
                    width: e['clientWidth'],
                    height: e['clientHeight']
                };
                //var client = App.getViewPort();
                if (client.height <= height + 122) {
                    height = client.height - 122;
                }
                if (client.width <= width + 22) {
                    width = client.width - 22;
                }
            }
            //$(eleId).width(width);
            var isshow = false;
            return BootstrapDialog.show({
                type: BootstrapDialog.TYPE_DEFAULT,
                title: title,
                size: BootstrapDialog.SIZE_CUSTOM,
                width: width + 22,
                height: height,
                message: $(eleId),
                onshown: function (dialog) {
                    if (isshow) return;
                    if (onshown) { onshown(dialog); }
                   
                    if (!isshow) isshow = true;
                    
                },
                onhidden: function (dialog) {

                },
                buttons: [{
                    label: $.messager.defaults.ok,
                    cssClass: 'btn-primary',
                    action: function (dialogItself) {
                        okcall(function (data, callfun) {
                            if (data && callfun) callfun(data);
                            dialogItself.close();
                        });
                    }
                }, {
                    label: $.messager.defaults.cancel,
                    action: function (dialogItself) {
                        if (cancelcall) {
                            cancelcall(function () {
                                dialogItself.close();
                            });
                        }
                        else {
                            dialogItself.close();
                        }
                        
                    }
                }]
            });
    };
    YarDialog.ShowCustom = function (eleId, title, width, height, customButtons, onshown) {
        //debugger;
            ///<summary>自定义对话框按钮</summary>
            ///<param name="customButtons" type="Array" >button array {cancel:true,text,icon,click,css}</param>
            ///cancel:true-取消行为,false-确定行为, text:按钮文本,css:按钮颜色css class,icon:按钮图标,click:按钮事件
            if (typeof App != 'undefined') {
                //var client = App.getViewPort();
                var e = document.documentElement || document.body;
                var client = {
                    width: e['clientWidth'],
                    height: e['clientHeight']
                };
                if (client.height <= height + 122) {
                    height = client.height - 122;
                }
                if (client.width <= width + 22) {
                    width = client.width - 22;
                }
            }

            if (!customButtons) return;
            var buttons = [];
            var closable = true;
            $.each(customButtons, function (index, item) {
                var button = {};
                if (item.cancel && item.text === undefined) {
                    button.label = $.messager.defaults.cancel;
                } else if (!item.cancel && item.text === undefined) {
                    button.label = $.messager.defaults.ok;
                } else {
                    button.label = (item.text === undefined) ? "" : item.text;
                }
                if (item.css) {
                    button.cssClass = item.css;
                } else {
                    if (item.cancel) {
                        //button.cssClass = 'dialogcancel';
                    } else {
                        button.cssClass = 'btn-primary';
                    }
                    //                    else {
                    //                        button.css = 'dialogok';
                    //                    }
                }
                if (!(item.icon === undefined)) button.icon = item.icon;
                if (item.cancel) {
                    if (item.click) {
                        closable = false;
                        button.action = function (dialogItself) {
                            item.click(function () {
                                dialogItself.close();
                            });
                        };
                    } else {
                        button.action = function (dialogItself) {
                            dialogItself.close();
                        };
                    }
                } else {
                    if (item.click) {
                        button.action = function (dialogItself) {
                            item.click(function (data, callfun) {
                                if (callfun) callfun(data);
                                dialogItself.close();
                            });
                        };
                    }
                    else {

                    }
                }
                buttons.push(button);
            });
            //debugger;
            //$(eleId).width(width);
            var isshow = false;
           return BootstrapDialog.show({
                type: BootstrapDialog.TYPE_DEFAULT,
                title: title,
                size: BootstrapDialog.SIZE_CUSTOM,
                width: width + 22,
                height: height,
                message: $(eleId),
                buttons: buttons,
                onshow: function () {
                    //debugger;
                },
                onshown: function (dialog) {
                    if (isshow) return;

                    if (onshown)
                        onshown(dialog);
                    
                    
                    if (!isshow) isshow = true;
                }
            });
            //debugger;
            
        };
	$.Yar.Dialog = YarDialog;
}));