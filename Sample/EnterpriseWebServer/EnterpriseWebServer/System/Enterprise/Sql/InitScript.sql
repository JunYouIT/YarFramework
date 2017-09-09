/****** Object:  Table [dbo].[HR_EMP_PostInformation]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[HR_ORG_Job]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[HR_ORG_JobLevel]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[HR_ORG_LegalEntity]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[HR_ORG_Organization]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[HR_ORG_Position]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[JobID] [uniqueidentifier] NOT NULL,
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

GO
/****** Object:  Table [dbo].[HR_ORG_PositionRoleList]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_ORG_PositionRoleList](
	[PositionID] [uniqueidentifier] NOT NULL,
	[RoleID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HR_ORG_POSITIONROLELIST] PRIMARY KEY NONCLUSTERED 
(
	[PositionID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SYS_AuditLog]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[CreateTime] [datetime] NOT NULL,
	[UserId] [nvarchar](50) NULL,
	[DataScope] [nvarchar](50) NULL,
	[TenantId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SYS_AuditLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SYS_Audittrail]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SYS_Audittrail](
	[AudittrailID] [varchar](32) NOT NULL,
	[RequestID] [varchar](50) NOT NULL,
	[Operation] [varchar](20) NOT NULL,
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

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SYS_CodeRule]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_CodeRuleCounter]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_COM_Attachement]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_COM_AttachmentType]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_DataPrivilege]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_Dict]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_DictItem]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_DictItemScope]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_Message]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_MessageDeliveryDetail]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_MessageScope]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_MessageTemplate]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_Org]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_RequestMaster]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_RequestType]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_RequestType](
	[Id] [uniqueidentifier] NOT NULL,
	[RequestTypeCode] [nvarchar](36) NOT NULL,
	[RequestGroup] [nvarchar](36) NULL,
	[RequestTypeName] [nvarchar](36) NOT NULL,
	[Memo] [nvarchar](512) NULL,
	[BusinessId] [nvarchar](100) NULL,
	[FormCode] [nvarchar](256) NULL,
	[FlowCode] [nvarchar](256) NULL,
	[FlowName] [nvarchar](50) NULL,
	[FolioRuleCode] [nvarchar](80) NULL,
	[WorkflowParam] [nvarchar](max) NULL,
	[WorkflowRemark] [nvarchar](max) NULL,
	[CanBatchApproval] [bit] NOT NULL,
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

GO
/****** Object:  Table [dbo].[SYS_Role]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[SYS_Tenant]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_Tenant](
	[TenantID] [uniqueidentifier] NOT NULL,
	[TenantCode] [nvarchar](36) NOT NULL,
	[TenantName] [nvarchar](256) NOT NULL,
	[TenantDomain] [nvarchar](100) NOT NULL,
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

GO
/****** Object:  Table [dbo].[SYS_User]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[RoleList] [nvarchar](4000) NULL,
	[ResState] [int] NOT NULL,
	[OrgId] [nvarchar](40) NULL,
	[PositionId] [nvarchar](40) NULL,
	[EmployeeNo] [nvarchar](50) NULL,
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
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WfTaskActivities]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[WfTaskProcesses]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  Table [dbo].[WfTasks]    Script Date: 9/9/2017 1:22:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
ALTER TABLE [dbo].[HR_EMP_PostInformation] ADD  CONSTRAINT [DF__HR_EMP_Po__Creat__76969D2E]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[HR_ORG_Job] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[HR_ORG_Job] ADD  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[HR_ORG_JobLevel] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[HR_ORG_JobLevel] ADD  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[HR_ORG_LegalEntity] ADD  CONSTRAINT [DF_HR_ORG_LegalEntity_LegalEntityID]  DEFAULT (newid()) FOR [LegalEntityID]
GO
ALTER TABLE [dbo].[HR_ORG_LegalEntity] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[HR_ORG_LegalEntity] ADD  CONSTRAINT [DF_HR_ORG_LegalEntity_CreateUserID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CreateUserID]
GO
ALTER TABLE [dbo].[HR_ORG_LegalEntity] ADD  CONSTRAINT [DF_HR_ORG_LegalEntity_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[HR_ORG_LegalEntity] ADD  CONSTRAINT [DF_HR_ORG_LegalEntity_TenantID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantID]
GO
ALTER TABLE [dbo].[HR_ORG_Organization] ADD  CONSTRAINT [DF_HR_ORG_Organization_Sequence]  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[HR_ORG_Organization] ADD  CONSTRAINT [DF__HR_ORG_Or__Creat__6E01572D]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[HR_ORG_Organization] ADD  CONSTRAINT [DF__HR_ORG_Or__IsDis__778AC167]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[HR_ORG_Position] ADD  CONSTRAINT [DF_HR_ORG_Position_IsHead]  DEFAULT ((0)) FOR [IsHead]
GO
ALTER TABLE [dbo].[HR_ORG_Position] ADD  CONSTRAINT [DF_HR_ORG_Position_IsPrincipal]  DEFAULT ((0)) FOR [IsPrincipal]
GO
ALTER TABLE [dbo].[HR_ORG_Position] ADD  CONSTRAINT [DF_HR_ORG_Position_IsApprover]  DEFAULT ((0)) FOR [IsApprover]
GO
ALTER TABLE [dbo].[HR_ORG_Position] ADD  CONSTRAINT [DF_HR_ORG_Position_IsApplier]  DEFAULT ((1)) FOR [IsApplier]
GO
ALTER TABLE [dbo].[HR_ORG_Position] ADD  CONSTRAINT [DF__HR_ORG_Po__Creat__70DDC3D8]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_CodeRule] ADD  DEFAULT (newid()) FOR [RuleID]
GO
ALTER TABLE [dbo].[SYS_CodeRule] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_CodeRuleCounter] ADD  DEFAULT ((0)) FOR [CounterValue]
GO
ALTER TABLE [dbo].[SYS_CodeRuleCounter] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_COM_Attachement] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_COM_AttachmentType] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_COM_AttachmentType] ADD  CONSTRAINT [DF_SYS_COM_AttachmentType_CreateUserID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CreateUserID]
GO
ALTER TABLE [dbo].[SYS_COM_AttachmentType] ADD  CONSTRAINT [DF_SYS_COM_AttachmentType_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[SYS_COM_AttachmentType] ADD  CONSTRAINT [DF_SYS_COM_AttachmentType_LegalEntityID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [LegalEntityID]
GO
ALTER TABLE [dbo].[SYS_COM_AttachmentType] ADD  CONSTRAINT [DF_SYS_COM_AttachmentType_TenantID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TenantID]
GO
ALTER TABLE [dbo].[SYS_Dict] ADD  DEFAULT (newid()) FOR [DictID]
GO
ALTER TABLE [dbo].[SYS_Dict] ADD  DEFAULT ((1)) FOR [IsEnable]
GO
ALTER TABLE [dbo].[SYS_Dict] ADD  DEFAULT ((0)) FOR [IsCache]
GO
ALTER TABLE [dbo].[SYS_Dict] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_Dict] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[SYS_DictItem] ADD  DEFAULT (newid()) FOR [ItemID]
GO
ALTER TABLE [dbo].[SYS_DictItem] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_DictItem] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[SYS_DictItem] ADD  DEFAULT ((1)) FOR [IsEnable]
GO
ALTER TABLE [dbo].[SYS_DictItemScope] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_Message] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_MessageDeliveryDetail] ADD  DEFAULT ((0)) FOR [MaxRetryTimes]
GO
ALTER TABLE [dbo].[SYS_MessageDeliveryDetail] ADD  CONSTRAINT [DF_SYS_MessageDeliveryDetail_IsRead]  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[SYS_MessageDeliveryDetail] ADD  CONSTRAINT [DF__SYS_M__Creat__53633AE1]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_MessageScope] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_MessageTemplate] ADD  CONSTRAINT [DF__SYS_M__Creat__6AFACD50]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_RequestMaster] ADD  CONSTRAINT [DF_SYS_RequestMaster_IsNotifyResult]  DEFAULT ((0)) FOR [IsNotifyResult]
GO
ALTER TABLE [dbo].[SYS_RequestType] ADD  CONSTRAINT [DF_SYS_RequestType_CanBatchApproval]  DEFAULT ((0)) FOR [CanBatchApproval]
GO
ALTER TABLE [dbo].[SYS_RequestType] ADD  CONSTRAINT [DF_SYS_RequestType_TypeLevel]  DEFAULT ((0)) FOR [TypeLevel]
GO
ALTER TABLE [dbo].[SYS_RequestType] ADD  CONSTRAINT [DF_SYS_RequestType_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[SYS_RequestType] ADD  CONSTRAINT [DF__SYS_R__Creat__03F0984C]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[SYS_Tenant] ADD  DEFAULT (newid()) FOR [TenantID]
GO
ALTER TABLE [dbo].[SYS_Tenant] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[SYS_Tenant] ADD  DEFAULT ((1)) FOR [IsEnable]
GO
ALTER TABLE [dbo].[SYS_Tenant] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[WfTaskActivities]  WITH CHECK ADD  CONSTRAINT [FK_WfTaskProcessWfTaskActivity] FOREIGN KEY([WfTaskProcessId])
REFERENCES [dbo].[WfTaskProcesses] ([Id])
GO
ALTER TABLE [dbo].[WfTaskActivities] CHECK CONSTRAINT [FK_WfTaskProcessWfTaskActivity]
GO
ALTER TABLE [dbo].[WfTasks]  WITH CHECK ADD  CONSTRAINT [FK_WfTaskActivityWfTask] FOREIGN KEY([WfTaskActivityId])
REFERENCES [dbo].[WfTaskActivities] ([Id])
GO
ALTER TABLE [dbo].[WfTasks] CHECK CONSTRAINT [FK_WfTaskActivityWfTask]
GO
ALTER TABLE [dbo].[WfTasks]  WITH CHECK ADD  CONSTRAINT [FK_WfTaskProcessWfTask] FOREIGN KEY([WfTaskProcessId])
REFERENCES [dbo].[WfTaskProcesses] ([Id])
GO
ALTER TABLE [dbo].[WfTasks] CHECK CONSTRAINT [FK_WfTaskProcessWfTask]
GO
