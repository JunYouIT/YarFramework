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
    
    public partial class SYS_Role
    {
        public long Id { get; set; }
        public string ResId { get; set; }
        public string Name { get; set; }
        public int ResState { get; set; }
        public string Desc { get; set; }
        public int RoleType { get; set; }
        public string AppFunctions { get; set; }
        public string BizFunctions { get; set; }
        public string InheritRoles { get; set; }
        public string Code { get; set; }
        public Nullable<System.Guid> LegalId { get; set; }
        public System.Guid TenantId { get; set; }
        public string DataOwner { get; set; }
        public string DataScope { get; set; }
        public string Creator { get; set; }
        public string Updator { get; set; }
        public Nullable<System.DateTime> CreateTime { get; set; }
        public Nullable<System.DateTime> UpdateTime { get; set; }
        public string Kind { get; set; }
    }
}
