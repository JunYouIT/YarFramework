
var global = function() {
	function AjaxCall(action,url,data,opts)
    {
        if (opts) {
            opts.IsWarning = opts.IsWarning == undefined ? false : opts.IsWarning;
            if (opts.IsCheckStatus == undefined) opts.IsCheckStatus = opts.IsWarning == undefined ? false : opts.IsWarning;            
        }
        else {
            opts = {
                IsWarning: false,
                IsCheckStatus: false
            }
        }
        var param = {
            url: url, type: action, dataType: 'text',
            success: function (text, textStatus, jqXHR) {
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
				var url;
				url = "/RestAPI/Business/" + bizId + "/" + bizAction + "";
				if(attrs){
					var attrUrl = "";
					for(var attr in attrs){
					    attrUrl = "" + attrUrl + "&" + attr + "=" + attrs[attr] + "";
					}
					url = url + '?' + attrUrl;
				}
				return url;
		}
	
	};
}();