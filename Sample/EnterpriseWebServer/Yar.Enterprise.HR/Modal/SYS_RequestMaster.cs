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
    
    public partial class SYS_RequestMaster
    {
        public System.Guid MasterRequestID { get; set; }
        public string RequestTypeCode { get; set; }
        public string MasterRequestCode { get; set; }
        public System.Guid TypeInfoID { get; set; }
        public System.Guid UserID { get; set; }
        public System.Guid PositionID { get; set; }
        public System.Guid OrgUnitID { get; set; }
        public System.DateTime RequestTime { get; set; }
        public System.Guid OperatorID { get; set; }
        public System.Guid OperatorPositionID { get; set; }
        public System.Guid OperatorOUID { get; set; }
        public string ApproveStatus { get; set; }
        public string BusinessStatus { get; set; }
        public bool IsNotifyResult { get; set; }
        public string WorkflowID { get; set; }
        public Nullable<System.Guid> ExtendFormID { get; set; }
        public Nullable<System.DateTime> LastApprovedTime { get; set; }
        public Nullable<System.Guid> LastApproverID { get; set; }
        public string Memo { get; set; }
        public System.DateTime CreateTime { get; set; }
        public System.Guid CreateUserID { get; set; }
        public Nullable<System.DateTime> UpdateTime { get; set; }
        public Nullable<System.Guid> UpdateUserID { get; set; }
        public bool IsDeleted { get; set; }
        public System.Guid LegalEntityID { get; set; }
        public System.Guid TenantID { get; set; }
    }
}
