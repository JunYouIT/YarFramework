
var global = function() {
	function AjaxCall(action,url,data,opts)
    {
        if (opts) {
            opts.IsWarning = opts.IsWarning == undefined ? false : opts.IsWarning;
            if (opts.IsCheckStatus == undefined) opts.IsCheckStatus = opts.IsWarning == undefined ? false : opts.IsWarning;            
        }
        opts = $.extend({
        }, {
                IsWarning: false,
                IsCheckStatus: true,
                IsBlock: (action == 'POST') ? true : false
            }, opts);
        var param = {
            url: url, type: action, dataType: 'text',
            success: function (text, textStatus, jqXHR) {
                if (opts.IsBlock) {
                    if (typeof App != 'undefined') App.unblockUI();
                }
                var data = text == '' ? '' : eval('(' + text + ')');
                if (opts.IsCheckStatus) {
                    if (data.StatusCode == 'Success') {

                        if (opts.IsWarning && data.Message)
                            $.messager.alert('Message', data.Message, 'info');
                        if (opts.success)
                            opts.success(data);
                    }
                    else {
                        if (opts.IsWarning && data.Message)
                            $.messager.alert('Message', data.Message, 'error');
                        if (opts.failed)
                            opts.failed(data)
                    }
                }
                else {
                    if (opts.success)
                        opts.success(data);
                }
                

            },
            error: function (jqXHR, textStatus, errorThrown) {
                var edata = { StatusCode: 'Failed', status: jqXHR.status, statustext: jqXHR.statusText, Message: jqXHR.responseText };
                if (opts.IsWarning)
                    $.messager.alert('Message', edata.Message, 'error');
                if (opts.failed)
                    opts.failed(edata)
            }
        }
        if (action == 'POST') {
            if (data) {
                if (typeof data == 'string')
                    param.data = data;
                else
                    param.data = $.toJSON(data)
            }         
        }
        if (opts.IsBlock) {
            if (typeof App != 'undefined') App.blockUI();
        }
        $.ajax(param);
    };
	return {
		initPage : function(){
			var initcss = $("#ContentInitCss").text();
			if(initcss != ''){
			   var cssarray = eval('(' + initcss + ')');
			   cssarray.forEach(function(css){  
					document.write('<link href="' + css + '" rel="stylesheet" type="text/css" />');
				})  
			   
			   $("#ContentInitCss").remove();
            }
            
		   var initscript = $("#ContentInitScript").text();
			if(initscript != ''){
			   var scriptarray = eval('(' + initscript + ')');
			   scriptarray.forEach(function(spt){  
					document.write('<script src="' + spt + '" type="text/javascript"></sc' + 'ript>');
				})  
			   
			   $("#ContentInitScript").remove();
		   }      
		},
		initGlobalScript : function() {
			var globalscript = $("#ContentGlobalScript").text();
			if(globalscript != ''){
				try {
					eval(globalscript);
				   
				}
				catch (e) {
                }
				 $("#ContentGlobalScript").remove();
			   
		   } 
		},
		initContent : function(){
			 var script = $("#ContentInit").text();
			   if(script != ''){
				   eval(script);
				   $("#ContentInit").remove();
			   }
		},
		OpenWindow : function(url,target,features) {
			if(target) {
				return window.open(url,target,features);
			} else {
			    window.location = url;
			    return window;
			}
		},
		AjaxGet : function (url, opts) { 
			AjaxCall('GET', url, null, opts);
		},
		AjaxPost : function (url, data, opts) {
			AjaxCall('POST', url, data, opts);
		},
		GetActionUrl : function(bizId,bizAction,attrs){
            var url, attrUrl = '';
            var idlist = bizId.split('.');
            var actionlist = bizAction.split('.');
            var bizIdUrl = bizId;
            var bizActionUrl = bizAction;
            if (attrs) {
                for (var attr in attrs) {
                    attrUrl = "" + attrUrl + "&" + attr + "=" + attrs[attr] + "";
                }
            }
            if (idlist.length > 1) {
                bizIdUrl = idlist[0];
                bizActionUrl = idlist.slice(1).join('.') + "." + bizAction;
                url = "/RestAPI/Business/ActionInvoke?businessname=" + bizIdUrl + '&businessaction=' + bizActionUrl;
                if (attrUrl) {
                    url = url + '&' + attrUrl;
                }
            } else if (actionlist.length > 1) {
                url = "/RestAPI/Business/ActionInvoke?businessname=" + bizId + '&businessaction=' + bizAction;
                if (attrUrl) {
                    url = url + '&' + attrUrl;
                }
            }
            else {
                url = "/RestAPI/Business/" + bizIdUrl + "/" + bizActionUrl + "";
                if (attrUrl)
                    url = url + '?' + attrUrl;
            }
		    return url;
		}
	
	};
}();