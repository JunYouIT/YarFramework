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
using Yar.EnterpriseService.Enterprise;
using Yar.Service.Business.ValidationAttributes;
using Yar.EnterpriseCommon.Biz;
using Yar.EnterpriseCommon.DataFilter;
using Yar.EnterpriseCommon.Extend;
using Yar.Enterprise.HR.Modal;
using System.ComponentModel;
using Yar.Core.Validation.Attributes;
using Yar.EnterpriseService.Modal;
using Yar.Service.Exceptions;
using Yar.BizModule.Model;
using System.Text.RegularExpressions;
using Yar.Core;
using System.Data.Entity.Validation;

namespace Yar.Enterprise.HR.Biz
{
    public class Biz_HR_EMP_Employee : BizEnterpriseEntityBase<HRDbContext, HR_EMP_Employee>
    {
        public Biz_HR_EMP_Employee() : base("HR_EMP_Employee")
        {
            this.ViewModel.Model.DataModels.Add(new DataModel
            {
                ResName = "HR_EMP_Employee",
                KeyId = "EmployeeID",
                ResField = "EmployeeID",
                ResFieldType = "System.Guid",
                UpdateFields = "EmployeeID, EmployeeNumber, EmployeeNameCN, EmployeeNameEN, Gender, IDType, IDNumber,"
                    + " Birthday, MaritalStatus, FirstWorkedDate, Nationality, OfficeAreaID, HukouAddress, OnboardDate,"    
                    + " EmployeeEMail, EmpStatus, EmployeeStatus, OrganizationID,"
                    + " OrganizationCode, OrganizationName, CurrentJobLevelName,"
                    + " CurrentJobLevelValue, ExtCode, TeleCode, PersonalEmail, PersonalCellPhone, CPFAccount,"
                    + " FileTransferInDate, FileTransferOutDate, PoliticalStatus, TAG, Description,"
                    + " UserName, MLAccount, CreateTime, CreateUserID, UpdateTime,"
                    + " UpdateUserID, IsDeleted, LegalEntityID, TenantID, PhotoAttachmentID, Ethnic, ProfessionalTitle, SupplHousingAccount, NoTrial, TrialBeginDate, TrialEndDate, PartyJoinInDate, ADAccount, NCUserCode, EmployeeType"
                //"TerminationDate, TerminationTypeName, MainJobPositionID, MainJobPostionName, Education, EmergencyCellPhone, TrialBeginDate, TrialEndDate, "

            });
            this.ViewModel.Model.ViewModels.Add(new ViewModel
            {
                Explorer = @"Enterprise\HR\EMP\Employee\View_Employee.cshtml",
                CreateView = @"Enterprise\HR\EMP\Employee\_fmEmployeeEdit.cshtml",
                EditView = @"Enterprise\HR\EMP\Employee\_fmEmployeeEdit.cshtml",
                PreviewView = @"Enterprise\HR\EMP\Employee\_fmEmployeePreview.cshtml"

            });
            this.DataFilterFields[DataFilterConstants.GlobalLegalField] = "";
        }

        protected override object ResourceListHander(DbContext objectContext, BusinessContext context, IQueryable<dynamic> objectSet)
        {
            var dbContext = objectContext as HRDbContext;

            var query = QueryEmpListInfos(context, dbContext);

            var sort = context.Request["sort"];
            var order = context.Request["order"];
            if (string.IsNullOrEmpty(sort))
            {
                query = query.OrderBy(g => g.OrganizationCode).ThenByDescending(g => g.SalaryLevelValue);
            }
            else
            {
                query = query.OrderBy(string.Format("it.{0} {1}", sort, order));
            }
            //var dsEmpStatus = this.GetEmpStatusList(context.Credential.LegalGuid());
            int total = 0;
            query = this.UpdateDataPrivilege(context, query);
            query = this.GetPageQuery(context, query, out total);
            return new
            {
                total = total,
                rows = query.ToArray().Select(item => new
                {
                    item.EmployeeID,
                    item.EmployeeNumber,
                    item.EmployeeNameCN,
                    item.LegalEntityID,
                    //item.OfficeAreaID,
                    //item.PersonalCellPhone,
                    item.PostionName,
                    EmpStatus = CommonDictService.GetDictItemName(item.EmpStatus),
                    EmployeeStatus = CommonDictService.GetDictItemName(item.EmployeeStatus),
                    item.OnboardDate,
                    item.OrganizationName,
                    item.IsMain
                }).ToArray()
            };
        }

        private static IQueryable<EmpListInfo> QueryEmpListInfos(BusinessContext context, HRDbContext dbContext)
        {
            var name = context.Request["name"];
            var number = context.Request["number"];
            var tag = context.Request["tag"];
            var empStatus = context.Request["empStatus"];
            var employeeStatus = context.Request["employeeStatus"];
            var onboarddate_min = context.Request["onboarddate_min"];
            var onboarddate_max = context.Request["onboarddate_max"];
            var description = context.Request["description"];
            string orgId = context.Request["orgId"];
            var showChild = "true".Equals(context.Request["showChild"], StringComparison.CurrentCultureIgnoreCase);
            var showSideline = "true".Equals(context.Request["showSideline"], StringComparison.CurrentCultureIgnoreCase);

            string orgCode = context.Request["orgCode"];
            var tenantId = context.Credential.TenantGuid();

            var nq = from e in dbContext.HR_EMP_Employee where !e.IsDeleted && e.TenantID == tenantId select e;


            DateTime tmp;

            if (!string.IsNullOrEmpty(name))
            {
                nq = nq.Where(item => item.EmployeeNameCN.Contains(name.Trim()));
            }
            if (!string.IsNullOrEmpty(number))
            {
                nq = nq.Where(item => item.EmployeeNumber.Contains(number.Trim()));
            }
            if (!string.IsNullOrEmpty(tag))
            {
                nq = nq.Where(item => item.TAG.Contains(tag.Trim()));
            }
            if (!string.IsNullOrEmpty(empStatus))
            {
                //默认显示在职和待离职的人员
                if ("default".Equals(empStatus, StringComparison.CurrentCultureIgnoreCase))
                    nq =
                        nq.Where(
                            item =>
                                item.EmpStatus == "0|" + DictConstants.HR_EMP_EmpStatus ||
                                item.EmpStatus == "2|" + DictConstants.HR_EMP_EmpStatus);
                else
                    nq = nq.Where(item => item.EmpStatus == empStatus);
            }
            if (!string.IsNullOrEmpty(employeeStatus))
            {
                nq = nq.Where(item => item.EmployeeStatus == employeeStatus);
            }
            if (!string.IsNullOrEmpty(onboarddate_min) && DateTime.TryParse(onboarddate_min, out tmp))
            {
                nq = nq.Where(item => item.OnboardDate >= tmp);
            }
            if (!string.IsNullOrEmpty(onboarddate_max) && DateTime.TryParse(onboarddate_max, out tmp))
            {
                nq = nq.Where(item => item.OnboardDate <= tmp);
            }
            if (!string.IsNullOrEmpty(description))
            {
                nq = nq.Where(item => item.Description.Contains(description));
            }

            IQueryable<EmpListInfo> query;
            if (showSideline)
            {
                query = from q in nq
                        from ep in
                            dbContext.HR_EMP_PostInformation.Where(
                                t => !t.IsDeleted && !t.IsMain && t.IsFunctionPosition && t.EmployeeID == q.EmployeeID)
                        from pos in dbContext.HR_ORG_Position.Where(t => !t.IsDeleted && t.PositionID == ep.PositionID && t.TenantID == tenantId)
                        from org in
                            dbContext.HR_ORG_Organization.Where(t => !t.IsDeleted && t.OrganizationID == pos.OrganizationID && pos.TenantID == tenantId)
                        join salary in dbContext.HR_EMP_SalaryLevel.Where(s => !s.IsDeleted
                        && !s.IsDisabled) on new { LegalEntityID = q.LegalEntityID, SalaryLevelID = q.SalaryLevelID.HasValue ? q.SalaryLevelID.Value : Guid.Empty } equals new { LegalEntityID = salary.LegalEntityID, SalaryLevelID = salary.SalaryLevelID } into tempClosure
                        from salaryClosure in tempClosure.DefaultIfEmpty()
                        select new EmpListInfo()
                        {
                            EmployeeID = q.EmployeeID,
                            EmployeeNumber = q.EmployeeNumber,
                            EmployeeNameCN = q.EmployeeNameCN,
                            LegalEntityID = ep.LegalEntityID,
                            OrganizationID = org.OrganizationID,
                            OrganizationCode = org.OrganizationCode,
                            OrganizationName = org.OrganizationName,
                            PostionID = pos.PositionID,
                            PostionName = pos.PositionName,
                            EmpStatus = q.EmpStatus,
                            EmployeeStatus = q.EmployeeStatus,
                            OnboardDate = q.OnboardDate,
                            JobLevelValue = q.CurrentJobLevelValue,
                            IsMain = 0,
                            SalaryLevelValue = salaryClosure != null ? salaryClosure.SalaryLevelValue : 9999//null值排序最后,
                            ,
                            OrgCodePath = org.CodePath
                        };
                query = query.Union(from employee in nq
                                    join salary in dbContext.HR_EMP_SalaryLevel.Where(s => !s.IsDeleted
                                   && !s.IsDisabled) on new { LegalEntityID = employee.LegalEntityID, SalaryLevelID = employee.SalaryLevelID.HasValue ? employee.SalaryLevelID.Value : Guid.Empty } equals new { LegalEntityID = salary.LegalEntityID, SalaryLevelID = salary.SalaryLevelID } into tempClosure
                                    from org in
                                    dbContext.HR_ORG_Organization.Where(t => !t.IsDeleted && t.OrganizationID == employee.OrganizationID && t.TenantID == tenantId)
                                    from salaryClosure in tempClosure.DefaultIfEmpty()
                                    select new EmpListInfo()
                                    {
                                        EmployeeID = employee.EmployeeID,
                                        EmployeeNumber = employee.EmployeeNumber,
                                        EmployeeNameCN = employee.EmployeeNameCN,
                                        LegalEntityID = employee.LegalEntityID,
                                        OrganizationID = employee.OrganizationID,
                                        OrganizationCode = employee.OrganizationCode,
                                        OrganizationName = employee.OrganizationName,
                                        PostionID = employee.MainJobPositionID,
                                        PostionName = employee.MainJobPostionName,
                                        EmpStatus = employee.EmpStatus,
                                        EmployeeStatus = employee.EmployeeStatus,
                                        OnboardDate = employee.OnboardDate,
                                        JobLevelValue = employee.CurrentJobLevelValue,
                                        IsMain = 1,
                                        SalaryLevelValue = salaryClosure != null ? salaryClosure.SalaryLevelValue : 9999//null值排序最后
                                        ,
                                        OrgCodePath = org.CodePath
                                    });
                if (showChild)
                {
                    if (!string.IsNullOrEmpty(orgCode))
                    {
                        query = query.Where(t => (t.OrgCodePath + ",").Contains(orgCode.Trim() + ","));
                    }
                }
                else
                {
                    if (!string.IsNullOrEmpty(orgCode))
                    {
                        query =
                            query.Where(
                                item =>
                                    item.OrganizationCode.Equals(orgCode.Trim(),
                                        StringComparison.CurrentCultureIgnoreCase));
                    }
                }
            }
            else
            {

                query = from employee in nq
                        join salary in dbContext.HR_EMP_SalaryLevel.Where(s => !s.IsDeleted
                       && !s.IsDisabled) on new { LegalEntityID = employee.LegalEntityID, SalaryLevelID = employee.SalaryLevelID.HasValue ? employee.SalaryLevelID.Value : Guid.Empty } equals new { LegalEntityID = salary.LegalEntityID, SalaryLevelID = salary.SalaryLevelID } into tempClosure
                        from salaryClosure in tempClosure.DefaultIfEmpty()
                        from org in
                                    dbContext.HR_ORG_Organization.Where(t => !t.IsDeleted && t.OrganizationID == employee.OrganizationID && t.TenantID == tenantId)
                        select new EmpListInfo()
                        {
                            EmployeeID = employee.EmployeeID,
                            EmployeeNumber = employee.EmployeeNumber,
                            EmployeeNameCN = employee.EmployeeNameCN,
                            LegalEntityID = employee.LegalEntityID,
                            OrganizationID = employee.OrganizationID,
                            OrganizationCode = employee.OrganizationCode,
                            OrganizationName = employee.OrganizationName,
                            PostionID = employee.MainJobPositionID,
                            PostionName = employee.MainJobPostionName,
                            EmpStatus = employee.EmpStatus,
                            EmployeeStatus = employee.EmployeeStatus,
                            OnboardDate = employee.OnboardDate,
                            JobLevelValue = employee.CurrentJobLevelValue,
                            IsMain = 1,
                            SalaryLevelValue = salaryClosure != null ? salaryClosure.SalaryLevelValue : 9999//null值排序最后
                            ,
                            OrgCodePath = org.CodePath
                        };
                if (showChild)
                {
                    if (!string.IsNullOrEmpty(orgCode))
                    {
                        query =
                            query.Where(
                                item =>
                                    (item.OrgCodePath + ",").Contains(orgCode.Trim() + ","));
                    }
                }
                else
                {
                    if (!string.IsNullOrEmpty(orgCode))
                    {
                        query =
                            query.Where(
                                item =>
                                    item.OrganizationCode.Equals(orgCode.Trim(),
                                        StringComparison.CurrentCultureIgnoreCase));
                    }
                }
            }
            return query;
        }

        private string GetType(string type, List<DictBindItem> list)
        {
            if (string.IsNullOrEmpty(type)) return null;
            return list.Where(item => item.ID == type).Select(item => item.Name).FirstOrDefault();
            //return "dd";
        }

        protected override object GetViewData(BusinessContext context)
        {
            var dsEmpStatus = this.GetEmpStatusList(context.Credential.LegalGuid());

            dsEmpStatus.Insert(0, new DictBindItem() { ID = "", Name = "请选择" });
            dsEmpStatus.Insert(1, new DictBindItem() { ID = "default", Name = "在职及待离职" });

            var dsEmployeeStatus = this.GetEmployeeStatusList(context.Credential.LegalGuid());

            dsEmployeeStatus.Insert(0, new DictBindItem() { ID = "", Name = "请选择" });
            //dsFieldSelections = GetAllExportFields<EmpListInfo>().Select(p => new DictBindItem { ID = p.Name, Name = p.GetCustomAttribute<DescriptionAttribute>().Description }).ToList()


            var data = new
            {
                dataSources = new
                {
                    dsEmpStatus,
                    dsEmployeeStatus,
                    dsFieldSelections = new List<DictBindItem>()
                }
            };

            return Yar.Service.JsonHelper.Serialize(data, true);
        }

        #region org data
        public BusinessResult GetOrgTree(BusinessContext context)
        {
            var data = GetTreeData(context);
            BM_TreeModel[] listtree = data.Select(item => new BM_TreeModel
            {
                id = item.OrgId.ToString(),
                text = item.OrgName,
                pid = item.ParentId.ToString(),
                code = item.OrgCode,
                Sequence = item.Sequence,
                attributes = new Dictionary<string, string>() {
                            { "CodePath", item.CodePath },
                            { "OrgType", item.OrgType }}
            }).ToArray();
            BM_TreeModel[] rel = BM_TreeModel.CreateTree(listtree);
            return this.CreateResult(BusinessStatusCode.OK, rel);
        }

        public BusinessResult GetOrgHeadCount(BusinessContext context)
        {
            var data = GetHeadCountData(context).Select(t => new { t.OrgId, t.OrgName, t.HeadCount });
            return this.Success(data);
        }

        private List<OrgTreeData> GetHeadCountData(BusinessContext context)
        {
            var empId = context.Credential.UserGuid();
            var legalId = context.Credential.LegalGuid();

            var orgService = this.GetBizService<IBizEmployeeService>();
            return orgService.GetOrgHeadCountData().Select(o => new OrgTreeData
            {
                OrgId = Guid.Parse(o.Id),
                OrgCode = o.Code,
                OrgName = o.Name,
                OrgType = o.OrganiztionType,
                ParentId = string.IsNullOrEmpty(o.ParentId) ? null : (Guid?)Guid.Parse(o.ParentId),
                CodePath = o.CodePath,
                HeadCount = o.Data.ToInt("HeadCount")
            }).ToList();
        }

        private List<OrgTreeData> GetTreeData(BusinessContext context)
        {

            var orgService = this.GetBizService<IBizOrganizationService>();
            return orgService.GetAllSysOrgs().Select(o => new OrgTreeData
            {
                OrgId = Guid.Parse(o.Id),
                OrgCode = o.Code,
                OrgName = o.Name,
                OrgType = o.OrganiztionType,
                ParentId = string.IsNullOrEmpty(o.ParentId) ? null : (Guid?)Guid.Parse(o.ParentId),
                CodePath = o.CodePath,                
            }).ToList();
        }

        private int GetOrgHeadCount(string orgCode)
        {
            using (var dc = new HRDbContext())
            {
                List<string> lstEmpStatus = new List<string>() { "0|" + DictConstants.HR_EMP_EmpStatus, "2|" + DictConstants.HR_EMP_EmpStatus };
                return dc.HR_EMP_Employee.Count(
                    t => !t.IsDeleted && t.OrganizationCode.StartsWith(orgCode) && lstEmpStatus.Contains(t.EmpStatus));
            }
        }
        #endregion

        #region 下拉框
        private List<DictBindItem> GetEmpStatusList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_EmpStatus, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<DictBindItem> GetIDTypeList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_IDType, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<DictBindItem> GetGenderList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_Gender, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<DictBindItem> GetMaritalStatusList(Guid legalId, bool appendPreifx = false)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_MaritalStatus, legalId);

            if (appendPreifx)
            {
                lst.Insert(0, new DictBindItem { ID = string.Empty, Name = "请选择" });
            }

            return lst;
        }

        private List<DictBindItem> GetNationalityStatusList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_Nationality, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<DictBindItem> GetOfficeAreaList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_OfficeArea, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<DictBindItem> GetEmployeeStatusList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_EmployeeStatus, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<DictBindItem> GetPoliticalStatusList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_PoliticalStatus, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<DictBindItem> GetBankNameList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_BankName, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<DictBindItem> GetEduBGList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_EduBG, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<DictBindItem> GetEduDegreeList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_EduDegree, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<DictBindItem> GetRelationshipsList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_Relationships, legalId);
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        private List<SelectItem> GetJobLevelList(Guid legalId)
        {
            using (var dc = new HRDbContext())
            {
                var q = from jl in dc.HR_ORG_JobLevel
                        where !jl.IsDeleted && jl.LegalEntityID == legalId
                        orderby jl.JobLevelNumber descending
                        select jl;
                var lst =
                    q.ToList()
                        .Select(
                            t =>
                                new SelectItem()
                                {
                                    ID = t.JobLevelNumber.ToString("0.00"),
                                    Name = string.Format("{0}", t.JobLevelName)
                                }).ToList();
                return lst;
            }
        }

        #region "Services: GetSalaryLevelList"
        [Require("legalId:guid")]
        public BusinessResult GetSalaryLevelList(BusinessContext context)
        {
            var legalId = Guid.Parse(context.Request["legalId"]);

            return this.Success(GetSalaryLevelList(legalId, true));
        }

        List<DictBindItem> GetSalaryLevelList(Guid legalId, bool appendPrefix = false)
        {
            using (var dc = new HRDbContext())
            {
                var slTypes = GetSalaryLevelTypeList(legalId);
                var lst = dc.HR_EMP_SalaryLevel.Where(p => !p.IsDeleted && !p.IsDisabled && p.LegalEntityID.Equals(legalId))
                                                .OrderBy(p => p.SalaryLevelType)
                                                .ThenBy(p => p.SalaryLevelValue)
                                                .ToList()
                                                .Select(p => new DictBindItem { ID = p.SalaryLevelID.ToString(), Name = string.Format("{0}（{1}）", p.SalaryLevelName, slTypes.FirstOrDefault(s => s.ID == p.SalaryLevelType)?.Name) })
                                                .ToList();

                if (appendPrefix)
                {
                    lst.Insert(0, new DictBindItem { ID = string.Empty, Name = "请选择" });
                }

                return lst;
            }
        }

        List<DictBindItem> GetSalaryLevelTypeList(Guid legalId, bool appendPrefix = false)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_SalaryLevelType, legalId);

            if (appendPrefix)
            {
                lst.Insert(0, new DictBindItem { ID = string.Empty, Name = "请选择" });
            }

            return lst;
        }
        #endregion

        private List<DictBindItem> GetCountryList(Guid legalId)
        {
            var lst = CommonDictService.GetDictItems(DictConstants.HR_EMP_Nationality, legalId);
            foreach (var item in lst)
            {
                item.ID = item.Name;
            }
            //lst.Insert(0, new DictBindItem { ID = "", Name = "---select---" });
            return lst;
        }

        #endregion

        #region create employee
        public virtual BusinessResult CreateEmployeeView(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var item = this.CreateObject(context, objectContext);
            InitCreateViewModel(objectContext, context, item);
            var vmData = GetEmployeeViewModelData(objectContext, context, item);
            return View(this.BizViewModel.CreateView, new { Context = context, ModelData = context.ContextTable["ModelData"], EntityAction = EntityAction.CreateView.ToString(), BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        //新建页面获取数据
        protected dynamic GetEmployeeViewModelData(DbContext objectContext, BusinessContext context, object dbitem)
        {
            var dsBankName = CommonDictService.GetDictItems("HR_EMP_BankName", context.Credential.LegalGuid());

            dsBankName.Insert(0, new DictBindItem() { ID = "", Name = "全部" });

            var item = dbitem as HR_EMP_Employee;

            if (item == null)
            {
                throw new BusinessException("有错误，未获取到数据");
            }

            item.EmpStatus = "0|HR_EMP_EmpStatus";

            var orgId = context.Request["orgId"];
            Guid gOrgId;

            if (string.IsNullOrEmpty(orgId) || !Guid.TryParse(orgId, out gOrgId))
            {
                throw new BusinessException("有错误，未获取到部门数据");
            }

            var orgService = this.GetBizService<IBizOrganizationService>();
            var orgInfo = orgService.GetSysOrg(gOrgId);

            if (orgInfo == null)
            {
                throw new BusinessException("有错误，未获取到部门信息");
            }

            item.OrganizationID = Guid.Parse(orgInfo.Id);
            item.OrganizationCode = orgInfo.Code;
            item.OrganizationName = orgInfo.Name;
            item.LegalEntityID = orgInfo.LegalId;
            item.TenantID = context.Credential.TenantGuid();

            var gTmpEmpId = item.EmployeeID;

            if (item.EmployeeID == Guid.Empty)
                gTmpEmpId = Guid.NewGuid();

            var dc = objectContext as HRDbContext;
            var address = ((HRDbContext)objectContext).HR_EMP_Address.Create();

            InitCreateViewModel(objectContext, context, address);

            address.Country = "中华人民共和国";

            var bank = ((HRDbContext)objectContext).HR_EMP_BankCard.Create();

            InitCreateViewModel(objectContext, context, bank);

            return new
            {
                form = new
                {
                    ResId = item.EmployeeID,
                    empId = gTmpEmpId,
                    item.EmployeeNumber,
                    item.NCUserCode,
                    EmployeeType = string.IsNullOrWhiteSpace(item.EmployeeType) ? "-1|HR_EMP_EmployeeType" : item.EmployeeType,
                    EmployeeTypeNames = GetEmployeeTypeNames(item.EmployeeType),
                    item.EmployeeNameCN,
                    item.EmployeeNameEN,
                    item.Gender,
                    item.IDType,
                    item.IDNumber,
                    Birthday = item.Birthday?.ToString("yyyy-MM-dd") ?? String.Empty,
                    item.MaritalStatus,
                    FirstWorkedDate = item.FirstWorkedDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                    item.Nationality,
                    item.OfficeAreaID,
                    OFDetailAddress = "",
                    item.HukouAddress,
                    OnboardDate = item.OnboardDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                    item.EmployeeEMail,
                    item.EmpStatus,
                    item.EmployeeStatus,
                    item.OrganizationID,
                    item.OrganizationCode,
                    item.OrganizationName,

                    MainJobPositionID = item.MainJobPositionID,
                    MainJobPositionName = string.IsNullOrWhiteSpace(item.MainJobPostionName) ? "无" : item.MainJobPostionName,

                    SalaryLevelID = string.Empty,
                    SalaryLevelName = string.Empty,

                    item.ExtCode,
                    item.TeleCode,
                    item.PersonalEmail,
                    item.Education,
                    item.PersonalCellPhone,
                    item.CPFAccount,
                    item.EmergencyCellPhone,
                    FileTransferInDate = item.FileTransferInDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                    FileTransferOutDate = item.FileTransferOutDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                    item.PoliticalStatus,
                    item.TAG,
                    item.Description,
                    item.UserName,
                    item.MLAccount,
                    NoTrial = item.NoTrial != null ? item.NoTrial.Value : false,
                    TrialBeginDate = item.TrialBeginDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                    TrialEndDate = item.TrialEndDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                    item.CreateTime,
                    item.CreateUserID,
                    item.UpdateTime,
                    item.UpdateUserID,
                    item.IsDeleted,
                    item.LegalEntityID,
                    item.TenantID,

                    item.Ethnic,
                    item.ProfessionalTitle,
                    item.SupplHousingAccount,
                    TerminationDate = item.TerminationDate?.ToString("yyyy-MM-dd") ?? string.Empty,
                    TerminationTypeName = item.TerminationTypeName,
                    item.PhotoAttachmentID,

                    address.Country,
                    //address.Province,
                    //address.City,
                    //address.District,
                    Area = string.Empty,
                    address.Address,
                    address.ZipCode,
                    address.AddressPhone,

                    HujiCountry = address.Country,
                    //HujiProvince = address.Province,
                    //HujiCity = address.City,
                    //HujiDistrict = address.District,
                    HujiArea = string.Empty,
                    HujiAddress = address.Address,
                    HujiZipCode = address.ZipCode,
                    HujiAddressPhone = address.AddressPhone,

                    bank.BankNumber,
                    bank.BankName,
                    BankAddress = bank.Address,
                    BankBranchCode = bank.BankBranchCode,
                    bank.AccountName,
                    bank.BankCity

                },
                dataSources = new
                {
                    dsEmpStatus = this.GetEmpStatusList(item.LegalEntityID),
                    dsIDType = this.GetIDTypeList(item.LegalEntityID),
                    dsGender = this.GetGenderList(item.LegalEntityID),
                    dsMaritalStatus = this.GetMaritalStatusList(item.LegalEntityID),
                    dsNationality = this.GetNationalityStatusList(item.LegalEntityID),
                    //dsOfficeArea = this.GetOfficeAreaList(item.LegalEntityID),
                    dsEmployeeStatus = this.GetEmployeeStatusList(item.LegalEntityID),
                    dsPoliticalStatus = this.GetPoliticalStatusList(item.LegalEntityID),
                    dsBankName = dsBankName,
                    //dsEduBG = this.GetEduBGList(item.LegalEntityID),
                    //dsEduDegree = this.GetEduDegreeList(item.LegalEntityID),
                    //dsMainJobPostionName = Positionlist,
                    //dsOrganizationName = Organizationlist,
                    dsSalaryLevels = GetSalaryLevelList(item.LegalEntityID, true),
                    dsEthnic = CommonDictService.GetDictItems(DictConstants.HR_EMP_Ethnic, item.LegalEntityID),
                    dsProfessionalTitle = CommonDictService.GetDictItems(DictConstants.HR_EMP_ProfessionalTitle, item.LegalEntityID),
                    dsCountry = GetCountryList(item.LegalEntityID),
                    employeeTypeTree = GetEmployeeTypeTree(context)
                }
            };
        }

        protected override dynamic GetViewModelData(DbContext objectContext, BusinessContext context, object dbitem)
        {
            //var dbContext = new HrDbContext();
            var dc = objectContext as HRDbContext;
            var item = dbitem as HR_EMP_Employee;

            #region "address"
            //如果item.EmployeeID为空下面自然没值 
            var area = string.Empty;
            var address = (
                                from a in dc.HR_EMP_Address
                                where a.EmployeeID == item.EmployeeID && a.IsDeleted == false && a.AddressType == "0"
                                select a
                           ).FirstOrDefault();


            if (address != null)
            {
                if (!string.IsNullOrEmpty(address.Province))
                    area += address.Province + "/";

                if (!string.IsNullOrEmpty(address.City))
                    area += address.City + "/";

                if (!string.IsNullOrEmpty(address.District))
                    area += address.District;
            }
            #endregion

            #region "hujiaddress"
            var hujiarea = string.Empty;
            var hujiaddress = (
                                    from a in dc.HR_EMP_Address
                                    where a.EmployeeID == item.EmployeeID && a.IsDeleted == false && a.AddressType == "1"
                                    select a
                               ).FirstOrDefault();


            if (hujiaddress != null)
            {
                if (!string.IsNullOrEmpty(hujiaddress.Province))
                    hujiarea += hujiaddress.Province + "/";

                if (!string.IsNullOrEmpty(hujiaddress.City))
                    hujiarea += hujiaddress.City + "/";

                if (!string.IsNullOrEmpty(hujiaddress.District))
                    hujiarea += hujiaddress.District;
            }
            #endregion

            #region "bank"
            var bankBranchName = string.Empty;
            var bank = (
                            from b in dc.HR_EMP_BankCard
                            where b.EmployeeID == item.EmployeeID && b.IsDeleted == false
                            select b
                       ).FirstOrDefault();

            if (bank != null)
            {
                var bankBranch = dc.SYS_COM_BankBranch.Where(a => a.BankBranchCode == bank.BankBranchCode).FirstOrDefault();

                if (bankBranch != null)
                {
                    bankBranchName = bankBranch.BankBranchName;
                }
            }
            #endregion

            #region "Additional Data"
            var position = (
                                from c in dc.HR_EMP_PostInformation.Where(p => !p.IsDeleted && p.IsMain && p.EmployeeID == item.EmployeeID)
                                join d in dc.HR_ORG_Position.Where(p => !p.IsDeleted && p.IsUse) on c.PositionID equals d.PositionID
                                join dl in dc.HR_ORG_JobLevel.Where(p => !p.IsDeleted && !p.IsDisabled) on d.PositionLevelID equals dl.JobLevelID into tmpDL
                                from dl in tmpDL.DefaultIfEmpty()
                                select new { d, dl }
                            ).FirstOrDefault();

            var organization = (
                                    from c in dc.HR_EMP_PostInformation.Where(p => !p.IsDeleted && p.IsMain && p.EmployeeID == item.EmployeeID)
                                    join d in dc.HR_ORG_Organization.Where(p => !p.IsDeleted && !p.IsDisabled) on c.OrganizationID equals d.OrganizationID
                                    select d
                               ).FirstOrDefault();

            var empSalaryLevelTypes = default(List<DictBindItem>);
            var empMaritalStatus = default(List<DictBindItem>);
            var empAreaName = (GetBizService<IBizHRService>()).GetOfficeArea(item.OfficeAreaID.GetValueOrDefault(Guid.Empty))?.Name;
            var empTypeNames = string.Empty;
            var empGenderName = string.Empty;
            var empIDTypeName = string.Empty;
            var empNationalityName = string.Empty;
            var empStatusName = string.Empty;
            var empEmployeeStatusName = string.Empty;
            var empPoliticalStatusName = string.Empty;
            var empEthnicName = string.Empty;
            //empSalaryLevelTypes = GetSalaryLevelList(item.LegalEntityID, true);
           // empMaritalStatus = GetMaritalStatusList(item.LegalEntityID, true);
            //empAreaName = (GetBizService<IBizFMService>()).MJService.GetAreaName(item.OfficeAreaID.GetValueOrDefault(Guid.Empty));
           // empTypeNames = GetEmployeeTypeNames(item.EmployeeType);
            //empGenderName = CommonDictService.GetDictItemName(item.Gender);
            //empIDTypeName = CommonDictService.GetDictItemName(item.IDType);
            //empNationalityName = CommonDictService.GetDictItemName(item.Nationality);
            //empStatusName = CommonDictService.GetDictItemName(item.EmpStatus);
            empEmployeeStatusName = CommonDictService.GetDictItemName(item.EmployeeStatus);
            empPoliticalStatusName = CommonDictService.GetDictItemName(item.PoliticalStatus);
            empEthnicName = CommonDictService.GetDictItemName(item.Ethnic);
            Parallel.Invoke(() =>
            {
                empTypeNames = GetEmployeeTypeNames(item.EmployeeType);
            }, () =>
            {
                empGenderName = CommonDictService.GetDictItemName(item.Gender);
            }, () =>
            {
                empIDTypeName = CommonDictService.GetDictItemName(item.IDType);
            }, () =>
            {
                empSalaryLevelTypes = GetSalaryLevelList(item.LegalEntityID, true);
            }, () =>
            {
                empMaritalStatus = GetMaritalStatusList(item.LegalEntityID, true);
            }
            , () =>
            {
                empNationalityName = CommonDictService.GetDictItemName(item.Nationality);
            }
            , () =>
            {
                empStatusName = CommonDictService.GetDictItemName(item.EmpStatus);
            }
            , () =>
            {
                empEmployeeStatusName = CommonDictService.GetDictItemName(item.EmployeeStatus);
            }
            , () =>
            {
                empPoliticalStatusName = CommonDictService.GetDictItemName(item.PoliticalStatus);
            }
            , () =>
            {
                empEthnicName = CommonDictService.GetDictItemName(item.Ethnic);
            }
            );
            #endregion

            String MainJobPositionName = "无";
            if (position != null && organization != null)
            {
                if (position.d != null)
                {
                    if (!String.IsNullOrWhiteSpace(position.d.PositionName))
                    {
                        MainJobPositionName = position.d.PositionName + "（" + organization.OrganizationName + "）";
                    }
                }
            }

            return new
            {
                form = new
                {
                    ResId = item.EmployeeID,
                    empId = item.EmployeeID,

                    item.EmployeeNumber,
                    item.EmployeeNameCN,
                    item.EmployeeNameEN,
                    item.NCUserCode,

                    EmployeeType = string.IsNullOrWhiteSpace(item.EmployeeType) ? "-1|HR_EMP_EmployeeType" : item.EmployeeType,
                    EmployeeTypeNames = empTypeNames,

                    Gender = item.Gender?.ToString() ?? string.Empty,
                    GenderName = empGenderName,

                    IDType = item.IDType?.ToString() ?? string.Empty,
                    IDTypeName = empIDTypeName,
                    IDNumber = item.IDNumber,

                    Birthday = item.Birthday?.ToString("yyyy-MM-dd") ?? String.Empty,

                    MaritalStatus = item.MaritalStatus?.ToString() ?? string.Empty,
                    MaritalStatusName = (!string.IsNullOrWhiteSpace(item.MaritalStatus) && empMaritalStatus.Any(p => p.ID == item.MaritalStatus)) ? empMaritalStatus.FirstOrDefault(p => p.ID == item.MaritalStatus).Name : string.Empty,

                    FirstWorkedDate = item.FirstWorkedDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                    OnboardDate = item.OnboardDate?.ToString("yyyy-MM-dd") ?? String.Empty,

                    Nationality = item.Nationality?.ToString() ?? string.Empty,
                    NationalityName = empNationalityName,

                    OfficeAreaID = item.OfficeAreaID != null && item.OfficeAreaID.Value != Guid.Empty ? item.OfficeAreaID.Value.ToString() : string.Empty,
                    OFDetailAddress = empAreaName,

                    item.HukouAddress,
                    item.EmployeeEMail,

                    EmpStatus = item.EmpStatus?.ToString() ?? string.Empty,
                    EmpStatusName = empStatusName,

                    EmployeeStatus = item.EmployeeStatus?.ToString() ?? string.Empty,
                    EmployeeStatusName = empEmployeeStatusName,

                    item.OrganizationID,
                    item.OrganizationCode,
                    item.OrganizationName,

                    MainJobPositionID = (item.MainJobPositionID != null && item.MainJobPositionID.Value != Guid.Empty) ? item.MainJobPositionID.Value.ToString() : string.Empty,
                    MainJobPositionName = MainJobPositionName,

                    SalaryLevelID = (item.SalaryLevelID != null && item.SalaryLevelID.Value != Guid.Empty) ? item.SalaryLevelID.Value.ToString() : string.Empty,
                    SalaryLevelName = (item.SalaryLevelID != null && item.SalaryLevelID.Value != Guid.Empty && empSalaryLevelTypes.Any(p => p.ID == item.SalaryLevelID.Value.ToString())) ? empSalaryLevelTypes.FirstOrDefault(p => p.ID == item.SalaryLevelID.Value.ToString()).Name : string.Empty,

                    item.ExtCode,
                    item.TeleCode,
                    item.PersonalEmail,
                    item.Education,
                    item.PersonalCellPhone,
                    item.CPFAccount,
                    item.EmergencyCellPhone,

                    FileTransferInDate = item.FileTransferInDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                    FileTransferOutDate = item.FileTransferOutDate?.ToString("yyyy-MM-dd") ?? String.Empty,

                    PoliticalStatus = item.PoliticalStatus,
                    PoliticalStatusName = empPoliticalStatusName,

                    item.TAG,
                    item.Description,
                    item.UserName,
                    item.MLAccount,

                    NoTrial = item.NoTrial != null ? item.NoTrial.Value : false,
                    TrialBeginDate = item.TrialBeginDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                    TrialEndDate = item.TrialEndDate?.ToString("yyyy-MM-dd") ?? String.Empty,

                    item.CreateTime,
                    item.CreateUserID,
                    item.UpdateTime,
                    item.UpdateUserID,
                    item.IsDeleted,
                    item.LegalEntityID,
                    item.TenantID,

                    Ethnic = item.Ethnic?.ToString() ?? string.Empty,
                    EthnicName = empEthnicName,

                    ProfessionalTitle = item.ProfessionalTitle,
                    ProfessionalTitleName = CommonDictService.GetDictItemName(item.ProfessionalTitle),

                    item.SupplHousingAccount,

                    TerminationDate = item.TerminationDate?.ToString("yyyy-MM-dd") ?? string.Empty,
                    TerminationTypeName = item.TerminationTypeName,

                    item.PhotoAttachmentID,

                    Country = address?.Country ?? string.Empty,
                    Area = area,
                    Address = address?.Address ?? string.Empty,
                    ZipCode = address?.ZipCode ?? string.Empty,
                    AddressPhone = address?.AddressPhone ?? string.Empty,

                    HujiCountry = hujiaddress?.Country ?? string.Empty,
                    HujiArea = hujiarea,
                    HujiAddress = hujiaddress?.Address ?? string.Empty,
                    HujiZipCode = hujiaddress?.ZipCode ?? string.Empty,
                    HujiAddressPhone = hujiaddress?.AddressPhone ?? string.Empty,

                    BankNumber = bank?.BankNumber ?? string.Empty,
                    BankName = bank?.BankName ?? string.Empty,
                    BanksName = CommonDictService.GetDictItemName(bank?.BankName ?? string.Empty),
                    BankAddress = bank?.Address ?? string.Empty,
                    BankBranchCode = bank?.BankBranchCode ?? string.Empty,
                    BankBranchName = bankBranchName,
                    AccountName = bank?.AccountName ?? string.Empty,
                    BankCity = bank?.BankCity ?? string.Empty,

                    PartyJoinInDate = item.PartyJoinInDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                    ADAccount = item.ADAccount
                },
                dataSources = new
                {
                    dsEmpStatus = this.GetEmpStatusList(item.LegalEntityID),
                    dsIDType = this.GetIDTypeList(item.LegalEntityID),
                    dsGender = this.GetGenderList(item.LegalEntityID),
                    dsMaritalStatus = empMaritalStatus,
                    dsNationality = this.GetNationalityStatusList(item.LegalEntityID),
                    dsEmployeeStatus = this.GetEmployeeStatusList(item.LegalEntityID),
                    dsPoliticalStatus = this.GetPoliticalStatusList(item.LegalEntityID),
                    dsBankName = this.GetBankNameList(item.LegalEntityID),
                    dsSalaryLevels = empSalaryLevelTypes,
                    dsEthnic = CommonDictService.GetDictItems(DictConstants.HR_EMP_Ethnic, item.LegalEntityID),
                    dsProfessionalTitle = CommonDictService.GetDictItems(DictConstants.HR_EMP_ProfessionalTitle, item.LegalEntityID),
                    dsCountry = GetCountryList(item.LegalEntityID),
                    employeeTypeTree = GetEmployeeTypeTree(context)
                }
            };
        }
        public BusinessResult IsOrgSetCostCenter(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var dc = (HRDbContext)objectContext;

            var orgId = Guid.Parse(context.Request["orgId"]);

            var costcenterCode = dc.HR_ORG_Organization.SingleOrDefault(m => m.IsDeleted == false && m.OrganizationID == orgId)?.CostCenterCode;

            return Success(!string.IsNullOrWhiteSpace(costcenterCode));
        }

        protected override void CreateHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var employeeType = context.Request["EmployeeType"];
            var content = context.Content as JObject;
            var data = content["formdata"];
            var o = item as HR_EMP_Employee;

            o.EmployeeType = employeeType;

            if (Convert.ToBoolean((string)data["NoTrial"]))
            {
                o.NoTrial = true;
                o.TrialBeginDate = null;
                o.TrialEndDate = null;
            }

            string officeArea = (string)data["OfficeAreaID"];
            Guid? guidOfficeArea = null;
            Guid tmp;

            if (!string.IsNullOrEmpty(officeArea) && Guid.TryParse(officeArea, out tmp))
                guidOfficeArea = tmp;

            if (!string.IsNullOrEmpty((string)data["empId"]) && Guid.TryParse((string)data["empId"], out tmp))
                o.EmployeeID = tmp;
            else
                o.EmployeeID = Guid.NewGuid();

            var dc = objectContext as HRDbContext;

            if (o.OrganizationID != null)
            {
                HR_ORG_Organization org = (from b in dc.HR_ORG_Organization
                                           where b.OrganizationID == o.OrganizationID
                                           select b).FirstOrDefault();
                o.OrganizationCode = org.OrganizationCode;
                o.OrganizationName = org.OrganizationName;
                o.LegalEntityID = org.LegalEntityID;
            }

            #region "Emp's Job Position"
            var strPosId = (string)data["JobPositionID"];
            var pos = default(SysOrgPosition);

            if (!string.IsNullOrEmpty(strPosId) && Guid.TryParse(strPosId, out tmp))
            {
                pos = this.GetBizService<IBizOrganizationService>().GetSysOrgPositions(new string[] { tmp.ToString() }).FirstOrDefault();
            }

            if ((o.EmpStatus == "0|" + DictConstants.HR_EMP_EmpStatus ||
                 o.EmpStatus == "2|" + DictConstants.HR_EMP_EmpStatus))
            {
                if (pos == null)
                {
                    throw new BusinessException("职位错误");
                }
            }

            if (pos != null)
            {
                var empPos = new HR_EMP_PostInformation()
                {
                    PostInformationID = Guid.NewGuid(),
                    EmployeeID = o.EmployeeID,
                    PositionID = Guid.Parse(pos.Id),
                    IsMain = true,
                    IsFunctionPosition = true,
                    OfficeBeginDate = o.OnboardDate ?? DateTime.Today,
                    OrganizationID = Guid.Parse(pos.OrgId),
                    LegalEntityID = pos.LegalId,
                    TenantID = o.TenantID,
                    IsDeleted = false,
                    CreateUserID = GetCurrentCredential().UserGuid(),
                    CreateTime = DateTime.Now
                };

                dc.Entry(empPos).State = EntityState.Added;

                o.MainJobPositionID = Guid.Parse(pos.Id);
                o.MainJobPostionName = pos.Name;
            }
            #endregion

            #region "Emp's Salary Level"
            var salaryLevelID = Guid.Empty;

            if (Guid.TryParse(Convert.ToString(data["SalaryLevelID"]), out salaryLevelID) &&
                salaryLevelID != Guid.Empty)
            {
                var sl = dc.HR_EMP_SalaryLevel.SingleOrDefault(p => p.SalaryLevelID == salaryLevelID);

                if (sl != null)
                {
                    o.SalaryLevelID = sl.SalaryLevelID;
                    o.SalaryLevelType = sl.SalaryLevelType;
                }
            }
            #endregion

            //o.LegalEntityID = context.Credential.LegalGuid();
            o.TenantID = context.Credential.TenantGuid();
            o.HukouAddress = (string)data["HukouAddress"];
            o.OfficeAreaID = guidOfficeArea;
            o.CreateTime = DateTime.Now;
            o.CreateUserID = context.Credential.UserGuid();
            o.UpdateTime = DateTime.Now;
            o.UpdateUserID = context.Credential.UserGuid();

            #region "联系住址"
            HR_EMP_Address address = new HR_EMP_Address();

            address.AddressID = Guid.NewGuid();
            address.EmployeeID = o.EmployeeID;
            address.AddressType = "0";
            address.Country = (string)data["Country"];

            var str = (string)data["Area"];

            if (!string.IsNullOrEmpty(str))
            {
                string[] sArray = str.Split('/');
                if (sArray.Length > 0)
                    address.Province = sArray[0].ToString();
                if (sArray.Length > 1)
                    address.City = sArray[1].ToString();
                if (sArray.Length > 2)
                    address.District = sArray[2].ToString();
            }

            address.Address = (string)data["Address"];
            address.AddressPhone = (string)data["AddressPhone"];
            address.ZipCode = (string)data["ZipCode"];
            address.CreateTime = DateTime.Now;
            address.CreateUserID = o.CreateUserID;
            address.UpdateTime = DateTime.Now;
            address.UpdateUserID = o.UpdateUserID;
            address.IsDeleted = false;
            address.LegalEntityID = o.LegalEntityID;
            address.TenantID = this.GetCurrentCredential().TenantGuid();

            objectContext.Entry(address).State = EntityState.Added;
            #endregion

            #region "户籍地址"
            HR_EMP_Address hjaddress = new HR_EMP_Address();

            hjaddress.AddressID = Guid.NewGuid();
            hjaddress.EmployeeID = o.EmployeeID;
            hjaddress.AddressType = "1";
            hjaddress.Country = (string)data["HujiCountry"];

            string Hujistr = ((string)data["HujiArea"]) ?? String.Empty;

            if (!string.IsNullOrEmpty(Hujistr))
            {
                string[] HujiArray = Hujistr.Split('/');

                if (HujiArray.Length > 0)
                    hjaddress.Province = HujiArray[0].ToString();

                if (HujiArray.Length > 1)
                    hjaddress.City = HujiArray[1].ToString();

                if (HujiArray.Length > 2)
                    hjaddress.District = HujiArray[2].ToString();
            }

            hjaddress.Address = (string)data["HujiAddress"];
            hjaddress.AddressPhone = (string)data["HujiAddressPhone"];
            hjaddress.ZipCode = (string)data["HujiZipCode"];
            hjaddress.CreateTime = DateTime.Now;
            hjaddress.CreateUserID = o.CreateUserID;
            hjaddress.UpdateTime = DateTime.Now;
            hjaddress.UpdateUserID = o.UpdateUserID;
            hjaddress.IsDeleted = false;
            hjaddress.LegalEntityID = o.LegalEntityID;
            hjaddress.TenantID = this.GetCurrentCredential().TenantGuid();

            objectContext.Entry(hjaddress).State = EntityState.Added;
            #endregion

            #region "银行账户"
            if (!string.IsNullOrWhiteSpace((string)data["BankNumber"])
                && !string.IsNullOrWhiteSpace(context.Request["BankName"])
                && !string.IsNullOrWhiteSpace((string)data["BankCity"])
                && !string.IsNullOrWhiteSpace(context.Request["BankBranchCode"])
                && !string.IsNullOrWhiteSpace((string)data["AccountName"]))
            {
                HR_EMP_BankCard bank = new HR_EMP_BankCard();

                bank.BankID = Guid.NewGuid();
                bank.EmployeeID = o.EmployeeID;
                bank.BankNumber = (string)data["BankNumber"];
                bank.AccountName = (string)data["AccountName"];
                //bank.BankName = (string)data["BankName"];
                bank.BankName = context.Request["BankName"];
                bank.BankCity = (string)data["BankCity"];
                //bank.Address = (string)data["Address"];
                bank.Address = context.Request["BankBranchName"];
                bank.BankBranchCode = context.Request["BankBranchCode"];
                bank.IsWageCard = true;
                bank.CreateTime = DateTime.Now;
                bank.CreateUserID = o.CreateUserID;
                bank.UpdateTime = DateTime.Now;
                bank.UpdateUserID = o.UpdateUserID;
                bank.IsDeleted = false;
                bank.LegalEntityID = o.LegalEntityID;
                bank.TenantID = this.GetCurrentCredential().TenantGuid();

                objectContext.Entry(bank).State = EntityState.Added;
            }
            #endregion

            #region "新增员工福利积分账户和激励积分账户"            

            //var staffAccountAdd = dc.HR_POINT_StaffAccounts.Create();

            //staffAccountAdd.BalancePoint = 0;
            //staffAccountAdd.CreateTime = DateTime.Now;
            //staffAccountAdd.CreateUserID = context.Credential.UserGuid();
            //staffAccountAdd.EmployeeID = o.EmployeeID;
            //staffAccountAdd.IsDeleted = false;
            //staffAccountAdd.LegalEntityID = o.LegalEntityID;
            //staffAccountAdd.ProcessedPoint = 0m;
            //staffAccountAdd.StaffAccountID = Guid.NewGuid();
            //staffAccountAdd.TenantID = context.Credential.TenantGuid();
            //staffAccountAdd.TotalAwardedPoint = 0;
            //staffAccountAdd.TotalExchangedPoint = 0m;
            //staffAccountAdd.EmployeeNameCN = o.EmployeeNameCN;
            //staffAccountAdd.Gender = o.Gender;
            //staffAccountAdd.Birthday = o.Birthday;
            //staffAccountAdd.OnboardDate = o.OnboardDate;
            //staffAccountAdd.EmployeeEMail = o.EmployeeEMail;
            //staffAccountAdd.PersonalCellPhone = o.PersonalCellPhone;
            //staffAccountAdd.TeleCode = o.TeleCode;
            //staffAccountAdd.ExtCode = o.ExtCode;
            //staffAccountAdd.IDType = o.IDType;
            //staffAccountAdd.IDNumber = o.IDNumber;
            //dc.Entry(staffAccountAdd).State = System.Data.Entity.EntityState.Added;

            //var staffBAccountAdd = dc.HR_POINT_StaffBenefitAccounts.Create();

            //staffBAccountAdd.BalancePoint = 0;
            //staffBAccountAdd.CreateTime = DateTime.Now;
            //staffBAccountAdd.CreateUserID = context.Credential.UserGuid();
            //staffBAccountAdd.EmployeeID = o.EmployeeID;
            //staffBAccountAdd.IsDeleted = false;
            //staffBAccountAdd.LegalEntityID = o.LegalEntityID;
            //staffBAccountAdd.ProcessedPoint = 0m;
            //staffBAccountAdd.StaffAccountID = Guid.NewGuid();
            //staffBAccountAdd.TenantID = context.Credential.TenantGuid();
            //staffBAccountAdd.TotalAwardedPoint = 0;
            //staffBAccountAdd.TotalExchangedPoint = 0m;
            //staffBAccountAdd.EmployeeNameCN = o.EmployeeNameCN;
            //staffBAccountAdd.Gender = o.Gender;
            //staffBAccountAdd.Birthday = o.Birthday;
            //staffBAccountAdd.OnboardDate = o.OnboardDate;
            //staffBAccountAdd.EmployeeEMail = o.EmployeeEMail;
            //staffBAccountAdd.PersonalCellPhone = o.PersonalCellPhone;
            //staffBAccountAdd.TeleCode = o.TeleCode;
            //staffBAccountAdd.ExtCode = o.ExtCode;
            //staffBAccountAdd.IDType = o.IDType;
            //staffBAccountAdd.IDNumber = o.IDNumber;
            //dc.Entry(staffBAccountAdd).State = System.Data.Entity.EntityState.Added;
            #endregion

            dc.SaveChanges();

            #region "Sync with SYS_USER"
            if ((o.EmpStatus == "0|" + DictConstants.HR_EMP_EmpStatus || o.EmpStatus == "2|" + DictConstants.HR_EMP_EmpStatus) && !string.IsNullOrEmpty(o.UserName))
            {
                var posGuid = Guid.Parse(pos.Id);
                EmployeeUser empUser = new EmployeeUser()
                {
                    Id = o.EmployeeID,
                    Email = o.EmployeeEMail,
                    Name = o.EmployeeNameCN,
                    EmployeeNo = o.EmployeeNumber,
                    Enable = true,
                    LegalId = o.LegalEntityID,
                    LoginName = o.UserName,
                    OrgId = o.OrganizationID.GetValueOrDefault(Guid.Empty),
                    MainPositionId = posGuid,
                    EmployeeStatus = o.EmpStatus,
                    Password = Yar.Core.YarSystem.Current.AppSettings["EmployeeOnboardInitPassword"],
                    TenantId = o.TenantID,
                    Positions = new[] { posGuid.ToString("D") },
                    PhotoAttachmentID = o.PhotoAttachmentID.ToString()
                };

                (GetBizService<IBizEmployeeService>()).SaveEmployeeUser(empUser);
            }
            #endregion
        }

        protected override void EditHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var employeeType = context.Request["EmployeeType"];
            var content = context.Content as JObject;
            var data = content["formdata"];
            var o = item as HR_EMP_Employee;

            #region Server Validation
            if (!o.EmpStatus.Equals("1|" + DictConstants.HR_EMP_EmpStatus))
            {
                if (o.EmployeeEMail != null && o.EmployeeEMail.Length > 50)
                {
                    throw new BusinessException("工作邮箱长度不能超过50");
                }
            }
            #endregion

            o.UpdateTime = DateTime.Now;
            o.UpdateUserID = context.Credential.UserGuid();
            o.EmployeeType = employeeType;

            if (Convert.ToBoolean((string)data["NoTrial"]))
            {
                o.NoTrial = true;
                o.TrialBeginDate = null;
                o.TrialEndDate = null;
            }

            var dc = objectContext as HRDbContext;

            #region "Emp's Organization"
            if (o.OrganizationID != null)
            {
                HR_ORG_Organization org = (from b in dc.HR_ORG_Organization
                                           where b.OrganizationID == o.OrganizationID
                                           select b).FirstOrDefault();

                o.OrganizationCode = org.OrganizationCode;
                o.OrganizationName = org.OrganizationName;
                o.LegalEntityID = org.LegalEntityID;

                if (dc.Entry(o).OriginalValues["OrganizationID"] != dc.Entry(o).CurrentValues["OrganizationID"])
                {
                    if (o.CostCenterMode == CommonDictService.GetDictItemValue<int>("Dept|CostCenterMode"))
                    {
                        o.CostCenterCode = org.CostCenterCode;
                        //TODO: 变更NC中CostCenter
                    }
                }
            }
            #endregion

            #region "Emp's Job Position"
            if (o.MainJobPositionID != null)
            {
                HR_ORG_Position pos = (from c in dc.HR_ORG_Position
                                       where c.PositionID == o.MainJobPositionID
                                       select c).FirstOrDefault();

                o.MainJobPostionName = pos.PositionName;
            }
            #endregion

            #region "Emp's Salary Level"
            var salaryLevelID = Guid.Empty;

            if (Guid.TryParse(Convert.ToString(data["SalaryLevelID"]), out salaryLevelID) &&
                salaryLevelID != Guid.Empty)
            {
                var sl = dc.HR_EMP_SalaryLevel.SingleOrDefault(p => p.SalaryLevelID == salaryLevelID);

                if (sl != null)
                {
                    o.SalaryLevelID = sl.SalaryLevelID;
                    o.SalaryLevelType = sl.SalaryLevelType;
                }
            }
            #endregion

            #region "联系地址"
            var resultAddr = from a in dc.HR_EMP_Address
                             where !a.IsDeleted && a.EmployeeID == o.EmployeeID && a.AddressType == "0"
                             select a;
            var address = resultAddr.FirstOrDefault();

            if (address == null)
            {
                address = new HR_EMP_Address();
                address.AddressID = Guid.NewGuid();

                address.AddressType = "0";

                address.CreateUserID = context.Credential.UserGuid();
                address.CreateTime = DateTime.Now;
                address.LegalEntityID = o.LegalEntityID;
                address.TenantID = o.TenantID;

                objectContext.Entry(address).State = EntityState.Added;
            }
            else
            {
                objectContext.Entry(address).State = EntityState.Modified;
            }

            address.Country = (string)data["Country"];

            string str = (string)data["Area"];

            if (!string.IsNullOrEmpty(str))
            {
                string[] sArray = str.Split('/');

                if (sArray.Length > 0)
                    address.Province = sArray[0].ToString();

                if (sArray.Length > 1)
                    address.City = sArray[1].ToString();

                if (sArray.Length > 2)
                    address.District = sArray[2].ToString();
            }

            address.Address = (string)data["Address"];
            address.AddressPhone = (string)data["AddressPhone"];
            address.ZipCode = (string)data["ZipCode"];
            address.UpdateTime = DateTime.Now;
            address.UpdateUserID = o.UpdateUserID;
            address.IsDeleted = false;
            //address.TenantID = this.GetCurrentCredential().TenantGuid(); 
            #endregion

            #region "户籍地址"
            var resultHujiAddr = from a in dc.HR_EMP_Address
                                 where !a.IsDeleted && a.EmployeeID == o.EmployeeID && a.AddressType == "1"
                                 select a;
            var addressHuji = resultHujiAddr.FirstOrDefault();

            if (addressHuji == null)
            {
                addressHuji = new HR_EMP_Address();
                addressHuji.AddressID = Guid.NewGuid();

                addressHuji.AddressType = "1";

                addressHuji.CreateUserID = context.Credential.UserGuid();
                addressHuji.CreateTime = DateTime.Now;
                addressHuji.LegalEntityID = o.LegalEntityID;
                addressHuji.TenantID = o.TenantID;

                objectContext.Entry(addressHuji).State = EntityState.Added;
            }
            else
            {
                objectContext.Entry(addressHuji).State = EntityState.Modified;
            }

            addressHuji.Country = (string)data["HujiCountry"];

            string Hujistr = (string)data["HujiArea"];

            if (!string.IsNullOrEmpty(Hujistr))
            {
                string[] HujiArray = Hujistr.Split('/');

                if (HujiArray.Length > 0)
                    addressHuji.Province = HujiArray[0].ToString();

                if (HujiArray.Length > 1)
                    addressHuji.City = HujiArray[1].ToString();

                if (HujiArray.Length > 2)
                    addressHuji.District = HujiArray[2].ToString();
            }

            addressHuji.Address = (string)data["HujiAddress"];
            addressHuji.AddressPhone = (string)data["HujiAddressPhone"];
            addressHuji.ZipCode = (string)data["HujiZipCode"];
            addressHuji.UpdateTime = DateTime.Now;
            addressHuji.UpdateUserID = o.UpdateUserID;
            addressHuji.IsDeleted = false;
            //addressHuji.TenantID = this.GetCurrentCredential().TenantGuid();
            //objectContext.Entry(addressHuji).State = EntityState.Modified; 
            #endregion

            #region "银行账户"
            var resultBank = from b in dc.HR_EMP_BankCard
                             where b.EmployeeID == o.EmployeeID && !b.IsDeleted
                             select b;
            var bank = resultBank.FirstOrDefault();

            if (bank == null)
            {
                bank = new HR_EMP_BankCard();
                bank.BankID = Guid.NewGuid();

                bank.EmployeeID = o.EmployeeID;

                bank.CreateUserID = context.Credential.UserGuid();
                bank.CreateTime = DateTime.Now;
                bank.LegalEntityID = o.LegalEntityID;
                bank.TenantID = o.TenantID;

                bank.BankNumber = (string)data["BankNumber"];
                //bank.BankName = (string)data["BankName"];
                bank.BankName = context.Request["BankName"];
                bank.BankCity = (string)data["BankCity"];
                //bank.Address = (string)data["BankAddress"];
                bank.Address = context.Request["BankBranchName"];
                bank.BankBranchCode = context.Request["BankBranchCode"];
                bank.AccountName = o.EmployeeNameCN;
                bank.IsWageCard = true;
                //bank.UpdateTime = DateTime.Now;
                //bank.UpdateUserID = o.UpdateUserID;
                bank.IsDeleted = false;

                objectContext.Entry(bank).State = EntityState.Added;
            }
            else
            {
                bank.BankNumber = (string)data["BankNumber"];
                //bank.BankName = (string)data["BankName"];
                bank.BankName = context.Request["BankName"];
                bank.BankCity = (string)data["BankCity"];
                //bank.Address = (string)data["BankAddress"];
                bank.Address = context.Request["BankBranchName"];
                bank.BankBranchCode = context.Request["BankBranchCode"];
                bank.AccountName = o.EmployeeNameCN;
                bank.IsWageCard = true;
                bank.UpdateTime = DateTime.Now;
                bank.UpdateUserID = o.UpdateUserID;
                bank.IsDeleted = false;

                objectContext.Entry(bank).State = EntityState.Modified;
            }
            #endregion

            dc.SaveChanges();

            #region "Sync with SYS_USER"
            
            var empService = GetBizService<IBizEmployeeService>();
            var empUser = empService.GetEmployeeUser(o.EmployeeID);
            
            if (o.EmpStatus == "0|" + DictConstants.HR_EMP_EmpStatus ||
                o.EmpStatus == "2|" + DictConstants.HR_EMP_EmpStatus)
            {
                if (!string.IsNullOrEmpty(o.UserName))
                {
                    if (empUser == null)
                    {
                        empUser = new EmployeeUser();
                        empUser.Id = o.EmployeeID;
                    }

                    empUser.Email = o.EmployeeEMail;
                    empUser.Name = o.EmployeeNameCN;
                    empUser.EmployeeNo = o.EmployeeNumber;
                    empUser.Enable = true;
                    empUser.LegalId = o.LegalEntityID;
                    empUser.LoginName = o.UserName;
                    empUser.OrgId = o.OrganizationID.GetValueOrDefault(Guid.Empty);
                    empUser.MainPositionId = o.MainJobPositionID.GetValueOrDefault(Guid.Empty);
                    //Password = "111111",
                    empUser.TenantId = o.TenantID;
                    empUser.PhotoAttachmentID = o.PhotoAttachmentID.ToString();
                }
                

            }
            else
            {
                if (empUser != null && empUser.Enable)
                {
                    empUser.Enable = false;
                }
            }

            if (empUser != null)
            {
                empUser.EmployeeStatus = o.EmpStatus;
                empService.SaveEmployeeUser(empUser);
            }
            #endregion

            //var financeService = GetBizService<IBizFinanceService>();
            //var costCenter = financeService.GetCostCenterByUserId(o.EmployeeID);

            //if (!string.IsNullOrWhiteSpace(costCenter.CostCenterCode))
            //{
            //    // NC队列
            //    var ncService = GetBizService<IBiz_NCService>();

            //    NCQueueInfo nc = new NCQueueInfo();

            //    nc.RequestType = (int)Enumerator.NCRequestType.GT01;
            //    nc.RequestSubType = (int)Enumerator.NCRequestSubType.EmployeeEdit;
            //    nc.KeyID = o.EmployeeID;
            //    nc.KeyCode = o.EmployeeNumber;
            //    nc.SendState = (int)Enumerator.NCSendState.Wait;
            //    //nc.RequestXml = ncQueue.RequestXml;
            //    //nc.RequestTime = ncQueue.RequestTime;
            //    //nc.ResponseXml = ncQueue.ResponseXml; 
            //    nc.CallBackState = (int)Enumerator.NCCallBackState.NoNeed;
            //    //nc.CallBackRequestXml = ncQueue.CallBackRequestXml;
            //    //nc.CallBackRequestTime = ncQueue.CallBackRequestTime;
            //    //nc.CallBackResponseXml = ncQueue.CallBackResponseXml;
            //    nc.CreateTime = DateTime.Now;
            //    nc.CreateUserID = context.Credential.UserGuid();
            //    //nc.UpdateTime = ncQueue.UpdateTime;
            //    //nc.UpdateUserID = ncQueue.UpdateUserID;
            //    nc.IsDeleted = false;
            //    nc.LegalEntityID = context.Credential.LegalGuid();
            //    nc.TenantID = context.Credential.TenantGuid();

            //    ncService.AddNCQueue(nc);
            //}

        }

        protected override void FalseDeleteHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            item.IsDeleted = true;
            item.UpdateTime = DateTime.Now;
            item.UpdateUserID = context.Credential.LegalGuid();
        }

        public BusinessResult DeleteAll(BusinessContext context)
        {
            string ids = context.Request["ids"];
            using (TransactionScope scope = new TransactionScope())
            {
                using (var dc = new HRDbContext())
                {
                    var list = ids.Split(';');
                    var lstGuid = list.Select(t => Guid.Parse(t)).ToArray();
                    //var inlist = list.Select(i => Convert.ToInt32(i)).ToArray();
                    var employees = dc.HR_EMP_Employee.Where(item => !item.IsDeleted && lstGuid.Contains(item.EmployeeID));
                    if (employees.Any(t => t.EmpStatus != "1|HR_EMP_EmpStatus"))
                    {
                        var names = string.Join("、",
                            employees.Where(t => t.EmpStatus != "1|HR_EMP_EmpStatus")
                                .Select(t => t.EmployeeNameCN)
                                .ToArray());
                        throw new BusinessException(names + " 员工不可删除， 只有待入职状态的员工才可删除");
                    }
                    foreach (var entity in employees)
                    {
                        entity.IsDeleted = true;
                        entity.UpdateTime = DateTime.Now;
                        entity.UpdateUserID = context.Credential.LegalGuid();

                        dc.Entry(entity).State = EntityState.Modified;
                    }

                    dc.SaveChanges();

                    var empService = GetBizService<IBizEmployeeService>();
                    var empList = employees.Select(t => t.EmployeeID).ToArray();
                    empService.DeleteEmployeeUser(empList);

                    //foreach (var emp in employees)
                    //{
                    //    // NC队列
                    //    var ncService = GetBizService<IBiz_NCService>();

                    //    NCQueueInfo nc = new NCQueueInfo();

                    //    nc.RequestType = (int)Enumerator.NCRequestType.GT01;
                    //    nc.RequestSubType = (int)Enumerator.NCRequestSubType.EmployeeDelete;
                    //    nc.KeyID = emp.EmployeeID;
                    //    nc.KeyCode = emp.EmployeeNumber;
                    //    nc.SendState = (int)Enumerator.NCSendState.Wait;
                    //    //nc.RequestXml = ncQueue.RequestXml;
                    //    //nc.RequestTime = ncQueue.RequestTime;
                    //    //nc.ResponseXml = ncQueue.ResponseXml; 
                    //    nc.CallBackState = (int)Enumerator.NCCallBackState.NoNeed;
                    //    //nc.CallBackRequestXml = ncQueue.CallBackRequestXml;
                    //    //nc.CallBackRequestTime = ncQueue.CallBackRequestTime;
                    //    //nc.CallBackResponseXml = ncQueue.CallBackResponseXml;
                    //    nc.CreateTime = DateTime.Now;
                    //    nc.CreateUserID = context.Credential.UserGuid();
                    //    //nc.UpdateTime = ncQueue.UpdateTime;
                    //    //nc.UpdateUserID = ncQueue.UpdateUserID;
                    //    nc.IsDeleted = false;
                    //    nc.LegalEntityID = context.Credential.LegalGuid();
                    //    nc.TenantID = context.Credential.TenantGuid();

                    //    ncService.AddNCQueue(nc);
                    //}

                    scope.Complete();

                    return this.Success();
                }

            }

        }
        #endregion
        #region job
        public BusinessResult JobTabView(BusinessContext context)
        {
            //获取员工id
            string resId = context.Request["resId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_PostInformation.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetJobViewModelData(objectContext, context, item, resId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeJobTab.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        public BusinessResult IJobTabView(BusinessContext context)
        {
            //获取员工id
            string resId = context.Request["resId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_PostInformation.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetJobViewModelData(objectContext, context, item, resId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeIJobTab.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        public BusinessResult NJobTabView(BusinessContext context)
        {
            //获取员工id
            string resId = context.Request["resId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_PostInformation.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetJobViewModelData(objectContext, context, item, resId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeNJobTab.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        public BusinessResult GetJobList(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            //var objectSet = this.CreateObjectSet(context, objectContext);
            var objectSet = ((HRDbContext)objectContext).HR_EMP_PostInformation;
            var result = JobListHander(objectContext, context, objectSet);
            return this.CreateResult(BusinessStatusCode.OK, result);
        }

        protected object JobListHander(DbContext objectContext, BusinessContext context, IQueryable<dynamic> objectSet)
        {
            var dbContext = objectContext as HRDbContext;

            var nq = from p in dbContext.HR_EMP_PostInformation
                     join l in dbContext.HR_ORG_LegalEntity on p.LegalEntityID equals l.LegalEntityID
                     join q in dbContext.HR_ORG_Position on p.PositionID equals q.PositionID
                     join o in dbContext.HR_ORG_Organization on p.OrganizationID equals o.OrganizationID
                     //join a in dbContext.HR_ORG_JobLevels on p.JobLevelID equals a.JobLevelID
                     where p.IsDeleted == false && p.IsFunctionPosition == true
                     select new
                     {
                         p.PostInformationID,
                         p.EmployeeID,
                         p.IsFunctionPosition,
                         p.PositionID,
                         p.OrganizationID,
                         //p.JobLevelID,
                         //p.EmployeeStatus,
                         p.OfficeBeginDate,
                         p.OfficeEndDate,
                         p.IsMain,
                         p.LegalEntityID,
                         p.CreateTime,
                         l.LegalEntityName,
                         q.PositionCode,
                         q.PositionName,
                         o.OrganizationName,
                         //a.JobLevelName,
                         Main = p.IsMain ? "主职位" : "非主职位"
                     };

            var sort = context.Request["sort"];
            var order = context.Request["order"];

            string resId = context.Request["resId"];

            if (!string.IsNullOrEmpty(resId))
            {
                Guid empId = new Guid(resId);
                nq = nq.Where(item => item.EmployeeID == empId);
            }
            if (string.IsNullOrEmpty(sort))
            {
                nq = nq.OrderBy(g => g.CreateTime);
            }
            else
            {
                nq = nq.OrderBy(string.Format("it.{0} {1}", sort, order));
            }
            int total = 0;
            nq = this.GetPageQuery(context, nq, out total);
            return new
            {
                total = total,
                rows = nq.ToArray().Select(item => new
                {
                    item.PostInformationID,
                    item.EmployeeID,
                    item.IsFunctionPosition,
                    item.PositionID,
                    item.OrganizationID,
                    //item.JobLevelID,
                    //item.EmployeeStatus,
                    OfficeBeginDate = item.OfficeBeginDate.ToString("yyyy-MM-dd"),
                    OfficeEndDate = item.OfficeEndDate?.ToString("yyyy-MM-dd") ?? string.Empty,
                    item.IsMain,
                    item.LegalEntityID,
                    item.LegalEntityName,
                    item.PositionCode,
                    item.PositionName,
                    item.OrganizationName,
                    // item.JobLevelName,
                    // EmployeeStatusName = DictService.GetDictItemName(item.EmployeeStatus),
                    item.Main
                }).ToArray()
            };
        }

        public BusinessResult GetNJobList(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            //var objectSet = this.CreateObjectSet(context, objectContext);
            var objectSet = ((HRDbContext)objectContext).HR_EMP_PostInformation;
            var result = JobNListHander(objectContext, context, objectSet);
            return this.CreateResult(BusinessStatusCode.OK, result);
        }

        protected object JobNListHander(DbContext objectContext, BusinessContext context, IQueryable<dynamic> objectSet)
        {
            var dbContext = objectContext as HRDbContext;

            var nq = from p in dbContext.HR_EMP_PostInformation
                     join l in dbContext.HR_ORG_LegalEntity on p.LegalEntityID equals l.LegalEntityID
                     join q in dbContext.HR_ORG_Position on p.PositionID equals q.PositionID
                     join o in dbContext.HR_ORG_Organization on p.OrganizationID equals o.OrganizationID
                     where p.IsDeleted == false && p.IsFunctionPosition == false
                     select new
                     {
                         p.PostInformationID,
                         p.EmployeeID,
                         p.IsFunctionPosition,
                         p.PositionID,
                         p.OrganizationID,
                         //p.JobLevelID,
                         //p.EmployeeStatus,
                         p.OfficeBeginDate,
                         p.OfficeEndDate,
                         p.IsMain,
                         p.LegalEntityID,
                         p.CreateTime,
                         l.LegalEntityName,
                         q.PositionCode,
                         q.PositionName,
                         o.OrganizationName
                     };

            var sort = context.Request["sort"];
            var order = context.Request["order"];

            string resId = context.Request["resId"];

            if (!string.IsNullOrEmpty(resId))
            {
                Guid empId = new Guid(resId);
                nq = nq.Where(item => item.EmployeeID == empId);
            }
            if (string.IsNullOrEmpty(sort))
            {
                nq = nq.OrderBy(g => g.CreateTime);
            }
            else
            {
                nq = nq.OrderBy(string.Format("it.{0} {1}", sort, order));
            }
            //var dsEmpStatus = this.GetEmpStatusList(context.Credential.LegalGuid());
            int total = 0;
            nq = this.GetPageQuery(context, nq, out total);
            return new
            {
                total = total,
                rows = nq.ToArray().Select(item => new
                {
                    item.PostInformationID,
                    item.EmployeeID,
                    item.IsFunctionPosition,
                    item.PositionID,
                    item.OrganizationID,
                    //item.JobLevelID,
                    //item.EmployeeStatus,
                    OfficeBeginDate = item.OfficeBeginDate.ToString("yyyy-MM-dd"),
                    OfficeEndDate = item.OfficeEndDate?.ToString("yyyy-MM-dd") ?? string.Empty,
                    item.IsMain,
                    item.LegalEntityID,
                    item.LegalEntityName,
                    item.PositionCode,
                    item.OrganizationName,
                    item.PositionName
                }).ToArray()
            };
        }

        public BusinessResult CreateJobView(BusinessContext context)
        {
            //获取员工id
            string empId = context.Request["empId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_PostInformation.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetJobViewModelData(objectContext, context, item, empId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeJobEdit.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        public BusinessResult EditJobView(BusinessContext context)
        {
            //获得学历id
            string resId = context.Request["resId"];
            string empId = context.Request["empId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;

            if (string.IsNullOrEmpty(resId))
            {
                return this.BadRequest();
            }
            else
            {
                //edit
                object resIdVal = resId;

                if (!string.IsNullOrEmpty(this.BizDataModel.ResFieldType))
                {
                    var type = Type.GetType(this.BizDataModel.ResFieldType);
                    resIdVal = CU.ChangeType(resId, type);
                    if (resIdVal == null)
                    {
                        return this.BadRequest();
                    }

                }

                var objectSet = ((HRDbContext)objectContext).HR_EMP_PostInformation;
                IQueryable<object> query = objectSet as IQueryable<object>;

                query = InitEditQuery(query);

                //var ps = query.Where(string.Format("it.{0} == @0", (string)this.BizDataModel.ResField), resIdVal).FirstOrDefault();
                var ps = query.Where(string.Format("it.{0} == @0", "PostInformationID"), resIdVal).FirstOrDefault();

                InitEditViewModel(objectContext, context, ps);

                vmData = GetJobViewModelData(objectContext, context, ps, empId, legalId);
            }

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeJobEdit.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        protected dynamic GetJobViewModelData(DbContext objectContext, BusinessContext context, object dbitem, string employeeId, string legalId)
        {
            var strFP = context.Request["fp"];
            var item = dbitem as HR_EMP_PostInformation;

            if (item.PostInformationID == Guid.Empty)
            {
                item.IsFunctionPosition = "true".Equals(strFP, StringComparison.CurrentCultureIgnoreCase);
                item.OfficeBeginDate = DateTime.Today;
            }

            var dc = objectContext as HRDbContext;
            
            var orgName = string.Empty;
            var upPosName = string.Empty;
            var Positionlist = new List<SelectItem>();
            var defaultOrgID = (Guid?)null;
            var defaultOrgName = string.Empty;
            var defaultLegalID = (Guid?)null;
            var orgService = this.GetBizService<IBizOrganizationService>();
            if (item != null && item.PostInformationID != Guid.Empty)
            {
                Positionlist = orgService.GetSysPositionsOfOrg(new string[] { item.OrganizationID.ToString() }).Select(p => new SelectItem { ID = p.Id, Name = p.Name }).ToList();

                var org = orgService.GetSysOrg(item.OrganizationID);

                if (org != null)
                {
                    orgName = org.Name;
                }

                var pos = orgService.GetReportToPosition(item.PositionID.ToString());

                if (pos != null)
                {
                    upPosName = pos.Name;
                }
            }
            else if (item != null && item.PostInformationID == Guid.Empty && !string.IsNullOrWhiteSpace(employeeId))
            {
                var empID = Guid.Parse(employeeId);
                var emp = dc.HR_EMP_Employee.FirstOrDefault(p => !p.IsDeleted && p.EmployeeID == empID);

                if (emp != null && emp.OrganizationID != null)
                {
                    defaultOrgID = emp.OrganizationID;

                    var org = orgService.GetSysOrg(emp.OrganizationID.Value);

                    if (org != null)
                    {
                        defaultOrgName = org.Name;
                        defaultLegalID = org.LegalId;
                    }
                    
                    Positionlist = orgService.GetSysPositionsOfOrg(new string[] { emp.OrganizationID.Value.ToString() }).Select(p => new SelectItem { ID = p.Id, Name = p.Name }).ToList();
                }
            }

            return new
            {
                form = new
                {
                    ResId = item.PostInformationID,
                    empId = employeeId,
                    IsFP = item.IsFunctionPosition,
                    legalId = legalId,
                    item.PositionID,
                    item.OrganizationID,
                    //item.JobLevelID,
                    //item.EmployeeStatus,
                    OfficeBeginDate = item.OfficeBeginDate.ToString("yyyy-MM-dd"),
                    OfficeEndDate = item.OfficeEndDate?.ToString("yyyy-MM-dd") ?? string.Empty,
                    item.IsMain,
                    item.CreateTime,
                    item.CreateUserID,
                    item.UpdateTime,
                    item.UpdateUserID,
                    item.IsDeleted,
                    item.LegalEntityID,
                    item.TenantID,
                    OrganizationName = orgName,
                    ReportToPositionName = upPosName,

                    DefaultOrganizationID = defaultOrgID != null ? defaultOrgID.Value.ToString() : string.Empty,
                    DefaultOrganizationName = defaultOrgName ?? string.Empty,
                    DefaultLegalEntityID = defaultLegalID != null ? defaultLegalID.Value.ToString() : string.Empty
                },
                dataSources = new
                {
                    dsPositionID = Positionlist,
                    //dsEmployeeStatus = this.GetEmployeeStatusList(context.Credential.LegalGuid()),
                    //dsJobLevelName = JobLevellist
                }
            };
        }

        public BusinessResult JobCreate(BusinessContext context)
        {
            var contentData = context.Content as dynamic;
            DbContext objectContext = this.CreateDbContext();
            var dbContext = objectContext as HRDbContext;
            Guid empId = Guid.Parse(contentData.formdata.empId.ToString());
            Guid positionId = Guid.Parse(contentData.formdata.PositionID.ToString());
            if (dbContext != null)
            {
                Int32 count = (from p in dbContext.HR_EMP_PostInformation.Where(p => p.EmployeeID.Equals(empId)
                         && p.PositionID.Equals(positionId))
                               join q in dbContext.HR_ORG_Position on p.PositionID equals q.PositionID
                               where p.IsDeleted == false
                               && p.IsFunctionPosition == false
                               select p).Count();
                if (count == 0)
                {
                    var item = ((HRDbContext)objectContext).HR_EMP_PostInformation.Create();
                    string listName = "PostInformations";
                    string fields =
                        "PostInformationID, EmployeeID, IsFunctionPosition, PositionID, OrganizationID, OfficeBeginDate, OfficeEndDate, IsMain, CreateTime, CreateUserID, UpdateTime, UpdateUserID, IsDeleted, LegalEntityID, TenantID";
                    return CreateLogic(context, objectContext, item, listName, fields);
                }
                else
                {
                    throw new BusinessException("职位已存在");
                }
            }
            else
            {
                throw new BusinessException("Context Initialization Failed");
            }
        }

        protected void CreateJobHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];
            string str = (string)data["empId"];
            Guid guid = new Guid(str);
            string logal = (string)data["LegalEntityID"];
            Guid guidLogal = new Guid(logal);
            string position = (string)data["PositionID"];
            //Guid guidPosition = new Guid(position);
            //string organization= (string)data["OrganizationID"];
            //Guid guidOrganization = new Guid(organization);
            ////string jobLevel = (string)data["JobLevelID"];
            ////Guid guidJobLevel = new Guid(jobLevel);

            //DateTime? endDate = null;
            //DateTime tmp;
            //if (!string.IsNullOrEmpty(data["OfficeEndDate"].ToString()) &&
            //    DateTime.TryParse(data["OfficeEndDate"].ToString(), out tmp))
            //    endDate = tmp;

            var postInfo = item as HR_EMP_PostInformation;
            postInfo.PostInformationID = Guid.NewGuid();
            postInfo.EmployeeID = guid;
            postInfo.IsFunctionPosition = (bool)data["IsFP"];
            //postInfo.IsMain = (bool)data["IsMain"];
            //postInfo.PositionID = guidPosition;
            ////postInfo.EmployeeStatus= (string)data["EmployeeStatus"];
            ////postInfo.JobLevelID = guidJobLevel;
            //postInfo.OrganizationID = guidOrganization;
            //postInfo.OfficeBeginDate = (DateTime)data["OfficeBeginDate"];
            //postInfo.OfficeEndDate = endDate;
            postInfo.CreateTime = DateTime.Now;
            postInfo.CreateUserID = context.Credential.UserGuid();
            postInfo.UpdateTime = DateTime.Now;
            postInfo.UpdateUserID = context.Credential.UserGuid();
            postInfo.IsDeleted = false;
            postInfo.LegalEntityID = guidLogal;
            postInfo.TenantID = this.GetCurrentCredential().TenantGuid();

            var dc = objectContext as HRDbContext;
            HR_EMP_Employee emp = new HR_EMP_Employee();
            if (postInfo.IsMain == true)
            {
                if (!SetEmpMainJobPosition(postInfo.PositionID, postInfo.EmployeeID))
                    throw new BusinessException("设置主职位出错");
            }

            dc.SaveChanges();

            SyncEmpPostions(postInfo.EmployeeID);

        }

        public BusinessResult JobEdit(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var objectSet = ((HRDbContext)objectContext).HR_EMP_PostInformation;
            string field = "PostInformationID,EmployeeID,IsFunctionPosition,PositionID,OrganizationID,OfficeBeginDate,OfficeEndDate,IsMain" +
                            ",CreateTime,CreateUserID,UpdateTime,UpdateUserID,IsDeleted,LegalEntityID,TenantID";
            string ID = "PostInformationID";
            return EditLogic(context, objectContext, objectSet, field, ID, "PostInformations");
        }

        protected void EditJobHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];
            string str = (string)data["empId"];
            Guid guid = new Guid(str);
            string logal = (string)data["LegalEntityID"];
            Guid guidLogal = new Guid(logal);
            string position = (string)data["PositionID"];
            Guid guidPosition = new Guid(position);
            string organization = (string)data["OrganizationID"];
            Guid guidOrganization = new Guid(organization);
            //string jobLevel = (string)data["JobLevelID"];
            //Guid guidJobLevel = new Guid(jobLevel);

            //DateTime? endDate = null;
            //DateTime tmp;
            //if (!string.IsNullOrEmpty(data["OfficeEndDate"].ToString()) &&
            //    DateTime.TryParse(data["OfficeEndDate"].ToString(), out tmp))
            //    endDate = tmp;

            var postInfo = item as HR_EMP_PostInformation;
            //postInfo.EmployeeID = guid;
            postInfo.IsFunctionPosition = (bool)data["IsFP"];
            //postInfo.IsMain = (bool)data["IsMain"];
            //postInfo.PositionID = guidPosition;
            ////postInfo.EmployeeStatus= (string)data["EmployeeStatus"];
            ////postInfo.JobLevelID = guidJobLevel;
            //postInfo.OrganizationID = guidOrganization;
            //postInfo.OfficeBeginDate = (DateTime)data["OfficeBeginDate"];
            //postInfo.OfficeEndDate = endDate;

            postInfo.UpdateTime = DateTime.Now;
            postInfo.UpdateUserID = context.Credential.UserGuid();
            //postInfo.IsDeleted = false;
            //postInfo.LegalEntityID = guidLogal;
            //postInfo.TenantID = this.GetCurrentCredential().TenantGuid();

            var dc = objectContext as HRDbContext;
            //HR_EMP_Employee emp = new HR_EMP_Employee();
            var origIsMain = dc.Entry(postInfo).OriginalValues["IsMain"];
            if ((bool)origIsMain && !postInfo.IsMain)
            {
                var emp = dc.HR_EMP_Employee.FirstOrDefault(t => !t.IsDeleted && t.EmployeeID == postInfo.EmployeeID);
                if (emp != null)
                {
                    emp.MainJobPositionID = null;
                    emp.MainJobPostionName = string.Empty;

                    dc.Entry(emp).State = EntityState.Modified;
                }
            }
            if (postInfo.IsMain == true)
            {
                if (!SetEmpMainJobPosition(postInfo.PositionID, postInfo.EmployeeID))
                    throw new BusinessException("设置主职位出错");


                // throw new Exception("for test");
                //var positions = from p in dc.HR_ORG_Positions
                //                where p.PositionID == postInfo.PositionID && p.IsDeleted == false
                //                select p;

                //HR_ORG_Position pos = positions.FirstOrDefault();
                //if (pos != null)
                //{
                //    emp.MainJobPositionID = pos.PositionID;
                //    emp.MainJobPostionName = pos.PositionName;
                //}
                //objectContext.Entry(emp).State = EntityState.Modified;
            }

            dc.SaveChanges();

            SyncEmpPostions(postInfo.EmployeeID);

        }

        public BusinessResult ModifyIsMainState(BusinessContext context)
        {
            Guid empPosId = Guid.Parse(context.Request["resId"]);

            if (SetEmpMainJobPosition(empPosId))
            {
                using (var dc = new HRDbContext())
                {

                    var qEmpPos =
                        dc.HR_EMP_PostInformation.Where(t => !t.IsDeleted && t.PostInformationID == empPosId)
                           ;
                    if (qEmpPos.Any())
                    {
                        var empId = qEmpPos.First().EmployeeID;
                        var permissionService = GetBizService<IBizEmployeeService>();

                        EmployeeUser empUser = permissionService.GetEmployeeUser(empId);

                        if (empUser != null)
                        {
                            empUser.MainPositionId = qEmpPos.First().PositionID;
                        }
                    }

                }
                return this.Success();
            }


            throw new BusinessException("变更失败");
        }

        private bool SetEmpMainJobPosition(Guid empPosId)
        {
            using (var scope = new TransactionScope(TransactionScopeOption.Suppress, new TransactionOptions { IsolationLevel = IsolationLevel.ReadCommitted }))
            {
                using (var dc = new HRDbContext())
                {
                    var nq = dc.HR_EMP_PostInformation.Where(t => !t.IsDeleted && t.PostInformationID == empPosId);
                    if (nq.Any())
                    {
                        var job = nq.First();
                        var qMain =
                            dc.HR_EMP_PostInformation.Where(
                                t => !t.IsDeleted && t.IsMain && t.EmployeeID == job.EmployeeID);
                        if (qMain.Any())
                        {
                            foreach (var m in qMain)
                            {
                                m.IsMain = false;
                                m.UpdateTime = DateTime.Now;
                                m.UpdateUserID = this.GetCurrentCredential().UserGuid();
                                dc.Entry(m).State = EntityState.Modified;
                            }
                        }
                        job.IsMain = true;
                        job.UpdateTime = DateTime.Now;
                        job.UpdateUserID = this.GetCurrentCredential().UserGuid();
                        dc.Entry(job).State = EntityState.Modified;

                        var qJobInfo = from j in dc.HR_ORG_Position
                                       join o in dc.HR_ORG_Organization on j.OrganizationID equals o.OrganizationID
                                       where !j.IsDeleted && j.PositionID == job.PositionID
                                       select
                                           new
                                           {
                                               j.PositionID,
                                               j.PositionCode,
                                               j.PositionName,
                                               o.OrganizationID,
                                               o.OrganizationCode,
                                               o.OrganizationName
                                           };
                        if (qJobInfo.Any())
                        {
                            var jobInfo = qJobInfo.First();
                            var qEmp = dc.HR_EMP_Employee.Where(t => !t.IsDeleted && t.EmployeeID == job.EmployeeID);
                            if (qEmp.Any())
                            {
                                var emp = qEmp.First();
                                emp.MainJobPositionID = jobInfo.PositionID;
                                emp.MainJobPostionName = jobInfo.PositionName;
                                emp.UpdateTime = DateTime.Now;
                                emp.UpdateUserID = this.GetCurrentCredential().UserGuid();
                                dc.Entry(emp).State = EntityState.Modified;

                                dc.SaveChanges();
                                scope.Complete();
                                return true;
                            }
                        }

                        SyncEmpPostions(job.EmployeeID);
                    }

                }

            }
            return false;
        }

        private bool SetEmpMainJobPosition(Guid posId, Guid empId)
        {
            using (
                var scope = new TransactionScope(TransactionScopeOption.Suppress,
                    new TransactionOptions { IsolationLevel = IsolationLevel.ReadCommitted }))
            {
                using (var dc = new HRDbContext())
                {

                    var qMain =
                        dc.HR_EMP_PostInformation.Where(
                            t => !t.IsDeleted && t.IsMain && t.EmployeeID == empId);
                    if (qMain.Any())
                    {
                        foreach (var m in qMain)
                        {
                            m.IsMain = false;
                            m.UpdateTime = DateTime.Now;
                            m.UpdateUserID = this.GetCurrentCredential().UserGuid();
                            dc.Entry(m).State = EntityState.Modified;
                        }
                    }


                    var qJobInfo = from j in dc.HR_ORG_Position
                                   join o in dc.HR_ORG_Organization on j.OrganizationID equals o.OrganizationID
                                   where !j.IsDeleted && j.PositionID == posId
                                   select
                                       new
                                       {
                                           j.PositionID,
                                           j.PositionCode,
                                           j.PositionName,
                                           o.OrganizationID,
                                           o.OrganizationCode,
                                           o.OrganizationName
                                       };
                    if (qJobInfo.Any())
                    {
                        var jobInfo = qJobInfo.First();
                        var qEmp = dc.HR_EMP_Employee.Where(t => !t.IsDeleted && t.EmployeeID == empId);
                        if (qEmp.Any())
                        {
                            var emp = qEmp.First();
                            emp.MainJobPositionID = jobInfo.PositionID;
                            emp.MainJobPostionName = jobInfo.PositionName;
                            emp.UpdateTime = DateTime.Now;
                            emp.UpdateUserID = this.GetCurrentCredential().UserGuid();
                            dc.Entry(emp).State = EntityState.Modified;

                            dc.SaveChanges();
                            scope.Complete();
                            return true;
                        }
                    }
                    SyncEmpPostions(empId);
                }

            }
            return false;
        }
        #endregion

        #region Contract
        public BusinessResult EmpContractTabView(BusinessContext context)
        {
            //获取员工id
            string resId = context.Request["resId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_EmployeeContract.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = new { form = new { ResId = "", empId = resId, legalId = legalId }, dataSources = new { } };

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeContractTab.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        //员工合同列表
        public BusinessResult GetContractList(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            //var objectSet = this.CreateObjectSet(context, objectContext);
            var objectSet = ((HRDbContext)objectContext).HR_EMP_EmployeeContract;
            var result = ContractListHander(objectContext, context, objectSet);
            return this.CreateResult(BusinessStatusCode.OK, result);
        }

        protected object ContractListHander(DbContext objectContext, BusinessContext context, IQueryable<dynamic> objectSet)
        {
            var dbContext = objectContext as HRDbContext;

            var nq = dbContext.HR_EMP_EmployeeContract
                     .Where(t => t.IsDeleted == false);

            var sort = context.Request["sort"];
            var order = context.Request["order"];

            string resId = context.Request["resId"];

            if (!string.IsNullOrEmpty(resId))
            {
                Guid empId = new Guid(resId);
                nq = nq.Where(item => item.EmployeeID == empId);
            }
            if (string.IsNullOrEmpty(sort))
            {
                nq = nq.OrderBy(g => g.CreateTime);
            }
            else
            {
                nq = nq.OrderBy(string.Format("it.{0} {1}", sort, order));
            }
            //var dsEmpStatus = this.GetEmpStatusList(context.Credential.LegalGuid());
            int total = 0;
            nq = this.GetPageQuery(context, nq, out total);
            var data = nq.Select(g => new
            {
                g.EmployeeContractID,
                g.EmployeeID,
                g.EmployeeContractNumber,
                g.ContractType,
                g.EmployeeContractBeginDate,
                g.EmployeeContractEndDate,
                g.IsUnfixedTerm,
                g.SignDate,
                g.HaveTrialDate,
                g.SignedTimes
            });
            return new
            {
                total = total,
                rows = data.ToArray().Select(g => new
                {
                    g.EmployeeContractID,
                    g.EmployeeID,
                    g.EmployeeContractNumber,
                    ContractType = CommonDictService.GetDictItemName(g.ContractType),
                    EmployeeContractBeginDate = g.EmployeeContractBeginDate.ToString("yyyy-MM-dd"),
                    EmployeeContractEndDate = g.EmployeeContractEndDate?.ToString("yyyy-MM-dd") ?? (g.IsUnfixedTerm ? "无固定期限" : ""),
                    SignDate = g.SignDate?.ToString("yyyy-MM-dd") ?? "",
                    HaveTrialDate = g.HaveTrialDate ? "有" : "无",
                    g.SignedTimes
                }).ToArray()
            };
        }

        #endregion

        #region 员工履职
        //员工履职GridView显示
        public BusinessResult WorkHistoryTabView(BusinessContext context)
        {
            //获取员工id
            string resId = context.Request["resId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_WorkHistory.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetWorkHistoryViewModelData(objectContext, context, item, resId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeWorkHistoryTab.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }
        protected dynamic GetWorkHistoryViewModelData(DbContext objectContext, BusinessContext context, object dbitem, string employeeId, string legalId)
        {
            var item = dbitem as HR_EMP_WorkHistory;

            return new
            {
                form = new
                {
                    ResId = item.WorkHistoryID,
                    empId = employeeId,
                    legalId = legalId,
                    item.Company,
                    item.Department,
                    item.JobDuty,
                    WorkBeginDate = item.WorkBeginDate == new DateTime() ? "" : item.WorkBeginDate.ToString("yyyy-MM-dd"),
                    WorkEndDate = item.WorkEndDate.HasValue ? item.WorkEndDate == new DateTime() ? "" : item.WorkEndDate.Value.ToString("yyyy-MM-dd") : String.Empty,
                    item.Description,
                    item.CreateTime,
                    item.CreateUserID,
                    item.UpdateTime,
                    item.UpdateUserID,
                    item.IsDeleted,
                    item.LegalEntityID,
                    item.TenantID

                },
                dataSources = new
                {

                }
            };
        }

        public BusinessResult GetWorkHistoryList(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            //var objectSet = this.CreateObjectSet(context, objectContext);
            var objectSet = ((HRDbContext)objectContext).HR_EMP_Education;
            var result = WorkHistoryListHander(objectContext, context, objectSet);
            return this.CreateResult(BusinessStatusCode.OK, result);
        }

        protected object WorkHistoryListHander(DbContext objectContext, BusinessContext context, IQueryable<dynamic> objectSet)
        {
            var dbContext = objectContext as HRDbContext;

            var nq = dbContext.HR_EMP_WorkHistory
                     .Where(t => t.IsDeleted == false);

            var sort = context.Request["sort"];
            var order = context.Request["order"];

            string resId = context.Request["resId"];

            if (!string.IsNullOrEmpty(resId))
            {
                Guid empId = new Guid(resId);
                nq = nq.Where(item => item.EmployeeID == empId);
            }
            if (string.IsNullOrEmpty(sort))
            {
                nq = nq.OrderBy(g => g.CreateTime);
            }
            else
            {
                nq = nq.OrderBy(string.Format("it.{0} {1}", sort, order));
            }
            //var dsEmpStatus = this.GetEmpStatusList(context.Credential.LegalGuid());
            int total = 0;
            nq = this.GetPageQuery(context, nq, out total);
            var data = nq.Select(g => new
            {
                g.WorkHistoryID,
                g.EmployeeID,
                g.Company,
                g.Department,
                g.JobDuty,
                g.WorkBeginDate,
                g.WorkEndDate,
                g.Description,
                Deleted = g.IsDeleted ? "启用" : "禁用"
            });
            return new
            {
                total = total,
                rows = data.ToArray().Select(item => new
                {
                    item.WorkHistoryID,
                    item.EmployeeID,
                    item.Company,
                    item.Department,
                    item.JobDuty,
                    WorkBeginDate = item.WorkBeginDate.ToString("yyyy-MM-dd"),
                    WorkEndDate = item.WorkEndDate.HasValue ? item.WorkEndDate.Value.ToString("yyyy-MM-dd") : String.Empty,
                    item.Description,
                    item.Deleted
                }).ToArray()
            };
        }

        public BusinessResult CreateWorkHistoryView(BusinessContext context)
        {
            //获取员工id
            string empId = context.Request["empId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_WorkHistory.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetWorkHistoryViewModelData(objectContext, context, item, empId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_frmEmployeeWorkHistoryEdit.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }
        public BusinessResult WorkHistoryCreate(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var item = ((HRDbContext)objectContext).HR_EMP_WorkHistory.Create();
            string listName = "WorkHistories";
            string fields =
                "WorkHistoryID, EmployeeID, Company, Department, JobDuty, WorkBeginDate, WorkEndDate, Description, CreateTime, CreateUserID, UpdateTime, UpdateUserID, IsDeleted, LegalEntityID, TenantID";
            return CreateLogic(context, objectContext, item, listName, fields);
        }

        protected void CreateWorkHistoryHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];
            string str = (string)data["empId"];
            Guid guid = new Guid(str);
            string legal = (string)data["legalId"];
            Guid guidLegal = new Guid(legal);
            var wh = item as HR_EMP_WorkHistory;
            wh.WorkHistoryID = Guid.NewGuid();
            wh.EmployeeID = guid;
            wh.CreateTime = DateTime.Now;
            wh.CreateUserID = context.Credential.UserGuid();
            wh.UpdateTime = DateTime.Now;
            wh.UpdateUserID = context.Credential.UserGuid();
            wh.IsDeleted = false;
            wh.LegalEntityID = guidLegal;
            wh.TenantID = this.GetCurrentCredential().TenantGuid();
        }

        public BusinessResult EditWorkHistoryView(BusinessContext context)
        {
            //获得学历id
            string resId = context.Request["resId"];
            string empId = context.Request["empId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            if (string.IsNullOrEmpty(resId))
            {//create
                var item = ((HRDbContext)objectContext).HR_EMP_WorkHistory.Create();
                InitCreateViewModel(objectContext, context, item);
                vmData = GetWorkHistoryViewModelData(objectContext, context, item, resId, legalId);
            }
            else
            {//edit
                object resIdVal = resId;
                if (!string.IsNullOrEmpty(this.BizDataModel.ResFieldType))
                {
                    var type = Type.GetType(this.BizDataModel.ResFieldType);
                    resIdVal = CU.ChangeType(resId, type);
                    if (resIdVal == null)
                    {
                        return this.BadRequest();
                    }

                }
                var objectSet = ((HRDbContext)objectContext).HR_EMP_WorkHistory;
                IQueryable<object> query = objectSet as IQueryable<object>;
                query = InitEditQuery(query);
                //var ps = query.Where(string.Format("it.{0} == @0", (string)this.BizDataModel.ResField), resIdVal).FirstOrDefault();
                var ps = query.Where(string.Format("it.{0} == @0", "WorkHistoryID"), resIdVal).FirstOrDefault();
                InitEditViewModel(objectContext, context, ps);
                vmData = GetWorkHistoryViewModelData(objectContext, context, ps, empId, legalId);
            }

            return View(@"Enterprise\HR\EMP\Employee\_frmEmployeeWorkHistoryEdit.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        public BusinessResult WorkHistoryEdit(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var objectSet = ((HRDbContext)objectContext).HR_EMP_WorkHistory;
            string field = "WorkHistoryID,EmployeeID,Company,Department,JobDuty,WorkBeginDate,WorkEndDate,Description" +
                            ",CreateTime,CreateUserID,UpdateTime,UpdateUserID,IsDeleted,LegalEntityID,TenantID";
            string ID = "WorkHistoryID";
            return EditLogic(context, objectContext, objectSet, field, ID, "WorkHistories");
        }

        protected void EditWorkHistoryHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];
            string str = (string)data["empId"];
            Guid guid = new Guid(str);
            string legal = (string)data["legalId"];
            Guid guidLegal = new Guid(legal);
            var wh = item as HR_EMP_WorkHistory;

            wh.UpdateTime = DateTime.Now;
            wh.UpdateUserID = context.Credential.UserGuid();
            //wh.IsDeleted = false;
        }

        public BusinessResult DeleteAllWorkHistory(BusinessContext context)
        {
            string ids = context.Request["ids"];
            using (TransactionScope scope = new TransactionScope())
            {
                using (var dc = new HRDbContext())
                {
                    var list = ids.Split(';');
                    var lstGuid = list.Select(t => Guid.Parse(t)).ToArray();
                    //var inlist = list.Select(i => Convert.ToInt32(i)).ToArray();
                    var whs = dc.HR_EMP_WorkHistory.Where(item => lstGuid.Contains(item.WorkHistoryID));
                    foreach (var entity in whs)
                    {
                        entity.IsDeleted = true;
                        entity.UpdateTime = DateTime.Now;
                        entity.UpdateUserID = context.Credential.LegalGuid();

                        dc.Entry(entity).State = EntityState.Modified;
                    }

                    dc.SaveChanges();
                    scope.Complete();
                    return this.Success();
                }
            }
        }
        #endregion

        #region Education
        public BusinessResult EducationTabView(BusinessContext context)
        {
            //获取员工id
            string resId = context.Request["resId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_Education.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetEducationViewModelData(objectContext, context, item, resId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeEducationTab.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        protected dynamic GetEducationViewModelData(DbContext objectContext, BusinessContext context, object dbitem, string employeeId, string legalId)
        {
            var item = dbitem as HR_EMP_Education;

            return new
            {
                form = new
                {
                    ResId = item.EducationID,
                    empId = employeeId,
                    legalId = legalId,
                    item.School,
                    item.Speciality,
                    item.EduBG,
                    item.EduDegree,
                    item.EduDegreeNumber,
                    item.EduBeginDate,
                    item.EduEndDate,
                    item.IsHighestDiploma,
                    item.CreateTime,
                    item.CreateUserID,
                    item.UpdateTime,
                    item.UpdateUserID,
                    item.IsDeleted,
                    item.LegalEntityID,
                    item.TenantID

                },
                dataSources = new
                {
                    dsEduBG = this.GetEduBGList(context.Credential.LegalGuid()),
                    dsEduDegree = this.GetEduDegreeList(context.Credential.LegalGuid())
                }
            };
        }

        public BusinessResult GetEducationList(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            //var objectSet = this.CreateObjectSet(context, objectContext);
            var objectSet = ((HRDbContext)objectContext).HR_EMP_Education;
            var result = EducationListHander(objectContext, context, objectSet);
            return this.CreateResult(BusinessStatusCode.OK, result);
        }

        protected object EducationListHander(DbContext objectContext, BusinessContext context, IQueryable<dynamic> objectSet)
        {
            var dbContext = objectContext as HRDbContext;

            var nq = dbContext.HR_EMP_Education
                     .Where(t => t.IsDeleted == false);

            var sort = context.Request["sort"];
            var order = context.Request["order"];

            string resId = context.Request["resId"];

            if (!string.IsNullOrEmpty(resId))
            {
                Guid empId = new Guid(resId);
                nq = nq.Where(item => item.EmployeeID == empId);
            }
            if (string.IsNullOrEmpty(sort))
            {
                nq = nq.OrderBy(g => g.CreateTime);
            }
            else
            {
                nq = nq.OrderBy(string.Format("it.{0} {1}", sort, order));
            }
            //var dsEmpStatus = this.GetEmpStatusList(context.Credential.LegalGuid());
            int total = 0;
            nq = this.GetPageQuery(context, nq, out total);
            var data = nq.Select(g => new
            {
                g.EducationID,
                g.School,
                g.Speciality,
                g.EduBG,
                g.EduDegree,
                g.EduDegreeNumber,
                g.EduBeginDate,
                g.EduEndDate,
                Highest = g.IsHighestDiploma ? "是" : "否"
            });
            return new
            {
                total = total,
                rows = data.ToArray().Select(item => new
                {
                    item.EducationID,
                    item.School,
                    item.Speciality,
                    item.EduDegreeNumber,
                    EduBeginDate = item.EduBeginDate?.ToString("yyyy-MM-dd") ?? string.Empty,
                    EduEndDate = item.EduEndDate?.ToString("yyyy-MM-dd") ?? string.Empty,
                    item.Highest,
                    BG = CommonDictService.GetDictItemName(item.EduBG),
                    Degree = CommonDictService.GetDictItemName(item.EduDegree)
                }).ToArray()
            };
        }

        public BusinessResult CreateEducationView(BusinessContext context)
        {
            //获取员工id
            string empId = context.Request["empId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_Education.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetEducationViewModelData(objectContext, context, item, empId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeEducationEdit.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        public BusinessResult EditEducationView(BusinessContext context)
        {
            //获得学历id
            string resId = context.Request["resId"];
            string empId = context.Request["empId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            if (string.IsNullOrEmpty(resId))
            {
                return this.BadRequest();
            }
            else
            {//edit
                object resIdVal = resId;
                if (!string.IsNullOrEmpty(this.BizDataModel.ResFieldType))
                {
                    var type = Type.GetType(this.BizDataModel.ResFieldType);
                    resIdVal = CU.ChangeType(resId, type);
                    if (resIdVal == null)
                    {
                        return this.BadRequest();
                    }

                }
                var objectSet = ((HRDbContext)objectContext).HR_EMP_Education;
                IQueryable<object> query = objectSet as IQueryable<object>;
                query = InitEditQuery(query);
                //var ps = query.Where(string.Format("it.{0} == @0", (string)this.BizDataModel.ResField), resIdVal).FirstOrDefault();
                var ps = query.Where(string.Format("it.{0} == @0", "EducationID"), resIdVal).FirstOrDefault();
                InitEditViewModel(objectContext, context, ps);
                vmData = GetEducationViewModelData(objectContext, context, ps, empId, legalId);
            }

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeEducationEdit.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        public BusinessResult EducationCreate(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var item = ((HRDbContext)objectContext).HR_EMP_Education.Create();
            string listName = "Educations";
            string fields =
                "EducationID, EmployeeID, School, Speciality, EduBG, EduDegree, EduDegreeNumber, EduBeginDate, EduEndDate, IsHighestDiploma, CreateTime, CreateUserID, UpdateTime, UpdateUserID, IsDeleted, LegalEntityID, TenantID";
            return CreateLogic(context, objectContext, item, listName, fields);
        }
        protected void CreateEducationHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];
            string str = (string)data["empId"];
            Guid guid = new Guid(str);
            string logal = (string)data["legalId"];
            Guid guidLogal = new Guid(logal);
            var edu = item as HR_EMP_Education;
            edu.EducationID = Guid.NewGuid();
            edu.EmployeeID = guid;
            //edu.School = (string)data["School"];
            //edu.Speciality = (string)data["Speciality"];
            //edu.EduBG = (string)data["EduBG"];
            //edu.EduDegree = (string)data["EduDegree"];
            //edu.EduDegreeNumber = (string)data["EduDegreeNumber"];
            //edu.EduBeginDate = (DateTime)data["EduBeginDate"];
            //edu.EduEndDate = (DateTime)data["EduEndDate"];
            //edu.IsHighestDiploma = (bool)data["IsHighestDiploma"];
            edu.CreateTime = DateTime.Now;
            edu.CreateUserID = context.Credential.UserGuid();
            edu.UpdateTime = DateTime.Now;
            edu.UpdateUserID = context.Credential.UserGuid();
            edu.IsDeleted = false;
            edu.LegalEntityID = guidLogal;
            edu.TenantID = this.GetCurrentCredential().TenantGuid();

            if (edu.IsHighestDiploma)
            {
                if (!SetEmpEducation(CommonDictService.GetDictItemName(edu.EduBG), edu.EmployeeID))
                    throw new BusinessException("设置最高学历出错");
            }
        }

        public BusinessResult EducationEdit(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var objectSet = ((HRDbContext)objectContext).HR_EMP_Education;
            string field = "EducationID,EmployeeID,School,Speciality,EduBG,EduDegree,EduDegreeNumber,EduBeginDate,EduEndDate,IsHighestDiploma" +
                            ",CreateTime,CreateUserID,UpdateTime,UpdateUserID,IsDeleted,LegalEntityID,TenantID";
            string ID = "EducationID";
            return EditLogic(context, objectContext, objectSet, field, ID, "Educations");
        }

        protected void EditEducationHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];
            string str = (string)data["empId"];
            Guid guid = new Guid(str);
            string logal = (string)data["legalId"];
            Guid guidLogal = new Guid(logal);
            var edu = item as HR_EMP_Education;

            //edu.School = (string)data["School"];
            //edu.Speciality = (string)data["Speciality"];
            //edu.EduBG = (string)data["EduBG"];
            //edu.EduDegree = (string)data["EduDegree"];
            //edu.EduDegreeNumber = (string)data["EduDegreeNumber"];
            //edu.EduBeginDate = (DateTime)data["EduBeginDate"];
            //edu.EduEndDate = (DateTime)data["EduEndDate"];
            //edu.IsHighestDiploma = (bool)data["IsHighestDiploma"];

            edu.UpdateTime = DateTime.Now;
            edu.UpdateUserID = context.Credential.UserGuid();
            //edu.IsDeleted = false;
            var dc = objectContext as HRDbContext;
            var origIsHighestDiploma = dc.Entry(edu).OriginalValues["IsHighestDiploma"];
            if ((bool)origIsHighestDiploma && !edu.IsHighestDiploma)
            {
                var emp = dc.HR_EMP_Employee.FirstOrDefault(t => !t.IsDeleted && t.EmployeeID == edu.EmployeeID);
                if (emp != null)
                {
                    emp.Education = string.Empty;

                    dc.Entry(emp).State = EntityState.Modified;
                }
            }
            if (edu.IsHighestDiploma)
            {
                if (!SetEmpEducation(CommonDictService.GetDictItemName(edu.EduBG), edu.EmployeeID))
                    throw new BusinessException("设置最高学历出错");
            }
        }

        public BusinessResult ModifyIsHighestDiplomaState(BusinessContext context)
        {

            using (var dc = new HRDbContext())
            {
                Guid guid = Guid.Parse(context.Request["resId"]);
                if (SetEmpEducation(guid))
                    return this.Success();
            }
            throw new BusinessException("变更失败");
        }

        private bool SetEmpEducation(Guid empEduId)
        {
            using (
                var scope = new TransactionScope(TransactionScopeOption.Suppress,
                    new TransactionOptions { IsolationLevel = IsolationLevel.ReadCommitted }))
            {
                using (var dc = new HRDbContext())
                {
                    var ee =
                        dc.HR_EMP_Education.FirstOrDefault(t => !t.IsDeleted && t.EducationID == empEduId);

                    if (ee != null)
                    {
                        if (SetEmpEducation(CommonDictService.GetDictItemName(ee.EduBG), ee.EmployeeID))
                        {
                            ee.IsHighestDiploma = true;
                            ee.UpdateTime = DateTime.Now;
                            ee.UpdateUserID = GetCurrentCredential().UserGuid();

                            dc.Entry(ee).State = EntityState.Modified;
                            dc.SaveChanges();
                            scope.Complete();

                            return true;
                        }
                    }
                }
            }
            return false;
        }

        private bool SetEmpEducation(string Education, Guid empId)
        {
            using (
                var scope = new TransactionScope(TransactionScopeOption.Suppress,
                    new TransactionOptions { IsolationLevel = IsolationLevel.ReadCommitted }))
            {
                using (var dc = new HRDbContext())
                {

                    var qMain =
                        dc.HR_EMP_Education.Where(
                            t => !t.IsDeleted && t.IsHighestDiploma && t.EmployeeID == empId);
                    if (qMain.Any())
                    {
                        foreach (var m in qMain)
                        {
                            m.IsHighestDiploma = false;
                            m.UpdateTime = DateTime.Now;
                            m.UpdateUserID = this.GetCurrentCredential().UserGuid();
                            dc.Entry(m).State = EntityState.Modified;
                        }
                    }



                    var qEmp = dc.HR_EMP_Employee.Where(t => !t.IsDeleted && t.EmployeeID == empId);
                    if (qEmp.Any())
                    {
                        var emp = qEmp.First();
                        emp.Education = Education;
                        emp.UpdateTime = DateTime.Now;
                        emp.UpdateUserID = this.GetCurrentCredential().UserGuid();
                        dc.Entry(emp).State = EntityState.Modified;

                        dc.SaveChanges();
                        scope.Complete();
                        return true;
                    }

                }

            }
            return false;
        }
        #endregion

        #region family
        public BusinessResult FamilyMemberTabView(BusinessContext context)
        {
            //获取员工id
            string resId = context.Request["resId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_EmployeeFamily.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetFamilyMemberViewModelData(objectContext, context, item, resId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeFamilyMemberTab.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        protected dynamic GetFamilyMemberViewModelData(DbContext objectContext, BusinessContext context, object dbitem, string employeeId, string legalId)
        {
            var item = dbitem as HR_EMP_EmployeeFamily;
            if (item.FamilyMemberID == Guid.Empty)
                item.InsuranceStatus = "0|HR_EMP_FamilyInsuranceStatus";

            return new
            {
                form = new
                {
                    ResId = item.FamilyMemberID,
                    empId = employeeId,
                    legalId = legalId,
                    item.Name,
                    item.Relationships,
                    item.IDType,
                    item.IDNumber,
                    item.ContactCellphone,
                    item.Gender,
                    Birthday = item.Birthday?.ToString("yyyy-MM-dd") ?? String.Empty,
                    item.Job,
                    item.Company,
                    item.InsuranceNumber,
                    item.InsuranceStatus,
                    InsuranceStatusName = CommonDictService.GetDictItemName(item.InsuranceStatus),
                    item.IsEmergency,
                    item.CreateTime,
                    item.CreateUserID,
                    item.UpdateTime,
                    item.UpdateUserID,
                    item.IsDeleted,
                    item.LegalEntityID,
                    item.TenantID

                },
                dataSources = new
                {
                    dsRelationships = this.GetRelationshipsList(context.Credential.LegalGuid()),
                    dsGender = this.GetGenderList(context.Credential.LegalGuid()),
                    dsIDType = this.GetIDTypeList(context.Credential.LegalGuid()),
                    dsInsuranceStatus = CommonDictService.GetDictItems(DictConstants.HR_EMP_FamilyInsuranceStatus, context.Credential.LegalGuid())
                }
            };
        }

        public BusinessResult GetFamilyMemberList(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            //var objectSet = this.CreateObjectSet(context, objectContext);
            var objectSet = ((HRDbContext)objectContext).HR_EMP_EmployeeFamily;
            var result = FamilyMemberListHander(objectContext, context, objectSet);
            return this.CreateResult(BusinessStatusCode.OK, result);
        }

        protected object FamilyMemberListHander(DbContext objectContext, BusinessContext context, IQueryable<dynamic> objectSet)
        {
            var dbContext = objectContext as HRDbContext;

            var nq = dbContext.HR_EMP_EmployeeFamily
                     .Where(t => t.IsDeleted == false);

            var sort = context.Request["sort"];
            var order = context.Request["order"];

            string resId = context.Request["resId"];

            if (!string.IsNullOrEmpty(resId))
            {
                Guid empId = new Guid(resId);
                nq = nq.Where(item => item.EmployeeID == empId);
            }
            if (string.IsNullOrEmpty(sort))
            {
                nq = nq.OrderBy(g => g.CreateTime);
            }
            else
            {
                nq = nq.OrderBy(string.Format("it.{0} {1}", sort, order));
            }
            //var dsEmpStatus = this.GetEmpStatusList(context.Credential.LegalGuid());
            int total = 0;
            nq = this.GetPageQuery(context, nq, out total);
            var data = nq.Select(g => new
            {
                g.FamilyMemberID,
                g.EmployeeID,
                g.Name,
                g.Relationships,
                g.IDType,
                g.IDNumber,
                g.ContactCellphone,
                g.Gender,
                g.Birthday,
                g.Job,
                g.Company,
                g.InsuranceNumber,
                g.InsuranceStatus,
                Emergency = g.IsEmergency ? "是" : "否"
            });
            return new
            {
                total = total,
                rows = data.ToArray().Select(item => new
                {
                    item.FamilyMemberID,
                    item.EmployeeID,
                    item.Name,
                    item.IDNumber,
                    item.ContactCellphone,
                    Birthday = item.Birthday?.ToString("yyyy-MM-dd") ?? string.Empty,
                    item.Job,
                    item.Company,
                    item.InsuranceNumber,
                    InsuranceStatus = CommonDictService.GetDictItemName(item.InsuranceStatus),
                    item.Emergency,
                    Relationships = CommonDictService.GetDictItemName(item.Relationships),
                    Gender = CommonDictService.GetDictItemName(item.Gender),
                    IDType = CommonDictService.GetDictItemName(item.IDType)
                }).ToArray()
            };
        }

        public BusinessResult FamilyMemberCreate(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var item = ((HRDbContext)objectContext).HR_EMP_EmployeeFamily.Create();
            string listName = "EmployeeFamilies";
            string fields =
                "FamilyMemberID, EmployeeID, Name, Relationships, IDType, IDNumber, ContactCellphone, Gender, Birthday, Job, Company, InsuranceNumber, InsuranceStatus, IsEmergency, CreateTime, CreateUserID, UpdateTime, UpdateUserID, IsDeleted, LegalEntityID, TenantID";
            return CreateLogic(context, objectContext, item, listName, fields);
        }
        protected void CreateFamilyMemberHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];
            string str = (string)data["empId"];
            Guid guid = new Guid(str);
            string logal = (string)data["legalId"];
            Guid guidLogal = new Guid(logal);
            var ef = item as HR_EMP_EmployeeFamily;
            ef.FamilyMemberID = Guid.NewGuid();
            ef.EmployeeID = guid;

            ef.InsuranceNumber = string.Empty;
            ef.InsuranceStatus = "0|HR_EMP_FamilyInsuranceStatus";

            ef.CreateTime = DateTime.Now;
            ef.CreateUserID = context.Credential.UserGuid();
            ef.UpdateTime = DateTime.Now;
            ef.UpdateUserID = context.Credential.UserGuid();
            ef.IsDeleted = false;
            ef.LegalEntityID = guidLogal;
            ef.TenantID = this.GetCurrentCredential().TenantGuid();

            if (ef.IsEmergency)
            {
                if (!SetEmpEmergencyContact(ef.ContactCellphone, ef.EmployeeID))
                    throw new BusinessException("变更紧急联系电话失败");
            }
        }

        public BusinessResult CreateFamilyMemberView(BusinessContext context)
        {
            //获取员工id
            string empId = context.Request["empId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_EmployeeFamily.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetFamilyMemberViewModelData(objectContext, context, item, empId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeFamilyMemberEdit.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        public BusinessResult EditFamilyMemberView(BusinessContext context)
        {
            //获得学历id
            string resId = context.Request["resId"];
            string empId = context.Request["empId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            if (string.IsNullOrEmpty(resId))
            {//create
                var item = ((HRDbContext)objectContext).HR_EMP_EmployeeFamily.Create();
                InitCreateViewModel(objectContext, context, item);
                vmData = GetFamilyMemberViewModelData(objectContext, context, item, resId, legalId);
            }
            else
            {//edit
                object resIdVal = resId;
                if (!string.IsNullOrEmpty(this.BizDataModel.ResFieldType))
                {
                    var type = Type.GetType(this.BizDataModel.ResFieldType);
                    resIdVal = CU.ChangeType(resId, type);
                    if (resIdVal == null)
                    {
                        return this.BadRequest();
                    }

                }
                var objectSet = ((HRDbContext)objectContext).HR_EMP_EmployeeFamily;
                IQueryable<object> query = objectSet as IQueryable<object>;
                query = InitEditQuery(query);
                //var ps = query.Where(string.Format("it.{0} == @0", (string)this.BizDataModel.ResField), resIdVal).FirstOrDefault();
                var ps = query.Where(string.Format("it.{0} == @0", "FamilyMemberID"), resIdVal).FirstOrDefault();
                InitEditViewModel(objectContext, context, ps);
                vmData = GetFamilyMemberViewModelData(objectContext, context, ps, empId, legalId);
            }

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeFamilyMemberEdit.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }

        public BusinessResult FamilyMemberEdit(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var objectSet = ((HRDbContext)objectContext).HR_EMP_EmployeeFamily;
            string field = "FamilyMemberID,EmployeeID,Name,Relationships,IDType,IDNumber,ContactCellphone,Gender,Birthday,Job,Company,InsuranceNumber,InsuranceStatus,IsEmergency" +
                            ",CreateTime,CreateUserID,UpdateTime,UpdateUserID,IsDeleted,LegalEntityID,TenantID";
            string ID = "FamilyMemberID";
            return EditLogic(context, objectContext, objectSet, field, ID, "EmployeeFamilies");
        }

        protected void EditFamilyMemberHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];
            string str = (string)data["empId"];
            Guid guid = new Guid(str);
            string logal = (string)data["legalId"];
            Guid guidLogal = new Guid(logal);
            var ef = item as HR_EMP_EmployeeFamily;
            var dc = objectContext as HRDbContext;
            var origIsEmergency = dc.Entry(ef).OriginalValues["IsEmergency"];
            if ((bool)origIsEmergency && !ef.IsEmergency)
            {
                var emp = dc.HR_EMP_Employee.FirstOrDefault(t => !t.IsDeleted && t.EmployeeID == ef.EmployeeID);
                if (emp != null)
                {
                    emp.EmergencyCellPhone = string.Empty;

                    dc.Entry(emp).State = EntityState.Modified;
                }
            }
            if (ef.IsEmergency)
            {
                if (!SetEmpEmergencyContact(ef.ContactCellphone, ef.EmployeeID))
                    throw new BusinessException("变更紧急联系电话失败");
            }

            ef.UpdateTime = DateTime.Now;
            ef.UpdateUserID = context.Credential.UserGuid();
            //ef.IsDeleted = false;

        }

        public BusinessResult ModifyIsEmergencyState(BusinessContext context)
        {

            using (var dc = new HRDbContext())
            {

                Guid guid = Guid.Parse(context.Request["resId"]);

                if (SetEmpEmergencyContact(guid))
                    return this.Success();
            }
            throw new BusinessException("变更失败");
        }

        private bool SetEmpEmergencyContact(Guid empFamilyId)
        {
            using (
                var scope = new TransactionScope(TransactionScopeOption.Suppress,
                    new TransactionOptions { IsolationLevel = IsolationLevel.ReadCommitted }))
            {
                using (var dc = new HRDbContext())
                {
                    var ef =
                        dc.HR_EMP_EmployeeFamily.FirstOrDefault(t => !t.IsDeleted && t.FamilyMemberID == empFamilyId);

                    if (ef != null)
                    {
                        if (SetEmpEmergencyContact(ef.ContactCellphone, ef.EmployeeID))
                        {
                            ef.IsEmergency = true;
                            ef.UpdateTime = DateTime.Now;
                            ef.UpdateUserID = GetCurrentCredential().UserGuid();

                            dc.Entry(ef).State = EntityState.Modified;
                            dc.SaveChanges();
                            scope.Complete();

                            return true;
                        }
                    }
                }
            }
            return false;
        }

        private bool SetEmpEmergencyContact(string emergencyCellPhone, Guid empId)
        {
            using (
                var scope = new TransactionScope(TransactionScopeOption.Suppress,
                    new TransactionOptions { IsolationLevel = IsolationLevel.ReadCommitted }))
            {
                using (var dc = new HRDbContext())
                {

                    var qMain =
                        dc.HR_EMP_EmployeeFamily.Where(
                            t => !t.IsDeleted && t.IsEmergency && t.EmployeeID == empId);
                    if (qMain.Any())
                    {
                        foreach (var m in qMain)
                        {
                            m.IsEmergency = false;
                            m.UpdateTime = DateTime.Now;
                            m.UpdateUserID = this.GetCurrentCredential().UserGuid();
                            dc.Entry(m).State = EntityState.Modified;
                        }
                    }



                    var qEmp = dc.HR_EMP_Employee.Where(t => !t.IsDeleted && t.EmployeeID == empId);
                    if (qEmp.Any())
                    {
                        var emp = qEmp.First();
                        emp.EmergencyCellPhone = emergencyCellPhone;
                        emp.UpdateTime = DateTime.Now;
                        emp.UpdateUserID = this.GetCurrentCredential().UserGuid();
                        dc.Entry(emp).State = EntityState.Modified;

                        dc.SaveChanges();
                        scope.Complete();
                        return true;
                    }

                }

            }
            return false;
        }
        #endregion

        #region 联系方式
        public BusinessResult OtherContactTabView(BusinessContext context)
        {
            //获取员工id
            string resId = context.Request["resId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_OtherContact.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetOtherContactViewModelData(objectContext, context, item, resId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeOtherContactTab.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }
        protected dynamic GetOtherContactViewModelData(DbContext objectContext, BusinessContext context, object dbitem, string employeeId, string legalId)
        {
            var item = dbitem as HR_EMP_OtherContact;

            return new
            {
                form = new
                {
                    ResId = item.OtherContactID,
                    empId = employeeId,
                    legalId = legalId,
                    Cellphone = item.Cellphone ?? string.Empty,
                    Email = item.Email ?? string.Empty,
                    Telephone = item.Telephone ?? string.Empty,
                    Address = item.Address ?? string.Empty,
                    item.CreateTime,
                    item.CreateUserID,
                    item.UpdateTime,
                    item.UpdateUserID,
                    item.IsDeleted,
                    item.LegalEntityID,
                    item.TenantID

                },
                dataSources = new
                {

                }
            };
        }

        public BusinessResult GetOtherContactList(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            //var objectSet = this.CreateObjectSet(context, objectContext);
            var objectSet = ((HRDbContext)objectContext).HR_EMP_OtherContact;
            var result = OtherContactListHander(objectContext, context, objectSet);
            return this.CreateResult(BusinessStatusCode.OK, result);
        }

        protected object OtherContactListHander(DbContext objectContext, BusinessContext context, IQueryable<dynamic> objectSet)
        {
            var dbContext = objectContext as HRDbContext;

            var nq = dbContext.HR_EMP_OtherContact
                     .Where(t => t.IsDeleted == false);

            var sort = context.Request["sort"];
            var order = context.Request["order"];

            string resId = context.Request["resId"];

            if (!string.IsNullOrEmpty(resId))
            {
                Guid empId = new Guid(resId);
                nq = nq.Where(item => item.EmployeeID == empId);
            }
            if (string.IsNullOrEmpty(sort))
            {
                nq = nq.OrderBy(g => g.CreateTime);
            }
            else
            {
                nq = nq.OrderBy(string.Format("it.{0} {1}", sort, order));
            }
            //var dsEmpStatus = this.GetEmpStatusList(context.Credential.LegalGuid());
            int total = 0;
            nq = this.GetPageQuery(context, nq, out total);
            var data = nq.Select(g => new
            {
                g.OtherContactID,
                g.EmployeeID,
                g.Cellphone,
                g.Email,
                g.Telephone,
                g.Address
            });
            return new
            {
                total = total,
                rows = data.ToArray().Select(item => new
                {
                    item.OtherContactID,
                    item.EmployeeID,
                    item.Cellphone,
                    item.Email,
                    item.Telephone,
                    item.Address
                }).ToArray()
            };
        }

        public BusinessResult CreateOtherContactView(BusinessContext context)
        {
            //获取员工id
            string empId = context.Request["empId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            var item = ((HRDbContext)objectContext).HR_EMP_OtherContact.Create();
            InitCreateViewModel(objectContext, context, item);
            vmData = GetOtherContactViewModelData(objectContext, context, item, empId, legalId);

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeOtherContactEdit.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }
        public BusinessResult EditOtherContactView(BusinessContext context)
        {
            //获得学历id
            string resId = context.Request["resId"];
            string empId = context.Request["empId"];
            string legalId = context.Request["legalId"];
            DbContext objectContext = this.CreateDbContext();
            dynamic vmData = null;
            if (string.IsNullOrEmpty(resId))
            {//create
                var item = ((HRDbContext)objectContext).HR_EMP_OtherContact.Create();
                InitCreateViewModel(objectContext, context, item);
                vmData = GetOtherContactViewModelData(objectContext, context, item, resId, legalId);
            }
            else
            {//edit
                object resIdVal = resId;
                if (!string.IsNullOrEmpty(this.BizDataModel.ResFieldType))
                {
                    var type = Type.GetType(this.BizDataModel.ResFieldType);
                    resIdVal = CU.ChangeType(resId, type);
                    if (resIdVal == null)
                    {
                        return this.BadRequest();
                    }

                }
                var objectSet = ((HRDbContext)objectContext).HR_EMP_OtherContact;
                IQueryable<object> query = objectSet as IQueryable<object>;
                query = InitEditQuery(query);
                //var ps = query.Where(string.Format("it.{0} == @0", (string)this.BizDataModel.ResField), resIdVal).FirstOrDefault();
                var ps = query.Where(string.Format("it.{0} == @0", "OtherContactID"), resIdVal).FirstOrDefault();
                InitEditViewModel(objectContext, context, ps);
                vmData = GetOtherContactViewModelData(objectContext, context, ps, empId, legalId);
            }

            return View(@"Enterprise\HR\EMP\Employee\_fmEmployeeOtherContactEdit.cshtml", new { Context = context, ModelData = context.ContextTable["ModelData"], BizId = this.ViewModel.Model.BizId, RawData = vmData, Data = Yar.Service.JsonHelper.Serialize(vmData, true) });
        }
        public BusinessResult OtherContactCreate(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var item = ((HRDbContext)objectContext).HR_EMP_OtherContact.Create();
            string listName = "OtherContacts";
            string fields =
                "OtherContactID, EmployeeID, Cellphone, Email, Telephone, Address, CreateTime, CreateUserID, UpdateTime, UpdateUserID, IsDeleted, LegalEntityID, TenantID";
            return CreateLogic(context, objectContext, item, listName, fields);
        }

        protected void CreateOtherContactHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];
            string str = (string)data["empId"];
            Guid guid = new Guid(str);
            string logal = (string)data["legalId"];
            Guid guidLogal = new Guid(logal);
            var ef = item as HR_EMP_OtherContact;
            ef.OtherContactID = Guid.NewGuid();
            ef.EmployeeID = guid;
            //ef.Cellphone = (string)data["Cellphone"];
            //ef.Email = (string)data["Email"];
            //ef.Telephone = (string)data["Telephone"];
            //ef.Address = (string)data["Address"];
            ef.CreateTime = DateTime.Now;
            ef.CreateUserID = context.Credential.UserGuid();
            ef.UpdateTime = DateTime.Now;
            ef.UpdateUserID = context.Credential.UserGuid();
            ef.IsDeleted = false;
            ef.LegalEntityID = guidLogal;
            ef.TenantID = this.GetCurrentCredential().TenantGuid();
        }
        public BusinessResult OtherContactEdit(BusinessContext context)
        {
            DbContext objectContext = this.CreateDbContext();
            var objectSet = ((HRDbContext)objectContext).HR_EMP_OtherContact;
            string field = "OtherContactID,EmployeeID,Cellphone,Email,Telephone,Address" +
                            ",CreateTime,CreateUserID,UpdateTime,UpdateUserID,IsDeleted,LegalEntityID,TenantID";
            string ID = "OtherContactID";
            return EditLogic(context, objectContext, objectSet, field, ID, "OtherContacts");
        }

        protected void EditOtherContactHander(DbContext objectContext, dynamic item, BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];
            string str = (string)data["empId"];
            Guid guid = new Guid(str);
            string logal = (string)data["legalId"];
            Guid guidLogal = new Guid(logal);
            var ef = item as HR_EMP_OtherContact;

            ef.UpdateTime = DateTime.Now;
            ef.UpdateUserID = context.Credential.UserGuid();
            //ef.IsDeleted = false;

        }
        #endregion

        #region sub create and edit logic
        public BusinessResult CreateLogic(BusinessContext context, DbContext objectContext, object item, string listName, string fields)
        {
            //string resId = context.Request["resId"];
            try
            {
                //using (DbContext objectContext = this.CreateDbContext())
                {
                    //var item;
                    var dmitem = item;
                    dynamic data = context.Content;
                    string[] updateFields = (fields).Split(',').Select(f => f.Trim()).ToArray();
                    foreach (var sitem in data.formdata)
                    {
                        string name = (string)sitem.Name;
                        string value = (string)sitem.Value;
                        //if (CreateOrEditField(0, name, value, dmitem, context, objectContext))
                        //    continue;
                        if (updateFields.SingleOrDefault(p => p == name) != null)
                            CU.UpdateObjProperty(dmitem, sitem.Name, value);
                    }
                    objectContext.Entry(item).State = EntityState.Added;
                    using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Suppress, new TransactionOptions { IsolationLevel = IsolationLevel.ReadCommitted }))
                    {
                        if (listName == "PostInformations")
                        {
                            CreateJobHander(objectContext, item, context);
                        }
                        if (listName == "Educations")
                        {
                            CreateEducationHander(objectContext, item, context);
                        }
                        if (listName == "WorkHistories")
                        {
                            CreateWorkHistoryHander(objectContext, item, context);
                        }
                        if (listName == "EmployeeFamilies")
                        {
                            CreateFamilyMemberHander(objectContext, item, context);
                        }
                        if (listName == "OtherContacts")
                        {
                            CreateOtherContactHander(objectContext, item, context);
                        }
                        objectContext.SaveChanges();
                        scope.Complete();
                    }

                }
                return this.CreateResult(BusinessStatusCode.Success, new { ResId = context.ContextTable["resId"] });
            }
            catch (System.Data.Entity.Infrastructure.DbUpdateException ex)
            {
                return this.CreateResult(BusinessStatusCode.Exception, "false", string.IsNullOrEmpty(this.BizDataModel.CreateFailMsg) ? ex.Message : this.BizDataModel.CreateFailMsg);
            }
            catch (DbEntityValidationException dbEx)
            {
                foreach (var validationErrors in dbEx.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                        YarSystem.WriteLog(string.Format("Property: {0} ValidataionError: {1}", validationError.PropertyName, validationError.ErrorMessage));
                    }
                }
                return this.CreateResult(BusinessStatusCode.Exception, "false", "ValidationException");
            }
        }

        public BusinessResult EditLogic(BusinessContext context, DbContext objectContext, object objectSet, string field, string ID, string listName)
        {
            if (context.Request["resId"] == null) return this.CreateResult(BusinessStatusCode.BadRequest, null);
            string resId = context.Request["resId"];
            object resIdVal = resId;
            if (!string.IsNullOrEmpty(this.BizDataModel.ResFieldType))
            {
                var type = Type.GetType(this.BizDataModel.ResFieldType);
                resIdVal = CU.ChangeType(resId, type);
                if (resIdVal == null)
                {
                    return this.BadRequest();
                }
            }
            try
            {
                //using (DbContext objectContext = this.CreateDbContext())
                {
                    //var objectSet = this.CreateObjectSet(context, objectContext);
                    IQueryable<object> query = objectSet as IQueryable<object>;
                    object item = query.Where(string.Format("it.{0} == @0", ID), resIdVal).FirstOrDefault();
                    //EntityObject item = objectSet.Where(string.Format("{0} == @resId", this.Model.ResField), new ObjectParameter("resId", resId)).FirstOrDefault();
                    if (item != null)
                    {
                        object dmitem = item;
                        dynamic data = context.Content;
                        BeforeEditHander(objectContext, item, data, context);
                        string[] updateFields = (field).Split(',').Select(f => f.Trim()).ToArray();
                        foreach (var sitem in data.formdata)
                        {
                            string name = (string)sitem.Name;
                            string value = (string)sitem.Value;
                            if (CreateOrEditField(1, name, value, dmitem, context, objectContext))
                                continue;
                            if (updateFields.SingleOrDefault(p => p == name) != null)
                                CU.UpdateObjProperty(dmitem, sitem.Name, value);
                        }
                        objectContext.Entry(item).State = EntityState.Modified;
                        using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Suppress, new TransactionOptions { IsolationLevel = IsolationLevel.ReadCommitted }))
                        {
                            if (listName == "PostInformations")
                            {
                                EditJobHander(objectContext, item, context);
                            }
                            if (listName == "Educations")
                            {
                                EditEducationHander(objectContext, item, context);
                            }
                            if (listName == "WorkHistories")
                            {
                                EditWorkHistoryHander(objectContext, item, context);
                            }
                            if (listName == "EmployeeFamilies")
                            {
                                EditFamilyMemberHander(objectContext, item, context);
                            }
                            if (listName == "OtherContacts")
                            {
                                EditOtherContactHander(objectContext, item, context);
                            }
                            objectContext.SaveChanges();
                            scope.Complete();
                        }
                    }
                }

                return this.CreateResult(BusinessStatusCode.Success, "");
            }
            catch (System.Data.Entity.Infrastructure.DbUpdateException ex)
            {
                return this.CreateResult(BusinessStatusCode.Exception, null, string.IsNullOrEmpty(this.BizDataModel.UpdateFailMsg) ? ex.Message : this.BizDataModel.UpdateFailMsg);
            }
            catch (DbEntityValidationException dbEx)
            {
                foreach (var validationErrors in dbEx.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                        YarSystem.WriteLog(string.Format("Property: {0} ValidataionError: {1}", validationError.PropertyName, validationError.ErrorMessage));
                    }
                }
                return this.CreateResult(BusinessStatusCode.Exception, null, "ValidationException");
            }

        }
        #endregion
        
        #region check 

        public BusinessResult CheckNoExist(BusinessContext context)
        {
            string name = context.Request["name"];
            var idstr = context.Request["id"];

            using (var dc = new HRDbContext())
            {
                string item = null;
                if (!string.IsNullOrEmpty(idstr) && idstr != "0")
                {
                    // id = int.Parse(idstr);
                    var g = Guid.Parse(idstr);
                    item = dc.HR_EMP_Employee.Where(employee => employee.EmployeeNameCN == name && employee.EmployeeID != g).Select(qitem => qitem.EmployeeNameCN).FirstOrDefault();
                }
                else
                {
                    item = dc.HR_EMP_Employee.Where(employee => employee.EmployeeNameCN == name).Select(qitem => qitem.EmployeeNameCN).FirstOrDefault();
                }

                if (item != null) return this.CreateResult(BusinessStatusCode.OK, "false");
                return this.CreateResult(BusinessStatusCode.OK, "true");
            }
        }
        public BusinessResult AddEmployeeNumber(BusinessContext context)
        {

            var legalId = Guid.Parse(context.Request["legalId"]);
            var ruleService = GetBizService<IBizCodeRuleService>();

            var EmployeeNumber = ruleService.GetBizCode(
                RuleCodeConstants.HR_EMP_Employee_EmployeeNumber, legalId, String.Empty);
            return this.OK(EmployeeNumber);
        }

        /// <summary>
        /// 获取职位下拉列表数据
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public BusinessResult GetJobPositionList(BusinessContext context)
        {
            var orgId = context.Request["orgId"];
            var isFPstr = context.Request["isFP"];
            var legal = context.Request["legal"];

            Guid gOrgId;
            if (string.IsNullOrEmpty(orgId) || !Guid.TryParse(orgId, out gOrgId))
            {
                throw new BusinessException("缺少OrgId");
            }

            Guid gLegal;
            if (string.IsNullOrEmpty(legal) || !Guid.TryParse(legal, out gLegal))
            {
                throw new BusinessException("缺少legal");
            }

            bool isFP = "1".Equals(isFPstr) || "true".Equals(isFPstr, StringComparison.CurrentCultureIgnoreCase);

            var orgService = this.GetBizService<IBizOrganizationService>();

            var lst = orgService.GetSysPositionsOfOrg(new string[] { gOrgId.ToString() }).Select(p => new SelectItem { ID = p.Id,Name = p.Name });

            return this.Success(lst);
        }

        public BusinessResult GetReportToPostionName(BusinessContext context)
        {
            var posId = context.Request["posId"];

            Guid gPosId;
            if (string.IsNullOrEmpty(posId) || !Guid.TryParse(posId, out gPosId))
            {
                throw new BusinessException("缺少PosId");
            }
            var orgService = this.GetBizService<IBizOrganizationService>();
            var parent = orgService.GetReportToPosition(gPosId.ToString());

            var name = string.Empty;
            if (parent != null)
                name = parent.Name;
            return this.OK(name);
        }

        public BusinessResult CheckUserNameExists(BusinessContext context)
        {
            string name = context.Request["name"];
            var idstr = context.Request["id"];

            if (string.IsNullOrEmpty(name))
                return this.CreateResult(BusinessStatusCode.OK, "true");

            Guid? empId = null;
            Guid tmp;
            if (!string.IsNullOrEmpty(idstr) && idstr != "0" && Guid.TryParse(idstr, out tmp))
            {
                // id = int.Parse(idstr);
                empId = tmp;
            }

            var permissionService = GetBizService<IBizPermissionService>();

            if (permissionService.IsExistUser(name,null, empId.ToString()))
            {
                return this.CreateResult(BusinessStatusCode.OK, "false");
            }

            return this.CreateResult(BusinessStatusCode.OK, "true");

        }

        public BusinessResult CheckIDNumberExists(BusinessContext context)
        {
            string IDNumber = context.Request["IDNumber"];
            var employeeId = context.Request["employeeId"];
            String idType = context.Request["idType"];
            String legalEntityId = context.Request["legalEntityId"];
            String gender = context.Request["gender"];

            var dictItem = this.GetIDTypeList(Guid.Parse(legalEntityId)).Where(d => d.ID.Equals(idType)).FirstOrDefault();
            if (dictItem == null)
            {
                return this.CreateResult(BusinessStatusCode.OK, "true");
            }
            if (!dictItem.Name.Equals("身份证"))
            {
                return this.CreateResult(BusinessStatusCode.OK, "true");
            }

            if (string.IsNullOrEmpty(IDNumber))
                return this.CreateResult(BusinessStatusCode.OK, "true");

            Guid? empId = null;
            Guid tmp;
            if (!string.IsNullOrEmpty(employeeId) && !employeeId.Equals("0") && Guid.TryParse(employeeId, out tmp))
            {
                // id = int.Parse(idstr);
                empId = tmp;
            }

            using (var dc = new HRDbContext())
            {
                var employeeEntity = dc.HR_EMP_Employee.Where(e => e.IDNumber.Equals(IDNumber) && e.EmpStatus == "0|HR_EMP_EmpStatus").FirstOrDefault();
                if (employeeEntity != null)
                {
                    if (employeeEntity.EmployeeID.Equals(empId))
                    {
                        if (ValidateIDNumber(IDNumber, gender))
                        {
                            return this.CreateResult(BusinessStatusCode.OK, "true");
                        }
                        else
                        {
                            return this.CreateResult(BusinessStatusCode.OK, "false");
                        }
                    }
                    else
                    {
                        return this.CreateResult(BusinessStatusCode.OK, "false");
                    }
                }
                else
                {
                    if (ValidateIDNumber(IDNumber, gender))
                    {
                        return this.CreateResult(BusinessStatusCode.OK, "true");
                    }
                    else
                    {
                        return this.CreateResult(BusinessStatusCode.OK, "false");
                    }
                }
            }
        }

        private Boolean ValidateIDNumber(String IDNumber, String gender)
        {
            if (IDNumber.Length == 15 || IDNumber.Length == 18)
            {
                if (IDNumber.Length == 15)
                {
                    String pattern = @"^\d{15}";
                    if (Regex.IsMatch(IDNumber, pattern))
                    {
                        Int32 month = Int32.Parse(IDNumber.Substring(10, 2));
                        Int32 day = Int32.Parse(IDNumber.Substring(12, 2));

                        if (month > 12 || month < 1 || day > 31 || day < 1)
                        {
                            return false;
                        }
                        else
                        {
                            return true;
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
                else if (IDNumber.Length == 18)
                {
                    Int64 n = 0;
                    if (Int64.TryParse(IDNumber.Remove(17), out n) == false
   || long.TryParse(IDNumber.Replace('x', '0').Replace('X', '0'), out n) == false)
                    {
                        return false;
                    }
                    else
                    {
                        String birth = IDNumber.Substring(6, 8).Insert(6, "-").Insert(4, "-");
                        DateTime time = new DateTime();
                        if (DateTime.TryParse(birth, out time) == false)
                        {
                            return false;
                        }
                        else
                        {
                            if (gender.Length > 0)
                            {
                                String genderChar = gender.Substring(0, 1);
                                if (genderChar.Equals("1"))//female
                                {
                                    Int32 genderSet = Int32.Parse(IDNumber.Substring(16, 1));
                                    if (genderSet % 2 == 0)
                                    {
                                        return true;
                                    }
                                    else
                                    {
                                        return false;
                                    }
                                }
                                else if (genderChar.Equals("0"))//male
                                {
                                    Int32 genderSet = Int32.Parse(IDNumber.Substring(16, 1));
                                    if (genderSet % 2 == 0)
                                    {
                                        return false;
                                    }
                                    else
                                    {
                                        return true;
                                    }
                                }
                                else
                                {
                                    return false;
                                }
                            }
                            else
                            {
                                return false;
                            }
                        }
                    }
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        #endregion

        #region private
        private void SyncEmpPostions(Guid empId)
        {
            var employeeService = GetBizService<IBizEmployeeService>();

            var empUser = employeeService.GetEmployeeUser(empId);


            if (empUser != null)
            {
                using (var dc = new HRDbContext())
                {
                    var q = from ep in dc.HR_EMP_PostInformation
                            where !ep.IsDeleted && ep.EmployeeID == empId
                            select ep.PositionID;
                    var e = (from emp in dc.HR_EMP_Employee
                             where !emp.IsDeleted && emp.EmployeeID == empId
                             select new { emp.MainJobPositionID, emp.EmpStatus }).FirstOrDefault();
                    empUser.EmployeeStatus = e.EmpStatus;
                    empUser.MainPositionId = e.MainJobPositionID.Value;
                    empUser.Positions = q.ToList().Select(t => t.ToString("D")).ToArray();

                    employeeService.SaveEmployeeUser(empUser);
                }
            }
        }

        private BM_TreeModel[] GetEmployeeTypeTree(BusinessContext context)
        {
            var dictEmployeeType = CommonDictService.GetDictItems(DictConstants.HR_EMP_EmployeeType, context.Credential.LegalGuid());

            List<BM_TreeModel> allSelection = new List<BM_TreeModel>()
            {
                new BM_TreeModel()
                {
                    code = "-1",
                    id = "-1|HR_EMP_EmployeeType",
                    pid = "",
                    text = "全部",
                }
            };

            BM_TreeModel[] treeNodes = dictEmployeeType.Select(item => new BM_TreeModel
            {
                code = item.ItemCode,
                id = item.ID,
                pid = "-1|HR_EMP_EmployeeType",
                text = item.Name,
            }).Union(allSelection).ToArray();

            BM_TreeModel[] tree = BM_TreeModel.CreateTree(treeNodes);
            return tree;
        }

        private string GetEmployeeTypeNames(string inputValue)
        {
            string outputValue = string.Empty;

            if (inputValue != null)
            {
                string[] dictItemValues = inputValue.Split(',');

                foreach (string dictItemValue in dictItemValues)
                {
                    outputValue += CommonDictService.GetDictItemName(dictItemValue) + ",";
                }

                if (outputValue.Length > 0)
                {
                    outputValue = outputValue.Substring(0, outputValue.Length - 1);
                }
            }
            else
            {
                outputValue = "";
            }

            return outputValue;
        }

#endregion
    }

    #region DTO
    public class EmpListInfo
    {
        #region "Properties"
        public Guid EmployeeID { get; set; }

        [Description("员工工号")]
        public string EmployeeNumber { get; set; }

        [Description("员工姓名")]
        public string EmployeeNameCN { get; set; }

        public Guid LegalEntityID { get; set; }
        //public string LegalEntityName { get; set; }

        public Guid? OrganizationID { get; set; }

        public string OrganizationCode { get; set; }

        [Description("部门")]
        public string OrganizationName { get; set; }

        public Guid? PostionID { get; set; }

        [Description("职位")]
        public string PostionName { get; set; }

        [Description("员工状态")]
        public string EmpStatus { get; set; }

        [Description("员工身份")]
        public string EmployeeStatus { get; set; }

        [Description("入职日期")]
        public DateTime? OnboardDate { get; set; }

        public decimal? JobLevelValue { get; set; }

        [Description("员工职级")]
        public string JobLevelName { get; set; }

        public int IsMain { get; set; }

        public Decimal? SalaryLevelValue { get; set; }

        public string OrgCodePath { get; set; }
        #endregion
    }

    #endregion

    public class OrgTreeData
    {
        public Guid OrgId { get; set; }
        public string OrgCode { get; set; }

        public string OrgName { get; set; }

        public string OrgType { get; set; }

        public Guid? ParentId { get; set; }

        public string CodePath { get; set; }

        public int HeadCount { get; set; }

        public int Sequence { get; set; }
    }
}
