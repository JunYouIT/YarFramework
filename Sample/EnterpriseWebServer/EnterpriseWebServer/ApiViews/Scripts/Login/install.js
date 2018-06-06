var Install = function () {
    return {
        baseUrl: '../',
        sysId:'',
        getUrlVars: function () {
            var vars = {};
            var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi,
            function (m, key, value) {
                vars[key] = decodeURIComponent(value);
            });
            return vars;
        },
        Install: function () {
            //debugger;
            var that = this;
            $("#btnCreate").attr("disabled", "disabled");
            $('form').isValid(function (v) {
                //debugger;
                if (v) {
                    var tenantId = $("#tenantId").val();
                    $.ajax({
                        url: that.baseUrl + "Auth/Install/Create",
                        headers: {
                            '_crsfToken': $("input[name^=_crsfToken]").first().val(),
                        },
                        type: 'POST',
                        data: $.toJSON({ TenantCode: $("#tenantId").val(), TenantName: $("#tenantName").val(), ConnectString: $("#connectString").val()}),
                        cache: false,
                        dataType: "text",
                        success: function (text) {
                            //debugger;
                            var data = eval('(' + text + ')');
                            if (data.StatusCode == "Success") {
                                swal({
                                    title: "安装成功!",
                                    text: "请登录系统",
                                    html: true,
                                    type: "success",
                                    showCancelButton: false,
                                },
                                    function () {
                                        window.location.href = "/Auth/Login?starturl=/Admin";
                                    });
                            }
                            else {
                                $('#txError').text(data.Message);
                                $("#btnCreate").removeAttr("disabled");
                            }
                                
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#txError').text(jqXHR.responseText);
                           $("#btnCreate").removeAttr("disabled");
                        }
                    });
                } else {
                    $("#btnCreate").removeAttr("disabled");
                }
            });
            
        },
        init: function (bUrl,sysId) {
            if (bUrl) {
                Install.baseUrl = bUrl;
            }
            if (sysId) {
                Install.sysId = sysId;
            }
            $("#btnCreate").click(function () {
                Install.Install();
            });        
        }
    };
}();




    