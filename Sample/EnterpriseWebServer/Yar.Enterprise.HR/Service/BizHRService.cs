using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Yar.EnterpriseCommon.Biz;
using Yar.EnterpriseService.Enterprise;
using Yar.EnterpriseService.Modal;
using Yar.EnterpriseCommon.Extend;
using Yar.Enterprise.HR.Modal;
using Yar.Service.Exceptions;
using System.Data.Entity;
using Yar.Service;
using Yar.Service.Permission;
using Yar.Enterprise.HR.Biz.Common;


namespace Yar.Enterprise.HR.Service
{
    public class BizHRService : BizEnterpriseCommonBase, IBizHRService
    {
        public BizHRService()
        {
            this.BusinessType = Yar.Service.BusinessType.Public;
            this.AddSubBiz("Biz_Select_OfficeArea", new Biz_Select_OfficeArea());
            
        }

        public SelectItem GetOfficeArea(Guid? areaId)
        {
            if (areaId == null || areaId == Guid.Empty) return new SelectItem();
            var tenantId = this.GetCurrentCredential().TenantGuid();
            using (var dc = new HRDbContext())
            {
                var query = dc.HR_EMP_OfficeArea.Where(c => c.TenantID == tenantId && c.AreaID == areaId.Value);
                var item = query.FirstOrDefault();
                if(item == null ) return new SelectItem();
                return new SelectItem { ID = item.AreaID.ToString(), Name = item.AreaName,Code = item.AreaCode };                
            }
        }

        public List<SelectItem> GetOfficeAreas(List<Guid> areaIds)
        {
            var list = new List<SelectItem>();
            if (areaIds == null || areaIds.Count == 0) return list;
            var tenantId = this.GetCurrentCredential().TenantGuid();
            using (var dc = new HRDbContext())
            {
                var query = dc.HR_EMP_OfficeArea.Where(c => c.TenantID == tenantId && areaIds.Contains(c.AreaID));
                var items = query.Select(item => new SelectItem { ID = item.AreaID.ToString(), Name = item.AreaName, Code = item.AreaCode }).ToList();
                return items;                
            }
        }

        public List<SelectItem> GetAllOfficeAreas()
        {
            var tenantId = this.GetCurrentCredential().TenantGuid();
            using (var dc = new HRDbContext())
            {
                var query = dc.HR_EMP_OfficeArea.Where(c => c.TenantID == tenantId);
                var items = query.Select(item => new SelectItem { ID = item.AreaID.ToString(), Name = item.AreaName, Code = item.AreaCode }).ToList();
                return items;
            }
        }
    }
}
