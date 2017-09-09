var AdminBoostrap = function () {
    var OnSelectMenu = function (id) {
        if (!id)
            return;
        var item = $(id);
        var menuContainer = $('.page-sidebar ul');
        menuContainer.children('li.active').removeClass('active');
        menuContainer.children('arrow.open').removeClass('open');

        item.parents('li').each(function () {
            item.addClass('active');
            item.children('a > span.arrow').addClass('open');
        });
        item.parents('li').addClass('active');
    };
    var csrfInstall = function () {              
        $.ajaxPrefilter(function (options, originalOptions, jqXHR) {
            var originalComplete = options.complete;
            options.complete = function (xhr, data) {
                if (xhr.getResponseHeader('REQUIRES_LOGIN') === '1') {
                    xhr.abort();
                    document.write(xhr.responseText);
                } else if (originalComplete) {
                    originalComplete(xhr, data);
                }                       
            };
            if (options.type.toUpperCase() === "POST") {
                var token = $("input[name^=_crsfToken]").first();
                if (!token.length) return;
                
                jqXHR.setRequestHeader(
                       '_crsfToken', token.val()
                    );                            
            }
        });       
    };
    return {
        init: function (defaultviewId) {
            OnSelectMenu(defaultviewId);
            csrfInstall();
        },
        SwitchLegal: function(id) {
            global.AjaxGet(global.GetActionUrl('_BizPermissionService', 'SwitchLegal', { resId: id }), {
                success: function (returnData) {
                    window.location.reload();
                }
            });
        }
    };
}();