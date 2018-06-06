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

--personalhome-setting
declare @homemobileTemplate varchar(36)
set @homemobileTemplate= LOWER(CONVERT(NVARCHAR(36), NEWID()))
insert [PS_HOM_HomeTemplate]
values(@homemobileTemplate,'tmobile','mobile',0,GETDATE(),0,@tenantGuid)

insert PS_HOM_TemplateUserRelation
values(NEWID(),@homemobileTemplate,'2',@legalGuid,@tenantGuid)

declare @ph_bizarea varchar(36)
set @ph_bizarea= LOWER(CONVERT(NVARCHAR(36), NEWID()))
insert PS_HOM_HomeTemplateArea
values(@ph_bizarea,@homemobileTemplate,N'业务','approval',1,null,'','','',0,0,GETDATE(),0,@tenantGuid)

declare @ph_mybacklog varchar(36)
set @ph_mybacklog= LOWER(CONVERT(NVARCHAR(36), NEWID()))
insert PS_HOM_Tile
values(@ph_mybacklog,N'我的申请',null,null,N'我发起的申请','1','link','blank','','icon f7-icons t:document_text','wf/MyBacklog',GETDATE(),1,0,null,@tenantGuid)

insert PS_HOM_TemplateAreaTileRelation
values(NEWID(),@ph_bizarea,@ph_mybacklog,1,GETDATE(),@tenantGuid)

declare @ph_fbacklog varchar(36)
set @ph_fbacklog= LOWER(CONVERT(NVARCHAR(36), NEWID()))
insert PS_HOM_Tile
values(@ph_fbacklog,N'已办业务',null,null,N'我处理过的业务','1','link','blank','','icon f7-icons t:document_text_fill','wf/fbacklog',GETDATE(),1,0,null,@tenantGuid)

insert PS_HOM_TemplateAreaTileRelation
values(NEWID(),@ph_bizarea,@ph_fbacklog,2,GETDATE(),@tenantGuid)

declare @ph_newrequest varchar(36)
set @ph_newrequest= LOWER(CONVERT(NVARCHAR(36), NEWID()))
insert PS_HOM_Tile
values(@ph_newrequest,N'新的申请',null,null,N'新的审批或者业务请求','1','link','blank','','icon f7-icons t:add_round_fill','wf/newrequest',GETDATE(),1,0,null,@tenantGuid)

insert PS_HOM_TemplateAreaTileRelation
values(NEWID(),@ph_bizarea,@ph_newrequest,3,GETDATE(),@tenantGuid)

declare @ph_assetarea varchar(36)
set @ph_assetarea= LOWER(CONVERT(NVARCHAR(36), NEWID()))
insert PS_HOM_HomeTemplateArea
values(@ph_assetarea,@homemobileTemplate,N'资产','asset',2,null,'','','',0,0,GETDATE(),0,@tenantGuid)

declare @ph_assetquery varchar(36)
set @ph_assetquery= LOWER(CONVERT(NVARCHAR(36), NEWID()))
insert PS_HOM_Tile
values(@ph_assetquery,N'资产查询和入库',null,'Biz_Asset_ZC',N'固定和低值资产查询和入库','1','link','blank','','icon material-icons t:assignment_returned','asset/manage',GETDATE(),1,0,null,@tenantGuid)


