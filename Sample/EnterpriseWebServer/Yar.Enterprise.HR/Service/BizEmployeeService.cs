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
using Yar.Core;

namespace Yar.Enterprise.HR.Service
{
    public class BizEmployeeService : BizEnterpriseCommonBase, IBizEmployeeService
    {
        private string EmployeeUserType = "employee";

        public BizEmployeeService()
        {
            this.BusinessType = Yar.Service.BusinessType.Public;
            this.AddSubBiz("Biz_Select_OrgUser", new Biz_Select_OrgUser());
            this.AddBizAction(new Yar.Service.BizAction
            {
                Name = "EmployeeView",
                BizCommand = "Route",
                CommandParam = "Biz_Select_OrgUser.EmployeeView"
            });
        }

        public BusinessResult GetEmployeeList(BusinessContext context)
        {
            using (var db = new HRDbContext())
            {
                var tenantId = this.GetCurrentCredential().TenantGuid();
                var query = from c in db.HR_EMP_Employee.Where(c => c.TenantID == tenantId && !c.IsDeleted)
                            join l in db.HR_ORG_LegalEntity.Where(p => !p.IsDeleted) on c.LegalEntityID equals l.LegalEntityID
                            join area in db.HR_EMP_OfficeArea on c.OfficeAreaID equals area.AreaID into atemp
                            from area in atemp.DefaultIfEmpty()
                            select new
                            {
                                EmployeeId = c.EmployeeID,
                                EmployeeName = c.EmployeeNameCN,
                                EmployeeNo = c.EmployeeNumber,
                                ExtCode = c.ExtCode,
                                TeleCode = c.TeleCode,
                                OfficeAreaID = c.OfficeAreaID,
                                OfficeAreaName = area.AreaName,
                                EMail = c.EmployeeEMail,
                                Mobile = c.PersonalCellPhone,
                                LegalID = c.LegalEntityID,
                                LegalEntityName = l.LegalEntityName,
                                MainJobPositionID = c.MainJobPositionID,
                                MainJobPostionName = c.MainJobPostionName,
                                OrganizationID = c.OrganizationID,
                                OrganizationCode = c.OrganizationCode,
                                OrganizationName = c.OrganizationName,
                                OnboardDate = c.OnboardDate,
                                TrialBeginDate = c.TrialBeginDate,
                                TrialEndDate = c.TrialEndDate,
                                PersonalCellPhone = c.PersonalCellPhone,
                                PhotoAttachmentID = c.PhotoAttachmentID,
                                CreateTime = c.CreateTime,
                                imageUrl = ""
                            };
                var total = 0;
                query = BizHelper.GetPageQuery(context, query.OrderBy(g => g.CreateTime), out total);
                return this.Success(new { total = total, rows = query.ToArray() });
            }
        }

        public BusinessResult GetPersonalInfoData(BusinessContext context)
        {
            using (var dc = new HRDbContext())
            {
                var tenantId = this.GetCurrentCredential().TenantGuid();
                var empId = this.GetCurrentCredential().UserGuid();
                var item = dc.HR_EMP_Employee.FirstOrDefault(t =>t.TenantID == tenantId && !t.IsDeleted && t.EmployeeID == empId);


                //如果item.EmployeeID为空下面自然没值
                var addresses = from a in dc.HR_EMP_Address
                                where a.EmployeeID == item.EmployeeID && a.IsDeleted == false && a.AddressType == "0"
                                select a;

                var area = string.Empty;
                HR_EMP_Address address = addresses.FirstOrDefault();

                if (addresses.Any())
                {

                    if (!string.IsNullOrEmpty(address.Province))
                        area += address.Province + "/";
                    if (!string.IsNullOrEmpty(address.City))
                        area += address.City + "/";
                    if (!string.IsNullOrEmpty(address.District))
                        area += address.District;
                }
                var hujiaddresses = from a in dc.HR_EMP_Address
                                    where a.EmployeeID == item.EmployeeID && a.IsDeleted == false && a.AddressType == "1"
                                    select a;

                var hujiarea = string.Empty;
                HR_EMP_Address hujiaddress = hujiaddresses.FirstOrDefault();

                if (hujiaddresses.Any())
                {

                    if (!string.IsNullOrEmpty(hujiaddress.Province))
                        hujiarea += hujiaddress.Province + "/";
                    if (!string.IsNullOrEmpty(hujiaddress.City))
                        hujiarea += hujiaddress.City + "/";
                    if (!string.IsNullOrEmpty(hujiaddress.District))
                        hujiarea += hujiaddress.District;
                }


                var banks = from b in dc.HR_EMP_BankCard
                            where b.EmployeeID == item.EmployeeID && b.IsDeleted == false
                            select b;

                HR_EMP_BankCard bank = banks.FirstOrDefault();

                var positions = from c in dc.HR_EMP_PostInformation
                                join d in dc.HR_ORG_Position on c.PositionID equals d.PositionID
                                where c.EmployeeID == item.EmployeeID && c.IsDeleted == false && c.IsMain == true
                                select d;
                HR_ORG_Position position = positions.FirstOrDefault();
                if (position == null)
                {
                    position = new HR_ORG_Position();
                }

                var organizations = from c in dc.HR_EMP_PostInformation
                                    join d in dc.HR_ORG_Organization on c.OrganizationID equals d.OrganizationID
                                    where c.EmployeeID == item.EmployeeID && c.IsDeleted == false && c.IsMain == true
                                    select d;

                HR_ORG_Organization organization = organizations.FirstOrDefault();
                if (organization == null)
                {
                    organization = new HR_ORG_Organization();
                }

                //var areaService = GetBizService<IBizFMService>();
                //var areaName = areaService.MJService.GetAreaName(item.OfficeAreaID.GetValueOrDefault(Guid.Empty));

                //var empSalaryLevelTypes = GetSalaryLevelList(item.LegalEntityID, true);

                var data= new
                {
                    form = new
                    {
                        ResId = item.EmployeeID,
                        empId = item.EmployeeID,
                        item.EmployeeNumber,
                        item.EmployeeNameCN,
                        item.EmployeeNameEN,
                        item.Gender,
                        GenderName = CommonDictService.GetDictItemName(item.Gender),
                        item.IDType,
                        IDTypeName = CommonDictService.GetDictItemName(item.IDType),
                        item.IDNumber,
                        Birthday = item.Birthday?.ToString("yyyy-MM-dd") ?? String.Empty,
                        item.MaritalStatus,
                        MaritalStatusName = CommonDictService.GetDictItemName(item.MaritalStatus),
                        FirstWorkedDate = item.FirstWorkedDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                        item.Nationality,
                        NationalityName = CommonDictService.GetDictItemName(item.Nationality),
                        item.OfficeAreaID,
                        OFDetailAddress = "",
                        item.HukouAddress,
                        OnboardDate = item.OnboardDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                        item.EmployeeEMail,
                        item.EmpStatus,
                        EmpStatusName = CommonDictService.GetDictItemName(item.EmpStatus),
                        item.EmployeeStatus,
                        EmployeeStatusName = CommonDictService.GetDictItemName(item.EmployeeStatus),
                        item.OrganizationID,
                        item.OrganizationCode,
                        item.OrganizationName,

                        item.MainJobPositionID,
                        item.CurrentJobLevelName,
                        CurrentJobLevelValue = item.CurrentJobLevelValue?.ToString("0.00") ?? string.Empty,
                        JobLevelText = item.CurrentJobLevelValue.HasValue ? (item.CurrentJobLevelName + "[" + item.CurrentJobLevelValue.Value.ToString("0.00") + "]") : string.Empty,
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
                        PoliticalStatusName = CommonDictService.GetDictItemName(item.PoliticalStatus),
                        item.TAG,
                        item.Description,
                        item.UserName,
                        item.MLAccount,
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
                        EthnicName = CommonDictService.GetDictItemName(item.Ethnic),
                        item.ProfessionalTitle,
                        ProfessionalTitleName = CommonDictService.GetDictItemName(item.ProfessionalTitle),
                        item.SupplHousingAccount,
                        TerminationDate = item.TerminationDate?.ToString("yyyy-MM-dd") ?? string.Empty,
                        item.TerminationTypeName,
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
                        AccountName = bank?.AccountName ?? string.Empty,
                        BankCity = bank?.BankCity ?? string.Empty,

                        MainJobPositionName = string.IsNullOrWhiteSpace(position.PositionName) ? "无" : position.PositionName + "(" + organization.OrganizationName + ")",
                        PartyJoinInDate = item.PartyJoinInDate?.ToString("yyyy-MM-dd") ?? String.Empty,
                        ADAccount = item.ADAccount
                    
                    }
                };
                return this.Success(data);
            }
        }
        public List<SysOrgItem> GetOrgHeadCountData(string category = null)
        {
            List<string> lstEmpStatus = new List<string>() { "0|" + DictConstants.HR_EMP_EmpStatus, "2|" + DictConstants.HR_EMP_EmpStatus };
            using (var dc = new HRDbContext())
            {
                var tenantId = this.GetCurrentCredential().TenantGuid();
                //TODO:根据数据权限限制法人实体
                var orgdata = from org in dc.HR_ORG_Organization
                              where !org.IsDeleted && !org.IsDisabled && org.TenantID == tenantId
                              orderby org.ParentID, org.Sequence
                              select new
                              {
                                  org.OrganizationID,
                                  org.OrganizationName,
                                  org.OrganizationCode,
                                  org.OrganizationType,
                                  org.CodePath,
                                  org.ParentID,
                                  org.LegalEntityID,
                                  org.TenantID,
                                  HeadCount =
                                      dc.HR_EMP_Employee.Count(
                                          t => !t.IsDeleted && t.OrganizationCode.StartsWith(org.OrganizationCode) && lstEmpStatus.Contains(t.EmpStatus))
                              };
                return orgdata.ToArray().Select(n => new SysOrgItem()
                {
                    Id = n.OrganizationID.ToString(),
                    Name = n.OrganizationName,
                    Code = n.OrganizationCode,
                    ParentId = n.ParentID.ToString(),
                    OrganiztionType = n.OrganizationType,
                    CodePath = n.CodePath,
                    LegalId = n.LegalEntityID,
                    TenantId = n.TenantID,
                    Data = new Core.DictTable { { "HeadCount", n.HeadCount } },
                }).ToList();
            }
        }

        public EmployeeUser GetEmployeeUser(Guid userId)
        {
            if (userId == Guid.Empty) throw new BusinessException(this.Exception("userId 不能为空"));
            var permissionService = this.GetBizService<IBizPermissionService>();
            var sysUser = permissionService.GetUser(userId.ToString(), EmployeeUserType);
            if(sysUser != null)
            {
                var tenantId = this.GetCurrentCredential().TenantGuid();
                var titem = TenantService.GetTenantItem(tenantId);
                if (titem != null)
                {
                    if (sysUser.LoginName.EndsWith("@" + titem.Domain))
                    {
                        sysUser.LoginName = sysUser.LoginName.Replace("@" + titem.Domain, "");
                    }
                }
                var user = new EmployeeUser
                {
                    Id = userId,
                    LoginName = sysUser.LoginName,
                    Name = sysUser.Name,
                    Email = sysUser.Email,
                    EmployeeNo = sysUser.UserNo,
                    MainPositionId = Guid.Parse(sysUser.PositionId),
                    OrgId = Guid.Parse(sysUser.OrgId),
                    LegalId = string.IsNullOrEmpty(sysUser.DataRoot) ? Guid.Empty : Guid.Parse(sysUser.DataRoot),
                    TenantId = Guid.Parse(sysUser.TenantId),
                    Enable = sysUser.ResState == 0 ? true : false,
                    PhotoAttachmentID = sysUser.UserPhotoId,
                    Mobile = sysUser.Mobile,
                    EmployeeStatus = sysUser.UserStatus
                };
                user.Positions = sysUser.BelongOrgs.ToArray();                
                return user;
            }            
            return null;
        }

        public void SaveEmployeeUser(EmployeeUser user)
        {
            if (user.Id == Guid.Empty) throw new BusinessException(this.Exception("Id 不能为空"));
            if (string.IsNullOrEmpty(user.LoginName)) throw new BusinessException(this.Exception("登陆名不能为空"));

            var credential = this.GetCurrentCredential();
            var tenantId = credential.TenantGuid();
            var permissionService = this.GetBizService<IBizPermissionService>();
            var sysUser = new SysUser
            {
                Id = user.Id.ToString(),
                LoginName = user.LoginName,
                Name = user.Name,
                UserType = "employee",
                Password = user.Password,
                UserNo = user.EmployeeNo,
                Email = user.Email,
                Mobile = user.Mobile,
                UserStatus = user.EmployeeStatus,
                UserPhotoId = user.PhotoAttachmentID,
                PositionId = user.MainPositionId.ToString(),
                OrgId = user.OrgId.ToString(),
                DataSource = "ERM_HR",
                ResState = user.Enable ? 0 : 1,
                BelongOrgs = user.Positions.ToList(),
                DataRoot = user.LegalId.ToString(),
                TenantId = user.TenantId.ToString()
            };
            try
            {
                using (var dc = new HRDbContext())
                {
                    var roleList = (from p in user.Positions
                                    join r in dc.HR_ORG_PositionRoleList on p equals r.PositionID.ToString()
                                    select r.RoleID.ToString()).Distinct().ToList();
                    sysUser.RoleList = roleList;
                }
                permissionService.SaveUser(sysUser);
            }
            catch (Exception e)
            {
                throw new BusinessException(this.Exception(e.Message));
            }
        }

        public void DeleteEmployeeUser(Guid[] ids)
        {
            if (ids == null || ids.Length == 0) return;
            var permissionService = this.GetBizService<IBizPermissionService>();
            permissionService.RemoveUser(ids.Select(d => d.ToString()).ToArray());            
        }

        public void UpdateUserRoleByPositonID(Guid positionID)
        {
            var permissionService = GetBizService<IBizPermissionService>();
            using (var db = new HRDbContext())
            {
                var posId = positionID.ToString();
                var tenantId = this.GetCurrentCredential().TenantGuid();
                var uIDs = db.SYS_User.Where(t => t.BelongOrg.Contains(posId) && t.UserType == this.EmployeeUserType && t.TenantId == tenantId).Select(a => a.UserId.ToString()).ToList();
                var posRoleList = db.HR_ORG_PositionRoleList.Where(pr => pr.PositionID == positionID).Select(pr => pr.RoleID.ToString()).ToArray();
                if (uIDs != null && uIDs.Count() > 0)
                {
                    foreach (var uID in uIDs)
                    {
                        var user = permissionService.GetUser(uID,this.EmployeeUserType);
                        if(user != null)
                        {
                            user.RoleList.AddRange(posRoleList);
                            permissionService.SaveUser(user);
                        }
                        
                    }
                }
            }
        }

        public List<EmployeeInfo> GetEmployeeInfos(Guid[] ids, DictTable queryParam=null)
        {
            using (var db = new HRDbContext())
            {
                var tenantId = this.GetCurrentCredential().TenantGuid();
                var query = from c in db.HR_EMP_Employee.Where(c => c.TenantID == tenantId && !c.IsDeleted)
                            join l in db.HR_ORG_LegalEntity.Where(p => !p.IsDeleted) on c.LegalEntityID equals l.LegalEntityID
                            join area in db.HR_EMP_OfficeArea on c.OfficeAreaID equals area.AreaID into atemp
                            from area in atemp.DefaultIfEmpty()
                            where ids.Contains(c.EmployeeID)
                            select new EmployeeInfo()
                            {
                                EmployeeId = c.EmployeeID,
                                EmployeeName = c.EmployeeNameCN,
                                EmployeeNo = c.EmployeeNumber,
                                ExtCode = c.ExtCode,
                                TeleCode = c.TeleCode,
                                OfficeAreaID = c.OfficeAreaID,
                                OfficeAreaName = area.AreaName,
                                EMail = c.EmployeeEMail,
                                Mobile = c.PersonalCellPhone,
                                LegalID = c.LegalEntityID,
                                LegalEntityName = l.LegalEntityName,
                                MainJobPositionID = c.MainJobPositionID,
                                MainJobPostionName = c.MainJobPostionName,
                                OrganizationID = c.OrganizationID,
                                OrganizationCode = c.OrganizationCode,
                                OrganizationName = c.OrganizationName,
                                OnboardDate = c.OnboardDate,
                                TrialBeginDate = c.TrialBeginDate,
                                TrialEndDate = c.TrialEndDate,
                                PersonalCellPhone = c.PersonalCellPhone,
                            };
                return query.ToList();                
            }
        }


    }
}
