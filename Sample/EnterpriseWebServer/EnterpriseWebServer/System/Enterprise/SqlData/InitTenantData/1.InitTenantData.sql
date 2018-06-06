/*
param
//{0} - tenantCode
//{1} - tenantName
//{2} - createtime
//{3} - tenantGuid
//{4} - legalGuid
//{5} - adminGuid
//{6} - adminLoginName
//{7} - adminPassword
*/
declare @tenantCode nvarchar(20),@tenantName nvarchar(100),@createtime nvarchar(100),@tenantGuid nvarchar(36),@legalGuid nvarchar(36),@adminGuid nvarchar(36),@adminLoginName nvarchar(50),@adminPassword nvarchar(50)
set @tenantCode= '{0}'
set @tenantName= '{1}'
set @createtime= '{2}'
set @tenantGuid= '{3}'
set @legalGuid= '{4}'
set @adminGuid= '{5}'
set @adminLoginName= '{6}'
set @adminPassword= '{7}'


INSERT [dbo].[SYS_User] ([UserId], [ResId], [Name], [LoginName], [LoginId], [Password], [Code], [InitPassword], [RoleList], [ResState], [OrgId], [PositionId], [BelongOrg], [Email], [UserStatus], [UserLevel], [UserNo], [UserPhotoId], [UserType], [DataSource], [Text1], [Text2], [Text3], [Text4], [Text5], [Text6], [Text7], [Text8], [LegalId], [TenantId], [DataOwner], [DataScope], [Creator], [Updator], [CreateTime], [UpdateTime]) 
VALUES (@adminGuid, @adminGuid, N'admin', @adminLoginName, NULL, @adminPassword, NULL, N'111111', N'admin', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'legal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @legalGuid, @tenantGuid, NULL, NULL, @adminGuid, @adminGuid, @createtime, @createtime)
INSERT [dbo].[HR_ORG_LegalEntity] ([LegalEntityID],[ParentID], [LegalEntityName], [LegalEntityCode], [EnterpriseType], [LegalRepresentativeName], [UnifiedCreditRecord], [BizBeginDate], [BizEndDate], [Province], [City], [BusinessAddress], [PostNumber], [TelNumber], [FaxNumber], [Website], [BizScope], [Description], [AccountBookNumber], [LegalCodePath], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [TenantID]) 
VALUES (@legalGuid,NULL, @tenantName, @tenantCode, N'', N'', N'',@createtime , null, N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @createtime, @adminGuid, @createtime, @adminGuid, 0, @tenantGuid)

--org
--组织机构
declare @org_company varchar(36)
set @org_company= LOWER(CONVERT(NVARCHAR(36), NEWID()))

INSERT [dbo].[HR_ORG_Organization] ([OrganizationID], [OrganizationName], [OrganizationCode], [ParentID], [CodePath], [Sequence], [OrganizationType], [HeadPositionID], [Description], [IsEnableHeadCountPeriod], [IsIndependentAccounting], [AccountBookNumber], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [IsDisabled], [CostCenterCode]) 
VALUES (@org_company, @tenantName, @tenantCode, NULL, @tenantCode, 0, N'3|HR_ORG_OrganizationType', NULL, NULL, 0, 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, 0, NULL)

--Role
declare @role_ceo varchar(36)
set @role_ceo= LOWER(CONVERT(NVARCHAR(36), NEWID()))
declare @role_employee varchar(36)
set @role_employee= LOWER(CONVERT(NVARCHAR(36), NEWID()))
declare @role_adminspecialist varchar(36)
set @role_adminspecialist= LOWER(CONVERT(NVARCHAR(36), NEWID()))
declare @role_hrspecialist varchar(36)
set @role_hrspecialist= LOWER(CONVERT(NVARCHAR(36), NEWID()))
INSERT [dbo].[SYS_Role] ([ResId], [Name], [ResState], [Desc], [RoleType], [AppFunctions], [BizFunctions], [InheritRoles], [Code], [LegalId], [TenantId], [DataOwner], [DataScope], [Creator], [Updator], [CreateTime], [UpdateTime], [Kind]) 
VALUES (N'admin', N'admin', 0, N'', 1, NULL, N'', NULL, N'admin', NULL, @tenantGuid, NULL, NULL, @adminGuid, @adminGuid, @createtime, @createtime, NULL)
INSERT [dbo].[SYS_Role] ([ResId], [Name], [ResState], [Desc], [RoleType], [AppFunctions], [BizFunctions], [InheritRoles], [Code], [LegalId], [TenantId], [DataOwner], [DataScope], [Creator], [Updator], [CreateTime], [UpdateTime], [Kind]) 
VALUES (@role_ceo, N'总经理', 0, N'', 1, 'DefaultAdmin_root,PersonalHome_A01,PersonalHome_Backlog,PersonalHome_MyBacklog,PersonalHome_FBacklog,PersonalHome_PersonalInfo,SYS_001,SYS_User,SYS_Role,SYS_SysAuditLog,SYS_002,SYS_Dict,SYS_CodeRule', 
N'-4209377017798016180', NULL, N'CEO', NULL, @tenantGuid, NULL, NULL, @adminGuid, @adminGuid, @createtime, @createtime, NULL)
INSERT [dbo].[SYS_Role] ([ResId], [Name], [ResState], [Desc], [RoleType], [AppFunctions], [BizFunctions], [InheritRoles], [Code], [LegalId], [TenantId], [DataOwner], [DataScope], [Creator], [Updator], [CreateTime], [UpdateTime], [Kind]) 
VALUES (@role_employee, N'员工', 0, N'', 1, 'DefaultAdmin_root,PersonalHome_A01,PersonalHome_Backlog,PersonalHome_MyBacklog,PersonalHome_FBacklog,PersonalHome_PersonalInfo,PersonalHome_Asset', 
N'-6727441226045939871,941944903260882362,-8782079924156881375,-8105690411004923952,-2193607210573372474,-4930263262153341963', NULL, N'Employee', NULL, @tenantGuid, NULL, NULL, @adminGuid, @adminGuid, @createtime, @createtime, NULL)
INSERT [dbo].[SYS_Role] ([ResId], [Name], [ResState], [Desc], [RoleType], [AppFunctions], [BizFunctions], [InheritRoles], [Code], [LegalId], [TenantId], [DataOwner], [DataScope], [Creator], [Updator], [CreateTime], [UpdateTime], [Kind]) 
VALUES (@role_adminspecialist, N'行政专员', 0, N'', 1, 'FM_A01,FM_OA_Cert,FM_OA_Stamp,FM_OA_StampCertRequest', N'', NULL, N'AdminSpecialist', NULL, @tenantGuid, NULL, NULL, @adminGuid, @adminGuid, @createtime, @createtime, NULL)
INSERT [dbo].[SYS_Role] ([ResId], [Name], [ResState], [Desc], [RoleType], [AppFunctions], [BizFunctions], [InheritRoles], [Code], [LegalId], [TenantId], [DataOwner], [DataScope], [Creator], [Updator], [CreateTime], [UpdateTime], [Kind]) 
VALUES (@role_hrspecialist, N'人事专员', 0, N'', 1, 'Organization_A01,ORG_LEG,ORG_ORGUNIT,ORG_Position,ORG_Job,ORG_JobLevel,HR_A01,HR_OfficeArea,HR_EMP_SalaryLevel,HR_EMP_Employee', N'', NULL, N'HrSpecialist', NULL, @tenantGuid, NULL, NULL, @adminGuid, @adminGuid, @createtime, @createtime, NULL)
declare @role_assetadmin varchar(36)
set @role_assetadmin= LOWER(CONVERT(NVARCHAR(36), NEWID()))
INSERT [dbo].[SYS_Role] ([ResId], [Name], [ResState], [Desc], [RoleType], [AppFunctions], [BizFunctions], [InheritRoles], [Code], [LegalId], [TenantId], [DataOwner], [DataScope], [Creator], [Updator], [CreateTime], [UpdateTime], [Kind]) 
VALUES (@role_assetadmin, N'资产管理员', 0, N'', 1, 'Asset_A01,Asset_Info,Asset_Warehouse,Asset_Category,Asset_OBList', N'', NULL, N'AssetAdmin', NULL, @tenantGuid, NULL, NULL, @adminGuid, @adminGuid, @createtime, @createtime, NULL)
declare @role_financespecialist varchar(36)
set @role_financespecialist= LOWER(CONVERT(NVARCHAR(36), NEWID()))
INSERT [dbo].[SYS_Role] ([ResId], [Name], [ResState], [Desc], [RoleType], [AppFunctions], [BizFunctions], [InheritRoles], [Code], [LegalId], [TenantId], [DataOwner], [DataScope], [Creator], [Updator], [CreateTime], [UpdateTime], [Kind]) 
VALUES (@role_financespecialist, N'财务专员', 0, N'', 1, '', N'', NULL, N'FinanceSpecialist', NULL, @tenantGuid, NULL, NULL, @adminGuid, @adminGuid, @createtime, @createtime, NULL)


--Position
declare @pos_ceo varchar(36)
set @pos_ceo= LOWER(CONVERT(NVARCHAR(36), NEWID()))
--ceo
INSERT [dbo].[HR_ORG_Position] ([PositionID], [PositionCode], [PositionName], [IsFunctionPosition], [ReportToPositionID], [PositionCodePath], [Headcount], [IsAppraisal], [IsHead], [IsPrincipal], [IsApprover], [IsApplier], [PositionDescription], [OrganizationID], [JobID], [PositionLevelID], [IsUse], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (@pos_ceo, N'P001', N'总经理', 1, NULL, N'P001', 1, 1, 0, 0, 0, 0, NULL, @org_company, NULL, NULL, 1,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[HR_ORG_PositionRoleList] ([PositionID], [RoleID]) VALUES (@pos_ceo, @role_ceo)
INSERT [dbo].[HR_ORG_PositionRoleList] ([PositionID], [RoleID]) VALUES (@pos_ceo, @role_employee)
INSERT [dbo].[HR_ORG_PositionRoleList] ([PositionID], [RoleID]) VALUES (@pos_ceo, @role_adminspecialist)
INSERT [dbo].[HR_ORG_PositionRoleList] ([PositionID], [RoleID]) VALUES (@pos_ceo, @role_hrspecialist)
INSERT [dbo].[HR_ORG_PositionRoleList] ([PositionID], [RoleID]) VALUES (@pos_ceo, @role_assetadmin)
INSERT [dbo].[HR_ORG_PositionRoleList] ([PositionID], [RoleID]) VALUES (@pos_ceo, @role_financespecialist)
--employee
declare @pos_employee varchar(36)
set @pos_employee= LOWER(CONVERT(NVARCHAR(36), NEWID()))
INSERT [dbo].[HR_ORG_Position] ([PositionID], [PositionCode], [PositionName], [IsFunctionPosition], [ReportToPositionID], [PositionCodePath], [Headcount], [IsAppraisal], [IsHead], [IsPrincipal], [IsApprover], [IsApplier], [PositionDescription], [OrganizationID], [JobID], [PositionLevelID], [IsUse], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (@pos_employee, N'P002', N'员工', 1, NULL, N'P002', 9, 1, 0, 0, 0, 0, NULL, @org_company, NULL, NULL, 1,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[HR_ORG_PositionRoleList] ([PositionID], [RoleID]) VALUES (@pos_employee, @role_employee)


--RuleCode
--Org
INSERT [dbo].[SYS_CodeRule] ([RuleCode], [RuleName], [Description], [Memo], [IsUse], [LegalChar], [LegalOrder], [FixChar], [FixOrder], [TimeChar], [TimeOrder], [FlowingChar], [FlowingOrder], [OtherCharType], [OtherCharOrder], [RuleProvider], [LastTimeCode], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES ( N'HR_ORG_Position_PositionCode', N'职位编码', N'公司编码(实体)+职位（固定值）+ 3位流水号', NULL, 1, NULL, 1, N'P', 2, NULL, NULL, N'001', 3, NULL, NULL, NULL, NULL, @createtime, @adminGuid, @createtime, @adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[SYS_CodeRule] ([RuleCode], [RuleName], [Description], [Memo], [IsUse], [LegalChar], [LegalOrder], [FixChar], [FixOrder], [TimeChar], [TimeOrder], [FlowingChar], [FlowingOrder], [OtherCharType], [OtherCharOrder], [RuleProvider], [LastTimeCode], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES ( N'HR_ORG_Organization_OrganizationCode', N'组织机构编码', N'上级组织机构编码 + 两位流水号', NULL, 1, NULL, NULL, N'', NULL, N'', NULL, N'', NULL, N'', NULL, N'Yar.Enterprise.CodeRule.HR_ORG_Organization_OrganizationCode_CodeRule,Yar.Enterprise', N'', @createtime, @adminGuid, @createtime, @adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[SYS_CodeRule] ( [RuleCode], [RuleName], [Description], [Memo], [IsUse], [LegalChar], [LegalOrder], [FixChar], [FixOrder], [TimeChar], [TimeOrder], [FlowingChar], [FlowingOrder], [OtherCharType], [OtherCharOrder], [RuleProvider], [LastTimeCode], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES ( N'HR_ORG_Job_JobCode', N'职务编码', N'公司编码(实体) + 三位流水号', NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, N'001', 2, NULL, NULL, NULL, NULL, @createtime, @adminGuid, @createtime, @adminGuid, 0, @legalGuid, @tenantGuid)

--wf rulecode
INSERT [dbo].[SYS_CodeRule] ([RuleID], [RuleCode], [RuleName], [Description], [Memo], [IsUse],[LegalChar],[LegalOrder], [FixChar], [FixOrder], [TimeChar], [TimeOrder], [FlowingChar], [FlowingOrder], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'Enterprise_WF_FolioRuleCode', N'业务表单编码', N'公司编码(实体)+WF+年月+四位流水号', NULL, 1,NULL,1, 'WF', 2, 'yyyyMM', 3, N'00001', 4, @createtime, @adminGuid, @createtime, @adminGuid, 0, @legalGuid, @tenantGuid)

--HR
INSERT [dbo].[SYS_CodeRule] ([RuleID], [RuleCode], [RuleName], [Description], [Memo], [IsUse],[LegalChar],[LegalOrder], [FixChar], [FixOrder], [TimeChar], [TimeOrder], [FlowingChar], [FlowingOrder], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'HR_EMP_Employee_EmployeeNumber', N'员工工号', N'公司编码（实体）+3位流水号', NULL, 1,NULL,1, NULL, NULL, NULL, NULL, N'001', 2, @createtime, @adminGuid, @createtime, @adminGuid, 0, @legalGuid, @tenantGuid)

--asset AM_WH_Warehouse_WareCode
INSERT [dbo].[SYS_CodeRule] ([RuleID], [RuleCode], [RuleName], [Description], [Memo], [IsUse],[LegalChar],[LegalOrder], [FixChar], [FixOrder], [TimeChar], [TimeOrder], [FlowingChar], [FlowingOrder], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'AM_WH_Warehouse_WareCode', N'仓库编码', N'法人公司+固定分类（2位）+流水号（3位）', NULL, 1,NULL,1, 'CK', 2, NULL, NULL, N'001', 3, @createtime, @adminGuid, @createtime, @adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[SYS_CodeRule] ([RuleID], [RuleCode], [RuleName], [Description], [Memo], [IsUse],[LegalChar],[LegalOrder], [FixChar], [FixOrder], [TimeChar], [TimeOrder], [FlowingChar], [FlowingOrder], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'AM_AS_Asset_AssetCode', N'资产编码', N'公司编码(实体)+Asset+四位流水号', NULL, 1,NULL,1, '-ASSET-', 2, NULL, NULL, N'0001', 3, @createtime, @adminGuid, @createtime, @adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[SYS_CodeRule] ([RuleID],[RuleCode], [RuleName], [Description], [Memo], [IsUse], [LegalChar], [LegalOrder], [FixChar], [FixOrder], [TimeChar], [TimeOrder], [FlowingChar], [FlowingOrder], [OtherCharType], [OtherCharOrder], [RuleProvider], [LastTimeCode], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'AM_AssetCategory_RuleCode', N'资产分类编码', N'资产分类 + 两位流水号', NULL, 1, NULL, NULL, N'', NULL, N'', NULL, N'', NULL, N'', NULL, N'Yar.Enterprise.Asset.Biz.AssetCategory_CodeRule,Yar.Enterprise.Asset', N'', @createtime, @adminGuid, @createtime, @adminGuid, 0, @legalGuid, @tenantGuid)


--workflow
INSERT [dbo].[SYS_RequestType] ([Id], [RequestTypeCode], [RequestGroup], [RequestTypeName], [Memo], [BusinessId], [VerifyView], [FormCode], [FlowCode], [FlowName], [FolioRuleCode], [WorkflowParam], [WorkflowRemark], [IsPositionSelect], [CanBatchApproval], [CanCommonApproval], [TypeLevel], [ParentTypeCode], [IsDefault], [IsDisabled], [IsDeleted], [IsHeadApproval], [Text1], [Text2], [Text3], [Text4], [Text5], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'FM007', NULL, N'用章申请', N'', N'Biz_OA_Request_Stamp', N'PreviewView', NULL, N'Enterprise_OA_FM007', N'用章申请', N'Enterprise_WF_FolioRuleCode', N'{{}}', N'流程发起后，将提交至总经理审批。', 0, 0, 1, 0, N'', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, @createtime, @adminGuid, @createtime, @adminGuid, @legalGuid, @tenantGuid)

INSERT [dbo].[SYS_RequestType] ([Id], [RequestTypeCode], [RequestGroup], [RequestTypeName], [Memo], [BusinessId], [VerifyView], [FormCode], [FlowCode], [FlowName], [FolioRuleCode], [WorkflowParam], [WorkflowRemark], [IsPositionSelect], [CanBatchApproval], [CanCommonApproval], [TypeLevel], [ParentTypeCode], [IsDefault], [IsDisabled], [IsDeleted], [IsHeadApproval], [Text1], [Text2], [Text3], [Text4], [Text5], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'FM006', NULL, N'印章证照借用申请', N'', N'Biz_OA_Request_StampBorrow', N'PreviewView', NULL, N'Enterprise_OA_FM006', N'印章证照借用申请', N'Enterprise_WF_FolioRuleCode', N'{{}}', N'流程发起后,将提交至总经理审批,行政办借用,申请者归还。', 0, 0, 1, 0, N'', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, @createtime, @adminGuid, @createtime, @adminGuid, @legalGuid, @tenantGuid)

INSERT [dbo].[SYS_RequestType] ([Id], [RequestTypeCode], [RequestGroup], [RequestTypeName], [Memo], [BusinessId], [VerifyView], [FormCode], [FlowCode], [FlowName], [FolioRuleCode], [WorkflowParam], [WorkflowRemark], [IsPositionSelect], [CanBatchApproval], [CanCommonApproval], [TypeLevel], [ParentTypeCode], [IsDefault], [IsDisabled], [IsDeleted], [IsHeadApproval], [Text1], [Text2], [Text3], [Text4], [Text5], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [LegalEntityID], [TenantID])
VALUES (NEWID(), N'FM005', NULL, N'刻章申请', N'', N'Biz_OA_Request_CarveStamp', N'PreviewView', NULL, N'Enterprise_OA_FM005', N'刻章申请', N'Enterprise_WF_FolioRuleCode', N'{{}}', N'流程发起后,将提交至总经理审批,行政发放。', 0, 0, 1, 0, N'', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, @createtime, @adminGuid, @createtime, @adminGuid, @legalGuid, @tenantGuid)

INSERT [dbo].[SYS_RequestType] ([Id], [RequestTypeCode], [RequestGroup], [RequestTypeName], [Memo], [BusinessId], [VerifyView], [FormCode], [FlowCode], [FlowName], [FolioRuleCode], [WorkflowParam], [WorkflowRemark], [IsPositionSelect], [CanBatchApproval], [CanCommonApproval], [TypeLevel], [ParentTypeCode], [IsDefault], [IsDisabled], [IsDeleted], [IsHeadApproval], [Text1], [Text2], [Text3], [Text4], [Text5], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [LegalEntityID], [TenantID])
VALUES (NEWID(), N'AM011', NULL, N'固定资产领用申请', N'', N'Biz_WF_Request_FixedAsset', N'PreviewView', NULL, N'Enterprise_OA_AM011', N'固定资产领用申请', N'Enterprise_WF_FolioRuleCode', N'{{}}', N'流程发起后，将先由行政办确认库存，行政办选择执行调拨或者采购。资产采购将经由财务部核价，行政部审批，总经理审批；资产调拨经由行政部审批，总经理审批。最后交由行政办进行资产发放。', 0, 0, 1, 0, N'', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, @createtime, @adminGuid, @createtime, @adminGuid, @legalGuid, @tenantGuid)

INSERT [dbo].[SYS_RequestType] ([Id], [RequestTypeCode], [RequestGroup], [RequestTypeName], [Memo], [BusinessId], [VerifyView], [FormCode], [FlowCode], [FlowName], [FolioRuleCode], [WorkflowParam], [WorkflowRemark], [IsPositionSelect], [CanBatchApproval], [CanCommonApproval], [TypeLevel], [ParentTypeCode], [IsDefault], [IsDisabled], [IsDeleted], [IsHeadApproval], [Text1], [Text2], [Text3], [Text4], [Text5], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [LegalEntityID], [TenantID])
VALUES (NEWID(), N'AM012', NULL, N'低值资产领用申请', N'', N'Biz_WF_Request_LowValueAsset', N'PreviewView', NULL, N'Enterprise_OA_AM012', N'低值资产领用申请', N'Enterprise_WF_FolioRuleCode', N'{{}}', N'流程发起后，交由行政办执行调拨,然后交由行政办进行资产发放', 0, 0, 1, 0, N'', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, @createtime, @adminGuid, @createtime, @adminGuid, @legalGuid, @tenantGuid)

INSERT [dbo].[SYS_RequestType] ([Id], [RequestTypeCode], [RequestGroup], [RequestTypeName], [Memo], [BusinessId], [VerifyView], [FormCode], [FlowCode], [FlowName], [FolioRuleCode], [WorkflowParam], [WorkflowRemark], [IsPositionSelect], [CanBatchApproval], [CanCommonApproval], [TypeLevel], [ParentTypeCode], [IsDefault], [IsDisabled], [IsDeleted], [IsHeadApproval], [Text1], [Text2], [Text3], [Text4], [Text5], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [LegalEntityID], [TenantID])
VALUES (NEWID(), N'AM003', NULL, N'资产归还申请', N'', N'Biz_WF_Request_AssetReturn', N'PreviewView', NULL, N'Enterprise_OA_AM003', N'资产归还申请', N'Enterprise_WF_FolioRuleCode', N'{{}}', N'流程发起后,由资产管理员审批,然后交由行政办进行资产执行', 0, 0, 1, 0, N'', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, @createtime, @adminGuid, @createtime, @adminGuid, @legalGuid, @tenantGuid)


--asset data
INSERT [dbo].[AM_WH_Warehouse] ([WareID], [WareCode], [Name], [LegalEntityID], [AdminUserID], [Contact], [IsNormal], [IsScraped], [Address], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [TenantID]) 
VALUES (NEWID(), @tenantCode + N'CK', @tenantName + N'仓库', @legalGuid, @adminGuid, NULL, 1, 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as001', N'办公打印文仪', N'0|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as002', N'办公家具', N'0|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as003', N'电子电器设备', N'0|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as004', N'计算机设备', N'0|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as005', N'房屋及建筑物', N'0|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as006', N'交通运输设备', N'0|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as007', N'其他类固定资产', N'0|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as101', N'办公打印文仪', N'1|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as102', N'办公家具', N'1|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as103', N'电子电器设备', N'1|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as104', N'计算机设备', N'1|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)
INSERT [dbo].[AM_AS_AssetCategory] ([AssetCategoryID], [ParentID], [AssetCategoryCode], [AssetCategoryName], [AssetCategoryType], [Remark], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID]) 
VALUES (NEWID(), N'00000000-0000-0000-0000-000000000000', N'as105', N'其他类低值资产', N'1|AM_LIST_CATEGORY', NULL,@createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid)

INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'小汽车', N'0|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'数码电子', N'0|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'笔记本', N'0|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'显示器', N'0|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'其他类固定资产', N'0|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'主机', N'0|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'椅子沙发', N'0|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'打印机', N'0|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'电器', N'0|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'投影仪', N'0|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)

INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'其他', N'1|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'鼠标', N'1|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'优盘', N'1|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'键盘', N'1|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'路由器', N'1|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)
INSERT [dbo].[AM_OB_List] ([ListID], [Name], [ListCategory], [Order], [Price], [IsGift], [Desc], [CreateTime], [CreateUserID], [UpdateTime], [UpdateUserID], [IsDeleted], [LegalEntityID], [TenantID], [Unit]) 
VALUES (NEWID(), N'拖线板', N'1|AM_LIST_CATEGORY', NULL, CAST(0.00 AS Decimal(18, 2)), 0, NULL, @createtime, @adminGuid, @createtime,@adminGuid, 0, @legalGuid, @tenantGuid, NULL)

