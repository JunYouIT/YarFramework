using System.Web;
using System.Web.Optimization;

namespace EnterpriseWebServer
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/respond.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css"));


            bundles.Add(new Bundle("~/CommonCss").Include("~/ApiViews/Scripts/fontcss/font-awesome.min.css", new CssRewriteUrlTransform())
                .Include("~/ApiViews/Scripts/fontcss/simple-line-icons.min.css", new CssRewriteUrlTransform())
                .Include(
                "~/ApiViews/Scripts/../Content/Site.css",
                "~/ApiViews/Scripts/bootstrap/bootstrap.min.css",
                "~/ApiViews/Scripts/bootstrap-switch/bootstrap-switch.min.css",
                 "~/ApiViews/Scripts/select2/select2.min.css",
                  "~/ApiViews/Scripts/select2/select2-bootstrap.css",
                       "~/ApiViews/Scripts/sweetalert/sweetalert.css")
                       );

            bundles.Add(new StyleBundle("~/DefaultAdminAppCss").Include(
                       "~/ApiViews/Scripts/BoostrapDialog/bootstrap-dialog.css")
                       .Include("~/ApiViews/Scripts/NiceValidator/jquery.validator.css", new CssRewriteUrlTransform())
                       .Include("~/ApiViews/Portal/DefaultAdmin/Content/components.css", new CssRewriteUrlTransform())
                       .Include("~/ApiViews/Portal/DefaultAdmin/Content/layout.css", new CssRewriteUrlTransform())
                       .Include("~/ApiViews/Portal/DefaultAdmin/Content/light.css", new CssRewriteUrlTransform())
                       .Include("~/ApiViews/Portal/DefaultAdmin/Content/custom.css", new CssRewriteUrlTransform())
                       );

            bundles.Add(new StyleBundle("~/HomeSiteAppCss").Include(
                       "~/ApiViews/Scripts/BoostrapDialog/bootstrap-dialog.css")
                       .Include("~/ApiViews/Scripts/NiceValidator/jquery.validator.css", new CssRewriteUrlTransform())
                       .Include("~/ApiViews/Portal/HomeSite/Content/components.css", new CssRewriteUrlTransform())
                       .Include("~/ApiViews/Portal/HomeSite/Content/layout.css", new CssRewriteUrlTransform())
                       .Include("~/ApiViews/Portal/HomeSite/Content/light.css", new CssRewriteUrlTransform())
                       .Include("~/ApiViews/Portal/HomeSite/Content/custom.css", new CssRewriteUrlTransform())
                       );

            bundles.Add(new Bundle("~/CommonJs").Include(
                        "~/ApiViews/Scripts/jquery.min.js",
                        "~/ApiViews/Scripts/jquery.json-2.4.min.js",
                        "~/ApiViews/Scripts/bootstrap/bootstrap.js",
                        "~/ApiViews/Scripts/js.cookie.min.js",
                        "~/ApiViews/Scripts/bootstrap-hover-dropdown.min.js",
                        "~/ApiViews/Scripts/bootstrap-switch/bootstrap-switch.min.js",
                        "~/ApiViews/Scripts/jquery.slimscroll.min.js",
                        "~/ApiViews/Scripts/jquery.blockui.min.js",
                        "~/ApiViews/Scripts/sweetalert/sweetalert.min.js",
                        "~/ApiViews/Scripts/select2/select2.full.min.js"
                        )
                        );
            bundles.Add(new ScriptBundle("~/DefaultAdminAppJs").Include(
                        "~/ApiViews/Scripts/BoostrapDialog/bootstrap-dialog.js",
                        "~/ApiViews/Scripts/NiceValidator/jquery.validator.js",
                        "~/ApiViews/Scripts/NiceValidator/local/zh-CN.js",
                        "~/ApiViews/Scripts/global.js",
                        "~/ApiViews/Portal/DefaultAdmin/Content/metronic.js",
                        "~/ApiViews/Portal/DefaultAdmin/Content/layout.js",
                        "~/ApiViews/Portal/DefaultAdmin/Content/AdminBoostrap.js"
                        )
                        );
            bundles.Add(new ScriptBundle("~/HomeSiteAppJs").Include(
                        "~/ApiViews/Scripts/BoostrapDialog/bootstrap-dialog.js",
                        "~/ApiViews/Scripts/NiceValidator/jquery.validator.js",
                        "~/ApiViews/Scripts/NiceValidator/local/zh-CN.js",
                        "~/ApiViews/Scripts/global.js",
                        "~/ApiViews/Portal/HomeSite/Content/metronic.js",
                        "~/ApiViews/Portal/HomeSite/Content/layout.js",
                        "~/ApiViews/Portal/HomeSite/Content/AdminBoostrap.js"
                        )
                        );

            bundles.Add(new StyleBundle("~/PersonalHomeCss").Include(
                       "~/ApiViews/Portal/DefaultAdmin/Content/profile.css", "~/ApiViews/Scripts/NiceValidator/jquery.validator.css")
                       );
            bundles.Add(new ScriptBundle("~/bundles/PersonalHomeJs").Include(
                        "~/ApiViews/Scripts/NiceValidator/jquery.validator.js?local=zh-CN",
                        "~/ApiViews/Portal/DefaultAdmin/Content/metronic.js",
                        "~/ApiViews/Portal/DefaultAdmin/Content/layout.js",
                        "~/ApiViews/Portal/DefaultAdmin/Content/AdminBoostrap.js"
                        )
                        );

            bundles.Add(new ScriptBundle("~/UploadJs").Include(
                        "~/ApiViews/Scripts/JQueryFileUpload/jquery.ui.widget.js",
                        "~/ApiViews/Scripts/JQueryFileUpload/jquery.fileupload.js",
                        "~/ApiViews/Scripts/JQueryFileUpload/jquery.fileupload-process.js",
                        "~/ApiViews/Scripts/JQueryFileUpload/jquery.fileupload-validate.js",
                        "~/ApiViews/Scripts/JQueryFileUpload/jquery.iframe-transport.js",
                        "~/ApiViews/Scripts/JQueryFileUpload/UploadHelper.js"
                        )
                        );


            bundles.Add(new StyleBundle("~/PageCommonCss")
                      .Include("~/ApiViews/Scripts/easyui-1.5.1/themes/bootstrap/easyui.css", new CssRewriteUrlTransform())
                      .Include("~/ApiViews/Scripts/easyuiextend.css", new CssRewriteUrlTransform())
                      .Include("~/ApiViews/Scripts/bootstrap-table/bootstrap-table.css", new CssRewriteUrlTransform())
                      .Include("~/ApiViews/Scripts/bootstrap-table/bootstrap-table-extend.css", new CssRewriteUrlTransform())
                      .Include("~/ApiViews/Scripts/bootstrap-datepicker/css/bootstrap-datepicker.css", new CssRewriteUrlTransform())
                       .Include("~/ApiViews/Scripts/JQueryFileUpload/jquery.fileupload.css", new CssRewriteUrlTransform())
                      );
            bundles.Add(new Bundle("~/PageCommonJs").Include(
                        "~/ApiViews/Scripts/knockout-3.4.1.js",
                        "~/ApiViews/Scripts/knockout.mapping.js",
                        "~/ApiViews/Scripts/easyui-1.5.1/jquery.easyui.min.js",
                        "~/ApiViews/Scripts/easyui-1.5.1/locale/easyui-lang-zh_CN.js",
                        "~/ApiViews/Scripts/bootstrap-table/bootstrap-table.js",
                        "~/ApiViews/Scripts/bootstrap-table/locale/bootstrap-table-zh-CN.min.js",
                        "~/ApiViews/Scripts/bootstrap-datepicker/js/bootstrap-datepicker.js",
                        "~/ApiViews/Scripts/bootstrap-datepicker/js/bootstrap-datepicker.zh-CN.js"
                        )
                        );
            bundles.Add(new ScriptBundle("~/PageJs").Include(
                        "~/ApiViews/Scripts/JQueryFileUpload/jquery.ui.widget.js",
                        "~/ApiViews/Scripts/JQueryFileUpload/jquery.fileupload.js",
                        "~/ApiViews/Scripts/JQueryFileUpload/jquery.fileupload-process.js",
                        "~/ApiViews/Scripts/JQueryFileUpload/jquery.fileupload-validate.js",
                        "~/ApiViews/Scripts/JQueryFileUpload/jquery.iframe-transport.js",
                        "~/ApiViews/Scripts/JQueryFileUpload/UploadHelper.js",
                        "~/ApiViews/Scripts/Yar.Common.js",
                        "~/ApiViews/Scripts/Yar.Dialog.js",
                        "~/ApiViews/Scripts/easyuiextend.js",
                        "~/ApiViews/Scripts/knockoutextend.js"
                        )
                        );
            bundles.Add(new Bundle("~/PageMainJs").Include(
                        "~//ApiViews/Scripts/PageMainApp.js"
                        )
                        );
        }
    }
}
