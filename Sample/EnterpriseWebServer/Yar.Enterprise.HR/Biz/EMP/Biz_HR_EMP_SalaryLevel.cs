using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Linq.Dynamic;
using System.Data.Entity;
using System.Transactions;
using Newtonsoft.Json.Linq;
using Yar.Service;
using Yar.EnterpriseCommon.Biz;
using Yar.EnterpriseCommon.DataFilter;
using Yar.EnterpriseCommon.Extend;
using Yar.Enterprise.HR.Modal;

using Yar.EnterpriseService.Enterprise;
using Yar.Service.Business.ValidationAttributes;

namespace Yar.Enterprise.HR.Biz
{
    public class Biz_HR_EMP_SalaryLevel : BizEnterpriseEntityBase<HRDbContext, HR_EMP_SalaryLevel>
    {
        public Biz_HR_EMP_SalaryLevel() : base("HR_EMP_SalaryLevel")
        {
            this.ViewModel.Model.DataModels.Add(new DataModel
            {
                ResName = "HR_EMP_SalaryLevel",
                KeyId = "SalaryLevelID",
                ResField = "SalaryLevelID",
                ResFieldType = "System.Guid",
                UpdateFields = "SalaryLevelID,SalaryLevelName,SalaryLevelValue,SalaryLevelType,Description,IsDisabled"

            });
            this.ViewModel.Model.ViewModels.Add(new ViewModel
            {
                Explorer = @"Enterprise\HR\EMP\SalaryLevel\View_SalaryLevel.cshtml",
                CreateView = @"Enterprise\HR\EMP\SalaryLevel\_fm_SalaryLevel_Edit.cshtml",
                EditView = @"Enterprise\HR\EMP\SalaryLevel\_fm_SalaryLevel_Edit.cshtml",
                PreviewView = @"Enterprise\HR\EMP\SalaryLevel\_fm_SalaryLevel_Preview.cshtml"
            });
            this.DataFilterFields[DataFilterConstants.GlobalLegalField] = "";
        }

        #region "List"
        protected override object ResourceListHander(DbContext objectContext, BusinessContext context, IQueryable<dynamic> objectSet)
        {
            #region "Query"
            var dbContext = objectContext as HRDbContext;
            var nq = objectSet.Cast<HR_EMP_SalaryLevel>().Where(t => t.IsDeleted == false);

            #region "Filters"
            if (context.Request.Contains("name") && !string.IsNullOrWhiteSpace(context.Request["name"]))
            {
                var fv = context.Request["name"].Trim();

                nq = nq.Where(item => item.SalaryLevelName.Contains(fv));
            }

            if (context.Request.Contains("type") && !string.IsNullOrWhiteSpace(context.Request["type"]))
            {
                var fv = context.Request["type"].Trim();

                nq = nq.Where(item => item.SalaryLevelType == fv);
            }
            #endregion

            #region "Sort"
            var sort = context.Request["sort"];
            var order = context.Request["order"];

            if (string.IsNullOrEmpty(sort))
            {
                nq = nq.OrderBy(g => g.SalaryLevelName);
            }
            else
            {
                nq = nq.OrderBy(string.Format("it.{0} {1}", sort, order));
            }

            #endregion 
            #endregion

            #region "Pagination"
            var total = 0;

            nq = this.UpdateDataPrivilege(context, nq);
            nq = this.GetPageQuery(context, nq, out total);

            var slTypes = GetSalaryLevelTypesList();

            return new
            {
                total = total,
                rows = nq.ToList().Select(p => new
                {
                    p.SalaryLevelID,
                    p.SalaryLevelName,
                    p.SalaryLevelValue,
                    SalaryLevelType = slTypes.Any(s => s.ID == p.SalaryLevelType) ? slTypes.FirstOrDefault(s => s.ID == p.SalaryLevelType).Name : string.Empty,
                    p.IsDisabled
                })
            };
            #endregion
        }

        protected override object GetViewData(BusinessContext context)
        {
            var data = new
            {
                dataSources = new
                {
                    dsSalaryLevelTypes = GetSalaryLevelTypesList(true)
                }
            };

            return Yar.Service.JsonHelper.Serialize(data, true);
        }
        #endregion

        #region "Create / Edit"
        protected override dynamic GetViewModelData(DbContext objectContext, BusinessContext context, object dbitem)
        {
            var item = dbitem as HR_EMP_SalaryLevel;
            var slTypes = GetSalaryLevelTypesList();

            return new
            {
                form = new
                {
                    ResId = item.SalaryLevelID,

                    item.SalaryLevelID,
                    item.SalaryLevelName,
                    item.SalaryLevelValue,
                    SalaryLevelType = !string.IsNullOrEmpty(item.SalaryLevelType) ? item.SalaryLevelType : string.Empty,
                    SalaryLevelTypeName = slTypes.Any(p => p.ID == item.SalaryLevelType) ? slTypes.FirstOrDefault(p => p.ID == item.SalaryLevelType).Name : string.Empty,
                    item.Description,
                    item.IsDisabled
                },
                dataSources = new
                {
                    dsSalaryLevelTypes = GetSalaryLevelTypesList(true)
                }
            };
        }

        public BusinessResult CheckNoExist(BusinessContext context)
        {
            var id = Guid.Parse(context.Request["id"]);
            var name = context.Request["name"];

            using (var dc = new HRDbContext())
            {
                if (dc.HR_EMP_SalaryLevel.Any(p => !p.IsDeleted && p.SalaryLevelID != id && p.SalaryLevelName == name))
                {
                    return this.CreateResult(BusinessStatusCode.OK, "false");
                }

                return this.CreateResult(BusinessStatusCode.OK, "true");
            }
        }

        protected override void CreateHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var o = item as HR_EMP_SalaryLevel;

            o.CreateTime = DateTime.Now;
            o.CreateUserID = context.Credential.UserGuid();
            o.LegalEntityID = context.Credential.LegalGuid();
        }

        protected override void EditHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var o = item as HR_EMP_SalaryLevel;

            o.UpdateTime = DateTime.Now;
            o.UpdateUserID = context.Credential.UserGuid();
        }
        #endregion

        #region "Services: DeleteAll"
        [RequireForRequest("ids")]
        public BusinessResult DeleteAll(BusinessContext context)
        {
            var ids = context.Request["ids"].Split(new char[] { ',', ';', '|' }, StringSplitOptions.RemoveEmptyEntries).ConvertTo<string, Guid>((s) => { return Guid.Parse(s); });

            using (var dc = new HRDbContext())
            {
                if (!dc.HR_EMP_SalaryLevel.Any(p => !p.IsDeleted && ids.Contains(p.SalaryLevelID)))
                {
                    return this.Error();
                }

                Int32 count = dc.HR_EMP_Employee.Where(e => e.SalaryLevelID.HasValue && ids.Contains(e.SalaryLevelID.Value)).Count();

                if (count == 0)
                {
                    foreach (var entity in dc.HR_EMP_SalaryLevel.Where(p => !p.IsDeleted && ids.Contains(p.SalaryLevelID)))
                    {
                        entity.IsDeleted = true;
                        entity.UpdateTime = DateTime.Now;
                        entity.UpdateUserID = context.Credential.UserGuid();

                        dc.Entry(entity).State = EntityState.Modified;
                    }

                    dc.SaveChanges();

                    return this.Success();
                }
                else
                {
                    return this.Error("不允许删除有员工关联的岗位等级");
                }
            }
        }
        #endregion

        #region "Services: ModifyState"
        [RequireForRequest("resId:guid")]
        public BusinessResult ModifyState(BusinessContext context)
        {
            using (var dc = new HRDbContext())
            {
                var id = Guid.Parse(context.Request["resId"]);
                var nq = dc.HR_EMP_SalaryLevel.Where(t => !t.IsDeleted && t.SalaryLevelID == id).FirstOrDefault();

                if (nq == null)
                {
                    return this.CreateResult(BusinessStatusCode.BadRequest, null);
                }

                Int32 count = dc.HR_EMP_Employee.Where(e => e.SalaryLevelID.HasValue && e.SalaryLevelID.Value.Equals(id)).Count();

                if (count == 0)
                {
                    nq.IsDisabled = !nq.IsDisabled;
                    nq.UpdateTime = DateTime.Now;
                    nq.UpdateUserID = context.Credential.UserGuid();

                    dc.SaveChanges();

                    return this.Success();
                }
                else
                {
                    return this.Error();
                }
            }
        }
        #endregion

        #region "Common Utils"
        IEnumerable<DictBindItem> GetSalaryLevelTypesList(bool appendPreix = false)
        {
            var lst = CommonDictService.GetDictItems(RuleCodeConstants.HR_EMP_SalaryLevelType, GetCurrentCredential().LegalGuid());

            if (appendPreix)
            {
                lst.Insert(0, new DictBindItem { ID = string.Empty, Name = "请选择" });
            }

            return lst;
        }
        #endregion
    }
}
