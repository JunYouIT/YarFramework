
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WfTaskProcessWfTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[WfTasks]'))
ALTER TABLE [dbo].[WfTasks] DROP CONSTRAINT [FK_WfTaskProcessWfTask]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WfTaskActivityWfTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[WfTasks]'))
ALTER TABLE [dbo].[WfTasks] DROP CONSTRAINT [FK_WfTaskActivityWfTask]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WfTaskProcessWfTaskActivity]') AND parent_object_id = OBJECT_ID(N'[dbo].[WfTaskActivities]'))
ALTER TABLE [dbo].[WfTaskActivities] DROP CONSTRAINT [FK_WfTaskProcessWfTaskActivity]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Tenan__Creat__1367E606]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Tenant] DROP CONSTRAINT [DF__SYS_Tenan__Creat__1367E606]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Tenan__IsEna__1273C1CD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Tenant] DROP CONSTRAINT [DF__SYS_Tenan__IsEna__1273C1CD]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Tenan__IsDel__117F9D94]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Tenant] DROP CONSTRAINT [DF__SYS_Tenan__IsDel__117F9D94]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Tenan__Tenan__108B795B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Tenant] DROP CONSTRAINT [DF__SYS_Tenan__Tenan__108B795B]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_R__Creat__03F0984C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] DROP CONSTRAINT [DF__SYS_R__Creat__03F0984C]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestType_IsDisabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] DROP CONSTRAINT [DF_SYS_RequestType_IsDisabled]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestType_TypeLevel]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] DROP CONSTRAINT [DF_SYS_RequestType_TypeLevel]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestType_CanCommonApproval]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] DROP CONSTRAINT [DF_SYS_RequestType_CanCommonApproval]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestType_CanBatchApproval]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] DROP CONSTRAINT [DF_SYS_RequestType_CanBatchApproval]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestType_IsPositionSelect]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] DROP CONSTRAINT [DF_SYS_RequestType_IsPositionSelect]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestMaster_IsNotifyResult]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestMaster] DROP CONSTRAINT [DF_SYS_RequestMaster_IsNotifyResult]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_M__Creat__6AFACD50]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_MessageTemplate] DROP CONSTRAINT [DF__SYS_M__Creat__6AFACD50]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Messa__Creat__3E1D39E1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_MessageScope] DROP CONSTRAINT [DF__SYS_Messa__Creat__3E1D39E1]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_M__Creat__53633AE1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_MessageDeliveryDetail] DROP CONSTRAINT [DF__SYS_M__Creat__53633AE1]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_MessageDeliveryDetail_IsRead]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_MessageDeliveryDetail] DROP CONSTRAINT [DF_SYS_MessageDeliveryDetail_IsRead]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Messa__MaxRe__3B40CD36]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_MessageDeliveryDetail] DROP CONSTRAINT [DF__SYS_Messa__MaxRe__3B40CD36]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Messa__Creat__3A4CA8FD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Message] DROP CONSTRAINT [DF__SYS_Messa__Creat__3A4CA8FD]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Feedb__IsDel__117F9D94]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Feedback] DROP CONSTRAINT [DF__SYS_Feedb__IsDel__117F9D94]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Feedb__Creat__1367E606]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Feedback] DROP CONSTRAINT [DF__SYS_Feedb__Creat__1367E606]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Feedb__Feedb__108B795B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Feedback] DROP CONSTRAINT [DF__SYS_Feedb__Feedb__108B795B]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_DictI__Creat__395884C4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_DictItemScope] DROP CONSTRAINT [DF__SYS_DictI__Creat__395884C4]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_DictI__IsEna__3864608B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_DictItem] DROP CONSTRAINT [DF__SYS_DictI__IsEna__3864608B]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_DictI__IsDel__37703C52]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_DictItem] DROP CONSTRAINT [DF__SYS_DictI__IsDel__37703C52]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_DictI__Creat__367C1819]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_DictItem] DROP CONSTRAINT [DF__SYS_DictI__Creat__367C1819]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_DictI__ItemI__3587F3E0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_DictItem] DROP CONSTRAINT [DF__SYS_DictI__ItemI__3587F3E0]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Dict__IsDele__3493CFA7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Dict] DROP CONSTRAINT [DF__SYS_Dict__IsDele__3493CFA7]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Dict__Create__339FAB6E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Dict] DROP CONSTRAINT [DF__SYS_Dict__Create__339FAB6E]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Dict__IsCach__32AB8735]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Dict] DROP CONSTRAINT [DF__SYS_Dict__IsCach__32AB8735]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Dict__IsEnab__31B762FC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Dict] DROP CONSTRAINT [DF__SYS_Dict__IsEnab__31B762FC]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Dict__DictID__30C33EC3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Dict] DROP CONSTRAINT [DF__SYS_Dict__DictID__30C33EC3]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_COM_BankBranch_CreateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_BankBranch] DROP CONSTRAINT [DF_SYS_COM_BankBranch_CreateTime]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_COM_AttachmentType_TenantID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_AttachmentType] DROP CONSTRAINT [DF_SYS_COM_AttachmentType_TenantID]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_COM_AttachmentType_LegalEntityID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_AttachmentType] DROP CONSTRAINT [DF_SYS_COM_AttachmentType_LegalEntityID]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_COM_AttachmentType_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_AttachmentType] DROP CONSTRAINT [DF_SYS_COM_AttachmentType_IsDeleted]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_COM_AttachmentType_CreateUserID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_AttachmentType] DROP CONSTRAINT [DF_SYS_COM_AttachmentType_CreateUserID]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_COM_A__Creat__2B0A656D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_AttachmentType] DROP CONSTRAINT [DF__SYS_COM_A__Creat__2B0A656D]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_COM_A__Creat__2A164134]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_Attachement] DROP CONSTRAINT [DF__SYS_COM_A__Creat__2A164134]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_CodeR__Creat__29221CFB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_CodeRuleCounter] DROP CONSTRAINT [DF__SYS_CodeR__Creat__29221CFB]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_CodeR__Count__282DF8C2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_CodeRuleCounter] DROP CONSTRAINT [DF__SYS_CodeR__Count__282DF8C2]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_CodeR__Creat__2739D489]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_CodeRule] DROP CONSTRAINT [DF__SYS_CodeR__Creat__2739D489]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_CodeR__RuleI__2645B050]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_CodeRule] DROP CONSTRAINT [DF__SYS_CodeR__RuleI__2645B050]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_AuditLog_IsMobileAgent]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_AuditLog] DROP CONSTRAINT [DF_SYS_AuditLog_IsMobileAgent]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ti__Tenan__12149A71]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_Tile] DROP CONSTRAINT [DF__PS_HOM_Ti__Tenan__12149A71]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ti__Creat__11207638]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_Tile] DROP CONSTRAINT [DF__PS_HOM_Ti__Creat__11207638]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ti__TileI__102C51FF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_Tile] DROP CONSTRAINT [DF__PS_HOM_Ti__TileI__102C51FF]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Templ__ID__0D4FE554]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_TemplateUserRelation] DROP CONSTRAINT [DF__PS_HOM_Templ__ID__0D4FE554]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Te__Creat__0A7378A9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_TemplateAreaTileRelation] DROP CONSTRAINT [DF__PS_HOM_Te__Creat__0A7378A9]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Templ__ID__097F5470]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_TemplateAreaTileRelation] DROP CONSTRAINT [DF__PS_HOM_Templ__ID__097F5470]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ho__Creat__01DE32A8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_HomeTemplateArea] DROP CONSTRAINT [DF__PS_HOM_Ho__Creat__01DE32A8]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ho__AreaI__00EA0E6F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_HomeTemplateArea] DROP CONSTRAINT [DF__PS_HOM_Ho__AreaI__00EA0E6F]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ho__Creat__7E0DA1C4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_HomeTemplate] DROP CONSTRAINT [DF__PS_HOM_Ho__Creat__7E0DA1C4]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ho__HomeT__7D197D8B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_HomeTemplate] DROP CONSTRAINT [DF__PS_HOM_Ho__HomeT__7D197D8B]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_INFO_InformationType_CreateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_InformationType] DROP CONSTRAINT [DF_INFO_InformationType_CreateTime]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_Info__Creat__245D67DE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_InformationComment] DROP CONSTRAINT [DF__INFO_Info__Creat__245D67DE]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_I__Creat__4C8B54C9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_InformationBodyNominated] DROP CONSTRAINT [DF__INFO_I__Creat__4C8B54C9]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_I__Creat__54CB950F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_InformationBody] DROP CONSTRAINT [DF__INFO_I__Creat__54CB950F]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_Info__Creat__2180FB33]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_InformationAttachement] DROP CONSTRAINT [DF__INFO_Info__Creat__2180FB33]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_I__Creat__2A363CC5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_Information] DROP CONSTRAINT [DF__INFO_I__Creat__2A363CC5]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_INFO_Information_IsNominated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_Information] DROP CONSTRAINT [DF_INFO_Information_IsNominated]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_C__Creat__3B60C8C7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_Column] DROP CONSTRAINT [DF__INFO_C__Creat__3B60C8C7]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Po__Creat__70DDC3D8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Position] DROP CONSTRAINT [DF__HR_ORG_Po__Creat__70DDC3D8]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_Position_IsApplier]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Position] DROP CONSTRAINT [DF_HR_ORG_Position_IsApplier]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_Position_IsApprover]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Position] DROP CONSTRAINT [DF_HR_ORG_Position_IsApprover]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_Position_IsPrincipal]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Position] DROP CONSTRAINT [DF_HR_ORG_Position_IsPrincipal]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_Position_IsHead]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Position] DROP CONSTRAINT [DF_HR_ORG_Position_IsHead]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Or__IsDis__778AC167]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Organization] DROP CONSTRAINT [DF__HR_ORG_Or__IsDis__778AC167]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Or__Creat__6E01572D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Organization] DROP CONSTRAINT [DF__HR_ORG_Or__Creat__6E01572D]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_Organization_Sequence]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Organization] DROP CONSTRAINT [DF_HR_ORG_Organization_Sequence]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_LegalEntity_TenantID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_LegalEntity] DROP CONSTRAINT [DF_HR_ORG_LegalEntity_TenantID]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_LegalEntity_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_LegalEntity] DROP CONSTRAINT [DF_HR_ORG_LegalEntity_IsDeleted]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_LegalEntity_CreateUserID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_LegalEntity] DROP CONSTRAINT [DF_HR_ORG_LegalEntity_CreateUserID]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Le__Creat__1332DBDC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_LegalEntity] DROP CONSTRAINT [DF__HR_ORG_Le__Creat__1332DBDC]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_LegalEntity_LegalEntityID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_LegalEntity] DROP CONSTRAINT [DF_HR_ORG_LegalEntity_LegalEntityID]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Jo__IsDis__114A936A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_JobLevel] DROP CONSTRAINT [DF__HR_ORG_Jo__IsDis__114A936A]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Jo__Creat__10566F31]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_JobLevel] DROP CONSTRAINT [DF__HR_ORG_Jo__Creat__10566F31]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Jo__IsDis__0F624AF8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Job] DROP CONSTRAINT [DF__HR_ORG_Jo__IsDis__0F624AF8]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Jo__Creat__0E6E26BF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Job] DROP CONSTRAINT [DF__HR_ORG_Jo__Creat__0E6E26BF]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Wo__Creat__529933DA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_WorkHistory] DROP CONSTRAINT [DF__HR_EMP_Wo__Creat__529933DA]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_SalaryLevel_CreateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_SalaryLevel] DROP CONSTRAINT [DF_HR_EMP_SalaryLevel_CreateTime]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_SalaryLevel_IsDisabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_SalaryLevel] DROP CONSTRAINT [DF_HR_EMP_SalaryLevel_IsDisabled]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Po__Creat__76969D2E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_PostInformation] DROP CONSTRAINT [DF__HR_EMP_Po__Creat__76969D2E]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Ot__Creat__3CA9F2BB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_OtherContact] DROP CONSTRAINT [DF__HR_EMP_Ot__Creat__3CA9F2BB]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_OfficeArea_AreaSize]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_OfficeArea] DROP CONSTRAINT [DF_HR_EMP_OfficeArea_AreaSize]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_OfficeAre__Creat__3DB3258D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_OfficeArea] DROP CONSTRAINT [DF__HR_EMP_OfficeAre__Creat__3DB3258D]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Em__Creat__0A688BB1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_EmployeeFamily] DROP CONSTRAINT [DF__HR_EMP_Em__Creat__0A688BB1]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Em__Creat__5A846E65]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_EmployeeContract] DROP CONSTRAINT [DF__HR_EMP_Em__Creat__5A846E65]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_EmployeeContract_SignedTimes]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_EmployeeContract] DROP CONSTRAINT [DF_HR_EMP_EmployeeContract_SignedTimes]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Em__Creat__73BA3083]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_Employee] DROP CONSTRAINT [DF__HR_EMP_Em__Creat__73BA3083]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_Employee_CostCenterMode]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_Employee] DROP CONSTRAINT [DF_HR_EMP_Employee_CostCenterMode]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Ed__Creat__26BAB19C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_Education] DROP CONSTRAINT [DF__HR_EMP_Ed__Creat__26BAB19C]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Ba__Creat__7EF6D905]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_BankCard] DROP CONSTRAINT [DF__HR_EMP_Ba__Creat__7EF6D905]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_BankCard_BankCity]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_BankCard] DROP CONSTRAINT [DF_HR_EMP_BankCard_BankCity]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Ad__Creat__7C1A6C5A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_Address] DROP CONSTRAINT [DF__HR_EMP_Ad__Creat__7C1A6C5A]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_FM_OA_Stapm_IsUse]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_Stapm] DROP CONSTRAINT [DF_FM_OA_Stapm_IsUse]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__FM_OA_Sta__Creat__39AD8A7F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_Stapm] DROP CONSTRAINT [DF__FM_OA_Sta__Creat__39AD8A7F]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__FM_OA_Sta__Creat__3C89F72A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_StampRequest] DROP CONSTRAINT [DF__FM_OA_Sta__Creat__3C89F72A]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__FM_OA_Sta__Creat__35DCF99B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_StampBorrowRequest] DROP CONSTRAINT [DF__FM_OA_Sta__Creat__35DCF99B]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_FM_OA_StampBorrowRequest_IsProject]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_StampBorrowRequest] DROP CONSTRAINT [DF_FM_OA_StampBorrowRequest_IsProject]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__FM_OA_Cer__Creat__414EAC47]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_Cert] DROP CONSTRAINT [DF__FM_OA_Cer__Creat__414EAC47]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__FM_OA_Car__Creat__1D4655FB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_CarvedIResquest] DROP CONSTRAINT [DF__FM_OA_Car__Creat__1D4655FB]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_WH_War__Creat__6754599E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_WH_Warehouse] DROP CONSTRAINT [DF__AM_WH_War__Creat__6754599E]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_OB_Usa__Creat__6477ECF3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_OB_UsageRequestDetail] DROP CONSTRAINT [DF__AM_OB_Usa__Creat__6477ECF3]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_OB_Usa__Creat__619B8048]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_OB_UsageRequest] DROP CONSTRAINT [DF__AM_OB_Usa__Creat__619B8048]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_OB_Ret__Creat__5EBF139D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_OB_ReturnRequestDetail] DROP CONSTRAINT [DF__AM_OB_Ret__Creat__5EBF139D]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_OB_Ret__Creat__5BE2A6F2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_OB_ReturnRequest] DROP CONSTRAINT [DF__AM_OB_Ret__Creat__5BE2A6F2]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_OB_Lis__Creat__5165187F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_OB_List] DROP CONSTRAINT [DF__AM_OB_Lis__Creat__5165187F]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_AS_Usa__Creat__35BCFE0A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_Usage] DROP CONSTRAINT [DF__AM_AS_Usa__Creat__35BCFE0A]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_AM_AS_PurchaseInput_PurchaseItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_PurchaseInput] DROP CONSTRAINT [DF_AM_AS_PurchaseInput_PurchaseItemID]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_AM_AS_PurchaseInput_PurchaseOrderItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_PurchaseInput] DROP CONSTRAINT [DF_AM_AS_PurchaseInput_PurchaseOrderItemID]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_AS_Pur__Creat__30F848ED]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_PurchaseInput] DROP CONSTRAINT [DF__AM_AS_Pur__Creat__30F848ED]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_AS_Mai__Creat__2B3F6F97]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_Maintain] DROP CONSTRAINT [DF__AM_AS_Mai__Creat__2B3F6F97]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_AS_Ass__Creat__2EDAF651]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_AssetCategory] DROP CONSTRAINT [DF__AM_AS_Ass__Creat__2EDAF651]
END

GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_AS_Ass__Creat__3D5E1FD2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_Asset] DROP CONSTRAINT [DF__AM_AS_Ass__Creat__3D5E1FD2]
END

GO
/****** Object:  Table [dbo].[WfTasks]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WfTasks]') AND type in (N'U'))
DROP TABLE [dbo].[WfTasks]
GO
/****** Object:  Table [dbo].[WfTaskProcesses]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WfTaskProcesses]') AND type in (N'U'))
DROP TABLE [dbo].[WfTaskProcesses]
GO
/****** Object:  Table [dbo].[WfTaskActivities]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WfTaskActivities]') AND type in (N'U'))
DROP TABLE [dbo].[WfTaskActivities]
GO
/****** Object:  Table [dbo].[SYS_User]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_User]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_User]
GO
/****** Object:  Table [dbo].[SYS_Tenant]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Tenant]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_Tenant]
GO
/****** Object:  Table [dbo].[SYS_Role]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Role]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_Role]
GO
/****** Object:  Table [dbo].[SYS_RequestType]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_RequestType]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_RequestType]
GO
/****** Object:  Table [dbo].[SYS_RequestMaster]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_RequestMaster]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_RequestMaster]
GO
/****** Object:  Table [dbo].[SYS_Org]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Org]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_Org]
GO
/****** Object:  Table [dbo].[SYS_MessageTemplate]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_MessageTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_MessageTemplate]
GO
/****** Object:  Table [dbo].[SYS_MessageScope]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_MessageScope]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_MessageScope]
GO
/****** Object:  Table [dbo].[SYS_MessageDeliveryDetail]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_MessageDeliveryDetail]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_MessageDeliveryDetail]
GO
/****** Object:  Table [dbo].[SYS_Message]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Message]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_Message]
GO
/****** Object:  Table [dbo].[SYS_Feedback]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Feedback]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_Feedback]
GO
/****** Object:  Table [dbo].[SYS_DictItemScope]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_DictItemScope]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_DictItemScope]
GO
/****** Object:  Table [dbo].[SYS_DictItem]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_DictItem]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_DictItem]
GO
/****** Object:  Table [dbo].[SYS_Dict]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Dict]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_Dict]
GO
/****** Object:  Table [dbo].[SYS_DataPrivilege]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_DataPrivilege]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_DataPrivilege]
GO
/****** Object:  Table [dbo].[SYS_COM_BankBranch]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_COM_BankBranch]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_COM_BankBranch]
GO
/****** Object:  Table [dbo].[SYS_COM_AttachmentType]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_COM_AttachmentType]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_COM_AttachmentType]
GO
/****** Object:  Table [dbo].[SYS_COM_Attachement]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_COM_Attachement]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_COM_Attachement]
GO
/****** Object:  Table [dbo].[SYS_CodeRuleCounter]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_CodeRuleCounter]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_CodeRuleCounter]
GO
/****** Object:  Table [dbo].[SYS_CodeRule]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_CodeRule]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_CodeRule]
GO
/****** Object:  Table [dbo].[SYS_Audittrail]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Audittrail]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_Audittrail]
GO
/****** Object:  Table [dbo].[SYS_AuditLog]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_AuditLog]') AND type in (N'U'))
DROP TABLE [dbo].[SYS_AuditLog]
GO
/****** Object:  Table [dbo].[PS_HOM_Tile]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PS_HOM_Tile]') AND type in (N'U'))
DROP TABLE [dbo].[PS_HOM_Tile]
GO
/****** Object:  Table [dbo].[PS_HOM_TemplateUserRelation]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PS_HOM_TemplateUserRelation]') AND type in (N'U'))
DROP TABLE [dbo].[PS_HOM_TemplateUserRelation]
GO
/****** Object:  Table [dbo].[PS_HOM_TemplateAreaTileRelation]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PS_HOM_TemplateAreaTileRelation]') AND type in (N'U'))
DROP TABLE [dbo].[PS_HOM_TemplateAreaTileRelation]
GO
/****** Object:  Table [dbo].[PS_HOM_HomeTemplateArea]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PS_HOM_HomeTemplateArea]') AND type in (N'U'))
DROP TABLE [dbo].[PS_HOM_HomeTemplateArea]
GO
/****** Object:  Table [dbo].[PS_HOM_HomeTemplate]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PS_HOM_HomeTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[PS_HOM_HomeTemplate]
GO
/****** Object:  Table [dbo].[INFO_InformationType]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationType]') AND type in (N'U'))
DROP TABLE [dbo].[INFO_InformationType]
GO
/****** Object:  Table [dbo].[INFO_InformationLike]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationLike]') AND type in (N'U'))
DROP TABLE [dbo].[INFO_InformationLike]
GO
/****** Object:  Table [dbo].[INFO_InformationComment]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationComment]') AND type in (N'U'))
DROP TABLE [dbo].[INFO_InformationComment]
GO
/****** Object:  Table [dbo].[INFO_InformationBodyNominated]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationBodyNominated]') AND type in (N'U'))
DROP TABLE [dbo].[INFO_InformationBodyNominated]
GO
/****** Object:  Table [dbo].[INFO_InformationBody]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationBody]') AND type in (N'U'))
DROP TABLE [dbo].[INFO_InformationBody]
GO
/****** Object:  Table [dbo].[INFO_InformationAttachement]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationAttachement]') AND type in (N'U'))
DROP TABLE [dbo].[INFO_InformationAttachement]
GO
/****** Object:  Table [dbo].[INFO_Information]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_Information]') AND type in (N'U'))
DROP TABLE [dbo].[INFO_Information]
GO
/****** Object:  Table [dbo].[INFO_ColumnDeliver]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_ColumnDeliver]') AND type in (N'U'))
DROP TABLE [dbo].[INFO_ColumnDeliver]
GO
/****** Object:  Table [dbo].[INFO_Column]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_Column]') AND type in (N'U'))
DROP TABLE [dbo].[INFO_Column]
GO
/****** Object:  Table [dbo].[HR_ORG_PositionRoleList]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_PositionRoleList]') AND type in (N'U'))
DROP TABLE [dbo].[HR_ORG_PositionRoleList]
GO
/****** Object:  Table [dbo].[HR_ORG_Position]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_Position]') AND type in (N'U'))
DROP TABLE [dbo].[HR_ORG_Position]
GO
/****** Object:  Table [dbo].[HR_ORG_Organization]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_Organization]') AND type in (N'U'))
DROP TABLE [dbo].[HR_ORG_Organization]
GO
/****** Object:  Table [dbo].[HR_ORG_LegalEntity]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_LegalEntity]') AND type in (N'U'))
DROP TABLE [dbo].[HR_ORG_LegalEntity]
GO
/****** Object:  Table [dbo].[HR_ORG_JobLevel]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_JobLevel]') AND type in (N'U'))
DROP TABLE [dbo].[HR_ORG_JobLevel]
GO
/****** Object:  Table [dbo].[HR_ORG_Job]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_Job]') AND type in (N'U'))
DROP TABLE [dbo].[HR_ORG_Job]
GO
/****** Object:  Table [dbo].[HR_EMP_WorkHistory]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_WorkHistory]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_WorkHistory]
GO
/****** Object:  Table [dbo].[HR_EMP_SalaryLevel]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_SalaryLevel]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_SalaryLevel]
GO
/****** Object:  Table [dbo].[HR_EMP_PostInformation]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_PostInformation]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_PostInformation]
GO
/****** Object:  Table [dbo].[HR_EMP_OtherContact]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_OtherContact]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_OtherContact]
GO
/****** Object:  Table [dbo].[HR_EMP_OfficeArea]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_OfficeArea]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_OfficeArea]
GO
/****** Object:  Table [dbo].[HR_EMP_EmployeeFamily]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_EmployeeFamily]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_EmployeeFamily]
GO
/****** Object:  Table [dbo].[HR_EMP_EmployeeContract]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_EmployeeContract]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_EmployeeContract]
GO
/****** Object:  Table [dbo].[HR_EMP_Employee]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_Employee]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_Employee]
GO
/****** Object:  Table [dbo].[HR_EMP_Education]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_Education]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_Education]
GO
/****** Object:  Table [dbo].[HR_EMP_BankCard]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_BankCard]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_BankCard]
GO
/****** Object:  Table [dbo].[HR_EMP_Address]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_Address]') AND type in (N'U'))
DROP TABLE [dbo].[HR_EMP_Address]
GO
/****** Object:  Table [dbo].[FM_OA_Stapm]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FM_OA_Stapm]') AND type in (N'U'))
DROP TABLE [dbo].[FM_OA_Stapm]
GO
/****** Object:  Table [dbo].[FM_OA_StampRequest]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FM_OA_StampRequest]') AND type in (N'U'))
DROP TABLE [dbo].[FM_OA_StampRequest]
GO
/****** Object:  Table [dbo].[FM_OA_StampBorrowRequest]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FM_OA_StampBorrowRequest]') AND type in (N'U'))
DROP TABLE [dbo].[FM_OA_StampBorrowRequest]
GO
/****** Object:  Table [dbo].[FM_OA_Cert]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FM_OA_Cert]') AND type in (N'U'))
DROP TABLE [dbo].[FM_OA_Cert]
GO
/****** Object:  Table [dbo].[FM_OA_CarvedIResquest]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FM_OA_CarvedIResquest]') AND type in (N'U'))
DROP TABLE [dbo].[FM_OA_CarvedIResquest]
GO
/****** Object:  Table [dbo].[AM_WH_Warehouse]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_WH_Warehouse]') AND type in (N'U'))
DROP TABLE [dbo].[AM_WH_Warehouse]
GO
/****** Object:  Table [dbo].[AM_OB_UsageRequestDetail]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_OB_UsageRequestDetail]') AND type in (N'U'))
DROP TABLE [dbo].[AM_OB_UsageRequestDetail]
GO
/****** Object:  Table [dbo].[AM_OB_UsageRequest]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_OB_UsageRequest]') AND type in (N'U'))
DROP TABLE [dbo].[AM_OB_UsageRequest]
GO
/****** Object:  Table [dbo].[AM_OB_ReturnRequestDetail]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_OB_ReturnRequestDetail]') AND type in (N'U'))
DROP TABLE [dbo].[AM_OB_ReturnRequestDetail]
GO
/****** Object:  Table [dbo].[AM_OB_ReturnRequest]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_OB_ReturnRequest]') AND type in (N'U'))
DROP TABLE [dbo].[AM_OB_ReturnRequest]
GO
/****** Object:  Table [dbo].[AM_OB_List]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_OB_List]') AND type in (N'U'))
DROP TABLE [dbo].[AM_OB_List]
GO
/****** Object:  Table [dbo].[AM_AS_Usage]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_AS_Usage]') AND type in (N'U'))
DROP TABLE [dbo].[AM_AS_Usage]
GO
/****** Object:  Table [dbo].[AM_AS_PurchaseInput]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_AS_PurchaseInput]') AND type in (N'U'))
DROP TABLE [dbo].[AM_AS_PurchaseInput]
GO
/****** Object:  Table [dbo].[AM_AS_Maintain]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_AS_Maintain]') AND type in (N'U'))
DROP TABLE [dbo].[AM_AS_Maintain]
GO
/****** Object:  Table [dbo].[AM_AS_AssetCategory]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_AS_AssetCategory]') AND type in (N'U'))
DROP TABLE [dbo].[AM_AS_AssetCategory]
GO
/****** Object:  Table [dbo].[AM_AS_Asset]    Script Date: 2018/6/5 15:41:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_AS_Asset]') AND type in (N'U'))
DROP TABLE [dbo].[AM_AS_Asset]
GO
/****** Object:  Table [dbo].[AM_AS_Asset]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_AS_Asset]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_AS_Asset](
	[AssetID] [uniqueidentifier] NOT NULL,
	[WareID] [uniqueidentifier] NULL,
	[AssetCategory] [uniqueidentifier] NOT NULL,
	[AssetCode] [nvarchar](36) NULL,
	[Serial] [nvarchar](max) NULL,
	[Price] [decimal](18, 2) NULL,
	[OfficeAreaID] [uniqueidentifier] NULL,
	[NetValue] [decimal](18, 2) NULL,
	[Status] [nvarchar](80) NOT NULL,
	[InputTime] [datetime] NULL,
	[Model] [nvarchar](max) NULL,
	[Attribute1] [nvarchar](256) NULL,
	[Attribute2] [nvarchar](256) NULL,
	[Attribute3] [nvarchar](256) NULL,
	[Attribute4] [nvarchar](256) NULL,
	[Attribute5] [nvarchar](256) NULL,
	[InputType] [nvarchar](80) NOT NULL,
	[ProviderID] [uniqueidentifier] NULL,
	[Owner] [nvarchar](80) NOT NULL,
	[Memo] [nvarchar](512) NULL,
	[EmployeeID] [uniqueidentifier] NULL,
	[EmployeeUseDate] [datetime] NULL,
	[OrganizationID] [uniqueidentifier] NULL,
	[OrganizationCode] [nvarchar](36) NULL,
	[OrganizationName] [nvarchar](36) NULL,
	[OrderID] [uniqueidentifier] NULL,
	[OrderItemID] [uniqueidentifier] NULL,
	[CardNo] [nvarchar](32) NULL,
	[DueTime] [int] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[Depreciation] [decimal](18, 2) NULL,
	[ScrapTime] [datetime] NULL,
	[PurchaseItemType] [nvarchar](80) NULL,
	[UseType] [nvarchar](80) NULL,
	[AssetName] [nvarchar](32) NULL,
 CONSTRAINT [PK_AM_AS_ASSET] PRIMARY KEY CLUSTERED 
(
	[AssetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AM_AS_AssetCategory]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_AS_AssetCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_AS_AssetCategory](
	[AssetCategoryID] [uniqueidentifier] NOT NULL,
	[ParentID] [uniqueidentifier] NOT NULL,
	[AssetCategoryCode] [nvarchar](36) NOT NULL,
	[AssetCategoryName] [nvarchar](36) NOT NULL,
	[AssetCategoryType] [nvarchar](80) NOT NULL,
	[Remark] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AM_AS_AssetCategory] PRIMARY KEY CLUSTERED 
(
	[AssetCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AM_AS_Maintain]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_AS_Maintain]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_AS_Maintain](
	[MaintainID] [uniqueidentifier] NOT NULL,
	[AssetID] [uniqueidentifier] NULL,
	[EmployeeName] [nvarchar](32) NULL,
	[EmployeeID] [uniqueidentifier] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Price] [decimal](18, 2) NULL,
	[ProviderID] [uniqueidentifier] NULL,
	[Cause] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[MaintainCode] [nvarchar](36) NULL,
	[PurchaseOrderCode] [nvarchar](32) NULL,
	[MaintainResult] [nvarchar](255) NULL,
 CONSTRAINT [PK_AM_AS_MAINTAIN] PRIMARY KEY CLUSTERED 
(
	[MaintainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AM_AS_PurchaseInput]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_AS_PurchaseInput]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_AS_PurchaseInput](
	[PurchaseInputID] [uniqueidentifier] NOT NULL,
	[PurchaseItemCode] [nvarchar](36) NOT NULL,
	[TotalPrice] [decimal](18, 2) NOT NULL,
	[PurchaseOrderID] [uniqueidentifier] NOT NULL,
	[PurchaseOrderCode] [nvarchar](32) NOT NULL,
	[LegaID] [uniqueidentifier] NULL,
	[VendorID] [uniqueidentifier] NOT NULL,
	[ReceiptQTY] [int] NOT NULL,
	[PurchaseItemType] [nvarchar](36) NOT NULL,
	[WarehouseID] [uniqueidentifier] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[IsInput] [bit] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[PurchaseOrderItemID] [uniqueidentifier] NOT NULL,
	[PurchaseItemID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AM_AS_PURCHASEINPUT] PRIMARY KEY CLUSTERED 
(
	[PurchaseInputID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AM_AS_Usage]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_AS_Usage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_AS_Usage](
	[UsageID] [uniqueidentifier] NOT NULL,
	[AssetID] [uniqueidentifier] NULL,
	[EmployeeName] [nvarchar](32) NULL,
	[EmployeeID] [uniqueidentifier] NULL,
	[OrgUnitName] [nvarchar](32) NULL,
	[OrgUnitID] [uniqueidentifier] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AM_AS_USAGE] PRIMARY KEY CLUSTERED 
(
	[UsageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AM_OB_List]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_OB_List]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_OB_List](
	[ListID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[ListCategory] [nvarchar](80) NOT NULL,
	[Order] [int] NULL,
	[Price] [decimal](18, 2) NULL,
	[IsGift] [bit] NOT NULL,
	[Desc] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[Unit] [nvarchar](50) NULL,
 CONSTRAINT [PK_AM_OB_LIST] PRIMARY KEY CLUSTERED 
(
	[ListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AM_OB_ReturnRequest]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_OB_ReturnRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_OB_ReturnRequest](
	[MasterRequestID] [uniqueidentifier] NOT NULL,
	[MasterRequestCode] [nvarchar](36) NOT NULL,
	[UsageStatus] [nvarchar](80) NOT NULL,
	[Cause] [nvarchar](512) NOT NULL,
	[ReturnType] [nvarchar](80) NOT NULL,
	[ReturnUserID] [uniqueidentifier] NULL,
	[AllotUserID] [uniqueidentifier] NULL,
	[ReturnDate] [datetime] NULL,
	[ReturnNote] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[NotifyIT] [bit] NULL,
 CONSTRAINT [PK_AM_OB_RETURNREQUEST] PRIMARY KEY CLUSTERED 
(
	[MasterRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AM_OB_ReturnRequestDetail]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_OB_ReturnRequestDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_OB_ReturnRequestDetail](
	[DetailID] [uniqueidentifier] NOT NULL,
	[MasterRequestID] [uniqueidentifier] NULL,
	[AssetID] [uniqueidentifier] NULL,
	[EmployeeID] [uniqueidentifier] NULL,
	[WareID] [uniqueidentifier] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AM_OB_RETURNREQUESTDETAIL] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AM_OB_UsageRequest]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_OB_UsageRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_OB_UsageRequest](
	[MasterRequestID] [uniqueidentifier] NOT NULL,
	[MasterRequestCode] [nvarchar](36) NOT NULL,
	[UsageStatus] [nvarchar](80) NOT NULL,
	[Cause] [nvarchar](512) NOT NULL,
	[ListCategory] [nvarchar](80) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[NotifyIT] [bit] NULL,
 CONSTRAINT [PK_AM_OB_USAGEREQUEST] PRIMARY KEY CLUSTERED 
(
	[MasterRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AM_OB_UsageRequestDetail]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_OB_UsageRequestDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_OB_UsageRequestDetail](
	[DetailID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[ListID] [uniqueidentifier] NULL,
	[MasterRequestID] [uniqueidentifier] NULL,
	[Amount] [int] NULL,
	[UserName] [nvarchar](36) NULL,
	[EmployeeID] [uniqueidentifier] NULL,
	[Mode] [nvarchar](80) NULL,
	[AssetCategory] [uniqueidentifier] NULL,
	[Price] [decimal](18, 2) NULL,
	[OrderItemID] [uniqueidentifier] NULL,
	[AssetID] [uniqueidentifier] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[GrantAmount] [int] NULL,
 CONSTRAINT [PK_AM_OB_USAGEREQUESTDETAIL] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AM_WH_Warehouse]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AM_WH_Warehouse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AM_WH_Warehouse](
	[WareID] [uniqueidentifier] NOT NULL,
	[WareCode] [nvarchar](36) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[AdminUserID] [uniqueidentifier] NOT NULL,
	[Contact] [nvarchar](32) NULL,
	[IsNormal] [bit] NOT NULL,
	[IsScraped] [bit] NOT NULL,
	[Address] [nvarchar](256) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_AM_WH_WAREHOUSE] PRIMARY KEY CLUSTERED 
(
	[WareID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FM_OA_CarvedIResquest]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FM_OA_CarvedIResquest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FM_OA_CarvedIResquest](
	[MasterRequestID] [uniqueidentifier] NOT NULL,
	[MasterRequestCode] [nvarchar](36) NOT NULL,
	[FormStatus] [nvarchar](80) NOT NULL,
	[ExtCode] [nvarchar](32) NOT NULL,
	[Type] [nvarchar](80) NULL,
	[Style] [nvarchar](80) NULL,
	[Color] [nvarchar](80) NULL,
	[Content] [nvarchar](64) NULL,
	[Desc] [nvarchar](64) NULL,
	[UsageTime] [datetime] NULL,
	[Cause] [nvarchar](512) NOT NULL,
	[OtherCause] [nvarchar](512) NULL,
	[Memo] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[HolderEmpID] [uniqueidentifier] NULL,
	[HolderContact] [nvarchar](128) NULL,
 CONSTRAINT [PK_FM_OA_CARVEDIRESQUEST] PRIMARY KEY CLUSTERED 
(
	[MasterRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FM_OA_Cert]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FM_OA_Cert]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FM_OA_Cert](
	[CertID] [uniqueidentifier] NOT NULL,
	[CertName] [nvarchar](32) NOT NULL,
	[CertType] [nvarchar](80) NOT NULL,
	[BelongLEID] [uniqueidentifier] NULL,
	[OrgUnitID] [uniqueidentifier] NOT NULL,
	[KeepingOUID] [uniqueidentifier] NOT NULL,
	[CertCode] [nvarchar](32) NULL,
	[ValidDate] [datetime] NULL,
	[YearCheckTime] [datetime] NULL,
	[YearVaildDate] [datetime] NULL,
	[IsYearCheck] [bit] NULL,
	[Linkman] [nvarchar](32) NULL,
	[Tel] [nvarchar](32) NULL,
	[Memo] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_FM_OA_CERT] PRIMARY KEY CLUSTERED 
(
	[CertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FM_OA_StampBorrowRequest]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FM_OA_StampBorrowRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FM_OA_StampBorrowRequest](
	[MasterRequestID] [uniqueidentifier] NOT NULL,
	[MasterRequestCode] [nvarchar](36) NOT NULL,
	[IsProject] [bit] NOT NULL,
	[ProjectID] [uniqueidentifier] NULL,
	[ProjectName] [nvarchar](256) NULL,
	[FormStatus] [nvarchar](80) NOT NULL,
	[ExtCode] [nvarchar](32) NOT NULL,
	[IsStamp] [bit] NULL,
	[IsCert] [bit] NULL,
	[StampLEID] [uniqueidentifier] NULL,
	[StampOUID] [uniqueidentifier] NULL,
	[KeepingOU] [uniqueidentifier] NULL,
	[StampType] [nvarchar](80) NULL,
	[StampTypeOther] [nvarchar](64) NULL,
	[CopyType] [nvarchar](80) NULL,
	[CertLEID] [uniqueidentifier] NULL,
	[CertOUID] [uniqueidentifier] NULL,
	[CertType] [nvarchar](80) NULL,
	[CertTypeOther] [nvarchar](64) NULL,
	[Cause] [nvarchar](512) NULL,
	[StartTime] [datetime] NULL,
	[ExpectTime] [datetime] NULL,
	[OtherCause] [nvarchar](512) NULL,
	[RetrunTime] [datetime] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_FM_OA_STAMPBORROWREQUEST] PRIMARY KEY CLUSTERED 
(
	[MasterRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FM_OA_StampRequest]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FM_OA_StampRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FM_OA_StampRequest](
	[MasterRequestID] [uniqueidentifier] NOT NULL,
	[MasterRequestCode] [nvarchar](36) NOT NULL,
	[FormStatus] [nvarchar](80) NOT NULL,
	[ExtCode] [nvarchar](32) NOT NULL,
	[StampLEID] [uniqueidentifier] NOT NULL,
	[StampOUID] [uniqueidentifier] NULL,
	[KeepingOU] [uniqueidentifier] NOT NULL,
	[StampType] [nvarchar](80) NOT NULL,
	[StampTypeOther] [nvarchar](64) NULL,
	[StampUsage] [nvarchar](80) NOT NULL,
	[ProjectName] [nvarchar](36) NULL,
	[ProjectID] [uniqueidentifier] NULL,
	[Cause] [nvarchar](512) NOT NULL,
	[OtherName] [nvarchar](32) NULL,
	[OtherCause] [nvarchar](512) NULL,
	[IsCertRequest] [bit] NULL,
	[CopyType] [nvarchar](80) NULL,
	[CertLEID] [uniqueidentifier] NULL,
	[CertOUID] [uniqueidentifier] NULL,
	[CertType] [nvarchar](80) NULL,
	[CertTypeOther] [nvarchar](64) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_FM_OA_STAMPREQUEST] PRIMARY KEY CLUSTERED 
(
	[MasterRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FM_OA_Stapm]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FM_OA_Stapm]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FM_OA_Stapm](
	[StampID] [uniqueidentifier] NOT NULL,
	[MasterRequestID] [uniqueidentifier] NULL,
	[StampName] [nvarchar](32) NOT NULL,
	[StampType] [nvarchar](80) NOT NULL,
	[BelongLEID] [uniqueidentifier] NOT NULL,
	[OrgUnitID] [uniqueidentifier] NULL,
	[KeepingOUID] [uniqueidentifier] NOT NULL,
	[Linkman] [nvarchar](32) NULL,
	[Tel] [nvarchar](32) NULL,
	[Memo] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[MasterRequestCode] [nvarchar](32) NULL,
	[UseStartDate] [datetime] NULL,
	[UseEndDate] [datetime] NULL,
	[IsUse] [bit] NOT NULL,
 CONSTRAINT [PK_FM_OA_STAPM] PRIMARY KEY CLUSTERED 
(
	[StampID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_Address]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_Address]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_Address](
	[AddressID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [uniqueidentifier] NOT NULL,
	[AddressType] [nvarchar](80) NOT NULL,
	[Country] [nvarchar](80) NULL,
	[Province] [nvarchar](80) NULL,
	[City] [nvarchar](80) NULL,
	[District] [nvarchar](80) NULL,
	[Address] [nvarchar](256) NULL,
	[AddressPhone] [nvarchar](36) NULL,
	[ZipCode] [nvarchar](36) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_EMP_ADDRESS] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_BankCard]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_BankCard]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_BankCard](
	[BankID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [uniqueidentifier] NOT NULL,
	[BankNumber] [nvarchar](36) NOT NULL,
	[AccountName] [nvarchar](36) NOT NULL,
	[BankName] [nvarchar](80) NOT NULL,
	[BankCity] [nvarchar](80) NOT NULL,
	[Address] [nvarchar](128) NOT NULL,
	[IsWageCard] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[BankBranchCode] [nvarchar](128) NULL,
 CONSTRAINT [PK_HR_EMP_BANKCARD] PRIMARY KEY CLUSTERED 
(
	[BankID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_Education]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_Education]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_Education](
	[EducationID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [uniqueidentifier] NOT NULL,
	[School] [nvarchar](36) NOT NULL,
	[Speciality] [nvarchar](36) NOT NULL,
	[EduBG] [nvarchar](80) NOT NULL,
	[EduDegree] [nvarchar](80) NOT NULL,
	[EduDegreeNumber] [nvarchar](36) NULL,
	[EduBeginDate] [datetime] NULL,
	[EduEndDate] [datetime] NULL,
	[IsHighestDiploma] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_EMP_EDUCATION] PRIMARY KEY CLUSTERED 
(
	[EducationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_Employee]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_Employee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_Employee](
	[EmployeeID] [uniqueidentifier] NOT NULL,
	[EmployeeNumber] [nvarchar](36) NULL,
	[EmployeeNameCN] [nvarchar](36) NOT NULL,
	[EmployeeNameEN] [nvarchar](36) NULL,
	[Gender] [nvarchar](80) NULL,
	[IDType] [nvarchar](80) NULL,
	[IDNumber] [nvarchar](36) NULL,
	[Birthday] [datetime] NULL,
	[MaritalStatus] [nvarchar](80) NULL,
	[FirstWorkedDate] [datetime] NULL,
	[Nationality] [nvarchar](80) NULL,
	[OfficeAreaID] [uniqueidentifier] NULL,
	[HukouAddress] [nvarchar](128) NULL,
	[OnboardDate] [datetime] NULL,
	[TerminationDate] [datetime] NULL,
	[TerminationTypeName] [nvarchar](36) NULL,
	[EmployeeEMail] [nvarchar](128) NULL,
	[EmpStatus] [nvarchar](80) NOT NULL,
	[EmployeeStatus] [nvarchar](36) NULL,
	[OrganizationID] [uniqueidentifier] NULL,
	[OrganizationCode] [nvarchar](36) NULL,
	[OrganizationName] [nvarchar](36) NULL,
	[MainJobPositionID] [uniqueidentifier] NULL,
	[MainJobPostionName] [nvarchar](36) NULL,
	[CurrentJobLevelName] [nvarchar](36) NULL,
	[CurrentJobLevelValue] [decimal](5, 2) NULL,
	[ExtCode] [nvarchar](32) NULL,
	[TeleCode] [nvarchar](32) NULL,
	[PersonalEmail] [nvarchar](128) NULL,
	[Education] [nvarchar](36) NULL,
	[PersonalCellPhone] [nvarchar](36) NULL,
	[CPFAccount] [nvarchar](36) NULL,
	[EmergencyCellPhone] [nvarchar](36) NULL,
	[FileTransferInDate] [datetime] NULL,
	[FileTransferOutDate] [datetime] NULL,
	[PoliticalStatus] [nvarchar](80) NULL,
	[TAG] [nvarchar](128) NULL,
	[Description] [nvarchar](max) NULL,
	[UserName] [nvarchar](36) NULL,
	[MLAccount] [nvarchar](36) NULL,
	[TrialBeginDate] [datetime] NULL,
	[TrialEndDate] [datetime] NULL,
	[PhotoAttachmentID] [uniqueidentifier] NULL,
	[Ethnic] [nvarchar](80) NULL,
	[ProfessionalTitle] [nvarchar](80) NULL,
	[SupplHousingAccount] [nvarchar](36) NULL,
	[CostCenterMode] [int] NULL,
	[CostCenterCode] [nvarchar](36) NULL,
	[ADAccount] [nvarchar](100) NULL,
	[ADPassword] [nvarchar](500) NULL,
	[ZYPolicyNo] [nvarchar](128) NULL,
	[PartyJoinInDate] [datetime] NULL,
	[NCUserCode] [nvarchar](50) NULL,
	[EmployeeType] [nvarchar](500) NULL,
	[NoTrial] [bit] NULL,
	[SalaryLevelType] [nvarchar](80) NULL,
	[SalaryLevelID] [uniqueidentifier] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_EMP_EMPLOYEE] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_EmployeeContract]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_EmployeeContract]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_EmployeeContract](
	[EmployeeContractID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [uniqueidentifier] NOT NULL,
	[SignMode] [nvarchar](80) NOT NULL,
	[SignApplicationID] [uniqueidentifier] NULL,
	[OriginalContractID] [uniqueidentifier] NULL,
	[ContractType] [nvarchar](80) NOT NULL,
	[EmployeeContractNumber] [nvarchar](36) NOT NULL,
	[EmployeeContractBeginDate] [datetime] NOT NULL,
	[EmployeeContractEndDate] [datetime] NULL,
	[TrialBeginDate] [datetime] NULL,
	[TrialEndDate] [datetime] NULL,
	[AttachmentID] [uniqueidentifier] NULL,
	[SignDate] [datetime] NULL,
	[SignedTimes] [int] NULL,
	[Description] [nvarchar](512) NULL,
	[IsUnfixedTerm] [bit] NOT NULL,
	[IsAutoExpandDate] [bit] NOT NULL,
	[HaveTrialDate] [bit] NOT NULL,
	[ExpandDate] [datetime] NULL,
	[ContractEndDateWarnDate] [datetime] NULL,
	[TrialEndDateWarnDate] [datetime] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_EMP_EMPLOYEECONTRACT] PRIMARY KEY CLUSTERED 
(
	[EmployeeContractID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_EmployeeFamily]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_EmployeeFamily]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_EmployeeFamily](
	[FamilyMemberID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](36) NOT NULL,
	[Relationships] [nvarchar](80) NOT NULL,
	[IDType] [nvarchar](80) NULL,
	[IDNumber] [nvarchar](36) NULL,
	[ContactCellphone] [nvarchar](36) NULL,
	[Gender] [nvarchar](80) NULL,
	[Birthday] [datetime] NULL,
	[Job] [nvarchar](36) NULL,
	[Company] [nvarchar](128) NULL,
	[InsuranceNumber] [nvarchar](36) NULL,
	[InsuranceStatus] [nvarchar](80) NULL,
	[InsuranceStartDate] [datetime] NULL,
	[InsuranceEndDate] [datetime] NULL,
	[IsEmergency] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_EMP_EMPLOYEEFAMILY] PRIMARY KEY CLUSTERED 
(
	[FamilyMemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_OfficeArea]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_OfficeArea]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_OfficeArea](
	[AreaID] [uniqueidentifier] NOT NULL,
	[AreaCode] [nvarchar](36) NOT NULL,
	[AreaName] [nvarchar](32) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[IsUse] [bit] NOT NULL,
	[Country] [nvarchar](32) NULL,
	[Province] [nvarchar](32) NULL,
	[City] [nvarchar](32) NULL,
	[District] [nvarchar](32) NULL,
	[OtherAddress] [nvarchar](64) NULL,
	[DetailAddress] [nvarchar](512) NULL,
	[ZipCode] [nvarchar](32) NULL,
	[Memo] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[AreaSize] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_HR_EMP_OfficeArea] PRIMARY KEY CLUSTERED 
(
	[AreaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_OtherContact]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_OtherContact]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_OtherContact](
	[OtherContactID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [uniqueidentifier] NOT NULL,
	[Cellphone] [nvarchar](36) NULL,
	[Email] [nvarchar](128) NULL,
	[Telephone] [nvarchar](36) NULL,
	[Address] [nvarchar](256) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_EMP_OTHERCONTACT] PRIMARY KEY CLUSTERED 
(
	[OtherContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_PostInformation]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_PostInformation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_PostInformation](
	[PostInformationID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [uniqueidentifier] NOT NULL,
	[IsFunctionPosition] [bit] NOT NULL,
	[PositionID] [uniqueidentifier] NOT NULL,
	[OrganizationID] [uniqueidentifier] NOT NULL,
	[OfficeBeginDate] [datetime] NOT NULL,
	[OfficeEndDate] [datetime] NULL,
	[IsMain] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_EMP_POSTINFORMATION] PRIMARY KEY CLUSTERED 
(
	[PostInformationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_SalaryLevel]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_SalaryLevel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_SalaryLevel](
	[SalaryLevelID] [uniqueidentifier] NOT NULL,
	[SalaryLevelName] [nvarchar](36) NULL,
	[SalaryLevelValue] [decimal](5, 2) NULL,
	[SalaryLevelType] [nvarchar](80) NULL,
	[Description] [nvarchar](128) NULL,
	[IsDisabled] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_EMP_SalaryLevel] PRIMARY KEY CLUSTERED 
(
	[SalaryLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_EMP_WorkHistory]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_EMP_WorkHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_EMP_WorkHistory](
	[WorkHistoryID] [uniqueidentifier] NOT NULL,
	[EmployeeID] [uniqueidentifier] NOT NULL,
	[Company] [nvarchar](128) NOT NULL,
	[Department] [nvarchar](36) NULL,
	[JobDuty] [nvarchar](36) NULL,
	[WorkBeginDate] [datetime] NOT NULL,
	[WorkEndDate] [datetime] NULL,
	[Description] [nvarchar](256) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_EMP_WORKHISTORY] PRIMARY KEY CLUSTERED 
(
	[WorkHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_ORG_Job]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_Job]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_ORG_Job](
	[JobID] [uniqueidentifier] NOT NULL,
	[JobCode] [nvarchar](36) NOT NULL,
	[JobName] [nvarchar](36) NOT NULL,
	[Description] [nvarchar](128) NULL,
	[JobGroup] [nvarchar](80) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[IsDisabled] [bit] NOT NULL,
 CONSTRAINT [PK_HR_ORG_JOB] PRIMARY KEY CLUSTERED 
(
	[JobID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_ORG_JobLevel]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_JobLevel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_ORG_JobLevel](
	[JobLevelID] [uniqueidentifier] NOT NULL,
	[JobLevelName] [nvarchar](36) NOT NULL,
	[JobLevelNumber] [decimal](5, 2) NOT NULL,
	[Description] [nvarchar](128) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[IsDisabled] [bit] NOT NULL,
 CONSTRAINT [PK_HR_ORG_JOBLEVEL] PRIMARY KEY CLUSTERED 
(
	[JobLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_ORG_LegalEntity]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_LegalEntity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_ORG_LegalEntity](
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[ParentID] [uniqueidentifier] NULL,
	[LegalEntityName] [nvarchar](128) NOT NULL,
	[LegalEntityCode] [nvarchar](36) NOT NULL,
	[EnterpriseType] [nvarchar](80) NOT NULL,
	[LegalRepresentativeName] [nvarchar](36) NULL,
	[UnifiedCreditRecord] [nvarchar](128) NULL,
	[BizBeginDate] [datetime] NULL,
	[BizEndDate] [datetime] NULL,
	[Province] [nvarchar](80) NULL,
	[City] [nvarchar](80) NULL,
	[BusinessAddress] [nvarchar](512) NULL,
	[PostNumber] [nvarchar](36) NULL,
	[TelNumber] [nvarchar](36) NULL,
	[FaxNumber] [nvarchar](36) NULL,
	[Website] [nvarchar](128) NULL,
	[BizScope] [nvarchar](512) NULL,
	[Description] [nvarchar](512) NULL,
	[AccountBookNumber] [nvarchar](36) NULL,
	[LegalCodePath] [nvarchar](max) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_ORG_LEGALENTITY] PRIMARY KEY CLUSTERED 
(
	[LegalEntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_ORG_Organization]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_Organization]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_ORG_Organization](
	[OrganizationID] [uniqueidentifier] NOT NULL,
	[OrganizationName] [nvarchar](36) NOT NULL,
	[OrganizationCode] [nvarchar](36) NOT NULL,
	[ParentID] [uniqueidentifier] NULL,
	[CodePath] [nvarchar](max) NOT NULL,
	[Sequence] [int] NOT NULL,
	[OrganizationType] [nvarchar](80) NOT NULL,
	[HeadPositionID] [uniqueidentifier] NULL,
	[Description] [nvarchar](512) NULL,
	[IsEnableHeadCountPeriod] [bit] NOT NULL,
	[IsIndependentAccounting] [bit] NOT NULL,
	[AccountBookNumber] [nvarchar](36) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[IsDisabled] [bit] NOT NULL,
	[CostCenterCode] [nvarchar](36) NULL,
 CONSTRAINT [PK_HR_ORG_ORGANIZATION] PRIMARY KEY CLUSTERED 
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_ORG_Position]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_Position]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_ORG_Position](
	[PositionID] [uniqueidentifier] NOT NULL,
	[PositionCode] [nvarchar](36) NOT NULL,
	[PositionName] [nvarchar](36) NOT NULL,
	[IsFunctionPosition] [bit] NOT NULL,
	[ReportToPositionID] [uniqueidentifier] NULL,
	[PositionCodePath] [nvarchar](max) NOT NULL,
	[Headcount] [int] NOT NULL,
	[IsAppraisal] [bit] NOT NULL,
	[IsHead] [bit] NOT NULL,
	[IsPrincipal] [bit] NOT NULL,
	[IsApprover] [bit] NOT NULL,
	[IsApplier] [bit] NOT NULL,
	[PositionDescription] [nvarchar](512) NULL,
	[OrganizationID] [uniqueidentifier] NOT NULL,
	[JobID] [uniqueidentifier] NULL,
	[PositionLevelID] [uniqueidentifier] NULL,
	[IsUse] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_ORG_POSITION] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HR_ORG_PositionRoleList]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HR_ORG_PositionRoleList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HR_ORG_PositionRoleList](
	[PositionID] [uniqueidentifier] NOT NULL,
	[RoleID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_ORG_POSITIONROLELIST] PRIMARY KEY NONCLUSTERED 
(
	[PositionID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[INFO_Column]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_Column]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[INFO_Column](
	[ColumnID] [uniqueidentifier] NOT NULL,
	[ColumnCode] [nvarchar](36) NOT NULL,
	[ColumnName] [nvarchar](256) NOT NULL,
	[AllowComment] [bit] NULL,
	[AllowDownload] [bit] NULL,
	[ShowOnHomePage] [bit] NULL,
	[ParentColumnID] [uniqueidentifier] NULL,
	[InfoCategory] [nvarchar](512) NULL,
	[Path] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_INFO_COLUMN] PRIMARY KEY CLUSTERED 
(
	[ColumnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[INFO_ColumnDeliver]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_ColumnDeliver]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[INFO_ColumnDeliver](
	[ID] [uniqueidentifier] NOT NULL,
	[ColumnID] [uniqueidentifier] NOT NULL,
	[ResId] [nvarchar](40) NOT NULL,
	[ResType] [nvarchar](10) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_INFO_ColumnDeliver] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[INFO_Information]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_Information]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[INFO_Information](
	[InformationID] [uniqueidentifier] NOT NULL,
	[GroupID] [uniqueidentifier] NULL,
	[ColumnID] [uniqueidentifier] NOT NULL,
	[InfoCategoryID] [nvarchar](80) NOT NULL,
	[IsNominated] [bit] NOT NULL,
	[ExpiryTime] [datetime] NULL,
	[AllowInternet] [bit] NOT NULL,
	[DeliveryReqID] [uniqueidentifier] NULL,
	[DeliveryTime] [datetime] NULL,
	[Status] [nvarchar](80) NOT NULL,
	[TopMost] [bit] NOT NULL,
	[TopMostExpiry] [datetime] NULL,
	[TompMostSeq] [int] NULL,
	[DeliveryUserID] [uniqueidentifier] NULL,
	[ReadTimes] [int] NULL,
	[CommentTimes] [int] NULL,
	[LikeTimes] [int] NULL,
	[TemplateType] [nvarchar](80) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_INFO_INFORMATION] PRIMARY KEY CLUSTERED 
(
	[InformationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[INFO_InformationAttachement]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationAttachement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[INFO_InformationAttachement](
	[ID] [uniqueidentifier] NOT NULL,
	[InformationID] [uniqueidentifier] NOT NULL,
	[AttachementID] [uniqueidentifier] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_INFO_INFORMATIONATTACHEM] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[INFO_InformationBody]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationBody]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[INFO_InformationBody](
	[ID] [uniqueidentifier] NOT NULL,
	[InformationID] [uniqueidentifier] NOT NULL,
	[No] [nvarchar](128) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[SubjectWords] [nvarchar](128) NULL,
	[Footer] [nvarchar](512) NULL,
	[Header] [nvarchar](128) NULL,
	[BodyType] [nvarchar](50) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_INFO_INFORMATIONBODY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[INFO_InformationBodyNominated]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationBodyNominated]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[INFO_InformationBodyNominated](
	[ID] [uniqueidentifier] NOT NULL,
	[InformationID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](128) NOT NULL,
	[URL] [nvarchar](1024) NULL,
	[Summary] [nvarchar](512) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[AttachmentID] [uniqueidentifier] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_INFO_INFORMATIONBODYNOMI] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[INFO_InformationComment]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationComment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[INFO_InformationComment](
	[CommentID] [uniqueidentifier] NOT NULL,
	[InformationID] [uniqueidentifier] NOT NULL,
	[Content] [nvarchar](512) NOT NULL,
	[CommentUserID] [uniqueidentifier] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_INFO_INFORMATIONCOMMENT] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[INFO_InformationLike]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationLike]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[INFO_InformationLike](
	[LikeID] [uniqueidentifier] NOT NULL,
	[InformationID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[ActionType] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_INFO_InformationLike] PRIMARY KEY CLUSTERED 
(
	[LikeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[INFO_InformationType]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INFO_InformationType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[INFO_InformationType](
	[InformationTypeID] [uniqueidentifier] NOT NULL,
	[InformationTypeName] [nvarchar](50) NULL,
	[Remark] [nvarchar](500) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_INFO_InformationType] PRIMARY KEY CLUSTERED 
(
	[InformationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PS_HOM_HomeTemplate]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PS_HOM_HomeTemplate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PS_HOM_HomeTemplate](
	[HomeTemplateID] [uniqueidentifier] NOT NULL,
	[TemplateName] [nvarchar](32) NOT NULL,
	[TemplateType] [nvarchar](10) NULL,
	[Status] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PS_HOM_HomeTemplate] PRIMARY KEY CLUSTERED 
(
	[HomeTemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PS_HOM_HomeTemplateArea]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PS_HOM_HomeTemplateArea]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PS_HOM_HomeTemplateArea](
	[AreaID] [uniqueidentifier] NOT NULL,
	[HomeTemplateID] [uniqueidentifier] NOT NULL,
	[DisplayName] [nvarchar](32) NOT NULL,
	[DisplayNameKey] [nvarchar](128) NULL,
	[DisplayOrder] [int] NULL,
	[AttachmentID] [uniqueidentifier] NULL,
	[Icon] [nvarchar](80) NULL,
	[BgColor] [nvarchar](20) NOT NULL,
	[TileColor] [nvarchar](20) NOT NULL,
	[Width] [int] NOT NULL,
	[Height] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PS_HOM_HomeTemplateArea] PRIMARY KEY CLUSTERED 
(
	[AreaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PS_HOM_TemplateAreaTileRelation]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PS_HOM_TemplateAreaTileRelation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PS_HOM_TemplateAreaTileRelation](
	[ID] [uniqueidentifier] NOT NULL,
	[AreaID] [uniqueidentifier] NOT NULL,
	[TileID] [uniqueidentifier] NOT NULL,
	[DisplayOrder] [int] NULL,
	[CreateTime] [datetime] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PS_HOM_HomeTemplateAreaTileRelation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PS_HOM_TemplateUserRelation]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PS_HOM_TemplateUserRelation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PS_HOM_TemplateUserRelation](
	[ID] [uniqueidentifier] NOT NULL,
	[HomeTemplateID] [uniqueidentifier] NOT NULL,
	[MemberTypeCode] [nvarchar](80) NOT NULL,
	[MemberID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PS_HOM_HomeTemplateUserGroupRelation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PS_HOM_Tile]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PS_HOM_Tile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PS_HOM_Tile](
	[TileID] [uniqueidentifier] NOT NULL,
	[TileName] [nvarchar](256) NOT NULL,
	[Alias] [nvarchar](32) NULL,
	[FuncationID] [nvarchar](max) NULL,
	[Memo] [nvarchar](512) NULL,
	[GroupType] [nvarchar](80) NULL,
	[DisplayType] [nvarchar](80) NULL,
	[DisplayMode] [nvarchar](80) NULL,
	[UpdateType] [nvarchar](80) NULL,
	[Icon] [nvarchar](80) NULL,
	[Url] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[IsUse] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UpdateAction] [nvarchar](255) NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PS_HOM_Tile] PRIMARY KEY CLUSTERED 
(
	[TileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_AuditLog]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_AuditLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_AuditLog](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[LogType] [int] NOT NULL,
	[Level] [int] NOT NULL,
	[System] [nvarchar](50) NOT NULL,
	[Application] [nvarchar](50) NULL,
	[Module] [nvarchar](max) NULL,
	[Business] [nvarchar](100) NULL,
	[BusinessName] [nvarchar](100) NULL,
	[Action] [nvarchar](100) NULL,
	[StatusCode] [nvarchar](50) NULL,
	[Title] [nvarchar](512) NULL,
	[Desc] [nvarchar](max) NULL,
	[Memo] [nvarchar](512) NULL,
	[RequestIP] [nvarchar](50) NULL,
	[UserAgent] [nvarchar](255) NULL,
	[IsMobileAgent] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[UserId] [nvarchar](50) NULL,
	[DataScope] [nvarchar](50) NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_AuditLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_Audittrail]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Audittrail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_Audittrail](
	[AudittrailID] [varchar](32) NOT NULL,
	[RequestID] [varchar](50) NOT NULL,
	[Operation] [varchar](20) NOT NULL,
	[OperationName] [nvarchar](50) NULL,
	[CreateTime] [datetime] NOT NULL,
	[OperationTime] [datetime] NULL,
	[ActivityName] [nvarchar](50) NOT NULL,
	[ActivityCode] [varchar](50) NOT NULL,
	[OperatorID] [varchar](50) NOT NULL,
	[OperatorGUID] [uniqueidentifier] NOT NULL,
	[Comments] [nvarchar](500) NULL,
	[ActivityInstanceID] [int] NULL,
	[RequestTypeCode] [nvarchar](36) NULL,
	[DelegateeID] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_Audittrail] PRIMARY KEY CLUSTERED 
(
	[AudittrailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SYS_CodeRule]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_CodeRule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_CodeRule](
	[RuleID] [uniqueidentifier] NOT NULL,
	[RuleCode] [nvarchar](100) NOT NULL,
	[RuleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](512) NULL,
	[Memo] [nvarchar](512) NULL,
	[IsUse] [bit] NOT NULL,
	[LegalChar] [nvarchar](32) NULL,
	[LegalOrder] [int] NULL,
	[FixChar] [nvarchar](32) NULL,
	[FixOrder] [int] NULL,
	[TimeChar] [nvarchar](32) NULL,
	[TimeOrder] [int] NULL,
	[FlowingChar] [nvarchar](32) NULL,
	[FlowingOrder] [int] NULL,
	[OtherCharType] [nvarchar](255) NULL,
	[OtherCharOrder] [int] NULL,
	[RuleProvider] [nvarchar](255) NULL,
	[LastTimeCode] [nvarchar](36) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_CODERULE] PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_CodeRuleCounter]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_CodeRuleCounter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_CodeRuleCounter](
	[CounterID] [uniqueidentifier] NOT NULL,
	[RuleID] [uniqueidentifier] NOT NULL,
	[RuleCode] [nvarchar](100) NOT NULL,
	[CounterLegalEntityID] [uniqueidentifier] NOT NULL,
	[CounterValue] [int] NOT NULL,
	[Memo] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_CODERULECOUNTER] PRIMARY KEY CLUSTERED 
(
	[CounterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_COM_Attachement]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_COM_Attachement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_COM_Attachement](
	[AttachementID] [uniqueidentifier] NOT NULL,
	[FormID] [uniqueidentifier] NOT NULL,
	[RequestTypeCode] [nvarchar](36) NULL,
	[AttachmentTypeCode] [nvarchar](36) NULL,
	[FileName] [nvarchar](256) NOT NULL,
	[Type] [nvarchar](36) NOT NULL,
	[Size] [bigint] NOT NULL,
	[MD5] [nvarchar](32) NOT NULL,
	[AccessURL] [nvarchar](512) NOT NULL,
	[StorePath] [nvarchar](512) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
	[AttachmentRemark] [nvarchar](50) NULL,
 CONSTRAINT [PK_SYS_COM_ATTACHEMENT] PRIMARY KEY CLUSTERED 
(
	[AttachementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_COM_AttachmentType]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_COM_AttachmentType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_COM_AttachmentType](
	[AttachmentTypeCode] [nvarchar](36) NOT NULL,
	[AttachmentTypeName] [nvarchar](36) NOT NULL,
	[Memo] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_COM_ATTACHMENTTYPE] PRIMARY KEY CLUSTERED 
(
	[AttachmentTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_COM_BankBranch]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_COM_BankBranch]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_COM_BankBranch](
	[BankBranchID] [uniqueidentifier] NOT NULL,
	[BankDictCode] [nvarchar](80) NOT NULL,
	[BankBranchCode] [nvarchar](128) NULL,
	[BankBranchName] [nvarchar](256) NULL,
	[IsDisabled] [bit] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_COM_BankBranch] PRIMARY KEY CLUSTERED 
(
	[BankBranchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_DataPrivilege]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_DataPrivilege]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_DataPrivilege](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ResId] [nvarchar](50) NOT NULL,
	[RoleResId] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[BizId] [nvarchar](50) NOT NULL,
	[ActionId] [nvarchar](50) NULL,
	[LogicCondition] [nvarchar](20) NOT NULL,
	[Type] [nvarchar](255) NOT NULL,
	[Value] [nvarchar](2000) NULL,
	[Param] [nvarchar](255) NULL,
	[Desc] [nvarchar](255) NULL,
 CONSTRAINT [PK_SYS_DataPrivilege] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_Dict]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Dict]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_Dict](
	[DictID] [uniqueidentifier] NOT NULL,
	[DictCode] [nvarchar](36) NOT NULL,
	[DictName] [nvarchar](256) NOT NULL,
	[DictType] [nvarchar](80) NOT NULL,
	[Memo] [nvarchar](512) NULL,
	[IsEnable] [bit] NOT NULL,
	[IsCache] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_Dict] PRIMARY KEY CLUSTERED 
(
	[DictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_DictItem]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_DictItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_DictItem](
	[ItemID] [uniqueidentifier] NOT NULL,
	[DictID] [uniqueidentifier] NULL,
	[ItemCode] [nvarchar](36) NOT NULL,
	[ItemName] [nvarchar](256) NOT NULL,
	[ItemValue] [nvarchar](256) NOT NULL,
	[ParentID] [uniqueidentifier] NULL,
	[Sequence] [int] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[Remark] [nvarchar](500) NULL,
	[IsEnable] [bit] NOT NULL,
	[DictCode] [nvarchar](36) NULL,
	[ItemIDCode] [nvarchar](80) NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_DictItem] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_DictItemScope]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_DictItemScope]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_DictItemScope](
	[ScopeID] [uniqueidentifier] NOT NULL,
	[ItemID] [uniqueidentifier] NULL,
	[VisibleLEID] [uniqueidentifier] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_DICTITEMSCOPE] PRIMARY KEY CLUSTERED 
(
	[ScopeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_Feedback]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Feedback]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_Feedback](
	[FeedbackID] [uniqueidentifier] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Name] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[AttachementID] [uniqueidentifier] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_FeedbackID] PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_Message]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Message]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_Message](
	[MessageID] [uniqueidentifier] NOT NULL,
	[MessageType] [int] NULL,
	[MessagePriority] [int] NOT NULL,
	[TemplateID] [uniqueidentifier] NOT NULL,
	[MessagePara1] [nvarchar](512) NULL,
	[MessagePara2] [nvarchar](512) NULL,
	[MessagePara3] [nvarchar](512) NULL,
	[MessagePara4] [nvarchar](512) NULL,
	[MessagePara5] [nvarchar](512) NULL,
	[MessagePara6] [nvarchar](512) NULL,
	[AttachmentID] [uniqueidentifier] NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_MESSAGE] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_MessageDeliveryDetail]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_MessageDeliveryDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_MessageDeliveryDetail](
	[MessageDeliveryDetailID] [uniqueidentifier] NOT NULL,
	[MessageID] [uniqueidentifier] NOT NULL,
	[MessageType] [int] NOT NULL,
	[MessagePriority] [int] NOT NULL,
	[MessageSubject] [nvarchar](500) NULL,
	[MaxRetryTimes] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ExternID] [uniqueidentifier] NULL,
	[EmailAddress] [nvarchar](200) NULL,
	[Mobile] [nvarchar](200) NULL,
	[SendStatus] [int] NOT NULL,
	[StartSendTime] [datetime] NULL,
	[RetriedTimes] [int] NOT NULL,
	[NextRetryTime] [datetime] NULL,
	[LastSendTime] [datetime] NULL,
	[IsRead] [bit] NOT NULL,
	[AttachmentFileName] [nvarchar](200) NULL,
	[Content] [nvarchar](max) NULL,
	[AttachmentStorePath] [nvarchar](512) NULL,
	[CreateTime] [datetime] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_MESSAGEDELIVERYDETA] PRIMARY KEY CLUSTERED 
(
	[MessageDeliveryDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_MessageScope]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_MessageScope]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_MessageScope](
	[ScopeID] [uniqueidentifier] NOT NULL,
	[MessageID] [uniqueidentifier] NOT NULL,
	[MessageScopeType] [int] NOT NULL,
	[ExternID] [uniqueidentifier] NULL,
	[Name] [nvarchar](50) NULL,
	[EmailAddress] [nvarchar](200) NULL,
	[Mobile] [nvarchar](200) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_MESSAGESCOPE] PRIMARY KEY CLUSTERED 
(
	[ScopeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_MessageTemplate]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_MessageTemplate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_MessageTemplate](
	[TemplateID] [uniqueidentifier] NOT NULL,
	[MessageType] [int] NOT NULL,
	[TemplateCode] [nvarchar](256) NOT NULL,
	[TemplateName] [nvarchar](256) NOT NULL,
	[MaxRetryTimes] [int] NOT NULL,
	[Desc] [nvarchar](512) NULL,
	[MessageSubject] [nvarchar](200) NULL,
	[Content] [nvarchar](4000) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_COM_MESSAGETEMPLATE] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_Org]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Org]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_Org](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrgId] [uniqueidentifier] NOT NULL,
	[ResId] [nvarchar](40) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ParentId] [nvarchar](40) NULL,
	[FullName] [nvarchar](100) NULL,
	[IdPath] [nvarchar](4000) NULL,
	[NamePath] [nvarchar](4000) NULL,
	[OrgType] [int] NOT NULL,
	[RoleList] [nvarchar](4000) NULL,
	[ResState] [int] NOT NULL,
	[Desc] [nvarchar](255) NULL,
	[ShortName] [nvarchar](20) NULL,
	[Code] [nvarchar](20) NULL,
	[Text1] [nvarchar](255) NULL,
	[Text2] [nvarchar](255) NULL,
	[Text3] [nvarchar](255) NULL,
	[Text4] [nvarchar](255) NULL,
	[Text5] [nvarchar](255) NULL,
	[Text6] [nvarchar](255) NULL,
	[Text7] [nvarchar](255) NULL,
	[Text8] [nvarchar](255) NULL,
	[LegalId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[DataOwner] [nvarchar](100) NULL,
	[DataScope] [nvarchar](100) NULL,
	[Creator] [nvarchar](50) NULL,
	[Updator] [nvarchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_RequestMaster]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_RequestMaster]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_RequestMaster](
	[MasterRequestID] [uniqueidentifier] NOT NULL,
	[RequestTypeCode] [nvarchar](36) NULL,
	[MasterRequestCode] [nvarchar](32) NOT NULL,
	[TypeInfoID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[PositionID] [uniqueidentifier] NOT NULL,
	[OrgUnitID] [uniqueidentifier] NOT NULL,
	[RequestTime] [datetime] NOT NULL,
	[OperatorID] [uniqueidentifier] NOT NULL,
	[OperatorPositionID] [uniqueidentifier] NOT NULL,
	[OperatorOUID] [uniqueidentifier] NOT NULL,
	[ApproveStatus] [nvarchar](80) NOT NULL,
	[BusinessStatus] [nvarchar](80) NULL,
	[IsNotifyResult] [bit] NOT NULL,
	[WorkflowID] [nvarchar](256) NULL,
	[ExtendFormID] [uniqueidentifier] NULL,
	[LastApprovedTime] [datetime] NULL,
	[LastApproverID] [uniqueidentifier] NULL,
	[Memo] [nvarchar](500) NULL,
	[ActivityCode] [nvarchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_REQUESTMASTER] PRIMARY KEY CLUSTERED 
(
	[MasterRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_RequestType]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_RequestType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_RequestType](
	[Id] [uniqueidentifier] NOT NULL,
	[RequestTypeCode] [nvarchar](36) NOT NULL,
	[RequestGroup] [nvarchar](36) NULL,
	[RequestTypeName] [nvarchar](36) NOT NULL,
	[Memo] [nvarchar](512) NULL,
	[BusinessId] [nvarchar](100) NULL,
	[VerifyView] [nvarchar](100) NULL,
	[FormCode] [nvarchar](256) NULL,
	[FlowCode] [nvarchar](256) NULL,
	[FlowName] [nvarchar](50) NULL,
	[FolioRuleCode] [nvarchar](80) NULL,
	[WorkflowParam] [nvarchar](max) NULL,
	[WorkflowRemark] [nvarchar](max) NULL,
	[IsPositionSelect] [bit] NOT NULL,
	[CanBatchApproval] [bit] NOT NULL,
	[CanCommonApproval] [bit] NOT NULL,
	[TypeLevel] [int] NOT NULL,
	[ParentTypeCode] [nvarchar](36) NULL,
	[IsDefault] [bit] NOT NULL,
	[IsDisabled] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsHeadApproval] [bit] NULL,
	[Text1] [nvarchar](80) NULL,
	[Text2] [nvarchar](80) NULL,
	[Text3] [nvarchar](80) NULL,
	[Text4] [nvarchar](80) NULL,
	[Text5] [nvarchar](80) NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [uniqueidentifier] NULL,
	[LegalEntityID] [uniqueidentifier] NOT NULL,
	[TenantID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_REQUESTTYPE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_Role]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Role]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_Role](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ResId] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ResState] [int] NOT NULL,
	[Desc] [nvarchar](255) NULL,
	[RoleType] [int] NOT NULL,
	[AppFunctions] [nvarchar](max) NULL,
	[BizFunctions] [nvarchar](max) NULL,
	[InheritRoles] [nvarchar](4000) NULL,
	[Code] [nvarchar](50) NULL,
	[LegalId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[DataOwner] [nvarchar](100) NULL,
	[DataScope] [nvarchar](100) NULL,
	[Creator] [nvarchar](50) NULL,
	[Updator] [nvarchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
	[Kind] [nvarchar](50) NULL,
 CONSTRAINT [PK_SYS_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_Tenant]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_Tenant]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_Tenant](
	[TenantID] [uniqueidentifier] NOT NULL,
	[TenantCode] [nvarchar](36) NOT NULL,
	[TenantName] [nvarchar](256) NOT NULL,
	[TenantDomain] [nvarchar](100) NOT NULL,
	[TenantType] [smallint] NULL,
	[Mobile] [nvarchar](15) NULL,
	[Email] [nvarchar](50) NULL,
	[DbConnectString] [nvarchar](255) NULL,
	[InitAdminPwd] [nvarchar](50) NULL,
	[UserLimit] [int] NULL,
	[Memo] [nvarchar](512) NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsEnable] [bit] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_SYS_Tenant] PRIMARY KEY CLUSTERED 
(
	[TenantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SYS_User]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYS_User]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYS_User](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ResId] [nvarchar](40) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[LoginName] [nvarchar](50) NOT NULL,
	[LoginId] [nvarchar](40) NULL,
	[Password] [nvarchar](50) NULL,
	[Code] [nvarchar](20) NULL,
	[InitPassword] [nvarchar](50) NULL,
	[RoleList] [nvarchar](max) NULL,
	[UserRoleList] [nvarchar](max) NULL,
	[ResState] [int] NOT NULL,
	[OrgId] [nvarchar](40) NULL,
	[PositionId] [nvarchar](40) NULL,
	[BelongOrg] [nvarchar](4000) NULL,
	[Email] [nvarchar](50) NULL,
	[Mobile] [nvarchar](20) NULL,
	[UserStatus] [nvarchar](50) NULL,
	[UserLevel] [nvarchar](50) NULL,
	[UserNo] [nvarchar](50) NULL,
	[UserPhotoId] [nvarchar](50) NULL,
	[UserType] [nvarchar](20) NULL,
	[DataSource] [nvarchar](30) NULL,
	[Text1] [nvarchar](255) NULL,
	[Text2] [nvarchar](255) NULL,
	[Text3] [nvarchar](255) NULL,
	[Text4] [nvarchar](255) NULL,
	[Text5] [nvarchar](255) NULL,
	[Text6] [nvarchar](255) NULL,
	[Text7] [nvarchar](255) NULL,
	[Text8] [nvarchar](255) NULL,
	[LegalId] [uniqueidentifier] NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
	[DataOwner] [nvarchar](100) NULL,
	[DataScope] [nvarchar](100) NULL,
	[Creator] [nvarchar](50) NULL,
	[Updator] [nvarchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_SYS_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[WfTaskActivities]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WfTaskActivities]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WfTaskActivities](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[WfTaskProcessId] [bigint] NOT NULL,
	[ActivityTemplateId] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[TaskType] [nvarchar](50) NULL,
	[ActivityState] [nvarchar](20) NULL,
	[PrvActivityId] [bigint] NOT NULL,
	[PrvActivityTemplateId] [nvarchar](50) NULL,
	[Resource] [nvarchar](4000) NULL,
	[Param] [nvarchar](max) NULL,
	[Executor] [nvarchar](30) NULL,
	[ExecutorName] [nvarchar](50) NULL,
	[ExecutorAction] [nvarchar](50) NULL,
	[ExecutorEvent] [nvarchar](50) NULL,
	[ExecuteContent] [nvarchar](max) NULL,
	[Text1] [nvarchar](50) NULL,
	[Text2] [nvarchar](255) NULL,
	[BusinessState] [nvarchar](50) NULL,
	[Creator] [nvarchar](50) NOT NULL,
	[Updator] [nvarchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_WfTaskActivities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[WfTaskProcesses]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WfTaskProcesses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WfTaskProcesses](
	[Id] [bigint] NOT NULL,
	[ParentId] [bigint] NULL,
	[TemplateId] [nvarchar](50) NOT NULL,
	[BizResId] [nvarchar](50) NULL,
	[BizResIntId] [int] NULL,
	[BizResLongId] [bigint] NULL,
	[Name] [nvarchar](30) NULL,
	[Version] [nvarchar](30) NULL,
	[Kind] [nvarchar](30) NULL,
	[Param] [nvarchar](max) NULL,
	[Creator] [nvarchar](50) NULL,
	[Updator] [nvarchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
	[DataOwner] [nvarchar](100) NULL,
	[DataScope] [nvarchar](100) NULL,
	[Deleted] [bit] NOT NULL,
	[ProcessState] [nvarchar](20) NULL,
	[BusinessState] [nvarchar](50) NULL,
	[BusinessState1] [nvarchar](50) NULL,
 CONSTRAINT [PK_WfTaskProcesses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[WfTasks]    Script Date: 2018/6/5 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WfTasks]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WfTasks](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[WfTaskProcessId] [bigint] NOT NULL,
	[WfTaskActivityId] [bigint] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[TaskType] [nvarchar](50) NULL,
	[TaskState] [nvarchar](50) NULL,
	[Executor] [nvarchar](50) NULL,
	[ExecutorName] [nvarchar](50) NULL,
	[ExecuteAction] [nvarchar](50) NULL,
	[ExecuteEvent] [nvarchar](50) NULL,
	[ExecuteContent] [nvarchar](max) NULL,
	[Destination] [nvarchar](50) NULL,
	[Resource] [nvarchar](4000) NULL,
	[Text1] [nvarchar](50) NULL,
	[Text2] [nvarchar](255) NULL,
	[Seq] [int] NOT NULL,
	[Creator] [nvarchar](50) NULL,
	[Updator] [nvarchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_WfTasks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_AS_Ass__Creat__3D5E1FD2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_Asset] ADD  CONSTRAINT [DF__AM_AS_Ass__Creat__3D5E1FD2]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_AS_Ass__Creat__2EDAF651]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_AssetCategory] ADD  CONSTRAINT [DF__AM_AS_Ass__Creat__2EDAF651]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_AS_Mai__Creat__2B3F6F97]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_Maintain] ADD  CONSTRAINT [DF__AM_AS_Mai__Creat__2B3F6F97]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_AS_Pur__Creat__30F848ED]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_PurchaseInput] ADD  CONSTRAINT [DF__AM_AS_Pur__Creat__30F848ED]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_AM_AS_PurchaseInput_PurchaseOrderItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_PurchaseInput] ADD  CONSTRAINT [DF_AM_AS_PurchaseInput_PurchaseOrderItemID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [PurchaseOrderItemID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_AM_AS_PurchaseInput_PurchaseItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_PurchaseInput] ADD  CONSTRAINT [DF_AM_AS_PurchaseInput_PurchaseItemID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [PurchaseItemID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_AS_Usa__Creat__35BCFE0A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_AS_Usage] ADD  CONSTRAINT [DF__AM_AS_Usa__Creat__35BCFE0A]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_OB_Lis__Creat__5165187F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_OB_List] ADD  CONSTRAINT [DF__AM_OB_Lis__Creat__5165187F]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_OB_Ret__Creat__5BE2A6F2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_OB_ReturnRequest] ADD  CONSTRAINT [DF__AM_OB_Ret__Creat__5BE2A6F2]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_OB_Ret__Creat__5EBF139D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_OB_ReturnRequestDetail] ADD  CONSTRAINT [DF__AM_OB_Ret__Creat__5EBF139D]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_OB_Usa__Creat__619B8048]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_OB_UsageRequest] ADD  CONSTRAINT [DF__AM_OB_Usa__Creat__619B8048]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_OB_Usa__Creat__6477ECF3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_OB_UsageRequestDetail] ADD  CONSTRAINT [DF__AM_OB_Usa__Creat__6477ECF3]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__AM_WH_War__Creat__6754599E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AM_WH_Warehouse] ADD  CONSTRAINT [DF__AM_WH_War__Creat__6754599E]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__FM_OA_Car__Creat__1D4655FB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_CarvedIResquest] ADD  CONSTRAINT [DF__FM_OA_Car__Creat__1D4655FB]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__FM_OA_Cer__Creat__414EAC47]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_Cert] ADD  CONSTRAINT [DF__FM_OA_Cer__Creat__414EAC47]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_FM_OA_StampBorrowRequest_IsProject]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_StampBorrowRequest] ADD  CONSTRAINT [DF_FM_OA_StampBorrowRequest_IsProject]  DEFAULT ((0)) FOR [IsProject]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__FM_OA_Sta__Creat__35DCF99B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_StampBorrowRequest] ADD  CONSTRAINT [DF__FM_OA_Sta__Creat__35DCF99B]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__FM_OA_Sta__Creat__3C89F72A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_StampRequest] ADD  CONSTRAINT [DF__FM_OA_Sta__Creat__3C89F72A]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__FM_OA_Sta__Creat__39AD8A7F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_Stapm] ADD  CONSTRAINT [DF__FM_OA_Sta__Creat__39AD8A7F]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_FM_OA_Stapm_IsUse]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FM_OA_Stapm] ADD  CONSTRAINT [DF_FM_OA_Stapm_IsUse]  DEFAULT ((0)) FOR [IsUse]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Ad__Creat__7C1A6C5A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_Address] ADD  CONSTRAINT [DF__HR_EMP_Ad__Creat__7C1A6C5A]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_BankCard_BankCity]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_BankCard] ADD  CONSTRAINT [DF_HR_EMP_BankCard_BankCity]  DEFAULT ('') FOR [BankCity]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Ba__Creat__7EF6D905]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_BankCard] ADD  CONSTRAINT [DF__HR_EMP_Ba__Creat__7EF6D905]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Ed__Creat__26BAB19C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_Education] ADD  CONSTRAINT [DF__HR_EMP_Ed__Creat__26BAB19C]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_Employee_CostCenterMode]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_Employee] ADD  CONSTRAINT [DF_HR_EMP_Employee_CostCenterMode]  DEFAULT ((0)) FOR [CostCenterMode]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Em__Creat__73BA3083]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_Employee] ADD  CONSTRAINT [DF__HR_EMP_Em__Creat__73BA3083]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_EmployeeContract_SignedTimes]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_EmployeeContract] ADD  CONSTRAINT [DF_HR_EMP_EmployeeContract_SignedTimes]  DEFAULT ((0)) FOR [SignedTimes]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Em__Creat__5A846E65]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_EmployeeContract] ADD  CONSTRAINT [DF__HR_EMP_Em__Creat__5A846E65]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Em__Creat__0A688BB1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_EmployeeFamily] ADD  CONSTRAINT [DF__HR_EMP_Em__Creat__0A688BB1]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_OfficeAre__Creat__3DB3258D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_OfficeArea] ADD  CONSTRAINT [DF__HR_EMP_OfficeAre__Creat__3DB3258D]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_OfficeArea_AreaSize]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_OfficeArea] ADD  CONSTRAINT [DF_HR_EMP_OfficeArea_AreaSize]  DEFAULT ((0)) FOR [AreaSize]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Ot__Creat__3CA9F2BB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_OtherContact] ADD  CONSTRAINT [DF__HR_EMP_Ot__Creat__3CA9F2BB]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Po__Creat__76969D2E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_PostInformation] ADD  CONSTRAINT [DF__HR_EMP_Po__Creat__76969D2E]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_SalaryLevel_IsDisabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_SalaryLevel] ADD  CONSTRAINT [DF_HR_EMP_SalaryLevel_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_EMP_SalaryLevel_CreateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_SalaryLevel] ADD  CONSTRAINT [DF_HR_EMP_SalaryLevel_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_EMP_Wo__Creat__529933DA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_EMP_WorkHistory] ADD  CONSTRAINT [DF__HR_EMP_Wo__Creat__529933DA]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Jo__Creat__0E6E26BF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Job] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Jo__IsDis__0F624AF8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Job] ADD  DEFAULT ((0)) FOR [IsDisabled]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Jo__Creat__10566F31]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_JobLevel] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Jo__IsDis__114A936A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_JobLevel] ADD  DEFAULT ((0)) FOR [IsDisabled]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_LegalEntity_LegalEntityID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_LegalEntity] ADD  CONSTRAINT [DF_HR_ORG_LegalEntity_LegalEntityID]  DEFAULT (newid()) FOR [LegalEntityID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Le__Creat__1332DBDC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_LegalEntity] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_LegalEntity_CreateUserID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_LegalEntity] ADD  CONSTRAINT [DF_HR_ORG_LegalEntity_CreateUserID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CreateUserID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_LegalEntity_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_LegalEntity] ADD  CONSTRAINT [DF_HR_ORG_LegalEntity_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_LegalEntity_TenantID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_LegalEntity] ADD  CONSTRAINT [DF_HR_ORG_LegalEntity_TenantID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_Organization_Sequence]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Organization] ADD  CONSTRAINT [DF_HR_ORG_Organization_Sequence]  DEFAULT ((0)) FOR [Sequence]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Or__Creat__6E01572D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Organization] ADD  CONSTRAINT [DF__HR_ORG_Or__Creat__6E01572D]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Or__IsDis__778AC167]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Organization] ADD  CONSTRAINT [DF__HR_ORG_Or__IsDis__778AC167]  DEFAULT ((0)) FOR [IsDisabled]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_Position_IsHead]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Position] ADD  CONSTRAINT [DF_HR_ORG_Position_IsHead]  DEFAULT ((0)) FOR [IsHead]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_Position_IsPrincipal]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Position] ADD  CONSTRAINT [DF_HR_ORG_Position_IsPrincipal]  DEFAULT ((0)) FOR [IsPrincipal]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_Position_IsApprover]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Position] ADD  CONSTRAINT [DF_HR_ORG_Position_IsApprover]  DEFAULT ((0)) FOR [IsApprover]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_HR_ORG_Position_IsApplier]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Position] ADD  CONSTRAINT [DF_HR_ORG_Position_IsApplier]  DEFAULT ((1)) FOR [IsApplier]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__HR_ORG_Po__Creat__70DDC3D8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HR_ORG_Position] ADD  CONSTRAINT [DF__HR_ORG_Po__Creat__70DDC3D8]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_C__Creat__3B60C8C7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_Column] ADD  CONSTRAINT [DF__INFO_C__Creat__3B60C8C7]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_INFO_Information_IsNominated]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_Information] ADD  CONSTRAINT [DF_INFO_Information_IsNominated]  DEFAULT ((0)) FOR [IsNominated]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_I__Creat__2A363CC5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_Information] ADD  CONSTRAINT [DF__INFO_I__Creat__2A363CC5]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_Info__Creat__2180FB33]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_InformationAttachement] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_I__Creat__54CB950F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_InformationBody] ADD  CONSTRAINT [DF__INFO_I__Creat__54CB950F]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_I__Creat__4C8B54C9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_InformationBodyNominated] ADD  CONSTRAINT [DF__INFO_I__Creat__4C8B54C9]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__INFO_Info__Creat__245D67DE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_InformationComment] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_INFO_InformationType_CreateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[INFO_InformationType] ADD  CONSTRAINT [DF_INFO_InformationType_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ho__HomeT__7D197D8B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_HomeTemplate] ADD  CONSTRAINT [DF__PS_HOM_Ho__HomeT__7D197D8B]  DEFAULT (newid()) FOR [HomeTemplateID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ho__Creat__7E0DA1C4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_HomeTemplate] ADD  CONSTRAINT [DF__PS_HOM_Ho__Creat__7E0DA1C4]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ho__AreaI__00EA0E6F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_HomeTemplateArea] ADD  CONSTRAINT [DF__PS_HOM_Ho__AreaI__00EA0E6F]  DEFAULT (newid()) FOR [AreaID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ho__Creat__01DE32A8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_HomeTemplateArea] ADD  CONSTRAINT [DF__PS_HOM_Ho__Creat__01DE32A8]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Templ__ID__097F5470]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_TemplateAreaTileRelation] ADD  CONSTRAINT [DF__PS_HOM_Templ__ID__097F5470]  DEFAULT (newid()) FOR [ID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Te__Creat__0A7378A9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_TemplateAreaTileRelation] ADD  CONSTRAINT [DF__PS_HOM_Te__Creat__0A7378A9]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Templ__ID__0D4FE554]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_TemplateUserRelation] ADD  CONSTRAINT [DF__PS_HOM_Templ__ID__0D4FE554]  DEFAULT (newid()) FOR [ID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ti__TileI__102C51FF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_Tile] ADD  CONSTRAINT [DF__PS_HOM_Ti__TileI__102C51FF]  DEFAULT (newid()) FOR [TileID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ti__Creat__11207638]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_Tile] ADD  CONSTRAINT [DF__PS_HOM_Ti__Creat__11207638]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__PS_HOM_Ti__Tenan__12149A71]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PS_HOM_Tile] ADD  CONSTRAINT [DF__PS_HOM_Ti__Tenan__12149A71]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_AuditLog_IsMobileAgent]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_AuditLog] ADD  CONSTRAINT [DF_SYS_AuditLog_IsMobileAgent]  DEFAULT ((0)) FOR [IsMobileAgent]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_CodeR__RuleI__2645B050]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_CodeRule] ADD  DEFAULT (newid()) FOR [RuleID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_CodeR__Creat__2739D489]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_CodeRule] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_CodeR__Count__282DF8C2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_CodeRuleCounter] ADD  DEFAULT ((0)) FOR [CounterValue]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_CodeR__Creat__29221CFB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_CodeRuleCounter] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_COM_A__Creat__2A164134]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_Attachement] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_COM_A__Creat__2B0A656D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_AttachmentType] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_COM_AttachmentType_CreateUserID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_AttachmentType] ADD  CONSTRAINT [DF_SYS_COM_AttachmentType_CreateUserID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CreateUserID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_COM_AttachmentType_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_AttachmentType] ADD  CONSTRAINT [DF_SYS_COM_AttachmentType_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_COM_AttachmentType_LegalEntityID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_AttachmentType] ADD  CONSTRAINT [DF_SYS_COM_AttachmentType_LegalEntityID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [LegalEntityID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_COM_AttachmentType_TenantID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_AttachmentType] ADD  CONSTRAINT [DF_SYS_COM_AttachmentType_TenantID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_COM_BankBranch_CreateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_COM_BankBranch] ADD  CONSTRAINT [DF_SYS_COM_BankBranch_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Dict__DictID__30C33EC3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Dict] ADD  DEFAULT (newid()) FOR [DictID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Dict__IsEnab__31B762FC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Dict] ADD  DEFAULT ((1)) FOR [IsEnable]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Dict__IsCach__32AB8735]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Dict] ADD  DEFAULT ((0)) FOR [IsCache]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Dict__Create__339FAB6E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Dict] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Dict__IsDele__3493CFA7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Dict] ADD  DEFAULT ((0)) FOR [IsDeleted]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_DictI__ItemI__3587F3E0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_DictItem] ADD  DEFAULT (newid()) FOR [ItemID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_DictI__Creat__367C1819]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_DictItem] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_DictI__IsDel__37703C52]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_DictItem] ADD  DEFAULT ((0)) FOR [IsDeleted]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_DictI__IsEna__3864608B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_DictItem] ADD  DEFAULT ((1)) FOR [IsEnable]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_DictI__Creat__395884C4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_DictItemScope] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Feedb__Feedb__108B795B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Feedback] ADD  CONSTRAINT [DF__SYS_Feedb__Feedb__108B795B]  DEFAULT (newid()) FOR [FeedbackID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Feedb__Creat__1367E606]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Feedback] ADD  CONSTRAINT [DF__SYS_Feedb__Creat__1367E606]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Feedb__IsDel__117F9D94]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Feedback] ADD  CONSTRAINT [DF__SYS_Feedb__IsDel__117F9D94]  DEFAULT ((0)) FOR [IsDeleted]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Messa__Creat__3A4CA8FD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Message] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Messa__MaxRe__3B40CD36]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_MessageDeliveryDetail] ADD  DEFAULT ((0)) FOR [MaxRetryTimes]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_MessageDeliveryDetail_IsRead]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_MessageDeliveryDetail] ADD  CONSTRAINT [DF_SYS_MessageDeliveryDetail_IsRead]  DEFAULT ((0)) FOR [IsRead]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_M__Creat__53633AE1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_MessageDeliveryDetail] ADD  CONSTRAINT [DF__SYS_M__Creat__53633AE1]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Messa__Creat__3E1D39E1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_MessageScope] ADD  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_M__Creat__6AFACD50]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_MessageTemplate] ADD  CONSTRAINT [DF__SYS_M__Creat__6AFACD50]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestMaster_IsNotifyResult]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestMaster] ADD  CONSTRAINT [DF_SYS_RequestMaster_IsNotifyResult]  DEFAULT ((0)) FOR [IsNotifyResult]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestType_IsPositionSelect]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] ADD  CONSTRAINT [DF_SYS_RequestType_IsPositionSelect]  DEFAULT ((0)) FOR [IsPositionSelect]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestType_CanBatchApproval]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] ADD  CONSTRAINT [DF_SYS_RequestType_CanBatchApproval]  DEFAULT ((0)) FOR [CanBatchApproval]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestType_CanCommonApproval]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] ADD  CONSTRAINT [DF_SYS_RequestType_CanCommonApproval]  DEFAULT ((0)) FOR [CanCommonApproval]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestType_TypeLevel]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] ADD  CONSTRAINT [DF_SYS_RequestType_TypeLevel]  DEFAULT ((0)) FOR [TypeLevel]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_SYS_RequestType_IsDisabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] ADD  CONSTRAINT [DF_SYS_RequestType_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_R__Creat__03F0984C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_RequestType] ADD  CONSTRAINT [DF__SYS_R__Creat__03F0984C]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Tenan__Tenan__108B795B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Tenant] ADD  CONSTRAINT [DF__SYS_Tenan__Tenan__108B795B]  DEFAULT (newid()) FOR [TenantID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Tenan__IsDel__117F9D94]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Tenant] ADD  CONSTRAINT [DF__SYS_Tenan__IsDel__117F9D94]  DEFAULT ((0)) FOR [IsDeleted]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Tenan__IsEna__1273C1CD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Tenant] ADD  CONSTRAINT [DF__SYS_Tenan__IsEna__1273C1CD]  DEFAULT ((1)) FOR [IsEnable]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__SYS_Tenan__Creat__1367E606]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SYS_Tenant] ADD  CONSTRAINT [DF__SYS_Tenan__Creat__1367E606]  DEFAULT (getdate()) FOR [CreateTime]
END

GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WfTaskProcessWfTaskActivity]') AND parent_object_id = OBJECT_ID(N'[dbo].[WfTaskActivities]'))
ALTER TABLE [dbo].[WfTaskActivities]  WITH CHECK ADD  CONSTRAINT [FK_WfTaskProcessWfTaskActivity] FOREIGN KEY([WfTaskProcessId])
REFERENCES [dbo].[WfTaskProcesses] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WfTaskProcessWfTaskActivity]') AND parent_object_id = OBJECT_ID(N'[dbo].[WfTaskActivities]'))
ALTER TABLE [dbo].[WfTaskActivities] CHECK CONSTRAINT [FK_WfTaskProcessWfTaskActivity]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WfTaskActivityWfTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[WfTasks]'))
ALTER TABLE [dbo].[WfTasks]  WITH CHECK ADD  CONSTRAINT [FK_WfTaskActivityWfTask] FOREIGN KEY([WfTaskActivityId])
REFERENCES [dbo].[WfTaskActivities] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WfTaskActivityWfTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[WfTasks]'))
ALTER TABLE [dbo].[WfTasks] CHECK CONSTRAINT [FK_WfTaskActivityWfTask]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WfTaskProcessWfTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[WfTasks]'))
ALTER TABLE [dbo].[WfTasks]  WITH CHECK ADD  CONSTRAINT [FK_WfTaskProcessWfTask] FOREIGN KEY([WfTaskProcessId])
REFERENCES [dbo].[WfTaskProcesses] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WfTaskProcessWfTask]') AND parent_object_id = OBJECT_ID(N'[dbo].[WfTasks]'))
ALTER TABLE [dbo].[WfTasks] CHECK CONSTRAINT [FK_WfTaskProcessWfTask]
GO
