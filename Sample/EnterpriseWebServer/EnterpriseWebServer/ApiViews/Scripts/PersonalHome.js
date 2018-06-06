

jQuery(document).ready(function () {
    var userPhotoId = $('#personalhome_userimg').attr('photeId');
    if (userPhotoId && userPhotoId != '00000000-0000-0000-0000-000000000000') {
        $('#personalhome_userimg').attr('src', global.GetActionUrl("_BizAttachmentService", "GetAttachment", { AttachmentId: userPhotoId }));
    } else {
        $('#personalhome_userimg').attr('src', '/ApiViews/Content/images/noman.jpg');
    } 
    $('#personalhome_changepwd').click(function () {
        MainApp.ShowDialog(global.GetActionUrl("_BizPermissionService", "ChangePasswordView"), {},
            function (data) {
            });
    });
});