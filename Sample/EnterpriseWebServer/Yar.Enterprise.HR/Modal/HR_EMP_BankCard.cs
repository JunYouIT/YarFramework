//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Yar.Enterprise.HR.Modal
{
    using System;
    using System.Collections.Generic;
    
    public partial class HR_EMP_BankCard
    {
        public System.Guid BankID { get; set; }
        public System.Guid EmployeeID { get; set; }
        public string BankNumber { get; set; }
        public string AccountName { get; set; }
        public string BankName { get; set; }
        public string BankCity { get; set; }
        public string Address { get; set; }
        public bool IsWageCard { get; set; }
        public System.DateTime CreateTime { get; set; }
        public System.Guid CreateUserID { get; set; }
        public Nullable<System.DateTime> UpdateTime { get; set; }
        public Nullable<System.Guid> UpdateUserID { get; set; }
        public bool IsDeleted { get; set; }
        public System.Guid LegalEntityID { get; set; }
        public System.Guid TenantID { get; set; }
        public string BankBranchCode { get; set; }
    }
}
