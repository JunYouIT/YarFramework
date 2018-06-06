using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Linq.Dynamic;
using Yar.Service;
using Yar.EnterpriseCommon.Biz;
using Yar.EnterpriseCommon.DataFilter;
using Yar.EnterpriseCommon.Extend;
using Yar.Enterprise.HR.Modal;
using System.Transactions;
using Newtonsoft.Json.Linq;
using Yar.EnterpriseService.Enterprise;

namespace Yar.Enterprise.HR.Biz
{
    /// <summary>
    /// 办公区域
    /// </summary>
    public class Biz_HR_OfficeArea : BizEnterpriseEntityBase<HRDbContext, HR_EMP_OfficeArea>
    {
        public Biz_HR_OfficeArea() : base("HR_EMP_OfficeArea")
        {
            this.ViewModel.Model.DataModels.Add(new DataModel
            {
                ResName = "HR_EMP_OfficeArea",
                KeyId = "AreaID",
                ResField = "AreaID",
                ResFieldType = "System.Guid",
                UpdateFields = "AreaID,AreaCode,AreaName,StartTime,IsUse,Country,Province,City,District,OtherAddress,DetailAddress,ZipCode,Memo,CreateTime,CreateUserID,UpdateTime,UpdateUserID,IsDeleted,LegalEntityID,TenantID"

            });
            this.ViewModel.Model.ViewModels.Add(new ViewModel
            {
                Explorer = @"Enterprise\HR\OfficeArea\View_OfficeArea.cshtml",
                CreateView = @"Enterprise\HR\OfficeArea\_fm_OfficeArea_Edit.cshtml",
                EditView = @"Enterprise\HR\OfficeArea\_fm_OfficeArea_Edit.cshtml",
                PreviewView = @"Enterprise\HR\OfficeArea\_fm_OfficeArea_Preview.cshtml"
            });
            this.DataFilterFields[DataFilterConstants.GlobalLegalField] = "";
        }

        protected override object ResourceListHander(DbContext objectContext, BusinessContext context, IQueryable<dynamic> objectSet)
        {
            var dbContext = objectContext as HRDbContext;
            var areaname = context.Request["areaname"]; // 区域名称
            var detailaddress = context.Request["detailaddress"]; // 区域位置在详细地址中模糊查询
            var starttime_start = context.Request["starttime_start"]; // 启用时间：时间区间的开始时间
            var starttime_end = context.Request["starttime_end"]; // 启用时间：时间区间的结束时间
            var usestatus = context.Request["usestatus"]; // 状态()
            var AreaSize_start = context.Request["AreaSize_start"]; // 办公面积
            var AreaSize_end = context.Request["AreaSize_end"]; // 办公面积
            var deletetatus = context.Request["deletetatus"]; // 删除状态()

            var legalId = context.Credential.LegalGuid();

            var query = objectSet.Cast<HR_EMP_OfficeArea>().Where(p => p.LegalEntityID == legalId);
            //根据筛选条件进行筛选
            if (!string.IsNullOrEmpty(areaname))//区域名称筛选
            {
                query = query.Where(g => g.AreaName.Contains(areaname.Trim()));
            }

            if (!string.IsNullOrEmpty(detailaddress))//详细地址筛选
            {
                query = query.Where(g => g.DetailAddress.Contains(detailaddress.Trim()));
            }

            if (!string.IsNullOrEmpty(usestatus))//状态筛选
            {
                query = query.Where(g => g.IsUse == (usestatus == "0" ? false : true));
            }

            if (!string.IsNullOrEmpty(AreaSize_start))//办公面积
            {
                decimal sizestart = Convert.ToDecimal(AreaSize_start);
                query = query.Where(g => g.AreaSize >= sizestart);
            }
            if (!string.IsNullOrEmpty(AreaSize_end))//办公面积
            {
                decimal sizeend = Convert.ToDecimal(AreaSize_end);
                query = query.Where(g => g.AreaSize <= sizeend);
            }

            DateTime time_start;
            DateTime time_end;

            if (!string.IsNullOrEmpty(starttime_start))//启用时间按区间查询
            {
                DateTime.TryParse(starttime_start.Trim(), out time_start);
                query = query.Where(g => g.StartTime >= time_start);
            }
            if (!string.IsNullOrEmpty(starttime_end))//启用时间按区间查询
            {
                DateTime.TryParse(starttime_end.Trim(), out time_end);
                query = query.Where(g => g.StartTime <= time_end);
            }

            if (!string.IsNullOrEmpty(deletetatus) && deletetatus != "-1")//区域名称筛选
            {
                var delstatus = deletetatus == "1" ? true : false;
                query = query.Where(g => g.IsDeleted == delstatus);
            }
            query = query.OrderByDescending(g => g.CreateTime);//.Where(g => !g.IsDeleted) 显示所有区域并可按删除状态搜索
            //******************权限暂不作处理**********************

            Dictionary<bool, string> dicUseStatus = new Dictionary<bool, string>();//状态
            dicUseStatus.Add(true, "可用");
            dicUseStatus.Add(false, "不可用");

            var nq = query.Select(g => new
            {
                Id = g.AreaID,
                g.AreaName,
                g.AreaCode,
                g.DetailAddress,
                g.StartTime,
                g.IsUse,
                g.AreaSize,
                g.CreateTime,
                g.IsDeleted
            });

            var sort = context.Request["sort"];
            var order = context.Request["order"];
            if (string.IsNullOrEmpty(sort))
            {
                nq = nq.OrderByDescending(g => g.CreateTime);
            }
            else
            {
                nq = nq.OrderBy(string.Format("it.{0} {1}", sort, order));
            }

            int total;
            nq = this.UpdateDataPrivilege(context, nq);
            nq = GetPageQuery(context, nq, out total);

            return new
            {
                total = total,
                rows = nq.ToArray().Select(
                    s => new
                    {
                        s.Id,
                        s.AreaCode,
                        s.AreaName,
                        s.DetailAddress,
                        AreaSize = s.AreaSize + "㎡",
                        StartTime = s.StartTime.ToString("yyyy-MM-dd"),
                        IsUse = dicUseStatus[s.IsUse],
                        IsDeleted = s.IsDeleted == true ? "已删除" : "未删除",
                    })
            };
        }

        protected override object GetViewData(BusinessContext context)
        {
            var delstatusdatasour = new List<dynamic> {
                new { ID = "-1", Name = "请选择" },
                new { ID = "1", Name = "已删除" },
                new { ID = "0", Name = "未删除" }
            };
            var data = new
            {
                dataSources = new
                {
                    dsType = GetTypeList(),
                    dsDeleteStatus = delstatusdatasour
                }
            };
            return JsonHelper.Serialize(data, true);
        }

        protected override void FalseDeleteHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            item.IsDeleted = true;
            item.UpdateTime = DateTime.Now;
            item.UpdateUserID = context.Credential.UserGuid();
        }

        #region [create/edit method]

        protected override void InitCreateViewModel(DbContext objectContext, BusinessContext context, object dbitem)
        {
            var model = dbitem as HR_EMP_OfficeArea;
            model.Country = "中国";//默认为中国
            model.Province = "";
            model.OtherAddress = "";
            model.StartTime = DateTime.Now;
            model.IsUse = true;
        }

        protected override dynamic GetViewModelData(DbContext objectContext, BusinessContext context, object dbitem)
        {
            var item = dbitem as HR_EMP_OfficeArea;

            var statusdatasour = new List<dynamic> {
                new { ID = true, Name = "可用" },
                new { ID = false, Name = "不可用" }
            };
            
            if (item.AreaID == Guid.Empty)
            {
                return new
                {
                    form = new
                    {
                        ResId = item.AreaID,
                        AreaCode = "",
                        AreaName = "",
                        Country = item.Country,
                        Province = "",
                        //City = item.City,
                        //District = item.District,
                        OtherAddress = "",
                        DetailAddress = "",
                        ZipCode = "",
                        IsUse = item.IsUse,
                        StartTime = item.StartTime.ToShortDateString(),
                        Memo = "",
                        AreaSize = 0.00
                    },
                    dataSources = new
                    {
                        UseStatus = statusdatasour,
                    }
                };
            }
            else
            {
                var permissionService = this.GetBizService<IBizPermissionService>();
                var createuser = permissionService.GetUserName(item.CreateUserID);
                var udpateuser = permissionService.GetUserName(item.UpdateUserID);
                return new
                {
                    form = new
                    {
                        ResId = item.AreaID,
                        CreateUserID = item.CreateUserID,
                        CreateUser = createuser.Name,
                        CreateTime = item.CreateTime,
                        UpdateTime = item.UpdateTime,
                        UpdateUserID = item.UpdateUserID,
                        UpdateUser = udpateuser.Name,
                        AreaCode = item.AreaCode,
                        AreaName = item.AreaName,
                        Country = item.Country,
                        Province = item.Province + "/" + item.City + "/" + item.District,
                        //City = item.City,
                        //District = item.District,
                        OtherAddress = item.OtherAddress,
                        DetailAddress = item.DetailAddress,
                        ZipCode = item.ZipCode,
                        IsUse = item.IsUse,
                        StartTime = item.StartTime.ToShortDateString(),
                        Memo = item.Memo,
                        AreaSize = item.AreaSize
                    },
                    dataSources = new
                    {
                        UseStatus = statusdatasour,

                    }
                };
            }

        }

        protected override void CreateHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var model = item as HR_EMP_OfficeArea;

            var content = context.Content as JObject;
            var data = content["formdata"];
            model.AreaID = Guid.NewGuid();
            model.CreateTime = DateTime.Now;//取初始时间
            model.CreateUserID = context.Credential.UserGuid();
            model.UpdateTime = model.CreateTime;
            model.UpdateUserID = model.CreateUserID;
            model.LegalEntityID = context.Credential.LegalGuid();
            model.TenantID = context.Credential.TenantGuid();
            model.AreaSize = Convert.ToDecimal(data["AreaSize"]);
        }

        //protected override void BeforeEditHander(DbContext dbContext, dynamic item, dynamic data, BusinessContext context)
        //{
        //    var model = item as FM_SA_Area;
        //    model.UpdateTime = DateTime.Now;
        //    model.UpdateUserID = context.Credential.UserGuid();
        //    base.BeforeEditHander(dbContext, (object)item, (object)data, context);
        //}

        protected override void EditHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var model = item as HR_EMP_OfficeArea;

            var content = context.Content as JObject;
            var data = content["formdata"];
            model.AreaSize = Convert.ToDecimal(data["AreaSize"]);
            model.UpdateTime = DateTime.Now;
            model.UpdateUserID = context.Credential.UserGuid();
            base.EditHander(objectContext, model, context);
        }

        protected override bool CreateOrEditField(int type, string name, string value, object dmitem, BusinessContext context, DbContext dbContext)
        {
            if ("Province".Equals(name, StringComparison.CurrentCultureIgnoreCase))
            {
                if (!string.IsNullOrEmpty(value))
                {
                    var o = dmitem as HR_EMP_OfficeArea;
                    if (value.Contains("/"))
                    {
                        var ss = value.Split(new char[] { '/' });
                        o.Province = ss[0];
                        o.City = ss[1];
                        if (ss.Length > 2)
                        {
                            o.District = ss[2];
                        }
                        else
                        {
                            o.District = null;
                        }
                    }
                    else
                    {
                        o.City = value;
                    }
                }
                return true;
            }

            return false;
            //return base.CreateOrEditField(type, name, value, dmitem, context, dbContext);
        }

        #endregion

        #region [private method]

        /// <summary>
        /// 返回状态列表
        /// </summary>
        /// <returns></returns>
        private List<dynamic> GetTypeList()
        {
            return new List<dynamic> { new { ID = "", Name = "请选择" }, new { ID = "1", Name = "可用" }, new { ID = "0", Name = "不可用" } };
        }

        #endregion

        #region [public method]

        public BusinessResult DeleteAll(BusinessContext context)
        {
            string ids = context.Request["ids"];
            using (TransactionScope scope = new TransactionScope())
            {
                using (var dc = new HRDbContext())
                {
                    var list = ids.Split(';');
                    var inlist = list.Select(i => Guid.Parse(i)).ToArray();
                    var legals = dc.HR_EMP_OfficeArea.Where(item => inlist.Contains(item.AreaID));
                    var hasdel = legals.Where(p => p.IsDeleted == true).ToList();
                    if (hasdel.Count > 0)
                    {
                        return this.CreateResult(BusinessStatusCode.Error, "已删除的区域信息不能重复删除");
                    }
                    // dc.AM_WH_Warehouse.RemoveRange(legals);
                    foreach (var entity in legals)
                    {
                        entity.IsDeleted = true;
                        entity.IsUse = false;
                        entity.UpdateTime = DateTime.Now;
                        entity.UpdateUserID = context.Credential.UserGuid();

                        dc.Entry(entity).State = EntityState.Modified;
                    }

                    dc.SaveChanges();
                    scope.Complete();
                    return this.Success();
                }

            }

        }

        public BusinessResult CheckNoExist(BusinessContext context)
        {
            string value = context.Request["name"];
            string field = context.Request["field"];
            string id = context.Request["id"];

            using (var dc = new HRDbContext())
            {
                bool result = true;
                if (!string.IsNullOrEmpty(value) && !string.IsNullOrEmpty(field))
                {
                    if (field.ToLower() == "areacode")
                    {
                        var keyId = Guid.Parse(id);
                        result = dc.HR_EMP_OfficeArea.Any(m => m.AreaCode == value && m.AreaID != keyId);
                    }
                    //if (field.ToLower() == "areaname")
                    //{
                    //    Guid wareId = new Guid(id);
                    //    result = dc.FM_SA_Area.Any(m => m.AreaName == value && m.AreaID != wareId);
                    //}
                }

                return this.CreateResult(BusinessStatusCode.OK, result ? "false" : "true");
            }
        }

        #endregion
    }
}
