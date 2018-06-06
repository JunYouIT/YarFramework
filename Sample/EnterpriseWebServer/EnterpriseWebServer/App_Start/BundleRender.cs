using RazorEngine.Text;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Yar.Service
{
    public static class BundleRender
    {
        public static IEncodedString RenderFormat(string bundleName)
        {
            var scriptstring = System.Web.Optimization.Scripts.RenderFormat("{0}", bundleName).ToHtmlString();
            var list = scriptstring.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries).ToList();
            var script = string.Join(",", list.Select(s => string.Format("'{0}'", s)).ToArray());
            return new RawString(script);
        }

        public static IEncodedString RenderCss(string bundleName)
        {
            var scriptstring = System.Web.Optimization.Scripts.RenderFormat("{0}", bundleName).ToHtmlString();
            var list = scriptstring.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries).ToList();
            var script = string.Join("\r\n", list.Select(s => string.Format("<link href='{0}' rel='stylesheet' type='text/css'>", s)).ToArray());
            return new RawString(script);
        }

        public static IEncodedString RenderScript(string bundleName)
        {
            var scriptstring = System.Web.Optimization.Scripts.RenderFormat("{0}", bundleName).ToHtmlString();
            var list = scriptstring.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries).ToList();
            var script = string.Join("\r\n", list.Select(s => string.Format("<script src='{0}' type='text/javascript' ></script>", s)).ToArray());
            return new RawString(script);
        }
    }
}