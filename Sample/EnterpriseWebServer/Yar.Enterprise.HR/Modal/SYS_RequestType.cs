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
    
    public partial class SYS_RequestType
    {
        public System.Guid Id { get; set; }
        public string RequestTypeCode { get; set; }
        public string RequestGroup { get; set; }
        public string RequestTypeName { get; set; }
        public string Memo { get; set; }
        public string BusinessId { get; set; }
        public string VerifyView { get; set; }
        public string FormCode { get; set; }
        public string FlowCode { get; set; }
        public string FlowName { get; set; }
        public string FolioRuleCode { get; set; }
        public string WorkflowParam { get; set; }
        public string WorkflowRemark { get; set; }
        public bool CanBatchApproval { get; set; }
        public bool CanCommonApproval { get; set; }
        public int TypeLevel { get; set; }
        public string ParentTypeCode { get; set; }
        public bool IsDefault { get; set; }
        public bool IsDisabled { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<bool> IsHeadApproval { get; set; }
        public string Text1 { get; set; }
        public string Text2 { get; set; }
        public string Text3 { get; set; }
        public string Text4 { get; set; }
        public string Text5 { get; set; }
        public System.DateTime CreateTime { get; set; }
        public System.Guid CreateUserID { get; set; }
        public Nullable<System.DateTime> UpdateTime { get; set; }
        public Nullable<System.Guid> UpdateUserID { get; set; }
        public System.Guid LegalEntityID { get; set; }
        public System.Guid TenantID { get; set; }
    }
}
