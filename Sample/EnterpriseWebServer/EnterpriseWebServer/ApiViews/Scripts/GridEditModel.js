var GridEditModel = function (grid) {
    var self = this;
    self.editIndex = undefined;
    self.UpdateUrlParam = null;
    self.IdField = 'Key';
    self.FormatterLink = function (value, rowData, rowIndex) {
        if (rowData[self.IdField])
            return String.format("<a href='#' onclick='cgridModel.Update(\"{0}\");' >更新</a>&nbsp;&nbsp;<a href='#' onclick='cgridModel.Delete(\"{0}\");' >删除</a>", rowData[self.IdField]);
        else
            return "<a href='#' onclick='cgridModel.Update();' >更新</a>&nbsp;&nbsp;<a href='#' onclick='cgridModel.Delete(\"\");' >删除</a>"
    };
    self.Delete = function (resId) {
        if (resId && resId != "") {
            $.messager.confirm('Confirm', 'Are you sure you want to delete record?', function (r) {
                if (r) {
                    $.ajax({
                        url: self.DeleteUrl + '&resId=' + resId,
                        type: 'POST',
                        cache: false,
                        dataType: 'text',
                        success: function (text) {
                            $.messager.alert('Delete', 'Delete success', 'info');
                            if (self.Refresh) self.Refresh();
                        },
                        error: function () {
                        }
                    });
                }
            });
        }
        else {
            var deleteIndex = self.editIndex;
            grid.datagrid('cancelEdit', self.editIndex);
            self.editIndex = undefined;
            grid.datagrid('deleteRow', deleteIndex);
        }
    };
    self.Update = function (resId) {
        if (resId) {
            var index = grid.datagrid('getRowIndex', resId);
            if (self.editIndex != index) return;
        }
        if (self.EndEdit()) {
            var selectRow = grid.datagrid('getSelected');
            var url;
            if (selectRow._new) url = self.InserUrl;
            else url = self.EditUrl + '&resId=' + selectRow[self.IdField];
            if (self.UpdateUrlParam != null) url = url + '&' + self.UpdateUrlParam;
            $.ajax({
                url: url,
                type: 'POST',
                data: $.toJSON(selectRow),
                cache: false,
                dataType: 'text',
                success: function (text) {
                    $.messager.alert('Update', 'update success', 'info');
                    if (self.Refresh) self.Refresh();
                },
                error: function () {
                }
            });
        };
    };
    self.Refresh = function () {
        grid.datagrid('load');
    };
    self.AddNew = function () {
        if (self.EndEdit()) {
            grid.datagrid('appendRow', { _new: true });
            self.editIndex = grid.datagrid('getRows').length - 1;
            grid.datagrid('selectRow', self.editIndex).datagrid('beginEdit', self.editIndex);
        }
    };
    self.BeganEdit = function (index) {
        if (self.editIndex != index) {
            if (self.EndEdit()) {
                grid.datagrid('selectRow', index).datagrid('beginEdit', index);
                self.editIndex = index;
            } else {
                grid.datagrid('selectRow', self.editIndex);
            }
        }
    };
    self.EndEdit = function () {
        if (self.editIndex == undefined) { return true }
        if (grid.datagrid('validateRow', self.editIndex)) {
            grid.datagrid('endEdit', self.editIndex);
            self.editIndex = undefined;
            return true;
        } else {
            return false;
        }
    };
};


var OptViewModel = function (optBiz, gridEleId, viewContext, idField) {
    var self = this;
    self.OptBizName = optBiz;
    self.Context = { ViewContext: viewContext };
    self.GridModel = new GridEditModel($(gridEleId));
    if (idField != undefined) self.GridModel.IdField = idField;
    window.cgridModel = self.GridModel;
    self.GridModel.InserUrl = self.Context.ViewContext.GetActionUrl("Post", self.OptBizName, { BizCommand: 'Create' });
    self.GridModel.EditUrl = self.Context.ViewContext.GetActionUrl("Post", self.OptBizName, { BizCommand: 'Edit' });
    self.GridModel.DeleteUrl = self.Context.ViewContext.GetActionUrl("Post", self.OptBizName, { BizCommand: 'Delete' });
    self.OnRefresh = function () {
        $(gridEleId).datagrid('load');
    };
    self.OnCreate = function () {
        self.GridModel.AddNew();
    };

    self.CreateGrid = function (columns, idField, toolbar) {
        columns.push({ field: 'ID', title: '操作', width: 100, formatter: self.GridModel.FormatterLink });
        YarGrid.Create({
            ClientPage: true,
            ele: gridEleId
        }, {
            url: self.Context.ViewContext.GetActionUrl("Post", self.OptBizName, { BizCommand: 'GetResourceList' }),
            initLoader: true,
            fit: true,
            idField: idField || 'Key',
            toolbar: toolbar || '#gtb',
            columns: [columns],
            onDblClickRow: self.GridModel.BeganEdit
        });
    }

    self.SetUpdateParam = function (updateParam) {
        if (updateParam != undefined)
            self.GridModel.UpdateUrlParam = updateParam;
    };
};

YarClient.ViewModel.GridListModel = function (biz, gridEleId, viewTool, idField) {
    var self = this;
    self.OptBizName = biz;
    self.IdField = 'ResID';
    self.ViewTool = viewTool || new YarClient.ViewModel(biz, MainApp.Token);
    if (viewTool != null) {
        self.InsertUrl = self.ViewTool.GetActionUrl("Post", self.OptBizName + '.Create');
        self.EditUrl = self.ViewTool.GetActionUrl("Post", self.OptBizName + '.Edit');
        self.DeleteUrl = self.ViewTool.GetActionUrl("Get", self.OptBizName + '.Delete');
        self.InsertViewUrl = self.ViewTool.GetActionUrl("Get", self.OptBizName + '.CreateView');
        self.EditViewUrl = self.ViewTool.GetActionUrl("Get", self.OptBizName + '.EditView');
    }
    else {
        self.InsertUrl = self.ViewTool.GetActionUrl("Post", 'Create');
        self.EditUrl = self.ViewTool.GetActionUrl("Post", 'Edit');
        self.DeleteUrl = self.ViewTool.GetActionUrl("Get", 'Delete');
        self.InsertViewUrl = self.ViewTool.GetActionUrl("Get", 'CreateView');
        self.EditViewUrl = self.ViewTool.GetActionUrl("Get", 'EditView');
    };
    self.SetUpdateParam = function (updateParam) {
        if (updateParam != undefined)
            self.UpdateUrlParam = updateParam;
    };
    self.OnRefresh = function () {
        $(gridEleId).datagrid('reload');
    };
    self.OnCreate = function () {
        MainApp.ShowPartialView(YarClient.NewGuid(), self.InsertViewUrl, { ViewModel: self, data: {} },
                function (data) {
                    if (data.result) {
                        self.OnRefresh();
                    }
                });
    };
    self.OnEdit = function () {
        var row = $(gridEleId).datagrid('getSelected');
        if (row) {
            MainApp.ShowPartialView(YarClient.NewGuid(), self.EditViewUrl + '&resId=' + row[self.IdField], { ViewModel: self, data: {} },
            function (data) {
                if (data.result) {
                    self.OnRefresh();
                }
            });
        }
    };
    self.OnDelete = function () {
        var row = $(gridEleId).datagrid('getSelected');
        if (row) {
            $.messager.confirm('Confirm', 'Are you sure you want to delete record?', function (r) {
                if (r) {
                    $.ajax({
                        url: self.DeleteUrl + '&resId=' + row[self.IdField],
                        success: function (text) {
                            self.OnRefresh();
                        },
                        error: function () {
                        }
                    });
                }
            });
        }
    };
};