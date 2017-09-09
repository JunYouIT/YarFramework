var Register = function () {
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
        Register: function () {
            debugger;
            var that = this;
            $("#btnCreate").attr("disabled", "disabled");
            $('form').isValid(function (v) {
                debugger;
                if (v) {
                    var tenantId = $("#tenantId").val();
                    $.ajax({
                        url: that.baseUrl + "Auth/Register/Create",
                        headers: {
                            '_crsfToken': $("input[name^=_crsfToken]").first().val(),
                        },
                        type: 'POST',
                        data: $.toJSON({ TenantCode: $("#tenantId").val(), TenantName: $("#tenantName").val() }),
                        cache: false,
                        dataType: "text",
                        success: function (text) {
                            debugger;
                            var data = eval('(' + text + ')');
                            if (data.StatusCode == "Success") {
                                swal({
                                    title: "租户创建成功!",
                                    text: "您可使用<span style='color:red;'>admin@" + tenantId.toLowerCase() + ".com</span> 密码:<span style='color:red;'>111111</span> 登陆",
                                    html: true,
                                    type: "success",
                                    showCancelButton: false,
                                },
                                    function () {
                                        window.location.href = "/Auth/Login";
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
                Register.baseUrl = bUrl;
            }
            if (sysId) {
                Register.sysId = sysId;
            }
            $("#btnCreate").click(function () {
                Register.Register();
            });        
        }
    };
}();




    