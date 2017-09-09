using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Yar.Core;

namespace EnterpriseWebServer
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {

            YarSystem.Init(YarSystem.AppModelEnum.Web, Server.MapPath("~/"), null);
            var site = System.Web.Hosting.HostingEnvironment.ApplicationHost.GetVirtualPath();
            YarSystem.Current.ViewSite = site.TrimEnd('/');
            YarSystem.WriteLog("--------------------------------------------");
            YarSystem.Current.Start();

            Yar.Service.HttpApi.HttpApiServerUtils.RegisterWebApiForAspNet(GlobalConfiguration.Configuration);
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            if (YarSystem.Current.AppSettings["runtype"] == "release")
            {
                BundleTable.EnableOptimizations = true;
            }
            BundleConfig.RegisterBundles(BundleTable.Bundles);

        }
    }
}
