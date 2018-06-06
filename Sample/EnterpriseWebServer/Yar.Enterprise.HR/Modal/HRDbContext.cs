using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Yar.EnterpriseCommon;
using Yar.EnterpriseService.Enterprise;

namespace Yar.Enterprise.HR.Modal
{
    public class HRDbContext : CommonBaseDbContext
    {
        public HRDbContext()
            : base(TenantService.GetTenantDbContextString(Yar.Core.YarSystem.Current.ConnectionStrings["enterprise_hr_db"]))
        {
            this.Configuration.LazyLoadingEnabled = false;
        }

        public virtual DbSet<HR_EMP_PostInformation> HR_EMP_PostInformation { get; set; }
        public virtual DbSet<HR_ORG_Organization> HR_ORG_Organization { get; set; }
        public virtual DbSet<HR_ORG_Position> HR_ORG_Position { get; set; }
        public virtual DbSet<HR_ORG_PositionRoleList> HR_ORG_PositionRoleList { get; set; }
        public virtual DbSet<SYS_Audittrail> SYS_Audittrail { get; set; }
        public virtual DbSet<SYS_RequestMaster> SYS_RequestMaster { get; set; }
        public virtual DbSet<SYS_RequestType> SYS_RequestType { get; set; }
        public virtual DbSet<SYS_Role> SYS_Role { get; set; }
        public virtual DbSet<SYS_User> SYS_User { get; set; }
        public virtual DbSet<HR_EMP_OfficeArea> HR_EMP_OfficeArea { get; set; }
        public virtual DbSet<HR_EMP_SalaryLevel> HR_EMP_SalaryLevel { get; set; }
        public virtual DbSet<HR_EMP_Employee> HR_EMP_Employee { get; set; }
        public virtual DbSet<HR_ORG_Job> HR_ORG_Job { get; set; }
        public virtual DbSet<HR_ORG_JobLevel> HR_ORG_JobLevel { get; set; }

        public virtual DbSet<HR_EMP_Address> HR_EMP_Address { get; set; }
        public virtual DbSet<HR_EMP_BankCard> HR_EMP_BankCard { get; set; }
        public virtual DbSet<HR_EMP_Education> HR_EMP_Education { get; set; }
        public virtual DbSet<HR_EMP_EmployeeContract> HR_EMP_EmployeeContract { get; set; }
        public virtual DbSet<HR_EMP_EmployeeFamily> HR_EMP_EmployeeFamily { get; set; }
        public virtual DbSet<HR_EMP_WorkHistory> HR_EMP_WorkHistory { get; set; }
        public virtual DbSet<SYS_COM_BankBranch> SYS_COM_BankBranch { get; set; }

        public virtual DbSet<HR_EMP_OtherContact> HR_EMP_OtherContact { get; set; }
        public virtual DbSet<HR_ORG_LegalEntity> HR_ORG_LegalEntity { get; set; }
    }
}
