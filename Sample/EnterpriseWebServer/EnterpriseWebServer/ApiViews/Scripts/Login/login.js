var Login = function () {
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
        setCookie: function (name, value, hours, path) {
            var name = escape(name);
            var value = escape(value);
            var expires = new Date();
            expires.setTime(expires.getTime() + hours * 3600000);
            path = path == "" ? "" : ";path=" + path;
            _expires = (typeof hours) == "string" ? "" : ";expires=" + expires.toUTCString();
            document.cookie = name + "=" + value + _expires + path;
        },
        getCookieValue: function (name) {
            
            var name = escape(name);
            //读cookie属性，这将返回文档的所有cookie
            var allcookies = document.cookie;
            //查找名为name的cookie的开始位置
            name += "=";
            var pos = allcookies.indexOf(name);
            //如果找到了具有该名字的cookie，那么提取并使用它的值
            if (pos != -1) {                                             //如果pos值为-1则说明搜索"version="失败
                var start = pos + name.length;                  //cookie值开始的位置
                var end = allcookies.indexOf(";", start);        //从cookie值开始的位置起搜索第一个";"的位置,即cookie值结尾的位置
                if (end == -1) end = allcookies.length;        //如果end值为-1说明cookie列表里只有一个cookie
                var value = allcookies.substring(start, end); //提取cookie的值
                return unescape(value);                           //对它解码      
            }
            else return "";                               //搜索失败，返回空字符串
        },
        deleteCookie: function (name, path) {
            var name = escape(name);
            var expires = new Date(0);
            path = path == "" ? "" : ";path=" + path;
            document.cookie = name + "=" + ";expires=" + expires.toUTCString() + path;
        },
        Login: function () {
            //debugger;
            if ($('#saveCookie').is(":checked")) {
                this.setCookie(this.sysId + "_userName", $("#Username").val(), 24, "/");
            }
            else {
                this.deleteCookie(this.sysId + '_userName', '/');
            }
     
            var params = this.getUrlVars();
            var starturl = params['starturl'];
            if (!starturl) {
                starturl = this.baseUrl;
            }
            $.ajax({
                url: this.baseUrl + "RestAPI/EnterprisePermission/Login",
                type: 'POST',
                data: $.base64.encode($.toJSON({ LoginName: $("#Username").val(), Password: hex_md5($("#Password").val()), ClientInfo: "" }), true),
                cache: false,
                dataType: "text",
                success: function (text) {
                    var data = eval('(' + text + ')');
                    if (data.StatusCode == "Success") {
                        window.location.href = starturl;
                    }
                    else
                        $('#txError').text(data.Message);
                },
                error: function () {

                }
            });
        },
        init: function (bUrl,sysId) {
            if (bUrl) {
                Login.baseUrl = bUrl;
            }
            if (sysId) {
                Login.sysId = sysId;
            }
            $("#btnOk").click(function () {
                Login.Login();
            });
            var userName = this.getCookieValue(Login.sysId + "_" + "userName");
            if (userName) {
                $("#Username").val(userName);
                $("#Password").focus();
            }
            else {
                $("#Username").focus();
            }
        }
    };
}();




    