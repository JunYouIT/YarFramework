
function ShowUploadTip() {
    return '仅允许上传小于5M的文件，允许的文件类型为：图片(bmp,gif,jpg,png);文档(doc,docx,xls,xlsx,ppt,pptx,pdf,zip);';
}

function AttachmentUpload(self, $inputObj, legalId, formId, requestTypeCode, attachmentTypeCode, successCallback, acceptFileTypes) {

    var isLteIe9 = false;
    //检测是否低于IE10
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
        var isOpera = userAgent.indexOf("Opera") > -1; //判断是否Opera浏览器  
        var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器 

        if (isIE) {
            var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
            reIE.test(userAgent);
            var fIEVersion = parseFloat(RegExp["$1"]);
            if (fIEVersion < 10)
                isLteIe9 = true;
        }
        if (acceptFileTypes === 'imgages')
            acceptFileTypes = /(\.|\/)(bmp|gif|jpe?g|png)$/i;
        else
            acceptFileTypes = /(\.|\/)(bmp|gif|jpe?g|png|zip|docx?|xlsx?|pptx?|ppsx?|pdf)$/i;

        var url = self.ViewTool.GetActionUrl("Post", "SaveAttachment", { _crsfToken: $("input[name^=_crsfToken]").first().val(), InputName: $inputObj.attr('name'), LegalId: legalId, FormId: formId, RequestTypeCode: requestTypeCode, AttachmentTypeCode: attachmentTypeCode });
    //$inputObj.attr('Accept', 'image/bmp, image/gif, image/jpeg, image/png, image/tif, application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.openxmlformats-officedocument.presentationml.slideshow, application/vnd.openxmlformats-officedocument.presentationml.presentation,application/vnd.ms-powerpoint, application/zip, application/pdf')
    $inputObj.fileupload({
        url: url,
        replaceFileInput: true,
        forceIframeTransport: isLteIe9,
        iframe: isLteIe9,
        dropZone: undefined,
        multipart: true,
        autoUpload: true,
        maxFileSize: 1024 * 1024 * 5, //限制文件大小为5M
        acceptFileTypes: acceptFileTypes, //限制文件类型
        dataType: 'json',
        formData: { },
        messages: {
            maxNumberOfFiles: 'Maximum number of files exceeded',
            acceptFileTypes: '该文件类型不允许上传',//'File type not allowed',
            maxFileSize: '文件大小超过限制',//'File is too large',
            minFileSize: '文件太小'//'File is too small'
        },
        change: function (e, data) {
            $.messager.progress({
                title: '正在上传文件，请稍侯',
                msg: '上传文件',
                text: 'PROCESSING.......'
            });
        },
        done: function (e, data) {

            $.messager.progress('close');
            if (data.result.StatusCode == "Success") {
                if ($.isFunction(successCallback))
                    successCallback(data.result); 
                //$.messager.alert('Message', data.result.Message, 'info');
            } else {
                $.messager.alert('Message', data.result.Message, 'error');
            }

        },
        fail: function (e, data) {
            //debugger;
            $.messager.progress('close');
            $.messager.alert('Message', 'errMsg', 'error');
        }
        , processfail: function (e, data) {
            //debugger;
            $.messager.progress('close');
            $.messager.alert('Message', data.files[0].error, 'error');
        }
    });
}

; (function (factory) {
    if ('function' === typeof define && (define.amd || define.cmd)) {
        // Register as an anonymous module.
        define([], function () {
            return factory;
        });
    } else {
        factory(jQuery);
    }
}(function ($, undefined) {
    $.Yar = $.Yar || {};
    var YarAttachment = {};
    YarAttachment.ShowUploadTip = function() {
        return '仅允许上传小于5M的文件，允许的文件类型为：图片(bmp,gif,jpg,png);文档(doc,docx,xls,xlsx,ppt,pptx,pdf,zip);';
    };
    YarAttachment.AttachmentUpload = function ($inputObj, legalId, formId, requestTypeCode, attachmentTypeCode, successCallback, acceptFileTypes) {

        var isLteIe9 = false;
        //检测是否低于IE10
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
        var isOpera = userAgent.indexOf("Opera") > -1; //判断是否Opera浏览器  
        var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器 

        if (isIE) {
            var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
            reIE.test(userAgent);
            var fIEVersion = parseFloat(RegExp["$1"]);
            if (fIEVersion < 10)
                isLteIe9 = true;
        }
        if (acceptFileTypes === 'imgages')
            acceptFileTypes = /(\.|\/)(bmp|gif|jpe?g|png)$/i;
        else
            acceptFileTypes = /(\.|\/)(bmp|gif|jpe?g|png|zip|docx?|xlsx?|pptx?|ppsx?|pdf)$/i;
        var url = global.GetActionUrl("_BizAttachmentService", "SaveAttachment", { _crsfToken: $("input[name^=_crsfToken]").first().val(), InputName: $inputObj.attr('name'), LegalId: legalId, FormId: formId, RequestTypeCode: requestTypeCode, AttachmentTypeCode: attachmentTypeCode });
        //$inputObj.attr('Accept', 'image/bmp, image/gif, image/jpeg, image/png, image/tif, application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.openxmlformats-officedocument.presentationml.slideshow, application/vnd.openxmlformats-officedocument.presentationml.presentation,application/vnd.ms-powerpoint, application/zip, application/pdf')
        $inputObj.fileupload({
            url: url,
            replaceFileInput: true,
            forceIframeTransport: isLteIe9,
            iframe: isLteIe9,
            dropZone: undefined,
            multipart: true,
            autoUpload: true,
            maxFileSize: 1024 * 1024 * 5, //限制文件大小为5M
            acceptFileTypes: acceptFileTypes, //限制文件类型
            dataType: 'json',
            formData: {},
            messages: {
                maxNumberOfFiles: 'Maximum number of files exceeded',
                acceptFileTypes: '该文件类型不允许上传',//'File type not allowed',
                maxFileSize: '文件大小超过限制',//'File is too large',
                minFileSize: '文件太小'//'File is too small'
            },
            change: function (e, data) {
                $.messager.progress({
                    title: '正在上传文件，请稍侯',
                    msg: '上传文件',
                    text: 'PROCESSING.......'
                });
            },
            done: function (e, data) {

                $.messager.progress('close');
                if (data.result.StatusCode == "Success") {
                    if ($.isFunction(successCallback))
                        successCallback(data.result);
                    //$.messager.alert('Message', data.result.Message, 'info');
                } else {
                    $.messager.alert('Message', data.result.Message, 'error');
                }

            },
            fail: function (e, data) {
                //debugger;
                $.messager.progress('close');
                $.messager.alert('Message', 'errMsg', 'error');
            }
            , processfail: function (e, data) {
                //debugger;
                $.messager.progress('close');
                $.messager.alert('Message', data.files[0].error, 'error');
            }
        });
    };
    $.Yar.Attachement = YarAttachment;
}));