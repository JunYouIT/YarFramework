using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Yar.EnterpriseCommon.Biz;
using Yar.Service;
using Yar.EnterpriseCommon.Extend;
using Yar.BizModule.Model;
using Yar.Enterprise.HR.Modal;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
namespace Yar.Enterprise.HR.Biz.Common
{
    class Biz_Select_OfficeArea : BizEnterpriseCommonBase
    {
        /// <summary>
        /// 选择区域对话框
        /// 参数无（根据当前人所属的法人得到当前组织机构）
        /// 返回数据
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public BusinessResult OfficeAreaView(BusinessContext context)
        {
            return this.View(@"Enterprise\HR\Common\_fmSelectOfficeArea.cshtml", new { Context = context, BizId = this.ViewModel.Model.BizId });
        }

        public BusinessResult AreasView(BusinessContext context)
        {
            return this.View(@"CIIC\Fm\Common\_fmSelectArea.cshtml", new { Context = context, BizId = this.ViewModel.Model.BizId });
        }

        public BusinessResult GetOfficeAreaData(BusinessContext context)//不考虑法人
        {
            //var legalId = context.Credential.LegalGuid();
            //var tenantId = context.Credential.TenantGuid();
            var areaname = context.Request["areaname"];
            var areacode = context.Request["areacode"];
            using (var dbContect = new HRDbContext())
            {
                var query = from area in dbContect.HR_EMP_OfficeArea
                            where area.IsDeleted == false && area.IsUse == true /*.TenantID == tenantId && area.LegalEntityID == legalId*/
                            select new
                            {
                                area.AreaID,
                                area.AreaCode,
                                area.AreaName,
                                area.DetailAddress,
                                area.CreateTime
                            };
                if (!string.IsNullOrEmpty(areaname))
                {
                    query = query.Where(u => u.AreaName.Contains(areaname));
                }
                if (!string.IsNullOrEmpty(areacode))
                {
                    query = query.Where(u => u.AreaCode.Contains(areacode));
                }
                int total = 0;
                query = BizHelper.GetPageQuery(context, query.OrderBy(g => g.CreateTime), out total);
                return this.OK(new { total = total, rows = query.ToArray() });
                //return this.OK(new { total = total, rows = new List<dynamic> { new {
                //    EmployeeID = "B31E66F4-2E66-4C55-8957-1A50280F9696",
                //    EmployeeNameCN = "赵六",
                //    EmployeeNumber = "123",
                //    IsMain = false
                //} } });
            }

        }
    }
}
