USE [master]
GO
/****** Object:  Database [HangfireEnocaDb]    Script Date: 3.11.2023 15:36:27 ******/
CREATE DATABASE [HangfireEnocaDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HangfireEnocaDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\HangfireEnocaDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HangfireEnocaDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\HangfireEnocaDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [HangfireEnocaDb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HangfireEnocaDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HangfireEnocaDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HangfireEnocaDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HangfireEnocaDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HangfireEnocaDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HangfireEnocaDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET RECOVERY FULL 
GO
ALTER DATABASE [HangfireEnocaDb] SET  MULTI_USER 
GO
ALTER DATABASE [HangfireEnocaDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HangfireEnocaDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HangfireEnocaDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HangfireEnocaDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HangfireEnocaDb] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HangfireEnocaDb', N'ON'
GO
ALTER DATABASE [HangfireEnocaDb] SET QUERY_STORE = OFF
GO
USE [HangfireEnocaDb]
GO
/****** Object:  Schema [HangFire]    Script Date: 3.11.2023 15:36:27 ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [int] NOT NULL,
	[ExpireAt] [datetime] NULL,
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_HangFire_Counter] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Key] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Job]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NULL,
	[StateName] [nvarchar](20) NULL,
	[InvocationData] [nvarchar](max) NOT NULL,
	[Arguments] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Queue] [nvarchar](50) NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Queue] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[List]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Server]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](200) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Set]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Key] [nvarchar](100) NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[State]    Script Date: 3.11.2023 15:36:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:deleted', 3, NULL)
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:deleted:2023-11-02', 3, CAST(N'2023-12-02T13:57:01.043' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:deleted:2023-11-02-13', 3, CAST(N'2023-11-03T13:57:01.043' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded', 65, NULL)
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-11-02', 63, CAST(N'2023-12-02T22:37:08.313' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-11-02-13', 4, CAST(N'2023-11-03T13:37:01.207' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-11-02-14', 4, CAST(N'2023-11-03T14:16:07.503' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-11-02-15', 11, CAST(N'2023-11-03T15:24:05.353' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-11-02-21', 6, CAST(N'2023-11-03T21:59:06.840' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-11-02-22', 38, CAST(N'2023-11-03T22:37:08.313' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-11-03', 2, CAST(N'2023-12-03T11:00:13.110' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-11-03-10', 1, CAST(N'2023-11-04T10:39:59.373' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2023-11-03-11', 1, CAST(N'2023-11-04T11:00:13.110' AS DateTime))
GO
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:reportJob', N'CreatedAt', N'2023-11-02T14:12:23.2631613Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:reportJob', N'Cron', N'0 * * * *', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:reportJob', N'Job', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":"[]"}', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:reportJob', N'LastExecution', N'2023-11-03T11:00:12.6832008Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:reportJob', N'LastJobId', N'69', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:reportJob', N'NextExecution', N'2023-11-03T12:00:00.0000000Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:reportJob', N'Queue', N'default', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:reportJob', N'TimeZoneId', N'UTC', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:reportJob', N'V', N'2', NULL)
GO
SET IDENTITY_INSERT [HangFire].[Job] ON 

INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (1, 12, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=6.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Recurring!\""]', CAST(N'2023-11-02T11:38:09.137' AS DateTime), CAST(N'2023-11-03T13:37:01.210' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (2, 13, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=6.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Recurring!\""]', CAST(N'2023-11-02T11:39:09.213' AS DateTime), CAST(N'2023-11-03T13:37:01.210' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (3, 14, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=6.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Recurring!\""]', CAST(N'2023-11-02T11:40:09.253' AS DateTime), CAST(N'2023-11-03T13:37:01.210' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (4, 15, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=6.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=6.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Recurring!\""]', CAST(N'2023-11-02T13:37:01.147' AS DateTime), CAST(N'2023-11-03T13:37:01.210' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (5, 29, N'Deleted', N'{"Type":"Enoca_Dotnet_Challenge_Service.Utility.Recurring, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T13:39:09.920' AS DateTime), CAST(N'2023-11-03T13:57:01.037' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (6, 30, N'Deleted', N'{"Type":"Enoca_Dotnet_Challenge_Service.Utility.Recurring, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T13:41:06.363' AS DateTime), CAST(N'2023-11-03T13:57:01.043' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (7, 31, N'Deleted', N'{"Type":"Enoca_Dotnet_Challenge_Service.Utility.Recurring, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T13:42:06.997' AS DateTime), CAST(N'2023-11-03T13:57:01.043' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (8, 34, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T14:13:07.303' AS DateTime), CAST(N'2023-11-03T14:13:08.017' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (9, 37, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T14:14:07.377' AS DateTime), CAST(N'2023-11-03T14:14:07.403' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (10, 40, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T14:15:07.430' AS DateTime), CAST(N'2023-11-03T14:15:07.447' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (11, 43, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T14:16:07.490' AS DateTime), CAST(N'2023-11-03T14:16:07.503' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (12, 46, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:14:35.313' AS DateTime), CAST(N'2023-11-03T15:14:45.470' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (13, 49, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:15:05.743' AS DateTime), CAST(N'2023-11-03T15:15:05.823' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (14, 52, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:16:05.820' AS DateTime), CAST(N'2023-11-03T15:16:05.937' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (15, 55, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:17:04.443' AS DateTime), CAST(N'2023-11-03T15:17:10.113' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (16, 58, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:18:17.440' AS DateTime), CAST(N'2023-11-03T15:18:17.580' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (17, 61, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:19:02.500' AS DateTime), CAST(N'2023-11-03T15:19:02.600' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (18, 64, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:20:02.590' AS DateTime), CAST(N'2023-11-03T15:20:02.650' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (19, 67, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:21:02.637' AS DateTime), CAST(N'2023-11-03T15:21:02.740' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (20, 70, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:22:02.720' AS DateTime), CAST(N'2023-11-03T15:22:02.837' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (21, 73, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:23:04.707' AS DateTime), CAST(N'2023-11-03T15:23:13.520' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (22, 76, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T15:24:05.180' AS DateTime), CAST(N'2023-11-03T15:24:05.353' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (23, 79, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T21:54:06.480' AS DateTime), CAST(N'2023-11-03T21:54:08.600' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (24, 82, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T21:55:06.667' AS DateTime), CAST(N'2023-11-03T21:55:06.687' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (25, 85, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T21:56:06.720' AS DateTime), CAST(N'2023-11-03T21:56:06.750' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (26, 88, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T21:57:06.747' AS DateTime), CAST(N'2023-11-03T21:57:06.773' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (27, 91, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T21:58:06.783' AS DateTime), CAST(N'2023-11-03T21:58:06.800' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (28, 94, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T21:59:06.813' AS DateTime), CAST(N'2023-11-03T21:59:06.840' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (29, 97, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:00:06.860' AS DateTime), CAST(N'2023-11-03T22:00:06.883' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (30, 100, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:01:06.907' AS DateTime), CAST(N'2023-11-03T22:01:06.937' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (31, 103, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:02:06.967' AS DateTime), CAST(N'2023-11-03T22:02:06.990' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (32, 106, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:03:07.003' AS DateTime), CAST(N'2023-11-03T22:03:07.033' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (33, 109, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:04:07.053' AS DateTime), CAST(N'2023-11-03T22:04:07.073' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (34, 112, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:05:57.687' AS DateTime), CAST(N'2023-11-03T22:05:59.987' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (35, 115, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:06:13.570' AS DateTime), CAST(N'2023-11-03T22:06:13.787' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (36, 118, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:07:32.277' AS DateTime), CAST(N'2023-11-03T22:07:35.570' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (37, 121, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:08:09.447' AS DateTime), CAST(N'2023-11-03T22:08:11.513' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (38, 127, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:09:03.743' AS DateTime), CAST(N'2023-11-03T22:10:19.373' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (39, 126, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:10:03.180' AS DateTime), CAST(N'2023-11-03T22:10:17.263' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (40, 130, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:11:02.597' AS DateTime), CAST(N'2023-11-03T22:11:02.630' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (41, 133, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:12:02.057' AS DateTime), CAST(N'2023-11-03T22:12:04.723' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (42, 136, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:13:02.997' AS DateTime), CAST(N'2023-11-03T22:13:03.013' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (43, 139, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:14:03.037' AS DateTime), CAST(N'2023-11-03T22:14:03.057' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (44, 142, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:15:03.083' AS DateTime), CAST(N'2023-11-03T22:15:03.097' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (45, 145, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:16:07.273' AS DateTime), CAST(N'2023-11-03T22:16:09.427' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (46, 148, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:17:08.767' AS DateTime), CAST(N'2023-11-03T22:17:08.790' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (47, 151, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:18:08.817' AS DateTime), CAST(N'2023-11-03T22:18:08.830' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (48, 154, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:19:08.867' AS DateTime), CAST(N'2023-11-03T22:19:08.880' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (49, 157, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:20:11.267' AS DateTime), CAST(N'2023-11-03T22:20:11.667' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (50, 160, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:21:11.373' AS DateTime), CAST(N'2023-11-03T22:21:11.410' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (51, 163, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:22:12.203' AS DateTime), CAST(N'2023-11-03T22:22:12.233' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (52, 166, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:23:43.920' AS DateTime), CAST(N'2023-11-03T22:23:46.120' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (53, NULL, NULL, N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:24:03.580' AS DateTime), CAST(N'2023-12-02T22:24:03.580' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (54, 169, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:24:34.507' AS DateTime), CAST(N'2023-11-03T22:24:36.680' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (55, 172, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:25:08.080' AS DateTime), CAST(N'2023-11-03T22:25:08.173' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (56, 191, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:26:08.123' AS DateTime), CAST(N'2023-11-03T22:31:08.260' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (57, 177, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:27:59.610' AS DateTime), CAST(N'2023-11-03T22:28:01.987' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (58, 180, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:28:17.817' AS DateTime), CAST(N'2023-11-03T22:28:31.940' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (59, 183, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:29:07.980' AS DateTime), CAST(N'2023-11-03T22:29:07.997' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (60, 186, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:30:08.010' AS DateTime), CAST(N'2023-11-03T22:30:08.027' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (61, 189, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:31:08.043' AS DateTime), CAST(N'2023-11-03T22:31:08.060' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (62, 194, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:32:08.090' AS DateTime), CAST(N'2023-11-03T22:32:08.110' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (63, 197, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:33:08.123' AS DateTime), CAST(N'2023-11-03T22:33:08.147' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (64, 200, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:34:08.153' AS DateTime), CAST(N'2023-11-03T22:34:08.170' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (65, 203, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:35:08.190' AS DateTime), CAST(N'2023-11-03T22:35:08.220' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (66, 206, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:36:08.240' AS DateTime), CAST(N'2023-11-03T22:36:08.267' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (67, 209, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-02T22:37:08.283' AS DateTime), CAST(N'2023-11-03T22:37:08.313' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (68, 212, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-03T10:39:57.357' AS DateTime), CAST(N'2023-11-04T10:39:59.377' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (69, 215, N'Succeeded', N'{"Type":"Enoca_Dotnet_Challenge_Service.Services.CarrierReportService, Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"Report","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2023-11-03T11:00:12.767' AS DateTime), CAST(N'2023-11-04T11:00:13.113' AS DateTime))
SET IDENTITY_INSERT [HangFire].[Job] OFF
GO
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (1, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (1, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (1, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (1, N'Time', N'1698925089')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (2, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (2, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (2, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (2, N'Time', N'1698925149')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (3, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (3, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (3, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (3, N'Time', N'1698925209')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (4, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (4, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (4, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (4, N'Time', N'1698932221')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (5, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (5, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (5, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (5, N'RetryCount', N'1')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (5, N'Time', N'1698932349')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (6, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (6, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (6, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (6, N'RetryCount', N'1')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (6, N'Time', N'1698932466')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'RetryCount', N'1')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'Time', N'1698932526')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (8, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (8, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (8, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (8, N'Time', N'1698934387')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (9, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (9, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (9, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (9, N'Time', N'1698934447')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (10, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (10, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (10, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (10, N'Time', N'1698934507')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (11, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (11, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (11, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (11, N'Time', N'1698934567')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (12, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (12, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (12, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (12, N'Time', N'1698938074')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (13, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (13, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (13, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (13, N'Time', N'1698938105')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (14, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (14, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (14, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (14, N'Time', N'1698938165')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (15, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (15, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (15, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (15, N'Time', N'1698938224')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (16, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (16, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (16, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (16, N'Time', N'1698938297')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (17, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (17, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (17, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (17, N'Time', N'1698938342')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (18, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (18, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (18, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (18, N'Time', N'1698938402')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (19, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (19, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (19, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (19, N'Time', N'1698938462')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (20, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (20, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (20, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (20, N'Time', N'1698938522')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (21, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (21, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (21, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (21, N'Time', N'1698938584')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (22, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (22, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (22, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (22, N'Time', N'1698938645')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (23, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (23, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (23, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (23, N'Time', N'1698962046')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (24, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (24, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (24, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (24, N'Time', N'1698962106')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (25, N'CurrentCulture', N'"tr-TR"')
GO
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (25, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (25, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (25, N'Time', N'1698962166')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (26, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (26, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (26, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (26, N'Time', N'1698962226')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (27, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (27, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (27, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (27, N'Time', N'1698962286')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (28, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (28, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (28, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (28, N'Time', N'1698962346')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (29, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (29, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (29, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (29, N'Time', N'1698962406')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (30, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (30, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (30, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (30, N'Time', N'1698962466')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (31, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (31, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (31, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (31, N'Time', N'1698962526')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (32, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (32, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (32, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (32, N'Time', N'1698962587')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (33, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (33, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (33, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (33, N'Time', N'1698962647')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (34, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (34, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (34, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (34, N'Time', N'1698962757')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (35, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (35, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (35, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (35, N'Time', N'1698962773')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (36, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (36, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (36, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (36, N'Time', N'1698962852')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (37, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (37, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (37, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (37, N'Time', N'1698962889')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (38, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (38, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (38, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (38, N'Time', N'1698962943')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (39, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (39, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (39, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (39, N'Time', N'1698963003')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (40, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (40, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (40, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (40, N'Time', N'1698963062')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (41, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (41, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (41, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (41, N'Time', N'1698963122')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (42, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (42, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (42, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (42, N'Time', N'1698963182')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (43, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (43, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (43, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (43, N'Time', N'1698963243')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (44, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (44, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (44, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (44, N'Time', N'1698963303')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (45, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (45, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (45, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (45, N'Time', N'1698963367')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (46, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (46, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (46, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (46, N'Time', N'1698963428')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (47, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (47, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (47, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (47, N'Time', N'1698963488')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (48, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (48, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (48, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (48, N'Time', N'1698963548')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (49, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (49, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (49, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (49, N'Time', N'1698963611')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (50, N'CurrentCulture', N'"tr-TR"')
GO
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (50, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (50, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (50, N'Time', N'1698963671')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (51, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (51, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (51, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (51, N'Time', N'1698963732')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (52, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (52, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (52, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (52, N'Time', N'1698963823')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (53, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (53, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (53, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (53, N'Time', N'1698963843')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (54, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (54, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (54, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (54, N'Time', N'1698963874')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (55, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (55, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (55, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (55, N'Time', N'1698963908')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (56, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (56, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (56, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (56, N'Time', N'1698963968')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (57, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (57, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (57, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (57, N'Time', N'1698964079')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (58, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (58, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (58, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (58, N'Time', N'1698964095')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (59, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (59, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (59, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (59, N'Time', N'1698964147')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (60, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (60, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (60, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (60, N'Time', N'1698964208')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (61, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (61, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (61, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (61, N'Time', N'1698964268')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (62, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (62, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (62, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (62, N'Time', N'1698964328')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (63, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (63, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (63, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (63, N'Time', N'1698964388')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (64, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (64, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (64, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (64, N'Time', N'1698964448')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (65, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (65, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (65, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (65, N'Time', N'1698964508')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (66, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (66, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (66, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (66, N'Time', N'1698964568')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (67, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (67, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (67, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (67, N'Time', N'1698964628')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (68, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (68, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (68, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (68, N'Time', N'1699007997')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (69, N'CurrentCulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (69, N'CurrentUICulture', N'"tr-TR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (69, N'RecurringJobId', N'"reportJob"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (69, N'Time', N'1699009212')
GO
INSERT [HangFire].[Schema] ([Version]) VALUES (9)
GO
INSERT [HangFire].[Server] ([Id], [Data], [LastHeartbeat]) VALUES (N'desktop-nvk7fit:14064:deb4bd28-d11f-4a09-8bdf-4ef85e73e041', N'{"WorkerCount":20,"Queues":["default"],"StartedAt":"2023-11-03T10:52:12.0169981Z"}', CAST(N'2023-11-03T11:12:12.767' AS DateTime))
GO
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'recurring-jobs', 1699012800, N'reportJob', NULL)
GO
SET IDENTITY_INSERT [HangFire].[State] ON 

INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (1, 1, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T11:38:09.157' AS DateTime), N'{"EnqueuedAt":"2023-11-02T11:38:09.1495224Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (2, 1, N'Processing', NULL, CAST(N'2023-11-02T11:38:09.247' AS DateTime), N'{"StartedAt":"2023-11-02T11:38:09.1736042Z","ServerId":"desktop-nvk7fit:16064:b93f6494-fe25-4a61-abcf-b5b09e124909","WorkerId":"9fba081e-8133-4ec6-93ce-09e09c019583"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (8, 1, N'Processing', NULL, CAST(N'2023-11-02T13:37:01.140' AS DateTime), N'{"StartedAt":"2023-11-02T13:37:01.0493567Z","ServerId":"desktop-nvk7fit:23508:e3ba927f-c223-400e-9b87-bc788cf5b599","WorkerId":"31c7016e-88ac-4013-b399-27cd098981e9"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (12, 1, N'Succeeded', NULL, CAST(N'2023-11-02T13:37:01.210' AS DateTime), N'{"SucceededAt":"2023-11-02T13:37:01.2045290Z","PerformanceDuration":"7","Latency":"7132059"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (3, 2, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T11:39:09.217' AS DateTime), N'{"EnqueuedAt":"2023-11-02T11:39:09.2155029Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (4, 2, N'Processing', NULL, CAST(N'2023-11-02T11:39:09.217' AS DateTime), N'{"StartedAt":"2023-11-02T11:39:09.2173797Z","ServerId":"desktop-nvk7fit:16064:b93f6494-fe25-4a61-abcf-b5b09e124909","WorkerId":"6ce35d41-9742-423d-8b55-47b3423f633b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (7, 2, N'Processing', NULL, CAST(N'2023-11-02T13:37:01.140' AS DateTime), N'{"StartedAt":"2023-11-02T13:37:01.0493597Z","ServerId":"desktop-nvk7fit:23508:e3ba927f-c223-400e-9b87-bc788cf5b599","WorkerId":"0892fd42-c895-470d-a0b0-9df6a1d1bb5e"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (13, 2, N'Succeeded', NULL, CAST(N'2023-11-02T13:37:01.210' AS DateTime), N'{"SucceededAt":"2023-11-02T13:37:01.2045088Z","PerformanceDuration":"7","Latency":"7071983"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (5, 3, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T11:40:09.253' AS DateTime), N'{"EnqueuedAt":"2023-11-02T11:40:09.2528303Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (6, 3, N'Processing', NULL, CAST(N'2023-11-02T11:40:09.253' AS DateTime), N'{"StartedAt":"2023-11-02T11:40:09.2540757Z","ServerId":"desktop-nvk7fit:16064:b93f6494-fe25-4a61-abcf-b5b09e124909","WorkerId":"2e38b0c2-110f-4e31-a3b3-866c9c9240d3"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (10, 3, N'Processing', NULL, CAST(N'2023-11-02T13:37:01.140' AS DateTime), N'{"StartedAt":"2023-11-02T13:37:01.0493510Z","ServerId":"desktop-nvk7fit:23508:e3ba927f-c223-400e-9b87-bc788cf5b599","WorkerId":"967ccf18-1f3f-4839-8466-b95943759cc4"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (14, 3, N'Succeeded', NULL, CAST(N'2023-11-02T13:37:01.210' AS DateTime), N'{"SucceededAt":"2023-11-02T13:37:01.2045136Z","PerformanceDuration":"7","Latency":"7011943"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (9, 4, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T13:37:01.157' AS DateTime), N'{"EnqueuedAt":"2023-11-02T13:37:01.1566078Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (11, 4, N'Processing', NULL, CAST(N'2023-11-02T13:37:01.197' AS DateTime), N'{"StartedAt":"2023-11-02T13:37:01.1953240Z","ServerId":"desktop-nvk7fit:23508:e3ba927f-c223-400e-9b87-bc788cf5b599","WorkerId":"2a24a885-ec74-4898-8340-3a9cab743c78"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (15, 4, N'Succeeded', NULL, CAST(N'2023-11-02T13:37:01.210' AS DateTime), N'{"SucceededAt":"2023-11-02T13:37:01.2045048Z","PerformanceDuration":"7","Latency":"49"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (16, 5, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T13:39:09.937' AS DateTime), N'{"EnqueuedAt":"2023-11-02T13:39:09.9285774Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (17, 5, N'Processing', NULL, CAST(N'2023-11-02T13:39:10.070' AS DateTime), N'{"StartedAt":"2023-11-02T13:39:09.9967896Z","ServerId":"desktop-nvk7fit:24308:d1cac7aa-e238-4515-857f-e078e565c281","WorkerId":"29ba9bca-bfb7-4155-9bbc-8d877db52ce7"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (22, 5, N'Processing', NULL, CAST(N'2023-11-02T13:44:10.243' AS DateTime), N'{"StartedAt":"2023-11-02T13:44:10.2048586Z","ServerId":"desktop-nvk7fit:20100:a1623fe1-007a-48bd-9ab9-8edded0e181d","WorkerId":"83eaf4ed-4b18-40c0-ada1-e0cf3137abb3"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (23, 5, N'Failed', N'Can not change the state to ''Processing'': target method was not found.', CAST(N'2023-11-02T13:56:38.567' AS DateTime), N'{"FailedAt":"2023-11-02T13:56:38.5388810Z","ExceptionType":"System.TypeLoadException","ExceptionMessage":"Could not load type ''Enoca_Dotnet_Challenge_Service.Utility.Recurring'' from assembly ''Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null''.","ExceptionDetails":"System.TypeLoadException: Could not load type ''Enoca_Dotnet_Challenge_Service.Utility.Recurring'' from assembly ''Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null''.\r\n   at System.Reflection.RuntimeAssembly.GetType(QCallAssembly assembly, String name, Boolean throwOnError, Boolean ignoreCase, ObjectHandleOnStack type, ObjectHandleOnStack keepAlive, ObjectHandleOnStack assemblyLoadContext)\r\n   at System.Reflection.RuntimeAssembly.GetType(String name, Boolean throwOnError, Boolean ignoreCase)\r\n   at System.TypeNameParser.ResolveType(Assembly assembly, String[] names, Func`4 typeResolver, Boolean throwOnError, Boolean ignoreCase, StackCrawlMark& stackMark)\r\n   at System.TypeNameParser.ConstructType(Func`2 assemblyResolver, Func`4 typeResolver, Boolean throwOnError, Boolean ignoreCase, StackCrawlMark& stackMark)\r\n   at System.TypeNameParser.GetType(String typeName, Func`2 assemblyResolver, Func`4 typeResolver, Boolean throwOnError, Boolean ignoreCase, StackCrawlMark& stackMark)\r\n   at System.Type.GetType(String typeName, Func`2 assemblyResolver, Func`4 typeResolver, Boolean throwOnError)\r\n   at Hangfire.Common.TypeHelper.DefaultTypeResolver(String typeName)\r\n   at Hangfire.Storage.InvocationData.DeserializeJob()","ServerId":"desktop-nvk7fit:2308:2e187647-74b4-49dd-93b9-32cda33982bd"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (28, 5, N'Scheduled', N'Retry attempt 1 of 10: Could not load type ''Enoca_Dotnet_Challenge_Servi…', CAST(N'2023-11-02T13:56:38.583' AS DateTime), N'{"EnqueueAt":"2023-11-02T13:57:12.5599582Z","ScheduledAt":"2023-11-02T13:56:38.5599772Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (29, 5, N'Deleted', N'Triggered via Dashboard UI', CAST(N'2023-11-02T13:57:01.037' AS DateTime), N'{"DeletedAt":"2023-11-02T13:57:01.0299128Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (18, 6, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T13:41:06.380' AS DateTime), N'{"EnqueuedAt":"2023-11-02T13:41:06.3731094Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (19, 6, N'Processing', NULL, CAST(N'2023-11-02T13:41:06.413' AS DateTime), N'{"StartedAt":"2023-11-02T13:41:06.3878423Z","ServerId":"desktop-nvk7fit:6636:b228d429-2997-472a-be28-b60907019716","WorkerId":"f0bab80c-5798-4717-8c41-93066833170b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (25, 6, N'Failed', N'Can not change the state to ''Processing'': target method was not found.', CAST(N'2023-11-02T13:56:38.567' AS DateTime), N'{"FailedAt":"2023-11-02T13:56:38.5388896Z","ExceptionType":"System.TypeLoadException","ExceptionMessage":"Could not load type ''Enoca_Dotnet_Challenge_Service.Utility.Recurring'' from assembly ''Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null''.","ExceptionDetails":"System.TypeLoadException: Could not load type ''Enoca_Dotnet_Challenge_Service.Utility.Recurring'' from assembly ''Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null''.\r\n   at System.Reflection.RuntimeAssembly.GetType(QCallAssembly assembly, String name, Boolean throwOnError, Boolean ignoreCase, ObjectHandleOnStack type, ObjectHandleOnStack keepAlive, ObjectHandleOnStack assemblyLoadContext)\r\n   at System.Reflection.RuntimeAssembly.GetType(String name, Boolean throwOnError, Boolean ignoreCase)\r\n   at System.TypeNameParser.ResolveType(Assembly assembly, String[] names, Func`4 typeResolver, Boolean throwOnError, Boolean ignoreCase, StackCrawlMark& stackMark)\r\n   at System.TypeNameParser.ConstructType(Func`2 assemblyResolver, Func`4 typeResolver, Boolean throwOnError, Boolean ignoreCase, StackCrawlMark& stackMark)\r\n   at System.TypeNameParser.GetType(String typeName, Func`2 assemblyResolver, Func`4 typeResolver, Boolean throwOnError, Boolean ignoreCase, StackCrawlMark& stackMark)\r\n   at System.Type.GetType(String typeName, Func`2 assemblyResolver, Func`4 typeResolver, Boolean throwOnError)\r\n   at Hangfire.Common.TypeHelper.DefaultTypeResolver(String typeName)\r\n   at Hangfire.Storage.InvocationData.DeserializeJob()","ServerId":"desktop-nvk7fit:2308:2e187647-74b4-49dd-93b9-32cda33982bd"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (26, 6, N'Scheduled', N'Retry attempt 1 of 10: Could not load type ''Enoca_Dotnet_Challenge_Servi…', CAST(N'2023-11-02T13:56:38.583' AS DateTime), N'{"EnqueueAt":"2023-11-02T13:56:54.5599583Z","ScheduledAt":"2023-11-02T13:56:38.5599992Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (30, 6, N'Deleted', N'Triggered via Dashboard UI', CAST(N'2023-11-02T13:57:01.040' AS DateTime), N'{"DeletedAt":"2023-11-02T13:57:01.0406754Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (20, 7, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T13:42:07.013' AS DateTime), N'{"EnqueuedAt":"2023-11-02T13:42:07.0072296Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (21, 7, N'Processing', NULL, CAST(N'2023-11-02T13:42:07.093' AS DateTime), N'{"StartedAt":"2023-11-02T13:42:07.0704405Z","ServerId":"desktop-nvk7fit:4056:792731cd-c09e-4828-b7d6-410f1e652d50","WorkerId":"7a2301de-ae74-4957-83c9-9192cbc0997b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (24, 7, N'Failed', N'Can not change the state to ''Processing'': target method was not found.', CAST(N'2023-11-02T13:56:38.567' AS DateTime), N'{"FailedAt":"2023-11-02T13:56:38.5388715Z","ExceptionType":"System.TypeLoadException","ExceptionMessage":"Could not load type ''Enoca_Dotnet_Challenge_Service.Utility.Recurring'' from assembly ''Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null''.","ExceptionDetails":"System.TypeLoadException: Could not load type ''Enoca_Dotnet_Challenge_Service.Utility.Recurring'' from assembly ''Enoca_Dotnet_Challenge_Service, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null''.\r\n   at System.Reflection.RuntimeAssembly.GetType(QCallAssembly assembly, String name, Boolean throwOnError, Boolean ignoreCase, ObjectHandleOnStack type, ObjectHandleOnStack keepAlive, ObjectHandleOnStack assemblyLoadContext)\r\n   at System.Reflection.RuntimeAssembly.GetType(String name, Boolean throwOnError, Boolean ignoreCase)\r\n   at System.TypeNameParser.ResolveType(Assembly assembly, String[] names, Func`4 typeResolver, Boolean throwOnError, Boolean ignoreCase, StackCrawlMark& stackMark)\r\n   at System.TypeNameParser.ConstructType(Func`2 assemblyResolver, Func`4 typeResolver, Boolean throwOnError, Boolean ignoreCase, StackCrawlMark& stackMark)\r\n   at System.TypeNameParser.GetType(String typeName, Func`2 assemblyResolver, Func`4 typeResolver, Boolean throwOnError, Boolean ignoreCase, StackCrawlMark& stackMark)\r\n   at System.Type.GetType(String typeName, Func`2 assemblyResolver, Func`4 typeResolver, Boolean throwOnError)\r\n   at Hangfire.Common.TypeHelper.DefaultTypeResolver(String typeName)\r\n   at Hangfire.Storage.InvocationData.DeserializeJob()","ServerId":"desktop-nvk7fit:2308:2e187647-74b4-49dd-93b9-32cda33982bd"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (27, 7, N'Scheduled', N'Retry attempt 1 of 10: Could not load type ''Enoca_Dotnet_Challenge_Servi…', CAST(N'2023-11-02T13:56:38.583' AS DateTime), N'{"EnqueueAt":"2023-11-02T13:57:07.5599579Z","ScheduledAt":"2023-11-02T13:56:38.5599994Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (31, 7, N'Deleted', N'Triggered via Dashboard UI', CAST(N'2023-11-02T13:57:01.043' AS DateTime), N'{"DeletedAt":"2023-11-02T13:57:01.0422761Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (32, 8, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T14:13:07.320' AS DateTime), N'{"EnqueuedAt":"2023-11-02T14:13:07.3112440Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (33, 8, N'Processing', NULL, CAST(N'2023-11-02T14:13:07.350' AS DateTime), N'{"StartedAt":"2023-11-02T14:13:07.3262870Z","ServerId":"desktop-nvk7fit:24584:585f8ab8-fd14-470c-a796-3814ba7a07ff","WorkerId":"0807b437-48da-4c0c-8d6c-712490862cc4"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (34, 8, N'Succeeded', NULL, CAST(N'2023-11-02T14:13:08.013' AS DateTime), N'{"SucceededAt":"2023-11-02T14:13:08.0096109Z","PerformanceDuration":"655","Latency":"51","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (35, 9, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T14:14:07.380' AS DateTime), N'{"EnqueuedAt":"2023-11-02T14:14:07.3784143Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (36, 9, N'Processing', NULL, CAST(N'2023-11-02T14:14:07.380' AS DateTime), N'{"StartedAt":"2023-11-02T14:14:07.3798807Z","ServerId":"desktop-nvk7fit:24584:585f8ab8-fd14-470c-a796-3814ba7a07ff","WorkerId":"aa252697-7e7e-492d-967a-049e64236b47"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (37, 9, N'Succeeded', NULL, CAST(N'2023-11-02T14:14:07.403' AS DateTime), N'{"SucceededAt":"2023-11-02T14:14:07.4024878Z","PerformanceDuration":"21","Latency":"3","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (38, 10, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T14:15:07.430' AS DateTime), N'{"EnqueuedAt":"2023-11-02T14:15:07.4307401Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (39, 10, N'Processing', NULL, CAST(N'2023-11-02T14:15:07.433' AS DateTime), N'{"StartedAt":"2023-11-02T14:15:07.4326713Z","ServerId":"desktop-nvk7fit:24584:585f8ab8-fd14-470c-a796-3814ba7a07ff","WorkerId":"af20ec2b-56d2-4756-8168-4af39b22dd5a"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (40, 10, N'Succeeded', NULL, CAST(N'2023-11-02T14:15:07.447' AS DateTime), N'{"SucceededAt":"2023-11-02T14:15:07.4464855Z","PerformanceDuration":"12","Latency":"3","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (41, 11, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T14:16:07.490' AS DateTime), N'{"EnqueuedAt":"2023-11-02T14:16:07.4901295Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (42, 11, N'Processing', NULL, CAST(N'2023-11-02T14:16:07.493' AS DateTime), N'{"StartedAt":"2023-11-02T14:16:07.4916119Z","ServerId":"desktop-nvk7fit:24584:585f8ab8-fd14-470c-a796-3814ba7a07ff","WorkerId":"0de573cc-c6ac-4877-a172-81bb8fb2ad2f"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (43, 11, N'Succeeded', NULL, CAST(N'2023-11-02T14:16:07.503' AS DateTime), N'{"SucceededAt":"2023-11-02T14:16:07.5016909Z","PerformanceDuration":"9","Latency":"2","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (44, 12, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:14:35.410' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:14:35.3755677Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (45, 12, N'Processing', NULL, CAST(N'2023-11-02T15:14:36.103' AS DateTime), N'{"StartedAt":"2023-11-02T15:14:35.7233780Z","ServerId":"desktop-nvk7fit:5640:686d3029-594c-4b28-b541-7fbfb30948b0","WorkerId":"185f265c-81c7-4bcf-91f6-218715da03cd"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (46, 12, N'Succeeded', NULL, CAST(N'2023-11-02T15:14:45.457' AS DateTime), N'{"SucceededAt":"2023-11-02T15:14:45.4358839Z","PerformanceDuration":"9317","Latency":"804","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (47, 13, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:15:05.747' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:15:05.7464645Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (48, 13, N'Processing', NULL, CAST(N'2023-11-02T15:15:05.753' AS DateTime), N'{"StartedAt":"2023-11-02T15:15:05.7519075Z","ServerId":"desktop-nvk7fit:5640:686d3029-594c-4b28-b541-7fbfb30948b0","WorkerId":"b68d391e-97cc-4d7b-8c93-3456a6d3c0a2"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (49, 13, N'Succeeded', NULL, CAST(N'2023-11-02T15:15:05.823' AS DateTime), N'{"SucceededAt":"2023-11-02T15:15:05.8209165Z","PerformanceDuration":"65","Latency":"12","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (50, 14, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:16:05.857' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:16:05.8563038Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (51, 14, N'Processing', NULL, CAST(N'2023-11-02T15:16:05.863' AS DateTime), N'{"StartedAt":"2023-11-02T15:16:05.8617899Z","ServerId":"desktop-nvk7fit:5640:686d3029-594c-4b28-b541-7fbfb30948b0","WorkerId":"2a4847b3-9574-4549-89fd-8ebb041d958a"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (52, 14, N'Succeeded', NULL, CAST(N'2023-11-02T15:16:05.937' AS DateTime), N'{"SucceededAt":"2023-11-02T15:16:05.9343649Z","PerformanceDuration":"68","Latency":"46","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (53, 15, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:17:04.550' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:17:04.5197574Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (54, 15, N'Processing', NULL, CAST(N'2023-11-02T15:17:05.020' AS DateTime), N'{"StartedAt":"2023-11-02T15:17:04.7684466Z","ServerId":"desktop-nvk7fit:15536:9f0e6d01-5c93-4f66-a506-329aad0d7366","WorkerId":"3eb77021-baab-49c9-9335-fe26844a6355"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (55, 15, N'Succeeded', NULL, CAST(N'2023-11-02T15:17:10.097' AS DateTime), N'{"SucceededAt":"2023-11-02T15:17:10.0792132Z","PerformanceDuration":"5049","Latency":"586","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (56, 16, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:18:17.440' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:18:17.4412356Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (57, 16, N'Processing', NULL, CAST(N'2023-11-02T15:18:17.450' AS DateTime), N'{"StartedAt":"2023-11-02T15:18:17.4479623Z","ServerId":"desktop-nvk7fit:15536:9f0e6d01-5c93-4f66-a506-329aad0d7366","WorkerId":"57c16a05-acfb-4a73-be28-5b7f8031c87b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (58, 16, N'Succeeded', NULL, CAST(N'2023-11-02T15:18:17.580' AS DateTime), N'{"SucceededAt":"2023-11-02T15:18:17.5770208Z","PerformanceDuration":"124","Latency":"12","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (59, 17, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:19:02.537' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:19:02.5357042Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (60, 17, N'Processing', NULL, CAST(N'2023-11-02T15:19:02.543' AS DateTime), N'{"StartedAt":"2023-11-02T15:19:02.5411441Z","ServerId":"desktop-nvk7fit:15536:9f0e6d01-5c93-4f66-a506-329aad0d7366","WorkerId":"f079881f-7325-4a34-ad9d-3e23babafb65"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (61, 17, N'Succeeded', NULL, CAST(N'2023-11-02T15:19:02.600' AS DateTime), N'{"SucceededAt":"2023-11-02T15:19:02.5961577Z","PerformanceDuration":"51","Latency":"45","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (62, 18, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:20:02.593' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:20:02.5936436Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (63, 18, N'Processing', NULL, CAST(N'2023-11-02T15:20:02.600' AS DateTime), N'{"StartedAt":"2023-11-02T15:20:02.5999923Z","ServerId":"desktop-nvk7fit:15536:9f0e6d01-5c93-4f66-a506-329aad0d7366","WorkerId":"935c9197-304a-4d6d-948a-14fdc26bb087"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (64, 18, N'Succeeded', NULL, CAST(N'2023-11-02T15:20:02.650' AS DateTime), N'{"SucceededAt":"2023-11-02T15:20:02.6481597Z","PerformanceDuration":"44","Latency":"14","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (65, 19, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:21:02.673' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:21:02.6742626Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (66, 19, N'Processing', NULL, CAST(N'2023-11-02T15:21:02.680' AS DateTime), N'{"StartedAt":"2023-11-02T15:21:02.6795392Z","ServerId":"desktop-nvk7fit:15536:9f0e6d01-5c93-4f66-a506-329aad0d7366","WorkerId":"49e51196-ed6e-4849-9016-6eb9afe9c4b6"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (67, 19, N'Succeeded', NULL, CAST(N'2023-11-02T15:21:02.740' AS DateTime), N'{"SucceededAt":"2023-11-02T15:21:02.7390611Z","PerformanceDuration":"54","Latency":"47","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (68, 20, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:22:02.757' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:22:02.7565928Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (69, 20, N'Processing', NULL, CAST(N'2023-11-02T15:22:02.763' AS DateTime), N'{"StartedAt":"2023-11-02T15:22:02.7617656Z","ServerId":"desktop-nvk7fit:15536:9f0e6d01-5c93-4f66-a506-329aad0d7366","WorkerId":"56d2d810-e26e-4e28-971e-d4ad8fafddb8"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (70, 20, N'Succeeded', NULL, CAST(N'2023-11-02T15:22:02.837' AS DateTime), N'{"SucceededAt":"2023-11-02T15:22:02.8331098Z","PerformanceDuration":"66","Latency":"46","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (71, 21, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:23:04.803' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:23:04.7697531Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (72, 21, N'Processing', NULL, CAST(N'2023-11-02T15:23:05.500' AS DateTime), N'{"StartedAt":"2023-11-02T15:23:05.1515353Z","ServerId":"desktop-nvk7fit:14360:981edf4f-c682-4238-ab31-44c2859db207","WorkerId":"9f295ad9-e79a-4856-94d2-7046fc3a920e"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (73, 21, N'Succeeded', NULL, CAST(N'2023-11-02T15:23:13.500' AS DateTime), N'{"SucceededAt":"2023-11-02T15:23:13.4772361Z","PerformanceDuration":"7928","Latency":"841","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (74, 22, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T15:24:05.217' AS DateTime), N'{"EnqueuedAt":"2023-11-02T15:24:05.2155550Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (75, 22, N'Processing', NULL, CAST(N'2023-11-02T15:24:05.223' AS DateTime), N'{"StartedAt":"2023-11-02T15:24:05.2217319Z","ServerId":"desktop-nvk7fit:14360:981edf4f-c682-4238-ab31-44c2859db207","WorkerId":"71cc8b26-6254-4dbf-8e5b-9081eba04b47"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (76, 22, N'Succeeded', NULL, CAST(N'2023-11-02T15:24:05.353' AS DateTime), N'{"SucceededAt":"2023-11-02T15:24:05.3493869Z","PerformanceDuration":"122","Latency":"46","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (77, 23, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T21:54:06.503' AS DateTime), N'{"EnqueuedAt":"2023-11-02T21:54:06.4944303Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (78, 23, N'Processing', NULL, CAST(N'2023-11-02T21:54:06.717' AS DateTime), N'{"StartedAt":"2023-11-02T21:54:06.6108432Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"869647be-ce0b-4bd5-a233-36875a355dd6"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (79, 23, N'Succeeded', NULL, CAST(N'2023-11-02T21:54:08.597' AS DateTime), N'{"SucceededAt":"2023-11-02T21:54:08.5917235Z","PerformanceDuration":"1870","Latency":"240","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (80, 24, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T21:55:06.667' AS DateTime), N'{"EnqueuedAt":"2023-11-02T21:55:06.6678885Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (81, 24, N'Processing', NULL, CAST(N'2023-11-02T21:55:06.670' AS DateTime), N'{"StartedAt":"2023-11-02T21:55:06.6694973Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"9a252148-31ef-4011-8f1d-c6fd597fdeb8"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (82, 24, N'Succeeded', NULL, CAST(N'2023-11-02T21:55:06.687' AS DateTime), N'{"SucceededAt":"2023-11-02T21:55:06.6872767Z","PerformanceDuration":"16","Latency":"4","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (83, 25, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T21:56:06.723' AS DateTime), N'{"EnqueuedAt":"2023-11-02T21:56:06.7226354Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (84, 25, N'Processing', NULL, CAST(N'2023-11-02T21:56:06.723' AS DateTime), N'{"StartedAt":"2023-11-02T21:56:06.7238384Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"6cdf5332-a9c4-4580-bbee-3f113673eeb9"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (85, 25, N'Succeeded', NULL, CAST(N'2023-11-02T21:56:06.750' AS DateTime), N'{"SucceededAt":"2023-11-02T21:56:06.7505092Z","PerformanceDuration":"25","Latency":"4","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (86, 26, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T21:57:06.750' AS DateTime), N'{"EnqueuedAt":"2023-11-02T21:57:06.7505613Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (87, 26, N'Processing', NULL, CAST(N'2023-11-02T21:57:06.753' AS DateTime), N'{"StartedAt":"2023-11-02T21:57:06.7522572Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"fa309fa4-b8f2-42b0-bcc5-e0f70bb3a024"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (88, 26, N'Succeeded', NULL, CAST(N'2023-11-02T21:57:06.773' AS DateTime), N'{"SucceededAt":"2023-11-02T21:57:06.7695379Z","PerformanceDuration":"16","Latency":"6","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (89, 27, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T21:58:06.787' AS DateTime), N'{"EnqueuedAt":"2023-11-02T21:58:06.7855620Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (90, 27, N'Processing', NULL, CAST(N'2023-11-02T21:58:06.787' AS DateTime), N'{"StartedAt":"2023-11-02T21:58:06.7870359Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"45cb498e-7338-44e9-a654-ebc992c87bfd"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (91, 27, N'Succeeded', NULL, CAST(N'2023-11-02T21:58:06.800' AS DateTime), N'{"SucceededAt":"2023-11-02T21:58:06.7996100Z","PerformanceDuration":"11","Latency":"5","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (92, 28, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T21:59:06.817' AS DateTime), N'{"EnqueuedAt":"2023-11-02T21:59:06.8167371Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (93, 28, N'Processing', NULL, CAST(N'2023-11-02T21:59:06.820' AS DateTime), N'{"StartedAt":"2023-11-02T21:59:06.8184792Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"1d52cf70-66ec-4d59-8a8f-4b5cb83c56f0"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (94, 28, N'Succeeded', NULL, CAST(N'2023-11-02T21:59:06.840' AS DateTime), N'{"SucceededAt":"2023-11-02T21:59:06.8364738Z","PerformanceDuration":"16","Latency":"6","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (95, 29, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:00:06.860' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:00:06.8614758Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (96, 29, N'Processing', NULL, CAST(N'2023-11-02T22:00:06.863' AS DateTime), N'{"StartedAt":"2023-11-02T22:00:06.8632414Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"38e06794-30b2-40c2-97d7-11318abfa898"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (97, 29, N'Succeeded', NULL, CAST(N'2023-11-02T22:00:06.883' AS DateTime), N'{"SucceededAt":"2023-11-02T22:00:06.8791782Z","PerformanceDuration":"14","Latency":"4","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (98, 30, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:01:06.910' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:01:06.9092542Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (99, 30, N'Processing', NULL, CAST(N'2023-11-02T22:01:06.913' AS DateTime), N'{"StartedAt":"2023-11-02T22:01:06.9131968Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"c9716fb7-1401-43c9-a1be-e0479e8dd554"}')
GO
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (100, 30, N'Succeeded', NULL, CAST(N'2023-11-02T22:01:06.937' AS DateTime), N'{"SucceededAt":"2023-11-02T22:01:06.9350864Z","PerformanceDuration":"19","Latency":"8","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (101, 31, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:02:06.970' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:02:06.9694337Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (102, 31, N'Processing', NULL, CAST(N'2023-11-02T22:02:06.970' AS DateTime), N'{"StartedAt":"2023-11-02T22:02:06.9708130Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"83afd919-4485-4892-88fe-010cb8186ef4"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (103, 31, N'Succeeded', NULL, CAST(N'2023-11-02T22:02:06.990' AS DateTime), N'{"SucceededAt":"2023-11-02T22:02:06.9886275Z","PerformanceDuration":"16","Latency":"5","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (104, 32, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:03:07.003' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:03:07.0042955Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (105, 32, N'Processing', NULL, CAST(N'2023-11-02T22:03:07.007' AS DateTime), N'{"StartedAt":"2023-11-02T22:03:07.0059673Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"aaac26d7-8a15-4468-8b14-bb46b87be883"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (106, 32, N'Succeeded', NULL, CAST(N'2023-11-02T22:03:07.033' AS DateTime), N'{"SucceededAt":"2023-11-02T22:03:07.0307016Z","PerformanceDuration":"23","Latency":"4","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (107, 33, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:04:07.057' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:04:07.0573755Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (108, 33, N'Processing', NULL, CAST(N'2023-11-02T22:04:07.060' AS DateTime), N'{"StartedAt":"2023-11-02T22:04:07.0593527Z","ServerId":"desktop-nvk7fit:19020:047a285a-8283-46e5-ade4-ba3153435cd9","WorkerId":"519b8fdd-0879-4579-b96c-eb1dbe426251"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (109, 33, N'Succeeded', NULL, CAST(N'2023-11-02T22:04:07.073' AS DateTime), N'{"SucceededAt":"2023-11-02T22:04:07.0711181Z","PerformanceDuration":"10","Latency":"7","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (110, 34, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:05:57.703' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:05:57.6974157Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (111, 34, N'Processing', NULL, CAST(N'2023-11-02T22:05:57.847' AS DateTime), N'{"StartedAt":"2023-11-02T22:05:57.7676331Z","ServerId":"desktop-nvk7fit:16316:a8c70edc-a02e-4861-809d-471ea7a9f0f2","WorkerId":"2f1a1de9-6580-43aa-b404-db466c91415d"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (112, 34, N'Succeeded', NULL, CAST(N'2023-11-02T22:05:59.983' AS DateTime), N'{"SucceededAt":"2023-11-02T22:05:59.9776873Z","PerformanceDuration":"2128","Latency":"161","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (113, 35, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:06:13.570' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:06:13.5695166Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (114, 35, N'Processing', NULL, CAST(N'2023-11-02T22:06:13.587' AS DateTime), N'{"StartedAt":"2023-11-02T22:06:13.5783793Z","ServerId":"desktop-nvk7fit:16316:a8c70edc-a02e-4861-809d-471ea7a9f0f2","WorkerId":"34ebefdb-89b1-438a-a52d-ac432feb0c2c"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (115, 35, N'Succeeded', NULL, CAST(N'2023-11-02T22:06:13.787' AS DateTime), N'{"SucceededAt":"2023-11-02T22:06:13.7839525Z","PerformanceDuration":"196","Latency":"17","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (116, 36, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:07:32.280' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:07:32.2809088Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (117, 36, N'Processing', NULL, CAST(N'2023-11-02T22:07:33.333' AS DateTime), N'{"StartedAt":"2023-11-02T22:07:32.2869937Z","ServerId":"desktop-nvk7fit:16316:a8c70edc-a02e-4861-809d-471ea7a9f0f2","WorkerId":"19e8214d-20ca-4397-bba1-779884a7ab9a"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (118, 36, N'Succeeded', NULL, CAST(N'2023-11-02T22:07:35.570' AS DateTime), N'{"SucceededAt":"2023-11-02T22:07:35.5669772Z","PerformanceDuration":"2226","Latency":"1063","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (119, 37, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:08:09.463' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:08:09.4564685Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (120, 37, N'Processing', NULL, CAST(N'2023-11-02T22:08:09.590' AS DateTime), N'{"StartedAt":"2023-11-02T22:08:09.5283903Z","ServerId":"desktop-nvk7fit:24424:db085c73-61e3-42a4-a56a-6f15893a45f5","WorkerId":"2d463ce8-c8d2-459d-8920-e82f2018d5dc"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (121, 37, N'Succeeded', NULL, CAST(N'2023-11-02T22:08:11.510' AS DateTime), N'{"SucceededAt":"2023-11-02T22:08:11.5045364Z","PerformanceDuration":"1911","Latency":"146","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (122, 38, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:09:03.747' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:09:03.7461044Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (123, 38, N'Processing', NULL, CAST(N'2023-11-02T22:09:27.107' AS DateTime), N'{"StartedAt":"2023-11-02T22:09:18.1536406Z","ServerId":"desktop-nvk7fit:24424:db085c73-61e3-42a4-a56a-6f15893a45f5","WorkerId":"d426b2b4-abfd-4624-9a20-3b126e26a06b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (127, 38, N'Succeeded', NULL, CAST(N'2023-11-02T22:10:19.373' AS DateTime), N'{"SucceededAt":"2023-11-02T22:10:17.2645200Z","PerformanceDuration":"45200","Latency":"28321","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (124, 39, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:10:03.183' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:10:03.1822476Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (125, 39, N'Processing', NULL, CAST(N'2023-11-02T22:10:04.003' AS DateTime), N'{"StartedAt":"2023-11-02T22:10:04.0001747Z","ServerId":"desktop-nvk7fit:24424:db085c73-61e3-42a4-a56a-6f15893a45f5","WorkerId":"b2f22701-f7bb-48a0-815f-8183d611ee90"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (126, 39, N'Succeeded', NULL, CAST(N'2023-11-02T22:10:17.263' AS DateTime), N'{"SucceededAt":"2023-11-02T22:10:08.9400412Z","PerformanceDuration":"4925","Latency":"834","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (128, 40, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:11:02.600' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:11:02.6015196Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (129, 40, N'Processing', NULL, CAST(N'2023-11-02T22:11:02.617' AS DateTime), N'{"StartedAt":"2023-11-02T22:11:02.6140672Z","ServerId":"desktop-nvk7fit:24424:db085c73-61e3-42a4-a56a-6f15893a45f5","WorkerId":"decdcf96-8dc2-41df-93ae-b70fc2a8abaf"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (130, 40, N'Succeeded', NULL, CAST(N'2023-11-02T22:11:02.630' AS DateTime), N'{"SucceededAt":"2023-11-02T22:11:02.6294983Z","PerformanceDuration":"10","Latency":"22","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (131, 41, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:12:02.063' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:12:02.0628903Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (132, 41, N'Processing', NULL, CAST(N'2023-11-02T22:12:02.970' AS DateTime), N'{"StartedAt":"2023-11-02T22:12:02.5481642Z","ServerId":"desktop-nvk7fit:24424:db085c73-61e3-42a4-a56a-6f15893a45f5","WorkerId":"33e20a59-924c-410a-a1e8-8cb1dbc90234"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (133, 41, N'Succeeded', NULL, CAST(N'2023-11-02T22:12:04.723' AS DateTime), N'{"SucceededAt":"2023-11-02T22:12:04.7224411Z","PerformanceDuration":"1746","Latency":"918","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (134, 42, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:13:02.997' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:13:02.9971607Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (135, 42, N'Processing', NULL, CAST(N'2023-11-02T22:13:03.000' AS DateTime), N'{"StartedAt":"2023-11-02T22:13:03.0009621Z","ServerId":"desktop-nvk7fit:24424:db085c73-61e3-42a4-a56a-6f15893a45f5","WorkerId":"c17eda7c-2877-4c82-b09f-f6dae355e134"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (136, 42, N'Succeeded', NULL, CAST(N'2023-11-02T22:13:03.013' AS DateTime), N'{"SucceededAt":"2023-11-02T22:13:03.0130622Z","PerformanceDuration":"10","Latency":"5","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (137, 43, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:14:03.037' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:14:03.0368669Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (138, 43, N'Processing', NULL, CAST(N'2023-11-02T22:14:03.040' AS DateTime), N'{"StartedAt":"2023-11-02T22:14:03.0382770Z","ServerId":"desktop-nvk7fit:24424:db085c73-61e3-42a4-a56a-6f15893a45f5","WorkerId":"e31ef301-2658-405e-96c2-5d680916e8ca"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (139, 43, N'Succeeded', NULL, CAST(N'2023-11-02T22:14:03.057' AS DateTime), N'{"SucceededAt":"2023-11-02T22:14:03.0531383Z","PerformanceDuration":"13","Latency":"2","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (140, 44, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:15:03.083' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:15:03.0848614Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (141, 44, N'Processing', NULL, CAST(N'2023-11-02T22:15:03.087' AS DateTime), N'{"StartedAt":"2023-11-02T22:15:03.0860813Z","ServerId":"desktop-nvk7fit:24424:db085c73-61e3-42a4-a56a-6f15893a45f5","WorkerId":"23f9e168-6917-4b81-86bb-28df96a2c3dc"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (142, 44, N'Succeeded', NULL, CAST(N'2023-11-02T22:15:03.097' AS DateTime), N'{"SucceededAt":"2023-11-02T22:15:03.0961225Z","PerformanceDuration":"9","Latency":"3","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (143, 45, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:16:07.293' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:16:07.2859368Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (144, 45, N'Processing', NULL, CAST(N'2023-11-02T22:16:07.423' AS DateTime), N'{"StartedAt":"2023-11-02T22:16:07.3551129Z","ServerId":"desktop-nvk7fit:22428:3f2650fc-e4a1-45b0-b34f-8518d8529857","WorkerId":"7c4ee9e1-fef3-4287-b1f0-0786f726ea3f"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (145, 45, N'Succeeded', NULL, CAST(N'2023-11-02T22:16:09.423' AS DateTime), N'{"SucceededAt":"2023-11-02T22:16:09.4169670Z","PerformanceDuration":"1990","Latency":"153","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (146, 46, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:17:08.767' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:17:08.7663375Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (147, 46, N'Processing', NULL, CAST(N'2023-11-02T22:17:08.767' AS DateTime), N'{"StartedAt":"2023-11-02T22:17:08.7673592Z","ServerId":"desktop-nvk7fit:22428:3f2650fc-e4a1-45b0-b34f-8518d8529857","WorkerId":"c4cd9796-8f83-4756-8056-c3a27a5b85b3"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (148, 46, N'Succeeded', NULL, CAST(N'2023-11-02T22:17:08.790' AS DateTime), N'{"SucceededAt":"2023-11-02T22:17:08.7886983Z","PerformanceDuration":"20","Latency":"1","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (149, 47, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:18:08.817' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:18:08.8167513Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (150, 47, N'Processing', NULL, CAST(N'2023-11-02T22:18:08.817' AS DateTime), N'{"StartedAt":"2023-11-02T22:18:08.8178378Z","ServerId":"desktop-nvk7fit:22428:3f2650fc-e4a1-45b0-b34f-8518d8529857","WorkerId":"c388f72e-4740-4650-becd-ac46da283cdb"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (151, 47, N'Succeeded', NULL, CAST(N'2023-11-02T22:18:08.830' AS DateTime), N'{"SucceededAt":"2023-11-02T22:18:08.8293444Z","PerformanceDuration":"10","Latency":"1","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (152, 48, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:19:08.867' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:19:08.8671582Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (153, 48, N'Processing', NULL, CAST(N'2023-11-02T22:19:08.870' AS DateTime), N'{"StartedAt":"2023-11-02T22:19:08.8683448Z","ServerId":"desktop-nvk7fit:22428:3f2650fc-e4a1-45b0-b34f-8518d8529857","WorkerId":"008ef853-49b7-45b0-9c10-91f76a6d96fb"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (154, 48, N'Succeeded', NULL, CAST(N'2023-11-02T22:19:08.880' AS DateTime), N'{"SucceededAt":"2023-11-02T22:19:08.8794143Z","PerformanceDuration":"9","Latency":"2","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (155, 49, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:20:11.287' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:20:11.2792356Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (156, 49, N'Processing', NULL, CAST(N'2023-11-02T22:20:11.393' AS DateTime), N'{"StartedAt":"2023-11-02T22:20:11.3317793Z","ServerId":"desktop-nvk7fit:13444:48fdaec0-722d-46a0-96d8-009985e524bb","WorkerId":"05598e81-3b3d-44c4-873a-6282f638a12c"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (157, 49, N'Succeeded', NULL, CAST(N'2023-11-02T22:20:11.667' AS DateTime), N'{"SucceededAt":"2023-11-02T22:20:11.6611971Z","PerformanceDuration":"264","Latency":"130","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (158, 50, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:21:11.377' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:21:11.3773857Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (159, 50, N'Processing', NULL, CAST(N'2023-11-02T22:21:11.380' AS DateTime), N'{"StartedAt":"2023-11-02T22:21:11.3790755Z","ServerId":"desktop-nvk7fit:13444:48fdaec0-722d-46a0-96d8-009985e524bb","WorkerId":"76003750-698c-4e23-9e43-6c481dbf0087"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (160, 50, N'Succeeded', NULL, CAST(N'2023-11-02T22:21:11.410' AS DateTime), N'{"SucceededAt":"2023-11-02T22:21:11.4083960Z","PerformanceDuration":"28","Latency":"7","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (161, 51, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:22:12.203' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:22:12.2047721Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (162, 51, N'Processing', NULL, CAST(N'2023-11-02T22:22:12.207' AS DateTime), N'{"StartedAt":"2023-11-02T22:22:12.2073782Z","ServerId":"desktop-nvk7fit:13444:48fdaec0-722d-46a0-96d8-009985e524bb","WorkerId":"da4a1be4-1785-4751-9aaa-88952b6c8d43"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (163, 51, N'Succeeded', NULL, CAST(N'2023-11-02T22:22:12.233' AS DateTime), N'{"SucceededAt":"2023-11-02T22:22:12.2315430Z","PerformanceDuration":"23","Latency":"5","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (164, 52, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:23:43.943' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:23:43.9337209Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (165, 52, N'Processing', NULL, CAST(N'2023-11-02T22:23:44.140' AS DateTime), N'{"StartedAt":"2023-11-02T22:23:44.0463268Z","ServerId":"desktop-nvk7fit:20824:79d49c38-bf1d-4556-9485-c870be36f71e","WorkerId":"2ed89d35-1e5c-4c25-94a9-71cb7a73a399"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (166, 52, N'Succeeded', NULL, CAST(N'2023-11-02T22:23:46.117' AS DateTime), N'{"SucceededAt":"2023-11-02T22:23:46.1124166Z","PerformanceDuration":"1967","Latency":"224","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (167, 54, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:24:34.523' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:24:34.5155598Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (168, 54, N'Processing', NULL, CAST(N'2023-11-02T22:24:34.647' AS DateTime), N'{"StartedAt":"2023-11-02T22:24:34.5859378Z","ServerId":"desktop-nvk7fit:23808:be801346-adc5-46c1-a352-733378841206","WorkerId":"0ca3ffc7-b9af-4124-95eb-71266603f6ad"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (169, 54, N'Succeeded', NULL, CAST(N'2023-11-02T22:24:36.677' AS DateTime), N'{"SucceededAt":"2023-11-02T22:24:36.6713645Z","PerformanceDuration":"2019","Latency":"144","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (170, 55, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:25:08.083' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:25:08.0837719Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (171, 55, N'Processing', NULL, CAST(N'2023-11-02T22:25:08.087' AS DateTime), N'{"StartedAt":"2023-11-02T22:25:08.0856488Z","ServerId":"desktop-nvk7fit:23808:be801346-adc5-46c1-a352-733378841206","WorkerId":"bfb6be7c-c1af-4426-8fe5-1a02e85e0f01"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (172, 55, N'Succeeded', NULL, CAST(N'2023-11-02T22:25:08.170' AS DateTime), N'{"SucceededAt":"2023-11-02T22:25:08.1653735Z","PerformanceDuration":"77","Latency":"7","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (173, 56, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:26:08.123' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:26:08.1223559Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (174, 56, N'Processing', NULL, CAST(N'2023-11-02T22:26:08.123' AS DateTime), N'{"StartedAt":"2023-11-02T22:26:08.1238686Z","ServerId":"desktop-nvk7fit:23808:be801346-adc5-46c1-a352-733378841206","WorkerId":"740219fa-2a69-40cf-9f38-037a3a045f52"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (190, 56, N'Processing', NULL, CAST(N'2023-11-02T22:31:08.243' AS DateTime), N'{"StartedAt":"2023-11-02T22:31:08.2441579Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"b6781710-143c-459e-844d-75a6ffc46472"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (191, 56, N'Succeeded', NULL, CAST(N'2023-11-02T22:31:08.260' AS DateTime), N'{"SucceededAt":"2023-11-02T22:31:08.2580472Z","PerformanceDuration":"12","Latency":"300122","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (175, 57, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:27:59.627' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:27:59.6212380Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (176, 57, N'Processing', NULL, CAST(N'2023-11-02T22:27:59.783' AS DateTime), N'{"StartedAt":"2023-11-02T22:27:59.6864778Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"b9443adf-3b2d-45f8-b498-c0096f909b6f"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (177, 57, N'Succeeded', NULL, CAST(N'2023-11-02T22:28:01.983' AS DateTime), N'{"SucceededAt":"2023-11-02T22:28:01.9787110Z","PerformanceDuration":"2190","Latency":"178","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (178, 58, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:28:17.820' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:28:17.8183492Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (179, 58, N'Processing', NULL, CAST(N'2023-11-02T22:28:22.947' AS DateTime), N'{"StartedAt":"2023-11-02T22:28:22.9443113Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"fbf21312-f704-45f8-ac3d-299af6ac7b98"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (180, 58, N'Succeeded', NULL, CAST(N'2023-11-02T22:28:31.940' AS DateTime), N'{"SucceededAt":"2023-11-02T22:28:31.9380300Z","PerformanceDuration":"8990","Latency":"5130","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (181, 59, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:29:07.980' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:29:07.9794031Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (182, 59, N'Processing', NULL, CAST(N'2023-11-02T22:29:07.980' AS DateTime), N'{"StartedAt":"2023-11-02T22:29:07.9805564Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"1acf57c3-fff0-4fc7-94e7-49d440770693"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (183, 59, N'Succeeded', NULL, CAST(N'2023-11-02T22:29:07.997' AS DateTime), N'{"SucceededAt":"2023-11-02T22:29:07.9965880Z","PerformanceDuration":"14","Latency":"1","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (184, 60, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:30:08.010' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:30:08.0108147Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (185, 60, N'Processing', NULL, CAST(N'2023-11-02T22:30:08.013' AS DateTime), N'{"StartedAt":"2023-11-02T22:30:08.0118720Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"59cafc6e-d9a9-4016-b9e0-0d0d3475ff6c"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (186, 60, N'Succeeded', NULL, CAST(N'2023-11-02T22:30:08.027' AS DateTime), N'{"SucceededAt":"2023-11-02T22:30:08.0266720Z","PerformanceDuration":"13","Latency":"2","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (187, 61, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:31:08.043' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:31:08.0423002Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (188, 61, N'Processing', NULL, CAST(N'2023-11-02T22:31:08.043' AS DateTime), N'{"StartedAt":"2023-11-02T22:31:08.0435256Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"f6d1e5b1-124a-4fb0-a99d-5be07956b453"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (189, 61, N'Succeeded', NULL, CAST(N'2023-11-02T22:31:08.060' AS DateTime), N'{"SucceededAt":"2023-11-02T22:31:08.0587145Z","PerformanceDuration":"14","Latency":"1","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (192, 62, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:32:08.090' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:32:08.0914028Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (193, 62, N'Processing', NULL, CAST(N'2023-11-02T22:32:08.093' AS DateTime), N'{"StartedAt":"2023-11-02T22:32:08.0932299Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"0de0417d-f694-4a0d-b1d6-11e74e5b15e5"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (194, 62, N'Succeeded', NULL, CAST(N'2023-11-02T22:32:08.110' AS DateTime), N'{"SucceededAt":"2023-11-02T22:32:08.1083584Z","PerformanceDuration":"13","Latency":"4","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (195, 63, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:33:08.123' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:33:08.1240154Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (196, 63, N'Processing', NULL, CAST(N'2023-11-02T22:33:08.127' AS DateTime), N'{"StartedAt":"2023-11-02T22:33:08.1251688Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"95c6a40f-e507-42f0-957d-443b65c26acc"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (197, 63, N'Succeeded', NULL, CAST(N'2023-11-02T22:33:08.147' AS DateTime), N'{"SucceededAt":"2023-11-02T22:33:08.1444125Z","PerformanceDuration":"17","Latency":"3","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (198, 64, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:34:08.153' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:34:08.1525803Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (199, 64, N'Processing', NULL, CAST(N'2023-11-02T22:34:08.153' AS DateTime), N'{"StartedAt":"2023-11-02T22:34:08.1537544Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"aac9825a-baf4-4c3f-b267-3c0ab47227d4"}')
GO
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (200, 64, N'Succeeded', NULL, CAST(N'2023-11-02T22:34:08.170' AS DateTime), N'{"SucceededAt":"2023-11-02T22:34:08.1687629Z","PerformanceDuration":"14","Latency":"1","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (201, 65, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:35:08.190' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:35:08.1907375Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (202, 65, N'Processing', NULL, CAST(N'2023-11-02T22:35:08.193' AS DateTime), N'{"StartedAt":"2023-11-02T22:35:08.1930737Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"81f6c4d6-5ff0-425f-b45c-0ae446780f3c"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (203, 65, N'Succeeded', NULL, CAST(N'2023-11-02T22:35:08.220' AS DateTime), N'{"SucceededAt":"2023-11-02T22:35:08.2182429Z","PerformanceDuration":"24","Latency":"4","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (204, 66, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:36:08.247' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:36:08.2458222Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (205, 66, N'Processing', NULL, CAST(N'2023-11-02T22:36:08.250' AS DateTime), N'{"StartedAt":"2023-11-02T22:36:08.2478138Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"7299f38a-ba43-4e8b-bf30-2e97085a8b50"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (206, 66, N'Succeeded', NULL, CAST(N'2023-11-02T22:36:08.267' AS DateTime), N'{"SucceededAt":"2023-11-02T22:36:08.2658237Z","PerformanceDuration":"16","Latency":"9","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (207, 67, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-02T22:37:08.287' AS DateTime), N'{"EnqueuedAt":"2023-11-02T22:37:08.2877929Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (208, 67, N'Processing', NULL, CAST(N'2023-11-02T22:37:08.290' AS DateTime), N'{"StartedAt":"2023-11-02T22:37:08.2899348Z","ServerId":"desktop-nvk7fit:18728:5c08908b-6006-4a11-bd9b-2a98ac61dc96","WorkerId":"494090d8-1363-4636-b25f-27c90154c618"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (209, 67, N'Succeeded', NULL, CAST(N'2023-11-02T22:37:08.313' AS DateTime), N'{"SucceededAt":"2023-11-02T22:37:08.3114414Z","PerformanceDuration":"19","Latency":"8","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (210, 68, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-03T10:39:57.380' AS DateTime), N'{"EnqueuedAt":"2023-11-03T10:39:57.3725716Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (211, 68, N'Processing', NULL, CAST(N'2023-11-03T10:39:57.590' AS DateTime), N'{"StartedAt":"2023-11-03T10:39:57.4754263Z","ServerId":"desktop-nvk7fit:10436:c54dfdc9-4db0-450a-a963-16bd6aa2b8c3","WorkerId":"a932081e-f859-43bf-8b27-7ceb81c5c24a"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (212, 68, N'Succeeded', NULL, CAST(N'2023-11-03T10:39:59.373' AS DateTime), N'{"SucceededAt":"2023-11-03T10:39:59.3699041Z","PerformanceDuration":"1778","Latency":"234","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (213, 69, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2023-11-03T11:00:12.783' AS DateTime), N'{"EnqueuedAt":"2023-11-03T11:00:12.7767546Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (214, 69, N'Processing', NULL, CAST(N'2023-11-03T11:00:12.900' AS DateTime), N'{"StartedAt":"2023-11-03T11:00:12.8221029Z","ServerId":"desktop-nvk7fit:14064:deb4bd28-d11f-4a09-8bdf-4ef85e73e041","WorkerId":"387f237e-5476-4455-9222-bb0ec66635f6"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (215, 69, N'Succeeded', NULL, CAST(N'2023-11-03T11:00:13.113' AS DateTime), N'{"SucceededAt":"2023-11-03T11:00:13.1074194Z","PerformanceDuration":"202","Latency":"137","Result":"{\"Data\":null,\"Message\":\"Başarıyla gerçekleştirildi\",\"StatusCode\":200,\"Errors\":null}"}')
SET IDENTITY_INSERT [HangFire].[State] OFF
GO
/****** Object:  Index [IX_HangFire_AggregatedCounter_ExpireAt]    Script Date: 3.11.2023 15:36:28 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_AggregatedCounter_ExpireAt] ON [HangFire].[AggregatedCounter]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Hash_ExpireAt]    Script Date: 3.11.2023 15:36:28 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_ExpireAt] ON [HangFire].[Hash]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Job_ExpireAt]    Script Date: 3.11.2023 15:36:28 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_ExpireAt] ON [HangFire].[Job]
(
	[ExpireAt] ASC
)
INCLUDE([StateName]) 
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Job_StateName]    Script Date: 3.11.2023 15:36:28 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_StateName] ON [HangFire].[Job]
(
	[StateName] ASC
)
WHERE ([StateName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_List_ExpireAt]    Script Date: 3.11.2023 15:36:28 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_List_ExpireAt] ON [HangFire].[List]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Server_LastHeartbeat]    Script Date: 3.11.2023 15:36:28 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Server_LastHeartbeat] ON [HangFire].[Server]
(
	[LastHeartbeat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Set_ExpireAt]    Script Date: 3.11.2023 15:36:28 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_ExpireAt] ON [HangFire].[Set]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Set_Score]    Script Date: 3.11.2023 15:36:28 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_Score] ON [HangFire].[Set]
(
	[Key] ASC,
	[Score] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_State_CreatedAt]    Script Date: 3.11.2023 15:36:28 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_State_CreatedAt] ON [HangFire].[State]
(
	[CreatedAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
GO
USE [master]
GO
ALTER DATABASE [HangfireEnocaDb] SET  READ_WRITE 
GO
