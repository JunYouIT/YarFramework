





if (typeof swal != 'undefined') {
    $.messager.alert = function (title, msg, icon, fn) {
        //icon:success,info,error,warning
        swal(title, msg, icon);
    };
    $.messager.confirm = function (title, msg, fn) {
        //icon:success,info,error,warning
        swal({
            title: title,
            text: msg,
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "是的, 删除!",
            closeOnConfirm: false
        }, fn);
    };
}



//YarClient javascript lib
//MainApp
var MainApp;
(function () {
    MainApp = {
        ViewSite: '',
        Token: '',
        IsIE: function () {
            if (navigator.appName == "Microsoft Internet Explorer") return true;
            return false;
        },
        GetUrlPath: function (path) {
            if (MainApp.ViewSite != '') {
                if (path.charAt(0) == '/')
                    return MainApp.ViewSite + path;
                else
                    return MainApp.ViewSite + '/' + path;
            }
            return path;
        },
        Init: function () {
        },
        GetUrl: function (bizId, httpType, action, attrs) {
            return YarClient.GetUrl(bizId, httpType, action, attrs);
        },
        SetAutoHeightContent: function (element) {
            var fit = $(element);
            var height = document.documentElement.clientHeight - fit.offset().top - 1;
            if (!height || height < 0) height = 0;
            fit.height(height + "px");
        },
        ShowLoading: function (cp) {
            //cp : string. element' selector
            var load = $('<div class="loading" />');
            $(cp).append(load);
            $('.loading').width($(cp).get(0).offsetWidth);
            $('.loading').height($(cp).get(0).offsetHeight);
            load.show();
        },
        HideLoading: function () {
            $('.loading').hide();
        },
        ShowPartialView: function (elementId, viewPath, context, callback) {
            //dialog
            elementId = 'f' + elementId;
            var eleId = "#" + elementId;
            if (typeof App != 'undefined') App.blockUI();
            $.ajax({
                url: viewPath,
                success: function (data, status, xhr) {
                    if (typeof App != 'undefined') App.unblockUI();
                    try {
                        var jsonObject = $.parseJSON(data);
                        if (jsonObject.StatusCode == 'Success') {
                            $.messager.alert('Message', jsonObject.Message, 'info');
                        }
                        else {
                            if (jsonObject.Message) {
                                $.messager.alert('Message', jsonObject.Message, 'error');
                            }

                        }
                        return;
                    }
                    catch (e) {
                    }
                    //debugger;
                    var html = $('<div id="' + elementId + '"></div>').html(data);
                    var script = html.find('script');
                    var scriptStr = script.text();
                    script.remove();
                    $('body').append(html);
                    eval(scriptStr);

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    if (typeof App != 'undefined') App.unblockUI();
                    $.messager.alert('Message', jqXHR.responseText || errorThrown, 'error');
                }
            });

        },
        ShowPartialViewPost: function (elementId, viewPath, context, callback, postData) {
            //dialog
            elementId = 'f' + elementId;
            var eleId = "#" + elementId;

            $.ajax({
                url: viewPath,
                type: 'post',
                data: $.toJSON(postData),
                success: function (data, status, xhr) {
                    try {
                        var jsonObject = $.parseJSON(data);
                        if (jsonObject.StatusCode == 'Success') {
                            $.messager.alert('Message', jsonObject.Message, 'info');
                        }
                        else {
                            if (jsonObject.Message) {
                                $.messager.alert('Message', jsonObject.Message, 'error');
                            }

                        }
                        return;
                    }
                    catch (e) {
                    }
                    if (window != top) {
                        var html = $('<div id="' + elementId + '"></div>').html(data);
                        var script = html.find('script');
                        var scriptStr = script.text();
                        script.remove();
                        $('body').append(html);
                        eval(scriptStr);
                    }
                    else {
                        var html = $('<div id="' + elementId + '"></div>').html(data);
                        var script = html.find('script');
                        var scriptStr = script.text();
                        script.remove();
                        $('body').append(html);
                        eval(scriptStr);
                    }

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.messager.alert('Message', errorThrown, 'error');
                }
            });
        },
        LoadPartialView: function (elementId, viewPath, context1, callback1,loadComplete) {
            var eleId1 = "#" + elementId;
            eval("var eleId = '#'+ arguments[0],context = arguments[2],callback = arguments[3]");
            $.ajax({
                url: viewPath,
                success: function (data, status, xhr) {
                    try {
                        var jsonObject = $.parseJSON(data);
                        if (jsonObject.StatusCode == 'Success') {
                            $.messager.alert('Message', jsonObject.Message, 'info');
                        }
                        else {
                            if (jsonObject.Message) {
                                $.messager.alert('Message', jsonObject.Message, 'error');
                            }

                        }
                        return;
                    }
                    catch (e) {
                    }
                    var html = $('<div></div>').html(data);
                    var script = html.find('script');
                    var scriptStr = script.text();
                    script.remove();
                    $(eleId1).html(html.children());
                    eval(scriptStr);
                    if (loadComplete) {
                        loadComplete();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $(eleId1).html('<div>' + errorThrown + '</div>');
                    if (loadComplete) {
                        loadComplete();
                    }
                }
            });
        },
        ShowDialog: function (url, data, callback) {
            MainApp.ShowPartialView(YarClient.NewGuid(), url, data, callback);
        },
        ShowDialogPost: function (url, data, postData, callback) {
            MainApp.ShowPartialViewPost(YarClient.NewGuid(), url, data, callback, postData);
        },
        ShowTabView: function (title, href, icon, isRefresh) {
            if (window.addTab) {
                window.addTab(title, href, icon, isRefresh);
            }
            else if (window.parent.addTab) {
                window.parent.addTab(title, href, icon, isRefresh);
            }
        },
        CloseTabView: function (title) {
            if (window.CloseTab) {
                window.CloseTab(title);
            }
            else if (window.parent.CloseTab) {
                window.parent.CloseTab(title);
            }
        },
        RefreshTabView: function (title, isPartialRefresh) {
            if (window.refreshTab) {
                window.refreshTab({ tabTitle: title, IsPartialRefresh: isPartialRefresh || false });
            }
            else if (window.parent.refreshTab) {
                window.parent.refreshTab({ tabTitle: title, IsPartialRefresh: isPartialRefresh || false });
            }

        },
        DialogModel: function (eleId, title, width, height, okcall, cancelcall, onshown) {
            return $.Yar.Dialog.Show(eleId, title, width, height, okcall, cancelcall, onshown);
            return;
            var closable = cancelcall ? false : true;
            if (typeof App != 'undefined') {
                var client = App.getViewPort();
                if (client.height <= height + 102) {
                    height = client.height - 122;
                }
                if (client.width <= width + 14) {
                    width = client.width - 34;
                }
            }
            $(eleId).dialog({
                title: title,
                width: width + 14,
                height: height + 102,
                closed: false,
                closable: closable,
                cache: false,
                modal: true,
                buttons: [{
                    text: $.messager.defaults.ok,
                    css: 'dialogok',
                    handler: function () {
                        okcall(function (data, callfun) {
                            if (data && callfun) callfun(data);
                            $(eleId).window('destroy');

                        });
                    }
                }, {
                    text: $.messager.defaults.cancel,
                    css: 'dialogcancel',
                    handler: function () {
                        if (cancelcall) {
                            cancelcall(function () {
                                $(eleId).window('destroy');
                            });
                        }
                        else {
                            $(eleId).window('destroy');
                        }
                    }
                }],
                onClose: function () {
                    $(eleId).window('destroy');
                }
            });
            $(eleId).slimScroll({
                height: height,
                alwaysVisible: false,
                color: 'rgb(161, 178, 189)'
            });
        },
        DialogCustomButton: function (eleId, title, width, height, customButtons,onshown) {
            return $.Yar.Dialog.ShowCustom(eleId, title, width, height, customButtons, onshown);
            return;
            ///<summary>自定义对话框按钮</summary>
            ///<param name="customButtons" type="Array" >button array {cancel:true,text,icon,click,css}</param>
            ///cancel:true-取消行为,false-确定行为, text:按钮文本,css:按钮颜色css class,icon:按钮图标,click:按钮事件
            if (typeof App != 'undefined') {
                var client = App.getViewPort();
                if (client.height <= height + 102) {
                    height = client.height - 122;
                }
                if (client.width <= width + 14) {
                    width = client.width - 34;
                }
            }

            if (!customButtons) return;
            var buttons = [];
            var closable = true;
            $.each(customButtons, function (index, item) {
                var button = {};
                if (item.cancel && item.text === undefined) {
                    button.text = $.messager.defaults.cancel;
                } else if (!item.cancel && item.text === undefined) {
                    button.text = $.messager.defaults.ok;
                } else {
                    button.text = (item.text === undefined) ? "" : item.text;
                }
                if (item.css) {
                    button.css = item.css;
                } else {
                    if (item.cancel) {
                        button.css = 'dialogcancel';
                    }
                    //                    else {
                    //                        button.css = 'dialogok';
                    //                    }
                }
                if (!(item.icon === undefined)) button.iconCls = item.icon;
                if (item.cancel) {
                    if (item.click) {
                        closable = false;
                        button.handler = function () {
                            item.click(function () {
                                $(eleId).window('destroy');
                            });
                        };
                    } else {
                        button.handler = function () {
                            $(eleId).window('destroy');
                        };
                    }
                } else {
                    if (item.click) {
                        button.handler = function () {
                            item.click(function (data, callfun) {
                                if (callfun) callfun(data);
                                $(eleId).window('destroy');
                            });
                        };
                    }
                    else {

                    }
                }
                buttons.push(button);
            });
            $(eleId).dialog({
                title: title,
                width: width + 14,
                height: height + 102,
                closed: false,
                closable: closable,
                cache: false,
                modal: true,
                buttons: buttons,
                onClose: function () {
                    $(eleId).window('destroy');
                }
            });
            $(eleId).slimScroll({
                height: height,
                alwaysVisible: false,
                color: 'rgb(161, 178, 189)'
            });
            if (typeof onshown === 'function') {
                onshown();
            }
        },
        Paste: function () {
            var ele = $('div[yar-layout="autoheight"]')[0];
            if (ele) {
                $(window).resize(function () {
                    var height = document.documentElement.clientHeight - $(ele).offset().top - 1;
                    if (!height || height < 0) height = 0;
                    $(ele).height(height + "px");
                });
                MainApp.SetAutoHeightContent(ele);
            }
            var table = $('table[yar-layout="autoheight"]')[0];
            if (table) {
                MainApp.SetAutoHeightContent(table);
            }
        },
        SetChecked: function (ele, bChecked) {
            if (bChecked) {
                if (!$(ele).is(":checked")) {
                    $(ele).prop('checked', true);
                    //$(ele).checked = true;
                }
            }
            else {
                $(ele).prop('checked', false);

            }
        },
        GetChecked: function (ele) {
            return $(ele).is(":checked");
        },
        SetEnable: function (ele, bEnable) {
            if (bEnable) {
                if ($(ele).is(":disabled")) {
                    $(ele).prop('disabled', false);
                }
            }
            else {
                $(ele).prop('disabled', true);
            }
        },
        GetEnable: function (ele) {
            return !$(ele).is(":disabled");
        },
        GetDataChange: function (formdata, sourcedata, ignoreChange) {
            //get data change from ko object
            var changedata = {
                HasChange: false
            };
            for (var name in formdata) {
                if (name == '__ko_mapping__' || name == '__proto__') continue;
                var fv = ko.utils.unwrapObservable(formdata[name]);
                var sv = sourcedata[name];
                if (ignoreChange) {
                    changedata[name] = fv;
                    changedata.HasChange = true;
                }
                else {
                    if ($.isArray(sv)) {
                        if ($.toJSON(sv) != $.toJSON(fv)) {
                            changedata[name] = fv;
                            changedata.HasChange = true;
                        }
                    }
                    else if (fv != sv) {
                        changedata[name] = fv;
                        changedata.HasChange = true;
                    }
                }
            }
            return changedata;
        },
        FormValidate: function (formEle) {
            if ($.fn.validatebox) {
                var t = ((formEle == undefined) || (formEle == null)) ? $('body') : $(formEle);
                t.find('.validatebox-text:not(:disabled)').validatebox('validate');
                var invalidbox = t.find('.validatebox-invalid');
                invalidbox.filter(':not(:disabled):first').focus();
                return invalidbox.length == 0;
            }
            return true;
        }


    };

})();

//end MainApp

//YarGrid
var YarGrid = {
    ClientPageFilter: function (data) {
        if (data && typeof data.length == 'number' && typeof data.splice == 'function') {    // is array
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            onSelectPage: function (pageNum, pageSize) {
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh', {
                    pageNumber: pageNum,
                    pageSize: pageSize
                });
                dg.datagrid('loadData', data);
            }
        });
        if (data == null)
            return {
                total: 0, rows: []
            };
        if (data && !data.originalRows) {
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    },
    Loader: function (param, success, error) {
        var opts = $(this).datagrid("options");
        if (!opts.url) {
            return false;
        }
        $.ajax({
            type: opts.method, url: opts.url, data: param, dataType: "json", success: function (data) {
                success(data);
            }, error: function () {
                error.apply(this, arguments);
            }
        });
    },
    Create: function (option, gridOpts, istree) {
        if (!option || !option.ele) return;
        if (option.ClientPage) {
            if (gridOpts.initLoader === undefined) gridOpts.initLoader = false;
            if (gridOpts.rownumbers === undefined) gridOpts.rownumbers = false;
            if (gridOpts.fitColumns === undefined) gridOpts.fitColumns = false;
            if (gridOpts.singleSelect === undefined) gridOpts.singleSelect = true;
            if (gridOpts.pagination === undefined) gridOpts.pagination = true;
            if (gridOpts.pageSize === undefined) gridOpts.pageSize = 20;
            if (gridOpts.pageList === undefined) gridOpts.pageList = [5, 10, 15, 20, 50];
            if (gridOpts.striped === undefined) gridOpts.striped = true;
            gridOpts.loadFilter = YarGrid.ClientPageFilter;
            if (istree) {
                $(option.ele).treegrid(gridOpts);
            }
            else {
                $(option.ele).datagrid(gridOpts);
            }
        }
        else {
            if (gridOpts.initLoader === undefined) gridOpts.initLoader = false;
            if (gridOpts.rownumbers === undefined) gridOpts.rownumbers = false;
            if (gridOpts.fitColumns === undefined) gridOpts.fitColumns = false;
            if (gridOpts.singleSelect === undefined) gridOpts.singleSelect = true;
            if (gridOpts.pagination === undefined) gridOpts.pagination = true;
            if (gridOpts.pageSize === undefined) gridOpts.pageSize = 20;
            if (gridOpts.pageList === undefined) gridOpts.pageList = [5, 10, 15, 20, 50];
            if (gridOpts.striped === undefined) gridOpts.striped = true;            

            if (istree) {
                $(option.ele).treegrid(gridOpts);
            }
            else {
                $(option.ele).datagrid(gridOpts);
            }
        };

        var showPageList = false;
        
        if (gridOpts.showPageList) {
            showPageList = true;
        }

        var pager = istree ? $(option.ele).treegrid('getPager') : $(option.ele).datagrid('getPager');

        if (pager) {
            pager.pagination({
                showPageList: showPageList,
                showRefresh: false,
                links:5,
                layout: showPageList ? ['first', 'prev', 'links', 'next', 'last', 'list'] : ['first', 'prev', 'links', 'next', 'last']
            });
        }

        if (option.SizeOpt && option.SizeOpt.pid) {
            if (option.SizeOpt.top) {
                $(window).resize(function () {
                    YarGrid.SetGridSize(option.ele, option.SizeOpt.pid, document.documentElement.clientHeight - option.SizeOpt.top);
                });
                YarGrid.SetGridSize(option.ele, option.SizeOpt.pid, document.documentElement.clientHeight - option.SizeOpt.top);
            } else if (option.SizeOpt.topinterval) {
                $(window).resize(function () {
                    YarGrid.SetGridSize(option.ele, option.SizeOpt.pid, $('.page-content').height() - option.SizeOpt.topinterval);
                });
                YarGrid.SetGridSize(option.ele, option.SizeOpt.pid, $('.page-content').height() - option.SizeOpt.topinterval);
            }

        };
    },
    CreateTree: function (option, treeOpts) {
        $(option.ele).treegrid(treeOpts);
        if (option.SizeOpt && option.SizeOpt.pid && option.SizeOpt.top) {
            $(window).resize(function () {
                YarGrid.SetGridSize(option.ele, option.SizeOpt.pid, option.SizeOpt.top, true);
            });
            YarGrid.SetGridSize(option.ele, option.SizeOpt.pid, option.SizeOpt.top, true);
        };
    },
    CreateBoostrapTable: function (option, gridOpts) {
        if (!option || !option.ele) return;
        if (option.ClientPage) {
            gridOpts.sidePagination = "client";
            gridOpts.contentType = "application/x-www-form-urlencoded";
            if (gridOpts.pageSize === undefined) gridOpts.pageSize = 20;
            gridOpts.pageList = [gridOpts.pageSize];
            gridOpts.queryParamsType = '';
            gridOpts.queryParams = function (params) {
                return {                    
                }
            };
            gridOpts.responseHandler = function (res) {
                if (res.rows) {
                    return res.rows;
                }
                return res;
            }
            if (gridOpts.striped === undefined) gridOpts.striped = true;
            if (gridOpts.method === undefined) gridOpts.method = 'post';
            if (gridOpts.dataType === undefined) gridOpts.dataType = 'json';
            if (gridOpts.undefinedText === undefined) gridOpts.undefinedText = '';
            if (gridOpts.pagination === undefined) gridOpts.pagination = true;
            if (gridOpts.paginationHAlign === undefined) gridOpts.paginationHAlign = true;
            if (gridOpts.paginationDetailHAlign === undefined) gridOpts.paginationDetailHAlign = true;
            if (gridOpts.paginationDetailHAlign === undefined) gridOpts.paginationDetailHAlign = true;
            $(option.ele).bootstrapTable(gridOpts);
        }
        else {
            gridOpts.sidePagination = "server";
            gridOpts.contentType = "application/x-www-form-urlencoded";
            if (gridOpts.pageSize === undefined) gridOpts.pageSize = 20;
            if (gridOpts.pageList === undefined) gridOpts.pageList = [gridOpts.pageSize];            
            gridOpts.queryParamsType = '';
            gridOpts.queryParams = function (params) {
                return {
                    sort: params.sortName,
                    rows: params.pageSize,
                    page: params.pageNumber,
                    order: params.sortOrder
                }
            };
            if (gridOpts.striped === undefined) gridOpts.striped = true;
            if (gridOpts.method === undefined) gridOpts.method = 'post';
            if (gridOpts.dataType === undefined) gridOpts.dataType = 'json';
            if (gridOpts.undefinedText === undefined) gridOpts.undefinedText = '';
            if (gridOpts.pagination === undefined) gridOpts.pagination = true;
            if (gridOpts.paginationHAlign === undefined) gridOpts.paginationHAlign = 'left';
            if (gridOpts.paginationDetailHAlign === undefined) gridOpts.paginationDetailHAlign = 'right';
            if (gridOpts.paginationPreText === undefined) gridOpts.paginationPreText = "<i class='fa fa-angle-left'></i>";
            if (gridOpts.paginationNextText === undefined) gridOpts.paginationNextText = "<i class='fa fa-angle-right'></i>"; 
            $(option.ele).bootstrapTable(gridOpts);
        };

        if (option.SizeOpt) {      
            if (option.SizeOpt.top) {
                $(window).resize(function () {
                    $(option.ele).bootstrapTable('resetView', { height: document.documentElement.clientHeight - option.SizeOpt.top });
                });
                $(option.ele).bootstrapTable('resetView', { height: document.documentElement.clientHeight - option.SizeOpt.top });
            } 
            else if (option.SizeOpt.topinterval) {
                $(window).resize(function () {
                    $(option.ele).bootstrapTable('resetView', { height: $('.page-content').height() - option.SizeOpt.interval });
                });
                $(option.ele).bootstrapTable('resetView', { height: $('.page-content').height() - option.SizeOpt.interval });
            } 
        };
    },
    SetGridSize: function (id, pid, height, isTreeGrid) {
        var parent = $(pid);
        if (parent) {
            var width = parent.width();

            if (!height || height < 0) height = 0;
            if (isTreeGrid) {
                $(id).treegrid('resize', { width: width, height: height });
            }
            else {
                $(id).datagrid('resize', { width: width, height: height });
            }
        }
    },
    CheckboxTFFormtter: function (value, row, index) {
        if (value == 1) {
            return '<input type="checkbox" checked="checked">';
        }
        else if (value == 0) {
            return '<input type="checkbox">';
        }
    },
    DateFormatter: function (value, row, index) {
        if (value && value != null) {
            var t = new Date(Date.parse(value.replace(/-/g, "/")));
            return t.Format("yyyy-MM-dd");
        }
        return value;
    },
    DatetimeFormatter: function (value, row, index) {
        if (value && value != null) {
            var t = new Date(Date.parse(value.replace(/-/g, "/")));
            return t.Format("yyyy-MM-dd hh:mm:ss");
        }
        return value;
    },
    StringContentFormatter: function (value, row, index) {
        var text = value ? value : '';
        return String.format('<span title="{0}" data-toggle="tooltip">{0}</span>', text);
    }

};
//end YarGrid


//namespce
var YarClient;
(function (YarClient) {
    YarClient.ViewModel = (function () {
        //ViewModel
        function ViewModel(businessName, tokenId) {
            /// <field name='BusinessName' type='String'>BusinessName</field>
            /// <field name='tokenId' type='String'>Identify Id</field>
            this.BusinessName = businessName;
            this.TokenId = tokenId;
        };
        ViewModel.prototype.GetActionUrl = function (httpType, action, attrs) {
            ///<summary>获取actiond 的URL sample:/RestAPI/Business/Post?businessname=PeopleBusiness&amp;businessaction=GetRoleList</summary>
            ///<param name="httpType" type="String" >Get,Post</param>
            ///<param name="action" type="String" >businessAction</param>
            ///<param name="attrs" type="Object" >atational attribute</param>
            /// <returns type="String">return string.  </returns>    

            if (!httpType) return "";

            var url;
            if (this.TokenId && this.TokenId != '') {
                url = String.format("/RestAPI/Business/{0}?token={3}&businessname={1}&businessaction={2}", httpType, this.BusinessName, action, this.TokenId);
            }
            else if (MainApp.Token && MainApp.Token != '') {
                url = String.format("/RestAPI/Business/{0}?token={3}&businessname={1}&businessaction={2}", httpType, this.BusinessName, action, MainApp.Token);
            }
            else
                url = String.format("/RestAPI/Business/{0}?businessname={1}&businessaction={2}", httpType, this.BusinessName, action);
            if (MainApp.ViewSite != '') url = MainApp.ViewSite + url;
            if (attrs) {
                var attrUrl = "";
                for (var attr in attrs) {
                    attrUrl = String.format("{0}&{1}={2}", attrUrl, attr, attrs[attr]);
                }
                url = url + attrUrl;
            }
            return url;
        };
        ViewModel.prototype.GetBizActionUrl = function (biz, httpType, action, attrs) {
            ///<summary>获取actiond 的URL sample:/RestAPI/Business/Post?businessname=PeopleBusiness&amp;businessaction=GetRoleList</summary>
            ///<param name="httpType" type="String" >Get,Post</param>
            ///<param name="action" type="String" >businessAction</param>
            ///<param name="attrs" type="Object" >atational attribute</param>
            /// <returns type="String">return string.  </returns>    

            if (!httpType) return "";

            var url;
            if (this.TokenId && this.TokenId != '') {
                url = String.format("/RestAPI/Business/{0}?token={3}&businessname={1}&businessaction={2}", httpType, biz, action, this.TokenId);
            }
            else if (MainApp.Token && MainApp.Token != '') {
                url = String.format("/RestAPI/Business/{0}?token={3}&businessname={1}&businessaction={2}", httpType, biz, action, MainApp.Token);
            }
            else
                url = String.format("/RestAPI/Business/{0}?businessname={1}&businessaction={2}", httpType, biz, action);

            if (MainApp.ViewSite != '') url = MainApp.ViewSite + url;
            if (attrs) {
                var attrUrl = "";
                for (var attr in attrs) {
                    attrUrl = String.format("{0}&{1}={2}", attrUrl, attr, attrs[attr]);
                }
                url = url + attrUrl;
            }
            return url;
        };
        return ViewModel;
    })();
    YarClient.GetUrl = function (bizId, httpType, action, attrs) {
        if (!httpType) return "";

        var url;
        if (this.TokenId && this.TokenId != '') {
            url = String.format("/RestAPI/Business/{0}?businessname={1}&businessaction={2}", httpType, bizId, action);
        }
        else if (MainApp.Token && MainApp.Token != '') {
            url = String.format("/RestAPI/Business/{0}?businessname={1}&businessaction={2}", httpType, bizId, action);
        }
        else
            url = String.format("/RestAPI/Business/{0}?businessname={1}&businessaction={2}", httpType, bizId, action);

        if (MainApp.ViewSite != '') url = MainApp.ViewSite + url;
        if (attrs) {
            var attrUrl = "";
            for (var attr in attrs) {
                attrUrl = String.format("{0}&{1}={2}", attrUrl, attr, attrs[attr]);
            }
            url = url + attrUrl;
        }
        return url;
    };
    YarClient.GetRequestString = function (attrs) {
        if (attrs) {
            var attrUrl = "";
            for (var attr in attrs) {
                if(attrUrl)
                    attrUrl = String.format("{0}&{1}={2}", attrUrl, attr, attrs[attr]);
                else 
                    attrUrl = String.format("{1}={2}", attrUrl, attr, attrs[attr]);
            }
            return attrUrl;
        }
        return "";
    };

    YarClient.AjaxGet = function (url, opts) {
        ///<summary>Ajax get call sample:YarClient.AjaxGet(GetActionUrl("Get", "GetData"),{ IsWarning: true });</summary>
        ///<param name="url" type="String" >url</param>
        ///<param name="opts" type="Object" >success -- function,failed -- function, IsWarning -- bool,warning when ajax success,ajax success but code is not success,ajax error </param>
        /// <returns type="Void">return void.  </returns>    
        AjaxCall('GET', url, null, opts);
    };
    YarClient.AjaxPost = function (url, data, opts) {
        ///<summary>Ajax get call sample:YarClient.AjaxGet(GetActionUrl("Get", "GetData"),{ IsWarning: true });</summary>
        ///<param name="url" type="String" >url</param>
        ///<param name="data" type="Object" >string or object</param>
        ///<param name="opts" type="Object" >success -- function,failed -- function, IsWarning -- bool,warning when ajax success,ajax success but code is not success,ajax error </param>
        /// <returns type="Void">return void.  </returns>    
        AjaxCall('POST', url, data, opts);
    };

    function AjaxCall(action, url, data, opts) {

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
                            $.messager.alert('成功', data.Message, 'info');
                        if (opts.success)
                            opts.success(data);
                    }
                    else {
                        if (opts.IsWarning && data.Message)
                            $.messager.alert('错误', data.Message, 'error');
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
                if (opts.IsBlock) {
                    if (typeof App != 'undefined') App.unblockUI();
                }
                var edata = {
                    StatusCode: 'Failed', status: jqXHR.status, statustext: jqXHR.statusText, Message: jqXHR.responseText
                };
                if (opts.IsWarning)
                    $.messager.alert('错误', edata.Message, 'error');
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
        if (opts.async !== void 0) {
            param.async = opts.async;
        }
        $.ajax(param);
    }

    YarClient.NewGuid = function () {
        var S4 = function () {
            return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
        };
        return (S4() + S4() + S4() + S4() + S4() + S4() + S4() + S4());
    };

})(YarClient || (YarClient = {}));




//end ViewModel

