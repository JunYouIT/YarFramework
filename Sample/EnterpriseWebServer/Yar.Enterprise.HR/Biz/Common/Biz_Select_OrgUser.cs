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
    public class Biz_Select_OrgUser : BizEnterpriseCommonBase
    {
        /// <summary>
        /// 选择员工对话框
        /// 参数无（根据当前人所属的法人得到当前组织机构）
        /// 返回数据(userId,userName)
        /// {userId:'B31E66F4-2E66-4C55-8957-1A50280F9696',userName:'张三'}
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public BusinessResult EmployeeView(BusinessContext context)
        {
            return this.View(@"Enterprise\HR\Common\_fmSelectUser.cshtml", new { Context = context, BizId = this.ViewModel.Model.BizId });
        }

        public BusinessResult GetOrgTree(BusinessContext context)
        {
            var notLimitLegal = "1".Equals(context.Request["notLimitLegal"]);
            var tenantId = context.Credential.TenantGuid();
            var legal = context.Credential.LegalGuid();

            using (var dc = new HRDbContext())
            {
                var orgdata = from org in dc.HR_ORG_Organization
                              where org.TenantID == tenantId && !org.IsDeleted && !org.IsDisabled
                              select new
                              {
                                  org.OrganizationID,
                                  org.OrganizationName,
                                  org.OrganizationType,
                                  org.ParentID,
                                  org.CodePath,
                                  org.OrganizationCode,
                                  org.Sequence,
                                  org.LegalEntityID
                              };

                if (!notLimitLegal)
                {
                    orgdata = orgdata.Where(t => t.LegalEntityID == legal);
                }

                var data = orgdata.OrderBy(t => t.OrganizationCode.Length).ThenBy(t => t.Sequence).ThenBy(t => t.OrganizationCode).ToArray();
                var listtree = data.Select(item => new BM_TreeModel
                {
                    id = item.OrganizationID.ToString(),
                    text = item.OrganizationName,
                    pid = (item.LegalEntityID == legal && item.OrganizationType == "3|HR_ORG_OrganizationType" && !notLimitLegal) ? null : item.ParentID.ToString(),
                    code = item.OrganizationCode,
                    Sequence = item.Sequence,
                    attributes = new Dictionary<string, string>() {
                            { "CodePath", item.CodePath },
                            { "OrgType", item.OrganizationType }}
                }).ToArray();

                return this.CreateResult(BusinessStatusCode.OK, BM_TreeModel.CreateTree(listtree));
            }
        }

        public BusinessResult GetEmployeeByOrg(BusinessContext context)
        {
            var legalId = context.Credential.LegalGuid();
            var tenantId = context.Credential.TenantGuid();

            var name = context.Request["name"];
            var userno = context.Request["userno"];
            var orgId = context.Request.Contains("orgId") && !string.IsNullOrWhiteSpace(context.Request["orgId"]) ? Guid.Parse(context.Request["orgId"]) : Guid.Empty;
            var options = context.Request["options"];

            var notLimitLegal = "1".Equals(context.Request["notLimitLegal"]);
            var includeOnBoarding = "1".Equals(context.Request["includeOnBoarding"]);

            var showChild = "true".Equals(context.Request["showChild"], StringComparison.CurrentCultureIgnoreCase);
            var showSideline = "true".Equals(context.Request["showSideline"], StringComparison.CurrentCultureIgnoreCase);

            using (var dbContect = new HRDbContext())
            {
                #region "Query"
                var lstEmpStatus = new List<string>()
                {
                    "0|HR_EMP_EmpStatus",
                    "2|HR_EMP_EmpStatus",
                };

                if (includeOnBoarding)
                {
                    lstEmpStatus.Add("1|HR_EMP_EmpStatus");
                }

                var lstChildOrgId = new HR_OrganizationHelper().GetChildOrgId(notLimitLegal ? Guid.Empty : legalId, orgId, true);
                var query = from emp in dbContect.HR_EMP_Employee
                            join emppos in dbContect.HR_EMP_PostInformation on emp.EmployeeID equals emppos.EmployeeID
                            join pos in dbContect.HR_ORG_Position on emppos.PositionID equals pos.PositionID
                            //join posl in dbContect.HR_ORG_PositionLevels on pos.PositionLevelID equals posl.PositionLevelID into tmpPOSL
                            //from posl in tmpPOSL.DefaultIfEmpty()
                            join sl in dbContect.HR_EMP_SalaryLevel.Where(p => !p.IsDeleted) on emp.SalaryLevelID equals sl.SalaryLevelID into tmpSL
                            from sl in tmpSL.DefaultIfEmpty()
                            join area in dbContect.HR_EMP_OfficeArea on emp.OfficeAreaID equals area.AreaID into tmpArea
                            from area in tmpArea.DefaultIfEmpty()
                            join org in dbContect.HR_ORG_Organization on emppos.OrganizationID equals org.OrganizationID
                            join leg in dbContect.HR_ORG_LegalEntity on org.LegalEntityID equals leg.LegalEntityID
                            where !emp.IsDeleted && !emppos.IsDeleted && lstEmpStatus.Contains(emp.EmpStatus) && emp.TenantID == tenantId
                            select new EmployeeInfo
                            {
                                EmployeeID = emp.EmployeeID,
                                EmployeeNameCN = emp.EmployeeNameCN,
                                EmployeeNameEN = emp.EmployeeNameEN,
                                EmployeeNumber = emp.EmployeeNumber,
                                TeleCode = emp.TeleCode,
                                ExtCode = emp.ExtCode,
                                OfficeAreaID = emp.OfficeAreaID,
                                OfficeAreaName = area == null ? string.Empty : area.AreaName,
                                IDType = emp.IDType,
                                IDNumber = emp.IDNumber,
                                PersonalTelNumber = emp.PersonalCellPhone,

                                MainJobPostionID = emp.MainJobPositionID,
                                MainJobPostionName = emp.MainJobPostionName,

                                CurrentJobLevelID = Guid.Empty,
                                CurrentJobLevelName = string.Empty,
                                CurrentJobLevelValue = decimal.Zero,

                                SalaryLevelID = sl != null ? sl.SalaryLevelID : (Guid?)null,
                                SalaryLevelName = sl != null ? sl.SalaryLevelName : string.Empty,
                                SalaryLevelType = sl != null ? sl.SalaryLevelType : string.Empty,

                                FirstWorkedDate = emp.FirstWorkedDate,
                                OnboardDate = emp.OnboardDate,
                                PositionID = pos.PositionID,
                                PositionCode = pos.PositionCode,
                                PositionName = pos.PositionName,
                                OrganizationID = org.OrganizationID,
                                OrganizationCode = org.OrganizationCode,
                                OrganizationName = org.OrganizationName,
                                LegalEntityID = org.LegalEntityID,
                                LegalEntityCode = leg.LegalEntityCode,
                                LegalEntityName = leg.LegalEntityName,
                                LegalEntityTelNumber = leg.TelNumber,
                                IsMain = emppos.IsMain,
                                CreateTime = emp.CreateTime,
                                EmployeeStatus = emp.EmployeeStatus,
                                TrialBeginDate = emp.TrialBeginDate,
                                TrialEndDate = emp.TrialEndDate,
                                EmployeeEMail = emp.EmployeeEMail,
                                Gender = emp.Gender,
                                Birthday = emp.Birthday,
                                MaritalStatus = emp.MaritalStatus
                            };

                if (!notLimitLegal)
                {
                    query = query.Where(t => t.LegalEntityID == legalId);
                }

                if (!string.IsNullOrEmpty(name))
                {
                    query = query.Where(u => u.EmployeeNameCN.Contains(name));
                }

                if (!string.IsNullOrEmpty(userno))
                {
                    query = query.Where(u => u.EmployeeNumber.Contains(userno));
                }

                #region "Options"
                var mainPosOnly = false;
                var probationEmpOnly = false;

                if (!string.IsNullOrWhiteSpace(options))
                {
                    var opts = Newtonsoft.Json.JsonConvert.DeserializeObject(options) as dynamic;

                    try
                    {
                        mainPosOnly = Convert.ToBoolean(opts.mainPosOnly);
                        probationEmpOnly = Convert.ToBoolean(opts.probationEmpOnly);
                    }
                    catch { }
                }

                if (mainPosOnly)
                {
                    query = query.Where(u => u.IsMain);
                }

                if (probationEmpOnly)
                {
                    query = query.Where(u => u.EmployeeStatus == "6|" + DictConstants.HR_EMP_EmployeeStatus);
                }
                #endregion

                if (!showSideline)
                {
                    query = query.Where(u => u.IsMain);
                }

                if (showChild)
                {
                    query = query.Where(t => lstChildOrgId.Contains(t.OrganizationID.Value));
                }
                else
                {
                    query = query.Where(t => t.OrganizationID == orgId);
                }
                #endregion

                var total = 0;
                var results = new EmployeeInfo[0];

                query = BizHelper.GetPageQuery(context, query.OrderBy(g => g.CreateTime), out total);

                if (total > 0)
                {
                    results = query.ToArray();

                    foreach (var item in results)
                    {
                        item.Gender = CommonDictService.GetDictItemName(item.Gender);
                        item.MaritalStatus = CommonDictService.GetDictItemName(item.MaritalStatus);
                        item.IDType = CommonDictService.GetDictItemName(item.IDType);
                        item.SalaryLevelName = string.Format("{0} ({1})", item.SalaryLevelName, CommonDictService.GetDictItemName(item.SalaryLevelType));
                    }

                    #region "Options: Address"
                    var empIDs = query.Select(p => p.EmployeeID).ToList();
                    var addrDatum = from c in dbContect.HR_EMP_Address.Where(p => !p.IsDeleted && empIDs.Contains(p.EmployeeID))
                                    group c by c.EmployeeID into g
                                    select new
                                    {
                                        EmployeeID = g.Key,
                                        HomeAddress = g.Where(p => p.AddressType == "0").OrderByDescending(p => p.CreateTime).Select(p => new EmployeeAddress
                                        {
                                            Country = p.Country,
                                            Province = p.Province,
                                            City = p.City,
                                            District = p.District,
                                            Address = p.Address,
                                            AddressPhone = p.AddressPhone,
                                            ZipCode = p.ZipCode
                                        }).FirstOrDefault(),
                                        HukouAddress = g.Where(p => p.AddressType == "1").OrderByDescending(p => p.CreateTime).Select(p => new EmployeeAddress
                                        {
                                            Country = p.Country,
                                            Province = p.Province,
                                            City = p.City,
                                            District = p.District,
                                            Address = p.Address,
                                            AddressPhone = p.AddressPhone,
                                            ZipCode = p.ZipCode
                                        }).FirstOrDefault()
                                    };

                    foreach (var addr in addrDatum)
                    {
                        var item = results.FirstOrDefault(p => p.EmployeeID == addr.EmployeeID);

                        if (item != null)
                        {
                            item.HomeAddress = addr.HomeAddress;
                            item.HukouAddress = addr.HukouAddress;
                        }
                    }
                    #endregion
                }

                return this.OK(new { total = total, rows = results });
            }
        }

        public BusinessResult GetEmployeeByIDs(BusinessContext context)
        {
            var content = context.Content as JObject;
            var data = content["formdata"];

            var jsonObj = JsonConvert.DeserializeAnonymousType(
               context.Content.ToJsonString(),
               new
               {
                   ids = string.Empty,
                   orgId = string.Empty,
                   name = string.Empty,
                   userno = string.Empty,
                   options = string.Empty,
                   notLimitLegal = string.Empty,
                   includeOnBoarding = string.Empty,
                   showChild = string.Empty,
                   showSideline = string.Empty
                   //formdata = new
                   //{
                   //    ids = string.Empty
                   //}
               });

            if (string.IsNullOrEmpty(jsonObj.ids))
            {
                this.ThrowException("请选择员工！");
            }
            var idPosList = jsonObj.ids.Split(';').ToList();
            var selectedEmpList = idPosList.Select(a => new { EmployeeID = Guid.Parse(a.Split(',')[0].ToString()), PosID = Guid.Parse(a.Split(',')[1].ToString()) }).ToList();
            //List<Guid> idList = new List<Guid>();
            //if (!string.IsNullOrEmpty(jsonObj.ids))
            //{
            //    idList = jsonObj.ids.Split(';').Select(a => Guid.Parse(a.Trim().ToString())).ToList();
            //}
            List<Guid> idList = selectedEmpList.Select(a => a.EmployeeID).ToList();
            var legalId = context.Credential.LegalGuid();
            var tenantId = context.Credential.TenantGuid();

            //var orgId = context.Request["orgId"];
            //Guid orgGuid = Guid.Parse(orgId);
            //var name = context.Request["name"];
            //var userno = context.Request["userno"];
            //var options = context.Request["options"];

            //var notLimitLegal = "1".Equals(context.Request["notLimitLegal"]);

            //var includeOnBoarding = "1".Equals(context.Request["includeOnBoarding"]);

            //var showChild = "true".Equals(context.Request["showChild"], StringComparison.CurrentCultureIgnoreCase);
            //var showSideline = "true".Equals(context.Request["showSideline"], StringComparison.CurrentCultureIgnoreCase);

            var orgId = jsonObj.orgId;
            Guid orgGuid = Guid.Parse(orgId);
            var name = jsonObj.name;
            var userno = jsonObj.userno;
            var options = jsonObj.options;

            var notLimitLegal = "1".Equals(jsonObj.notLimitLegal);

            var includeOnBoarding = "1".Equals(jsonObj.includeOnBoarding);

            var showChild = "true".Equals(jsonObj.showChild, StringComparison.CurrentCultureIgnoreCase);
            var showSideline = "true".Equals(jsonObj.showSideline, StringComparison.CurrentCultureIgnoreCase);

            using (var dbContect = new HRDbContext())
            {

                var lstEmpStatus = new List<string>()
                {
                    "0|HR_EMP_EmpStatus",
                    "2|HR_EMP_EmpStatus",
                };
                if (includeOnBoarding)
                    lstEmpStatus.Add("1|HR_EMP_EmpStatus");

                var lstChildOrgId = new HR_OrganizationHelper().GetChildOrgId(notLimitLegal ? Guid.Empty : legalId, orgGuid, true);
                ////HR_EMP_Employee,HR_ORG_Position,HR_ORG_Organization
                var query = (from emp in dbContect.HR_EMP_Employee
                             join emppos in dbContect.HR_EMP_PostInformation on emp.EmployeeID equals emppos.EmployeeID
                             join pos in dbContect.HR_ORG_Position on emppos.PositionID equals pos.PositionID
                             join org in dbContect.HR_ORG_Organization on emppos.OrganizationID equals org.OrganizationID
                             join leg in dbContect.HR_ORG_LegalEntity on org.LegalEntityID equals leg.LegalEntityID
                             join salary in dbContect.HR_EMP_SalaryLevel.Where(s => !s.IsDeleted && !s.IsDisabled) on emp.SalaryLevelID equals salary.SalaryLevelID into salaryClosure
                             from s in salaryClosure.DefaultIfEmpty()
                             join area in dbContect.HR_EMP_OfficeArea on emp.OfficeAreaID equals area.AreaID into tmpArea
                             from area in tmpArea.DefaultIfEmpty()
                             where !emp.IsDeleted && !emppos.IsDeleted && !leg.IsDeleted && !pos.IsDeleted && !org.IsDeleted && emp.TenantID == tenantId && idList.Contains(emp.EmployeeID)
                             select new EmployeeInfo
                             {
                                 EmployeeID = emp.EmployeeID,
                                 EmployeeNameCN = emp.EmployeeNameCN,
                                 EmployeeNameEN = emp.EmployeeNameEN,
                                 EmployeeNumber = emp.EmployeeNumber,
                                 TeleCode = emp.TeleCode,
                                 ExtCode = emp.ExtCode,
                                 OfficeAreaID = emp.OfficeAreaID,
                                 OfficeAreaName = area == null ? string.Empty : area.AreaName,
                                 IDType = emp.IDType,
                                 IDNumber = emp.IDNumber,
                                 PersonalTelNumber = emp.PersonalCellPhone,
                                 MainJobPostionID = emp.MainJobPositionID,
                                 MainJobPostionName = emp.MainJobPostionName,
                                 CurrentJobLevelName = emp.CurrentJobLevelName,
                                 FirstWorkedDate = emp.FirstWorkedDate,
                                 OnboardDate = emp.OnboardDate,
                                 PositionID = pos.PositionID,
                                 PositionCode = pos.PositionCode,
                                 PositionName = pos.PositionName,
                                 OrganizationID = org.OrganizationID,
                                 OrganizationCode = org.OrganizationCode,
                                 OrganizationName = org.OrganizationName,
                                 LegalEntityID = org.LegalEntityID,
                                 LegalEntityCode = leg.LegalEntityCode,
                                 LegalEntityName = leg.LegalEntityName,
                                 LegalEntityTelNumber = leg.TelNumber,
                                 IsMain = emppos.IsMain,
                                 CreateTime = emp.CreateTime,
                                 EmployeeStatus = emp.EmployeeStatus,
                                 TrialBeginDate = emp.TrialBeginDate,
                                 TrialEndDate = emp.TrialEndDate,
                                 EmployeeEMail = emp.EmployeeEMail,
                                 Gender = emp.Gender,
                                 Birthday = emp.Birthday,
                                 MaritalStatus = emp.MaritalStatus,
                                 SalaryLevelID = emp.SalaryLevelID,
                                 SalaryLevelName = s == null ? String.Empty : s.SalaryLevelName,
                                 SalaryLevelType = s.SalaryLevelType
                             }).Distinct().ToList();


                if (!notLimitLegal)
                {
                    query = query.Where(t => t.LegalEntityID == legalId).ToList();
                }

                if (!string.IsNullOrEmpty(name))
                {
                    query = query.Where(u => u.EmployeeNameCN.Contains(name)).ToList();
                }

                if (!string.IsNullOrEmpty(userno))
                {
                    query = query.Where(u => u.EmployeeNumber.Contains(userno)).ToList();
                }

                #region "Options"
                var mainPosOnly = false;

                var probationEmpOnly = false;


                if (!string.IsNullOrWhiteSpace(options))
                {
                    var opts = Newtonsoft.Json.JsonConvert.DeserializeObject(options) as dynamic;

                    try
                    {
                        mainPosOnly = Convert.ToBoolean(opts.mainPosOnly);
                        probationEmpOnly = Convert.ToBoolean(opts.probationEmpOnly);
                    }
                    catch { }
                }

                if (mainPosOnly)
                {
                    query = query.Where(u => u.IsMain).ToList();
                }

                if (probationEmpOnly)
                {
                    query = query.Where(u => u.EmployeeStatus == "6|" + DictConstants.HR_EMP_EmployeeStatus).ToList();
                }

                #endregion

                if (!showSideline)
                {
                    query = query.Where(u => u.IsMain).ToList();
                }
                else
                {
                    query = (from q in query
                             join emp in selectedEmpList on new { empID = q.EmployeeID, posID = q.PositionID } equals new { empID = emp.EmployeeID, posID = (Guid?)emp.PosID }
                             select q).ToList();
                }

                if (showChild)
                {
                    query = query.Where(t => lstChildOrgId.Contains(t.OrganizationID.Value)).ToList();
                }
                else
                {
                    query = query.Where(t => t.OrganizationID == orgGuid).ToList();
                }

                var total = 0;
                var results = new EmployeeInfo[0];

                query = BizHelper.GetPageQuery(context, query.OrderBy(g => g.CreateTime).AsQueryable(), out total).ToList();

                if (total > 0)
                {
                    results = query.ToArray();

                    foreach (var item in results)
                    {
                        item.Gender = CommonDictService.GetDictItemName(item.Gender);
                        item.MaritalStatus = CommonDictService.GetDictItemName(item.MaritalStatus);
                        item.IDType = CommonDictService.GetDictItemName(item.IDType);
                    }

                    #region "Options: Address"
                    var empIDs = query.Select(p => p.EmployeeID).ToList();
                    var addrDatum = from c in dbContect.HR_EMP_Address.Where(p => !p.IsDeleted && empIDs.Contains(p.EmployeeID))
                                    group c by c.EmployeeID into g
                                    select new
                                    {
                                        EmployeeID = g.Key,
                                        HomeAddress = g.Where(p => p.AddressType == "0").OrderByDescending(p => p.CreateTime).Select(p => new EmployeeAddress
                                        {
                                            Country = p.Country,
                                            Province = p.Province,
                                            City = p.City,
                                            District = p.District,
                                            Address = p.Address,
                                            AddressPhone = p.AddressPhone,
                                            ZipCode = p.ZipCode
                                        }).FirstOrDefault(),
                                        HukouAddress = g.Where(p => p.AddressType == "1").OrderByDescending(p => p.CreateTime).Select(p => new EmployeeAddress
                                        {
                                            Country = p.Country,
                                            Province = p.Province,
                                            City = p.City,
                                            District = p.District,
                                            Address = p.Address,
                                            AddressPhone = p.AddressPhone,
                                            ZipCode = p.ZipCode
                                        }).FirstOrDefault()
                                    };

                    foreach (var addr in addrDatum)
                    {
                        var item = results.FirstOrDefault(p => p.EmployeeID == addr.EmployeeID);

                        if (item != null)
                        {
                            item.HomeAddress = addr.HomeAddress;
                            item.HukouAddress = addr.HukouAddress;
                        }
                    }
                    #endregion
                }

                return this.Success(results);
                //return this.OK(new { total = total, rows = new List<dynamic> { new {
                //    EmployeeID = "B31E66F4-2E66-4C55-8957-1A50280F9696",
                //    EmployeeNameCN = "赵六",
                //    EmployeeNumber = "123",
                //    IsMain = false
                //} } });
            }
        }

        public class EmployeeInfo
        {
            #region "Properties"
            public Guid EmployeeID { get; set; }

            public string EmployeeNameCN { get; set; }

            public string EmployeeNameEN { get; set; }

            public string EmployeeNumber { get; set; }

            public string TeleCode { get; set; }

            public string ExtCode { get; set; }

            public string CompanyTelNumber
            {
                get
                {
                    if (!string.IsNullOrWhiteSpace(this.TeleCode) && !string.IsNullOrWhiteSpace(this.ExtCode))
                    {
                        return string.Format("{0} Ext.{1}", this.TeleCode, this.ExtCode);
                    }
                    else if (!string.IsNullOrWhiteSpace(this.TeleCode))
                    {
                        return this.TeleCode;
                    }
                    else
                    {
                        return string.Format("Ext.{0}", this.ExtCode);
                    }
                }
            }

            public Guid? OfficeAreaID { get; set; }

            public string OfficeAreaName { get; set; }

            public string IDType { get; set; }

            public string IDNumber { get; set; }

            public string PersonalTelNumber { get; set; }

            public Guid? MainJobPostionID { get; set; }

            public string MainJobPostionName { get; set; }

            [Obsolete]
            public Guid? CurrentJobLevelID { get; set; }

            [Obsolete]
            public string CurrentJobLevelName { get; set; }

            [Obsolete]
            public decimal? CurrentJobLevelValue { get; set; }

            public Guid? SalaryLevelID { get; set; }

            public string SalaryLevelName { get; set; }

            public string SalaryLevelType { get; set; }

            public DateTime? FirstWorkedDate { get; set; }

            public DateTime? OnboardDate { get; set; }

            public Guid? PositionID { get; set; }

            public string PositionCode { get; set; }

            public string PositionName { get; set; }

            public Guid? OrganizationID { get; set; }

            public string OrganizationCode { get; set; }

            public string OrganizationName { get; set; }

            public Guid LegalEntityID { get; set; }

            public string LegalEntityCode { get; set; }

            public string LegalEntityName { get; set; }

            public string LegalEntityTelNumber { get; set; }

            public bool IsMain { get; set; }

            public DateTime CreateTime { get; set; }

            public string EmployeeStatus { get; set; }

            public DateTime? TrialBeginDate { get; set; }

            public DateTime? TrialEndDate { get; set; }

            public string EmployeeEMail { get; set; }

            public EmployeeAddress HomeAddress { get; set; }

            public EmployeeAddress HukouAddress { get; set; }

            public string Gender { get; set; }

            public string MaritalStatus { get; set; }

            public DateTime? Birthday { get; set; }
            #endregion
        }

        public class EmployeeAddress
        {
            #region "Properties"
            /// <summary>
            /// 国籍
            /// </summary>
            public string Country { get; set; }

            /// <summary>
            /// 省
            /// </summary>
            public string Province { get; set; }

            /// <summary>
            /// 市/县
            /// </summary>
            public string City { get; set; }

            /// <summary>
            /// 区
            /// </summary>
            public string District { get; set; }

            /// <summary>
            /// 地址
            /// </summary>
            public string Address { get; set; }

            /// <summary>
            /// 住宅电话
            /// </summary>
            public string AddressPhone { get; set; }

            /// <summary>
            /// 邮政编码
            /// </summary>
            public string ZipCode { get; set; }
            #endregion

            #region "Properties"
            public string DisplayAddress { get { return this.ToString(false); } }
            #endregion

            #region "Methods"
            public override string ToString()
            {
                return this.ToString(true);
            }

            public string ToString(bool ignoreCountry)
            {
                var sb = new StringBuilder();

                if (!ignoreCountry && !string.IsNullOrWhiteSpace(this.Country))
                {
                    sb.AppendFormat("{0}", this.Country);
                }

                if (!string.IsNullOrWhiteSpace(this.Province))
                {
                    sb.AppendFormat("{0}", this.Province);
                }

                if (!string.IsNullOrWhiteSpace(this.City))
                {
                    sb.AppendFormat("{0}", this.City);
                }

                if (!string.IsNullOrWhiteSpace(this.District))
                {
                    sb.AppendFormat("{0}", this.District);
                }

                if (!string.IsNullOrWhiteSpace(this.Address))
                {
                    sb.AppendFormat(", {0}", this.Address);
                }

                if (!string.IsNullOrWhiteSpace(this.ZipCode))
                {
                    sb.AppendFormat(", 邮编：{0}", this.ZipCode);
                }

                return sb.ToString().TrimStart(' ', ',');
            }
            #endregion
        }
    }

    public class HR_OrganizationHelper
    {
        public IList<Guid> GetChildOrgId(Guid legalId, Guid parentId, bool includeSelf = true)
        {
            return GetChildOrg(legalId, parentId, includeSelf).Select(t => t.OrganizationID).ToList();
        }

        public IList<HR_ORG_Organization> GetChildOrg(Guid legalId, Guid parentId, bool includeSelf = true)
        {
            List<HR_ORG_Organization> lst = new List<HR_ORG_Organization>();

            using (var dc = new HRDbContext())
            {
                var org = dc.HR_ORG_Organization.Where(t => !t.IsDeleted && t.OrganizationID == parentId);
                if (legalId != Guid.Empty)
                    org = org.Where(t => t.LegalEntityID == legalId);
                if (!org.Any())
                    return new List<HR_ORG_Organization>();

                var listAllOrg = dc.HR_ORG_Organization.Where(t => !t.IsDeleted);
                if (legalId != Guid.Empty)
                    listAllOrg = listAllOrg.Where(t => t.LegalEntityID == legalId);
                if (includeSelf)
                {
                    lst.Add(org.First());
                }

                lst.AddRange(GetChild(listAllOrg.ToList(), org.First().OrganizationID).ToList());

            }
            return lst;
        }
        private IList<HR_ORG_Organization> GetChild(IList<HR_ORG_Organization> listAllOrg, Guid parentID)
        {
            var q = listAllOrg.Where(x => x.ParentID == parentID)
                .Union(listAllOrg.Where(x => x.ParentID == parentID).SelectMany(y => GetChild(listAllOrg, y.OrganizationID)));

            return q.ToList();
        }
    }
}
