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
    
    public partial class SYS_Audittrail
    {
        public string AudittrailID { get; set; }
        public string RequestID { get; set; }
        public string Operation { get; set; }
        public string OperationName { get; set; }
        public System.DateTime CreateTime { get; set; }
        public Nullable<System.DateTime> OperationTime { get; set; }
        public string ActivityName { get; set; }
        public string ActivityCode { get; set; }
        public string OperatorID { get; set; }
        public System.Guid OperatorGUID { get; set; }
        public string Comments { get; set; }
        public Nullable<int> ActivityInstanceID { get; set; }
        public string RequestTypeCode { get; set; }
        public Nullable<System.Guid> DelegateeID { get; set; }
        public System.Guid TenantId { get; set; }
    }
}