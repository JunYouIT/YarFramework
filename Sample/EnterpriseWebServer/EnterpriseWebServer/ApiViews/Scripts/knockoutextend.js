//knockout bingding
//bind html and apply bingding context
ko.bindingHandlers.bindHTML = {
    init: function () {
        // we will handle the bindings of any descendants
        return { controlsDescendantBindings: true };
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        // must read the value so it will update on changes to the value
        //var value = ko.utils.unwrapObservable(valueAccessor());
        // create the child html using the value
        //ko.applyBindingsToNode(element, { html: value });
        // apply bindings on the created html
        //ko.applyBindingsToDescendants(bindingContext, element);
        ko.utils.setHtml(element, valueAccessor());
        ko.applyBindingsToDescendants(bindingContext, element);
    }
};
//dateboxValue binding
ko.bindingHandlers.dateboxValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        
        var allBindings = allBindingsAccessor();
        var editable = allBindings.editable || false;
        var defaultvalue = allBindings.defaultvalue;
        var modalVale = ko.utils.unwrapObservable(valueAccessor());
        var val = (modalVale == undefined || modalVale == null) ? defaultvalue : modalVale;
        var option = {
            editable: editable,
            onChange: function (newValue, oldValue) {
                var val = valueAccessor();
                if (ko.isObservable(val))
                    val(newValue);
            }
        };
        if (val != undefined && val != null) {
            option.value = val;
        }
        $(element).datebox(option);
        //if (defaultvalue && ko.isObservable(modalValue) && ko.utils.unwrapObservable(modalValue) == null) modalValue(defaultvalue);

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
       
        var allBindings = allBindingsAccessor();
        var defaultvalue = allBindings.defaultvalue;
        var modalVale = ko.utils.unwrapObservable(valueAccessor());
        var val = (modalVale == undefined || modalVale == null) ? defaultvalue : modalVale;

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
        if (val) {
            option.value = val;
        }
        $(element).combobox(option);
        //if (defaultvalue && ko.isObservable(modalValue) && ko.utils.unwrapObservable(modalValue) == null) modalValue(defaultvalue);

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
     
        var allBindings = allBindingsAccessor();
        var defaultvalue = allBindings.defaultvalue;
        var modalVale = ko.utils.unwrapObservable(valueAccessor());
        var val = (modalVale == undefined || modalVale == null) ? defaultvalue : modalVale;
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
        if (val != undefined && val != null) {
            option.value = val;
        }
        $(element).combobox(option);
        //if (defaultvalue && ko.isObservable(modalValue) && ko.utils.unwrapObservable(modalValue) == null) modalValue(defaultvalue);

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

ko.bindingHandlers.tagboxValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {

        var allBindings = allBindingsAccessor();
        var defaultvalue = allBindings.defaultvalue;
        var modalVale = ko.utils.unwrapObservable(valueAccessor());
        var val = (modalVale == undefined || modalVale == null) ? defaultvalue : modalVale;
        var readonly = (allBindings.readonly === undefined) ? true : allBindings.readonly;
        var hasdownArrow = (allBindings.hasArrow === undefined) ? true : allBindings.hasArrow;
        var option = {
            editable: allBindings.editable || false,
            valueField: allBindings.valueField || 'ID',
            textField: allBindings.displayField || 'Name',
            data: allBindings.dataSource || [],
            limitToList: true,
            readonly: readonly,
            hasDownArrow: hasdownArrow,
            onChange: function (newValue, oldValue) {
                var val = valueAccessor();
                if (ko.isObservable(val))
                    val(newValue);
            }
        };
        if (val != undefined && val != null) {
            option.value = val;
        }
        $(element).tagbox(option);
        //if (defaultvalue && ko.isObservable(modalValue) && ko.utils.unwrapObservable(modalValue) == null) modalValue(defaultvalue);

    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).combobox('getValues');
        var valueHasChanged = (newValue != elementValue);
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;

        if (valueHasChanged) {
            $(element).tagbox('setValues', newValue);
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

//timespinnerValue binding
ko.bindingHandlers.timespinnerValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        $(element).timespinner({
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
        var elementValue = $(element).timespinner('getValue');
        var valueHasChanged = (newValue != elementValue);
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;
        if (valueHasChanged) {
            $(element).timespinner('setValue', newValue);
        }
    }
};

//numberspinnerValue binding
ko.bindingHandlers.numberspinnerValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        $(element).numberspinner({
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
        var elementValue = $(element).numberspinner('getValue');
        var valueHasChanged = (newValue != elementValue);
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;
        if (valueHasChanged) {
            $(element).numberspinner('setValue', newValue);
        }
    }
};

//combogridValue binding
ko.bindingHandlers.combogridValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
       
        var allBindings = allBindingsAccessor();
        var defaultvalue = allBindings.defaultvalue;
        var modalVale = ko.utils.unwrapObservable(valueAccessor());
        var val = (modalVale == undefined || modalVale == null) ? defaultvalue : modalVale;
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
        if (val != undefined && val != null) {
            option.value = val;
        }
        $(element).combogrid(option);
        //if (defaultvalue && ko.isObservable(modalValue) && ko.utils.unwrapObservable(modalValue) == null) modalValue(defaultvalue);

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


//grid InitFun binding
ko.bindingHandlers.grid = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var ops = ko.utils.unwrapObservable(valueAccessor());
        YarGrid.Create(ops.ops, ops.sops, ops.istree);
    }
};

ko.bindingHandlers.boostraptable = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var ops = ko.utils.unwrapObservable(valueAccessor());
        YarGrid.CreateBoostrapTable(ops.ops, ops.sops);
    }
};

ko.bindingHandlers.dispalypanel = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        //debugger;
        var val = valueAccessor();
        var initclose = val();
        $(element).panel({ noheader: true, closed: !initclose });
        
        val.subscribe(function (newValue) {
            if (newValue) {
                $(element).panel('open');
            } else {
                $(element).panel('close');
            }
        });
    }
};

ko.bindingHandlers.textboxValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        //var ontxclick = ko.utils.unwrapObservable(valueAccessor());
        var allBindings = allBindingsAccessor();
        var option = {
            onChange: function (newValue, oldValue) {
                var val = valueAccessor();
                if (ko.isObservable(val))
                    val(newValue);
            }
        };
        if (allBindings.txclick) {
            option.onClickButton = allBindings.txclick;
        }
        if (allBindings.disable != null) {
            option.disabled = allBindings.disable;
        }

        $(element).textbox(option);
    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).textbox('getValue');
        var valueHasChanged = (newValue != elementValue);

        // JavaScript's 0 == "" behavious is unfortunate here as it prevents writing 0 to an empty text box (loose equality suggests the values are the same).
        // We don't want to do a strict equality comparison as that is more confusing for developers in certain cases, so we specifically special case 0 != "" here.
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;

        var allBindings = allBindingsAccessor();

        if (allBindings.disable != null) {
            if (allBindings.disable) {
                $(element).textbox('disable');
            } else {
                $(element).textbox('enable');
            }
        }

        if (valueHasChanged) {
            $(element).textbox('setValue', newValue);
        }
    }
};
ko.bindingHandlers.textboxText = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).textbox('getText');
        var valueHasChanged = (newValue != elementValue);

        // JavaScript's 0 == "" behavious is unfortunate here as it prevents writing 0 to an empty text box (loose equality suggests the values are the same).
        // We don't want to do a strict equality comparison as that is more confusing for developers in certain cases, so we specifically special case 0 != "" here.
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;

        if (valueHasChanged) {
            $(element).textbox('setText', newValue);
        }
    }
};

//knockout bingding
//datetimeboxValue binding
ko.bindingHandlers.datetimeboxValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var modalValue = valueAccessor();
        var allBindings = allBindingsAccessor();
        var editable = allBindings.editable || false;
        var defaultvalue = allBindings.defaultvalue;
        var showSeconds = allBindings.showSeconds == undefined ? true : allBindings.showSeconds;
        var option = {
            editable: editable,
            showSeconds: showSeconds,
            onChange: function (newValue, oldValue) {
                var val = valueAccessor();
                if (ko.isObservable(val))
                    val(newValue);
            }
        };

        $(element).datetimebox(option);
        if (defaultvalue && ko.isObservable(modalValue) && ko.utils.unwrapObservable(modalValue) == null) modalValue(defaultvalue);

    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).datetimebox('getValue');
        var valueHasChanged = (newValue != elementValue);

        // JavaScript's 0 == "" behavious is unfortunate here as it prevents writing 0 to an empty text box (loose equality suggests the values are the same).
        // We don't want to do a strict equality comparison as that is more confusing for developers in certain cases, so we specifically special case 0 != "" here.
        if ((newValue === 0) && (elementValue !== 0) && (elementValue !== "0"))
            valueHasChanged = true;

        if (valueHasChanged) {
            $(element).datetimebox('setValue', newValue);

        }
    }
};

ko.bindingHandlers.DeptValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var
        ctrl = String.format('<div class="input-group"><input type="text" class="form-control" readonly="readonly" data-bind="value:currentDept().DeptName" data-options="required:true" /><span class="input-group-btn"><button class="btn btn-default" data-bind="click:onDeptSelect" type="button" id="btnSelectPosition" >部门</button></span></div>');

        viewModel.onDeptSelect = function () {
            MainApp.ShowDialog(MainApp.GetUrl("Biz_HR_OrganizationService", "Get", "Biz_Select_OrgUnit.OrgView"), { isMulti: 0 }, function (data) {
                var val = valueAccessor();
                if (ko.isObservable(val)) {
                    val({ DeptId: data[0].Id, DeptName: data[0].Name });
                }
            });
        };

        $(ctrl).appendTo(element);


    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {

    }
};

ko.bindingHandlers.SwitchValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var
        onText = $(element).data("ontext") || "是",
        offText = $(element).data("offtext") || "否",
        title = $(element).data("title") || "",
        disabled = $(element).attr("disabled") || "";
        var allBindings = allBindingsAccessor();
        if (allBindings.disable != null) {
            disabled = ko.utils.unwrapObservable(allBindings.disable());
        }
        $(element).bootstrapSwitch(
        {
            onText: onText,
            offText: offText,
            state: ko.utils.unwrapObservable(valueAccessor()),
            disabled: disabled,
            onSwitchChange: function (event, state) {
                var val = valueAccessor();
                if (ko.isObservable(val)) {
                    val(state);
                }
            }
        });
        if (title != "") {

            var tip = String.format(' <i class="fa fa-question-circle fa-2x"  data-toggle="tooltip" data-placement="right" title="{0}"></i>', title);

            //$(tip).appendTo(element);
            $(element).parent().parent().after(tip);

        }
    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var newValue = ko.utils.unwrapObservable(valueAccessor());
        var elementValue = $(element).bootstrapSwitch('state');
        var valueHasChanged = (newValue != elementValue);
        if (valueHasChanged) {
            $(element).bootstrapSwitch('setState', newValue);
        }
    }
};

ko.bindingHandlers.BatchOpertion = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
         //debugger;
        var val = ko.utils.unwrapObservable(valueAccessor());
        var allBindings = allBindingsAccessor();

        // 是否允许批量
        var canBatch = false;
        var code = allBindings.code || "";
        var url = MainApp.GetUrl("BizPermission", "Post", "AppCanBatch");
        var postdata = { code: code };

        YarClient.AjaxPost(url, postdata, {
            success: function (returnData) {
                if (returnData.StatusCode === "Success") {
                    canBatch = returnData.Result;
                }
            },
            async: false
        });

        if (!val || !canBatch) {
            $(element).attr('display', 'none');
        }
        else {
            $(element).empty()
                      .attr('display', 'inline-block');

            // 是否允许退回
            var withdraw = $(element).data("withdraw") || false;
            var ctl = "";

            // 允许退回时增加批量退回按钮
            if (withdraw) {
                ctl = '<a href="javascript:;" name="approve" style="margin-right:5px" class="btn btn-sm btn-success" data-bind="click:batchOp.bind($data,0)"><i class="fa fa-thumbs-o-up"></i> 批量通过 </a><a href="javascript:;" style="margin-right:5px" class="btn btn-sm btn-danger" data-bind="click:batchOp.bind($data,4)" ><i class="fa fa-thumbs-o-down"></i>批量拒绝 </a><a href="javascript:;" style="margin-right:5px" class="btn btn-sm btn-danger" data-bind="click:batchOp.bind($data,2)" ><i class="fa fa-reply"></i>批量退回 </a>';
            } else {
                ctl = '<a href="javascript:;" style="margin-right:5px" class="btn btn-sm btn-success" data-bind="click:batchOp.bind($data,0)"><i class="fa fa-thumbs-o-up"></i> 批量通过 </a><a href="javascript:;" class="btn btn-sm btn-danger" data-bind="click:batchOp.bind($data,4)" ><i class="fa fa-thumbs-o-down"></i>批量拒绝 </a>';
            }

            viewModel.batchOp = function (actionType) {
                var
                gridId = this.uiSources.gridList.ops.ele,
                selectedItems = $(gridId).datagrid("getChecked"),
                self = this;

                if (selectedItems.length === 0) {
                    swal("操作失败..", "请先勾选待操作的申请单！", "warning");
                } else {
                    if (self.ApproveCheck && typeof self.ApproveCheck == "function") {
                        if (!self.ApproveCheck()) {
                            return false;
                        }
                    }

                    var actionName = "";
                    switch (actionType) {
                        case 0:
                            actionName = "通过";
                            break;
                        case 2:
                            actionName = "退回";
                            break;
                        case 4:
                            actionName = "拒绝";
                            break;
                        default:
                            actionName = "执行";
                            break;
                    };

                    swal({
                            title: "确认批量" + actionName + "审批么?",
                            text: "操作之后将不能还原！",
                            type: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "是的!",
                            closeOnConfirm: true
                        },
                        function () {
                            var idArray = new Array();
                            selectedItems.each(function (value, index) {
                                //                            if (value.Status && (value.Status ==="已提交" || value.Status==="审批中" )) {
                                //                                idArray.push(value.MasterRequestCode);
                                //                            }
                                idArray.push(value.MasterRequestCode);
                            });

                            var url = MainApp.GetUrl("BizPermission", "Post", "AppBatchAprove");
                            var postdata = { ids: idArray.join(';'), action: actionType };
                            YarClient.AjaxPost(url, postdata, {
                                IsWarning: true,
                                success: function (returnData) {
                                    swal("保存成功!", "您的审批意见已经提交", "success");
                                    if (typeof self.OnRefresh == "function") {
                                        if (actionType == 4 && self.OnApproveAllRejected && typeof self.OnApproveAllRejected == "function") {
                                            self.OnApproveAllRejected();
                                        }
                                        if (self.OnAfterBatchOperation && typeof self.OnAfterBatchOperation == "function") {
                                            self.OnAfterBatchOperation(idArray.join('|'));
                                        }
                                        self.OnRefresh();

                                    } else {
                                        $(gridId).datagrid('load');
                                    }

                                    $(gridId).datagrid('load');
                                }
                            });
                        });
                }
            };

            $(ctl).appendTo(element);
        }
    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        //debugger;
        var val = ko.utils.unwrapObservable(valueAccessor());
        var allBindings = allBindingsAccessor();

        // 是否允许批量
        var canBatch = false;
        var code = allBindings.code || "";
        var url = MainApp.GetUrl("BizPermission", "Post", "AppCanBatch");
        var postdata = { code: code };

        YarClient.AjaxPost(url, postdata, {
            success: function (returnData) {
                if (returnData.StatusCode === "Success") {
                    canBatch = returnData.Result;
                }
            },
            async: false
        });

        if (!val || !canBatch) {
            $(element).attr('display', 'none');
        }
        else {
            $(element).empty()
                      .attr('display', 'inline-block');
                      

            // 是否允许退回
            var withdraw = $(element).data("withdraw") || false;
            var ctl = "";

            // 允许退回时增加批量退回按钮
            if (withdraw) {
                ctl = '<a href="javascript:;" name="approve" style="margin-right:5px" class="btn btn-sm btn-success" data-bind="click:batchOp.bind($data,0)"><i class="fa fa-thumbs-o-up"></i> 批量通过 </a><a href="javascript:;" style="margin-right:5px" class="btn btn-sm btn-danger" data-bind="click:batchOp.bind($data,4)" ><i class="fa fa-thumbs-o-down"></i>批量拒绝 </a><a href="javascript:;" style="margin-right:5px" class="btn btn-sm btn-danger" data-bind="click:batchOp.bind($data,2)" ><i class="fa fa-reply"></i>批量退回 </a>';
            } else {
                ctl = '<a href="javascript:;" style="margin-right:5px" class="btn btn-sm btn-success" data-bind="click:batchOp.bind($data,0)"><i class="fa fa-thumbs-o-up"></i> 批量通过 </a><a href="javascript:;" class="btn btn-sm btn-danger" data-bind="click:batchOp.bind($data,4)" ><i class="fa fa-thumbs-o-down"></i>批量拒绝 </a>';
            }

            $(ctl).appendTo(element);
        }
    }
};

ko.bindingHandlers.SearchValue = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var
        placeholder = $(element).attr("placeholder"),
        width = $(element).attr("width"),
        bizName = $(element).data("biz"),
        action = $(element).data("action"),
        clickName = $(element).data("clickname"),
        dialog = $(element).data("dialog"),
        allowClear = $(element).data("allow-clear");

        var searchParam = {};

        if (allBindingsAccessor().SearchParam != undefined) {
            searchParam = allBindingsAccessor().SearchParam;
        }

        var ctl = $(element).select2({
            width: width,
            placeholder: placeholder,
            allowClear: allowClear,
            ajax: {
                url: MainApp.GetUrl(bizName, "Get", action, searchParam),
                dataType: 'json',
                type: "Get",
                delay: 250,
                onChange: function () {
                },
                data: function (params) {
                    return {
                        q: params.term, // search term
                        page: params.page
                    };
                },
                processResults: function (data, params) {
                    // parse the results into the format expected by Select2
                    // since we are using custom formatting functions we do not need to
                    // alter the remote JSON data, except to indicate that infinite
                    // scrolling can be used
                    params.page = params.page || 1;
                    return {
                        results: data.items,
                        pagination: {
                            more: (params.page * 10) < data.total_count
                        }
                    };
                },
                cache: true
            },
            escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
            minimumInputLength: 0,
            // initSelection: function (element, callback) {
            //     var initData = ko.utils.unwrapObservable(valueAccessor());
            //     if(initData){
            //         var newdata = {id:initData.id,text:initData.text};
            //         callback(newdata);
            //     }
            // }
        });

        var initData = ko.utils.unwrapObservable(valueAccessor());

        if (initData) {
            ctl.append(String.format('<option value={0}>{1}</option>', initData.id, initData.text));
            ctl.val(initData.id).trigger("change");
        }

        ctl.on("change", function () {
            if ($(this).val()) {
                var id = $(this).val();
                var text = $(this).select2("data")[0].text;
                var val = valueAccessor();

                if (ko.isObservable(val)) {
                    val({ id: id, text: text });
                }
            }
        });

        viewModel[clickName] = function () {
            MainApp.ShowDialog(MainApp.GetUrl(bizName, "Get", dialog, searchParam), {}, function (data) {
                var t = { id: (typeof data[0] != "undefined" ? data[0].Id : data.Id), text: (typeof data[0] != "undefined" ? data[0].Name : data.Name) };
                ctl.select2('val', null);
                ctl.append(String.format('<option value={0}>{1}</option>', t.id, t.text));
                ctl.val(t.id).trigger("change");
            });
        };

        if (dialog && clickName) {
            var btn = String.format(' <a href="javascript:;" class="gt2_btn_search" data-bind="click:{0}">选择</a>', clickName);

            $(element).parent().append(btn);
        }
    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {        
        var initData = ko.utils.unwrapObservable(valueAccessor());

        // 赋空值
        if (initData && initData.id == "") {
            $(element).val('').trigger("change");
        } else if (initData && initData.id && initData.text) {
            // 赋值
            var ctl = $(element);

            ctl.select2('val', null);
            ctl.append(String.format('<option value={0}>{1}</option>', initData.id, initData.text));
            ctl.val(initData.id).trigger("change");
        }
    }
};
