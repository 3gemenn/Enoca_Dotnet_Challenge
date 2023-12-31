USE [master]
GO
/****** Object:  Database [EnocaDb]    Script Date: 3.11.2023 15:34:02 ******/
CREATE DATABASE [EnocaDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EnocaDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\EnocaDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EnocaDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\EnocaDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [EnocaDb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EnocaDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EnocaDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EnocaDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EnocaDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EnocaDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EnocaDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [EnocaDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EnocaDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EnocaDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EnocaDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EnocaDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EnocaDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EnocaDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EnocaDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EnocaDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EnocaDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EnocaDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EnocaDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EnocaDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EnocaDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EnocaDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EnocaDb] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [EnocaDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EnocaDb] SET RECOVERY FULL 
GO
ALTER DATABASE [EnocaDb] SET  MULTI_USER 
GO
ALTER DATABASE [EnocaDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EnocaDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EnocaDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EnocaDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EnocaDb] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EnocaDb', N'ON'
GO
ALTER DATABASE [EnocaDb] SET QUERY_STORE = OFF
GO
USE [EnocaDb]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 3.11.2023 15:34:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CarrierConfigurations]    Script Date: 3.11.2023 15:34:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarrierConfigurations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CarrierId] [int] NOT NULL,
	[MaxDesi] [int] NOT NULL,
	[MinDesi] [int] NOT NULL,
	[CarrierCost] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_CarrierConfigurations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CarrierReports]    Script Date: 3.11.2023 15:34:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarrierReports](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CarrierId] [int] NOT NULL,
	[CarrierCost] [decimal](18, 2) NOT NULL,
	[Date] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CarrierReports] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carriers]    Script Date: 3.11.2023 15:34:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carriers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[PlusDesiCost] [int] NOT NULL,
	[ConfigurationId] [int] NOT NULL,
 CONSTRAINT [PK_Carriers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3.11.2023 15:34:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CarrierId] [int] NOT NULL,
	[Desi] [int] NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[CarrierCost] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231031211335_init', N'6.0.24')
GO
SET IDENTITY_INSERT [dbo].[CarrierConfigurations] ON 

INSERT [dbo].[CarrierConfigurations] ([Id], [CarrierId], [MaxDesi], [MinDesi], [CarrierCost]) VALUES (1, 1, 10, 1, CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[CarrierConfigurations] ([Id], [CarrierId], [MaxDesi], [MinDesi], [CarrierCost]) VALUES (4, 3, 15, 35, CAST(40.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[CarrierConfigurations] OFF
GO
SET IDENTITY_INSERT [dbo].[CarrierReports] ON 

INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (1, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T17:13:07.7931151' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (2, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T17:14:07.3970238' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (3, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T17:15:07.4434899' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (4, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T17:16:07.4988454' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (5, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:14:44.2177406' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (6, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:15:05.7968421' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (7, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:16:05.9151377' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (8, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:17:09.0003758' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (9, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:18:17.5587769' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (10, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:19:02.5822914' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (11, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:20:02.6334365' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (12, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:21:02.7223204' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (13, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:22:02.7987116' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (14, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:23:12.2027149' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (15, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-02T18:24:05.3003124' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (16, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T00:54:08.3707547' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (17, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T00:55:06.6829354' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (18, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T00:56:06.7327062' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (19, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T00:57:06.7620206' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (20, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T00:58:06.7963347' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (21, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T00:59:06.8290615' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (22, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:00:06.8719889' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (23, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:01:06.9243981' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (24, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:02:06.9795734' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (25, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:03:07.0138172' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (26, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:04:07.0677754' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (27, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:05:59.6813413' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (28, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:06:13.7762046' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (29, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:07:35.5160049' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (30, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:08:11.2615145' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (31, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:10:08.1989588' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (32, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:10:08.6067721' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (33, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:11:02.6262084' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (34, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:12:04.7193716' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (35, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:13:03.0102969' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (36, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:14:03.0465419' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (37, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:15:03.0931172' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (38, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:16:09.1680988' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (39, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:17:08.7848282' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (40, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:18:08.8262761' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (41, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:19:08.8764222' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (42, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:20:11.4852861' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (43, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:21:11.3976710' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (44, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:22:12.2203340' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (45, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:23:45.8644615' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (46, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:24:36.4315150' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (47, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:25:08.1594993' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (48, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:26:08.1324256' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (49, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:28:01.7357178' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (50, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:28:26.0727611' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (51, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:28:27.5912738' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (52, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:29:07.9893202' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (53, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:29:07.9941830' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (54, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:30:08.0198501' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (55, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:30:08.0242477' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (56, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:31:08.0516035' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (57, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:31:08.0557763' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (58, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:31:08.2515071' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (59, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:31:08.2557052' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (60, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:32:08.1017522' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (61, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:32:08.1060159' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (62, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:33:08.1335292' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (63, 3, CAST(400.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:33:08.1380647' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (64, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:34:08.1612430' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (65, 3, CAST(460.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:34:08.1661049' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (66, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:35:08.2009624' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (67, 3, CAST(460.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:35:08.2083893' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (68, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:36:08.2556965' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (69, 3, CAST(460.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:36:08.2596420' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (70, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:37:08.2980939' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (71, 3, CAST(460.00 AS Decimal(18, 2)), CAST(N'2023-11-03T01:37:08.3089464' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (72, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T13:39:59.1241228' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (73, 3, CAST(460.00 AS Decimal(18, 2)), CAST(N'2023-11-03T13:39:59.3569646' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (74, 1, CAST(34.00 AS Decimal(18, 2)), CAST(N'2023-11-03T14:00:13.0809041' AS DateTime2))
INSERT [dbo].[CarrierReports] ([Id], [CarrierId], [CarrierCost], [Date]) VALUES (75, 3, CAST(420.00 AS Decimal(18, 2)), CAST(N'2023-11-03T14:00:13.1022539' AS DateTime2))
SET IDENTITY_INSERT [dbo].[CarrierReports] OFF
GO
SET IDENTITY_INSERT [dbo].[Carriers] ON 

INSERT [dbo].[Carriers] ([Id], [Name], [IsActive], [PlusDesiCost], [ConfigurationId]) VALUES (1, N'Aras', 1, 4, 1)
INSERT [dbo].[Carriers] ([Id], [Name], [IsActive], [PlusDesiCost], [ConfigurationId]) VALUES (3, N'Yurtiçi', 1, 20, 4)
SET IDENTITY_INSERT [dbo].[Carriers] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (1, 3, 5, CAST(N'2023-11-01T15:00:08.5742059' AS DateTime2), CAST(20.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (2, 3, 13, CAST(N'2023-11-01T17:15:22.2808109' AS DateTime2), CAST(60.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (3, 3, 11, CAST(N'2023-11-01T17:29:48.9770328' AS DateTime2), CAST(40.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (4, 3, 11, CAST(N'2023-11-01T17:33:24.5162067' AS DateTime2), CAST(40.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (5, 3, 11, CAST(N'2023-11-01T17:36:01.5161333' AS DateTime2), CAST(40.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (6, 3, 11, CAST(N'2023-11-01T17:38:49.6603984' AS DateTime2), CAST(40.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (7, 3, 11, CAST(N'2023-11-01T17:41:19.8097355' AS DateTime2), CAST(40.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (9, 3, 11, CAST(N'2023-11-01T17:58:44.8689934' AS DateTime2), CAST(40.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (10, 3, 11, CAST(N'2023-11-01T19:23:15.0222864' AS DateTime2), CAST(40.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (17, 1, 11, CAST(N'2023-11-03T01:28:10.2834477' AS DateTime2), CAST(34.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([Id], [CarrierId], [Desi], [Date], [CarrierCost]) VALUES (18, 3, 13, CAST(N'2023-11-03T01:33:32.0552206' AS DateTime2), CAST(60.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
/****** Object:  Index [IX_CarrierConfigurations_CarrierId]    Script Date: 3.11.2023 15:34:02 ******/
CREATE NONCLUSTERED INDEX [IX_CarrierConfigurations_CarrierId] ON [dbo].[CarrierConfigurations]
(
	[CarrierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CarrierReports_CarrierId]    Script Date: 3.11.2023 15:34:02 ******/
CREATE NONCLUSTERED INDEX [IX_CarrierReports_CarrierId] ON [dbo].[CarrierReports]
(
	[CarrierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_CarrierId]    Script Date: 3.11.2023 15:34:02 ******/
CREATE NONCLUSTERED INDEX [IX_Orders_CarrierId] ON [dbo].[Orders]
(
	[CarrierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CarrierConfigurations]  WITH CHECK ADD  CONSTRAINT [FK_CarrierConfigurations_Carriers_CarrierId] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carriers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CarrierConfigurations] CHECK CONSTRAINT [FK_CarrierConfigurations_Carriers_CarrierId]
GO
ALTER TABLE [dbo].[CarrierReports]  WITH CHECK ADD  CONSTRAINT [FK_CarrierReports_Carriers_CarrierId] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carriers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CarrierReports] CHECK CONSTRAINT [FK_CarrierReports_Carriers_CarrierId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Carriers_CarrierId] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carriers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Carriers_CarrierId]
GO
USE [master]
GO
ALTER DATABASE [EnocaDb] SET  READ_WRITE 
GO
