USE [master]
GO
/****** Object:  Database [gm_notification]    Script Date: 11/16/2021 6:51:12 PM ******/
CREATE DATABASE [gm_notification]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'gm_notification', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\gm_notification.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'gm_notification_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\gm_notification_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [gm_notification] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [gm_notification].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [gm_notification] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [gm_notification] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [gm_notification] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [gm_notification] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [gm_notification] SET ARITHABORT OFF 
GO
ALTER DATABASE [gm_notification] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [gm_notification] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [gm_notification] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [gm_notification] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [gm_notification] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [gm_notification] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [gm_notification] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [gm_notification] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [gm_notification] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [gm_notification] SET  DISABLE_BROKER 
GO
ALTER DATABASE [gm_notification] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [gm_notification] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [gm_notification] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [gm_notification] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [gm_notification] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [gm_notification] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [gm_notification] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [gm_notification] SET RECOVERY FULL 
GO
ALTER DATABASE [gm_notification] SET  MULTI_USER 
GO
ALTER DATABASE [gm_notification] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [gm_notification] SET DB_CHAINING OFF 
GO
ALTER DATABASE [gm_notification] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [gm_notification] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [gm_notification] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'gm_notification', N'ON'
GO
ALTER DATABASE [gm_notification] SET QUERY_STORE = OFF
GO
USE [gm_notification]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [gm_notification]
GO
/****** Object:  User [gm_notificationdba]    Script Date: 11/16/2021 6:51:13 PM ******/
CREATE USER [gm_notificationdba] FOR LOGIN [gm_notificationdba] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [gm_notificationdba]
GO
/****** Object:  Table [dbo].[devices]    Script Date: 11/16/2021 6:51:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[devices](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[device_uuid] [nvarchar](512) NOT NULL,
	[device_token] [nvarchar](512) NULL,
	[device_type] [nvarchar](30) NULL,
	[model] [nvarchar](30) NULL,
	[manufacturer] [nvarchar](30) NULL,
	[user_id] [nvarchar](50) NULL,
	[last_connected_at] [datetime2](7) NULL,
	[status] [char](10) NOT NULL,
	[utc_create] [datetime2](7) NOT NULL,
	[utc_modified] [datetime2](7) NOT NULL,
	[push_type] [int] NOT NULL,
	[device_os] [nvarchar](50) NULL,
	[device_id] [nvarchar](512) NULL,
	[language] [nvarchar](10) NULL,
 CONSTRAINT [PK__devices__3213E83F23FAC3A5] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[message_types]    Script Date: 11/16/2021 6:51:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[message_types](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [varchar](50) NOT NULL,
	[description] [varchar](100) NOT NULL,
	[utc_create] [datetime2](7) NOT NULL,
 CONSTRAINT [PK__msg_push__3213E83FC8D1A605] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[push_messages]    Script Date: 11/16/2021 6:51:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[push_messages](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[application_id] [bigint] NOT NULL,
	[code] [varchar](50) NOT NULL,
	[title] [nvarchar](2000) NOT NULL,
	[body] [nvarchar](max) NOT NULL,
	[ejson] [nvarchar](max) NOT NULL,
	[sound] [varchar](10) NULL,
	[badge] [int] NOT NULL,
	[message_type_id] [bigint] NOT NULL,
	[device_token] [varchar](500) NOT NULL,
	[utc_create] [datetime2](7) NOT NULL,
	[utc_modified] [datetime2](7) NOT NULL,
	[push_type] [int] NOT NULL,
	[receiver_id] [nvarchar](50) NOT NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK__msg_mess__3213E83F5415D5DC] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[read_count]    Script Date: 11/16/2021 6:51:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[read_count](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[push_message_code] [varchar](50) NOT NULL,
	[utc_create] [datetime2](7) NULL,
 CONSTRAINT [PK_user_badge_copy1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sms_messages]    Script Date: 11/16/2021 6:51:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sms_messages](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[application_id] [bigint] NOT NULL,
	[code] [varchar](50) NOT NULL,
	[title] [nvarchar](2000) NOT NULL,
	[body] [nvarchar](max) NOT NULL,
	[message_type_id] [bigint] NOT NULL,
	[dialing_code] [varchar](10) NOT NULL,
	[read_count] [int] NOT NULL,
	[utc_create] [datetime2](7) NOT NULL,
	[utc_modified] [datetime2](7) NOT NULL,
	[phone_number] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__msg_mess__3213E83F5415D5DC_copy1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_badges]    Script Date: 11/16/2021 6:51:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_badges](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[badge] [int] NOT NULL,
	[utc_create] [datetime2](7) NULL,
	[utc_modified] [datetime2](7) NULL,
 CONSTRAINT [PK_user_badge] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[devices] ON 

INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (1, N'4cb83-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'D         ', CAST(N'2021-08-19T09:41:47.0566667' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 2, N'Andorid 11', N'1e0e4f0a-c810-4138-9556-051263770c6a', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (2, N'7673cf9e4919f8e0', N'fYVKG7QnR4a6xHWfWGHlWD:APA91bH_GTtMuZleJSl4SrTBKTDszns54UswRkSjnpOTo4ZIr2-bD0DuKc9f_qFKuH69fIxj1-rkxx3k0qsUviQ0c0PCzlWGEVyHiFXxjgoAuX1AzuoI89UOQ2sNfnstZVYxD2r2YwwR', N'Android', N'msmnile', N'samsung', N'', CAST(N'2021-08-19T09:48:10.4000000' AS DateTime2), N'N         ', CAST(N'2021-08-19T09:48:10.4000000' AS DateTime2), CAST(N'2021-08-19T09:48:10.4000000' AS DateTime2), 2, N'Android 11', N'433a2f8f-d991-42c6-a660-2671ae6caa2c', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (3, N'xxssee14cb83-5681-477d-b16c-67c6f0e873f4', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'', CAST(N'2021-08-20T06:40:59.7166667' AS DateTime2), N'N         ', CAST(N'2021-08-20T06:40:59.7166667' AS DateTime2), CAST(N'2021-08-20T06:40:59.7166667' AS DateTime2), 2, N'Andorid 11', N'2cbcf64e-4257-4820-9bc2-318b6378bed7', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (4, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'', CAST(N'2021-08-20T06:43:40.9066667' AS DateTime2), N'N         ', CAST(N'2021-08-20T06:43:40.9066667' AS DateTime2), CAST(N'2021-08-20T06:43:40.9066667' AS DateTime2), 2, N'Andorid 11', N'32a68b2f-6a55-4060-898b-5042d8efcfe9', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (5, N'qafd4wcb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFObw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'w', CAST(N'2021-08-20T06:45:20.5766667' AS DateTime2), N'N         ', CAST(N'2021-08-20T06:45:20.5766667' AS DateTime2), CAST(N'2021-08-20T06:45:20.5766667' AS DateTime2), 2, N'Andorid 11', N'fcbfd482-11ad-4b58-ad75-96abfc07f0a1', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (6, N'qafd4wcb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFObw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'w', CAST(N'2021-08-20T07:11:55.3500000' AS DateTime2), N'N         ', CAST(N'2021-08-20T07:11:55.3500000' AS DateTime2), CAST(N'2021-08-20T07:11:55.3500000' AS DateTime2), 2, N'Andorid 11', N'37a63516-deee-4718-b8c4-77dc275bc9a7', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (7, N'qafd4wcb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFObw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'w', CAST(N'2021-08-20T07:11:57.2066667' AS DateTime2), N'N         ', CAST(N'2021-08-20T07:11:57.2066667' AS DateTime2), CAST(N'2021-08-20T07:11:57.2066667' AS DateTime2), 2, N'Andorid 11', N'531e2023-9d78-49a1-988c-d462e1a22dbe', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (8, N'7673cf9e4919f8e0', N'dXl3_u1hQ-m6ty2-Zq-4vD:APA91bFx0-wiGVoxFhl_zBP1-yqiQsPhlq5OK9EDUft8RdoZqrPe9Jjk1GgmNZx_cdSV4frsgiul_q0TEt3bD0yiRCnVj1aLw658wkEa8_93ccHGOuCThHwUVlXEeATzujso0Aqe_7R4', N'Android', N'msmnile', N'samsung', N'', CAST(N'2021-08-20T07:12:50.0566667' AS DateTime2), N'N         ', CAST(N'2021-08-20T07:12:50.0566667' AS DateTime2), CAST(N'2021-08-20T07:12:50.0566667' AS DateTime2), 2, N'Android 11', N'9dc15b22-7db7-459d-bc1b-3b37b4a62c15', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (9, N'186C0C9D-602B-4404-8397-EBE5826D4F02', N'cbPDRy45Tk_ik3c4CbifQL:APA91bEkg5l-73wIwV31frGt1x1tmichAtuVGKN9700j_Iex3It3Ne4Z_pZ1iVGuuwtwNvH3Lt5UyV3omK6dh-Uwf6_5-oA0ubUc1XzF6h0M2WwUrXauxdL07vPYG0rGx8FrBbiYirGZ', N'iOS', N'iPhone13,2', N'Apple', N'', CAST(N'2021-08-20T10:31:18.7233333' AS DateTime2), N'N         ', CAST(N'2021-08-20T10:31:18.7233333' AS DateTime2), CAST(N'2021-08-20T10:31:18.7233333' AS DateTime2), 1, N'iOS 14.3', N'e90c6021-f7ef-4a30-8f0a-192d230051eb', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (10, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'sdf', CAST(N'2021-08-20T10:31:20.5866667' AS DateTime2), N'N         ', CAST(N'2021-08-20T10:31:20.5866667' AS DateTime2), CAST(N'2021-08-20T10:31:20.5866667' AS DateTime2), 2, N'Andorid 11', N'5962ae44-22b2-4aca-86e0-f1f8789e2a29', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (11, N'186C0C9D-602B-4404-8397-EBE5826D4F02', N'cbPDRy45Tk_ik3c4CbifQL:APA91bEkg5l-73wIwV31frGt1x1tmichAtuVGKN9700j_Iex3It3Ne4Z_pZ1iVGuuwtwNvH3Lt5UyV3omK6dh-Uwf6_5-oA0ubUc1XzF6h0M2WwUrXauxdL07vPYG0rGx8FrBbiYirGZ', N'iOS', N'iPhone13,2', N'Apple', N'', CAST(N'2021-08-20T11:26:22.2300000' AS DateTime2), N'N         ', CAST(N'2021-08-20T11:26:22.2300000' AS DateTime2), CAST(N'2021-08-20T11:26:22.2300000' AS DateTime2), 1, N'iOS 14.3', N'02ba9cf3-d19d-4337-8bef-6a272319ddba', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (12, N'186C0C9D-602B-4404-8397-EBE5826D4F02', N'duIYdg-iI0eIm_4-YCgnvy:APA91bEJmzU7PjMfGT3Z7foY2jYIJt6hqOxJpT2kKhDIgnNFc5VE96i3U1_vX4BbUwzbL28dnjbZBai1QS2kphReFOXmtGFR5DWmSjwh2-Grd1Zu7VXWhrnUSWM9VEnn2sUXnLY_UIeC', N'iOS', N'iPhone13,2', N'Apple', N'', CAST(N'2021-08-20T11:31:59.9800000' AS DateTime2), N'N         ', CAST(N'2021-08-20T11:31:59.9800000' AS DateTime2), CAST(N'2021-08-20T11:31:59.9800000' AS DateTime2), 1, N'iOS 14.3', N'5966514c-452a-4638-81c8-9bb1b604e57b', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (13, N'186C0C9D-602B-4404-8397-EBE5826D4F02', N'ciWvyz_VPkzbr-E8BSGQqX:APA91bGf7oJztAe_Xd1ePMYnf0X1YK2uUAf4J1Nekf301bpeRQJ-6Hn4KZDnCvSrXH6Myt86rkQrMG_bbtXaKfyOCjCuYUWmN9C-mw_nL7x41OGgwggwK25YY33RSiMQhiGOYIBwcvsi', N'iOS', N'iPhone13,2', N'Apple', N'', CAST(N'2021-08-21T02:31:47.2300000' AS DateTime2), N'N         ', CAST(N'2021-08-21T02:31:47.2300000' AS DateTime2), CAST(N'2021-08-21T02:31:47.2300000' AS DateTime2), 1, N'iOS 14.3', N'7c5d7987-698b-4549-b8d2-f28ad5ea8ba0', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (14, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'sdf', CAST(N'2021-08-23T01:48:12.5433333' AS DateTime2), N'N         ', CAST(N'2021-08-23T01:48:12.5433333' AS DateTime2), CAST(N'2021-08-23T01:48:12.5433333' AS DateTime2), 2, N'Andorid 11', N'f9821509-0d50-490e-855d-12c4a6028eea', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (15, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'sdf', CAST(N'2021-08-23T01:48:47.6066667' AS DateTime2), N'N         ', CAST(N'2021-08-23T01:48:47.6066667' AS DateTime2), CAST(N'2021-08-23T01:48:47.6066667' AS DateTime2), 2, N'Andorid 11', N'04dc560f-2325-4933-93ba-dcdc95a61264', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (16, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'sdf', CAST(N'2021-08-23T09:14:44.2866667' AS DateTime2), N'N         ', CAST(N'2021-08-23T09:14:44.2866667' AS DateTime2), CAST(N'2021-08-23T09:14:44.2866667' AS DateTime2), 2, N'Andorid 11', N'c60375e1-3b6e-4a23-ada2-89de5969fb44', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (17, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'sdf', CAST(N'2021-08-23T09:17:02.2000000' AS DateTime2), N'N         ', CAST(N'2021-08-23T09:17:02.2000000' AS DateTime2), CAST(N'2021-08-23T09:17:02.2000000' AS DateTime2), 2, N'Andorid 11', N'74e6761a-de3c-441b-91c2-a0f83ce34199', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (18, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'sdf', CAST(N'2021-08-23T09:18:59.4100000' AS DateTime2), N'N         ', CAST(N'2021-08-23T09:18:59.4100000' AS DateTime2), CAST(N'2021-08-23T09:18:59.4100000' AS DateTime2), 2, N'Andorid 11', N'25ad924e-dedb-44e3-9f97-e3209a9ccd16', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (19, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'sdf', CAST(N'2021-08-23T09:19:27.7700000' AS DateTime2), N'N         ', CAST(N'2021-08-23T09:19:27.7700000' AS DateTime2), CAST(N'2021-08-23T09:19:27.7700000' AS DateTime2), 2, N'Andorid 11', N'34aa9c71-47fb-494a-b2be-0d2e50355a9b', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (20, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'sdf', CAST(N'2021-08-23T09:19:28.8400000' AS DateTime2), N'N         ', CAST(N'2021-08-23T09:19:28.8400000' AS DateTime2), CAST(N'2021-08-23T09:19:28.8400000' AS DateTime2), 2, N'Andorid 11', N'38a147c1-408b-4e28-b595-e6349d8882a3', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (21, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'sdf', CAST(N'2021-08-23T09:22:21.9866667' AS DateTime2), N'N         ', CAST(N'2021-08-23T09:22:21.9866667' AS DateTime2), CAST(N'2021-08-23T09:22:21.9866667' AS DateTime2), 2, N'Andorid 11', N'd39d1643-e708-4a12-a2c8-e5dad2151be3', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (22, N'3886922B-C168-4561-815B-CFFA0C038713', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'ios', N'iPhone10,3', N'apple', N'10000000009', CAST(N'2021-08-23T09:31:22.6700000' AS DateTime2), N'N         ', CAST(N'2021-08-23T09:31:22.6700000' AS DateTime2), CAST(N'2021-08-23T09:31:22.6700000' AS DateTime2), 2, N'iOS 14.7.1', N'3622226f-40f6-404e-8daa-fb485eb00da1', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (23, N'3886922B-C168-4561-815B-CFFA0C038713', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'ios', N'iPhone10,3', N'apple', N'10000000009', CAST(N'2021-08-23T09:41:13.6200000' AS DateTime2), N'N         ', CAST(N'2021-08-23T09:41:13.6200000' AS DateTime2), CAST(N'2021-08-23T09:41:13.6200000' AS DateTime2), 2, N'iOS 14.7.1', N'cacfab3e-ea2b-473c-ab72-d18b419179c2', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (24, N'3886922B-C168-4561-815B-CFFA0C038713', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'ios', N'iPhone10,3', N'apple', N'10000000009', CAST(N'2021-08-23T09:47:47.9233333' AS DateTime2), N'N         ', CAST(N'2021-08-23T09:47:47.9233333' AS DateTime2), CAST(N'2021-08-23T09:47:47.9233333' AS DateTime2), 2, N'iOS 14.7.1', N'952be635-f3cf-4d9e-9ca8-cd849e79be7c', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (25, N'3886922B-C168-4561-815B-CFFA0C038713', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'ios', N'iPhone10,3', N'apple', N'10000000009', CAST(N'2021-08-23T09:48:06.9433333' AS DateTime2), N'N         ', CAST(N'2021-08-23T09:48:06.9433333' AS DateTime2), CAST(N'2021-08-23T09:48:06.9433333' AS DateTime2), 2, N'iOS 14.7.1', N'c6a16718-9837-46dd-b517-26bfc391417a', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (26, N'3886922B-C168-4561-815B-CFFA0C038713', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'ios', N'iPhone10,3', N'apple', N'10000000009', CAST(N'2021-08-23T10:13:05.6733333' AS DateTime2), N'N         ', CAST(N'2021-08-23T10:13:05.6733333' AS DateTime2), CAST(N'2021-08-23T10:13:05.6733333' AS DateTime2), 2, N'iOS 14.7.1', N'2c5d4f8d-8b27-477b-af83-98ff8623324c', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (27, N'2323232-5681-477d-b16c-67c6f0e873f42', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'android', N'google nexus 12', N'Google', N'sdf', CAST(N'2021-08-23T10:14:33.1033333' AS DateTime2), N'N         ', CAST(N'2021-08-23T10:14:33.1033333' AS DateTime2), CAST(N'2021-08-23T10:14:33.1033333' AS DateTime2), 2, N'Andorid 11', N'fdc1c150-6d51-4543-8364-7623dcd64f2e', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (28, N'3FF9691F-9604-49DF-993C-A3A867232486', N'f4-8v8pTGUeniEIQz6WMTg:APA91bG96ChhJClzdeTSP84sMAm2WDie5-w5usOyo8efqt5JK3Aq7Zn-ZV-XMWdTTU09L-jsuHMKmAfAWq0nS6-ZIhWwK6gNwUrE3K8YJ7vP39so9Xyd5by6HHkZCH63Kd_sc_75aKbf', N'iOS', N'iPhone11,8', N'Apple', N'10017564', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-08-23T10:15:46.2133333' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 1, N'iOS 14.8', N'cb7920c0-3526-4f23-909d-b984101a9acf', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (29, N'3886922B-C168-4561-815B-CFFA0C038713', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'ios', N'iPhone10,3', N'apple', N'10000000009', CAST(N'2021-08-24T02:17:16.2866667' AS DateTime2), N'N         ', CAST(N'2021-08-24T02:17:16.2866667' AS DateTime2), CAST(N'2021-08-24T02:17:16.2866667' AS DateTime2), 2, N'iOS 14.7.1', N'f420c671-bb53-4c14-89ab-bfe8cfe83a94', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (30, N'3886922B-C168-4561-815B-CFFA0C038713', N'cq92wjKRFOw:APA91bFU_PFKds9DZ1GImOaGY1TtmkfK8QZ9U29xzH-16RCvPhtHi4zK8QdbAuooFHpZ5ja9wY34n1ZESa6HGY1KfA5NCW5HBUeaGDlmfZ5aXGu5FP0GUJJXqIa3v4rxUldmUNzL6dg5', N'ios', N'iPhone10,3', N'apple', N'10000000009', CAST(N'2021-08-24T02:17:18.5333333' AS DateTime2), N'N         ', CAST(N'2021-08-24T02:17:18.5333333' AS DateTime2), CAST(N'2021-08-24T02:17:18.5333333' AS DateTime2), 2, N'iOS 14.7.1', N'5b2b36be-683d-4f98-b2e6-8d42fda699fa', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (31, N'551A2276-A1A6-4B42-8A32-53A0535A4465', N'fNROiyaQL0bVu_GmQ5BB5T:APA91bH15rvXeNDWJnTiq-7Nqks6kXR1KXE-bDYATL-g86Yrd6yxaLcVrbqujqeCXeYWcw99TC0akRD0xj7B6dpWMKu8KzwNdonXtZUjcjFTGCeAerSnCTwhrMsrsMDKl3j88W5WMysA', N'iOS', N'iPhone13,2', N'Apple', N'', CAST(N'2021-08-25T02:30:26.5200000' AS DateTime2), N'N         ', CAST(N'2021-08-25T02:30:26.5200000' AS DateTime2), CAST(N'2021-08-25T02:30:26.5200000' AS DateTime2), 1, N'iOS 14.5', N'4c5c793a-b233-4429-9c16-290e2f75fdb0', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (32, N'EEF8EB09-1CF6-44F3-A9B7-324F99D5C942', N'daXDkAcr-0FGoLFVV5x-vc:APA91bEGrvGf-w-z6sbe0rz7ZWxE2n20dZkTarDko5Ag0njQGERP5HcLcK8v3dtzs0f2IvkTl11kxk6bTwplWqaRolsi4XEyjklTdGOY8oLowTnb_cvHTiJFf8ApnLg_7QPvDWRZtlqN', N'iOS', N'iPhone12,1', N'Apple', N'', CAST(N'2021-08-26T07:42:58.0366667' AS DateTime2), N'N         ', CAST(N'2021-08-26T07:42:58.0366667' AS DateTime2), CAST(N'2021-08-26T07:42:58.0366667' AS DateTime2), 1, N'iOS 14.3', N'69274693-1cc5-408f-bb52-cabd123d60cb', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (33, N'5b0fd640fc793ed2', N'dQ3xbfz5RgOLFco2c4OSBK:APA91bFXMpgzi05m3z3VgBjQC09smQCZ4PmnMmkUPV9UAXLLgMATruFviD7r5P5uEQcdsEUzhjwfTG0k7hSWynnWGs7zhMfqhs9Y1zTwvAc_ECnJVi-vUgsyMgIx7XQyMC4PGE33pGfr', N'Android', N'goldfish_x86', N'google', N'', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-08-30T09:20:43.1566667' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 2, N'Android 11', N'28043e31-89e4-4995-8eab-9b478f927b4a', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (34, N'E78EBB8A-2FE3-4A71-A662-F134D47EEA66', N'B66CD8E35E852FA2C26E4FCB6F8D1C639E48B42459BA313B4A1122FE52C55990', N'iOS', N'iPhone12,1', N'Apple', N'', CAST(N'2021-08-31T10:13:47.8433333' AS DateTime2), N'N         ', CAST(N'2021-08-31T10:13:47.8433333' AS DateTime2), CAST(N'2021-08-31T10:13:47.8433333' AS DateTime2), 1, N'iOS 14.7.1', N'81871513-0f90-4105-8cdc-19d20bd503ae', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (35, N'xxxqafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'b66cd8e35e852fa2c26e4fcb6f8d1c639e48b42459ba313b4a1122fe52c55990', N'ios', N'iPhone 12', N'Apple', N'1000002', CAST(N'2021-08-31T10:29:49.7566667' AS DateTime2), N'N         ', CAST(N'2021-08-31T10:29:49.7566667' AS DateTime2), CAST(N'2021-08-31T10:29:49.7566667' AS DateTime2), 1, N'iOS 14', N'5f202f4f-eeb7-408e-95cc-8114b7aa54fd', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (36, N'7673cf9e4919f8e0', N'etP32scRSuKbm2goe0DRUK:APA91bEpJPY_lOlP8tSeUZ_McIqn5Bp5AaZ0EF-HLYUGCtKZRhizVlyv1PnUE6IXG70ylCtiiX8Q0oQt9uR7qqmMQwYo13lXUfslLjJH4LndJr02Z2SDgQsYaKArT84nQqtSUp2awczk', N'Android', N'msmnile', N'samsung', N'', CAST(N'2021-09-01T07:08:50.8333333' AS DateTime2), N'N         ', CAST(N'2021-09-01T07:08:50.8333333' AS DateTime2), CAST(N'2021-09-01T07:08:50.8333333' AS DateTime2), 2, N'Android 11', N'fbda745b-a686-49bb-b710-3b5c233e4a64', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (37, N'7f7b1bf51f1467d1', N'c-H2Zq4URny-9fkjkxUsKf:APA91bGpkPfJhO-UGRJs5ysUXBbA-AapjAxVUZywAEN2GcTVVAdMIM_Z4m7U-vDXuMXaXm8KRkTVpQ9gl7xq60gwAHMwvbPMFgqTlr1H_TdNNFXWVvPV-vI6681_bZ4vm500z3NK-WlP', N'Android', N'lahaina', N'OnePlus', N'', CAST(N'2021-09-01T07:47:52.2833333' AS DateTime2), N'N         ', CAST(N'2021-09-01T07:47:52.2833333' AS DateTime2), CAST(N'2021-09-01T07:47:52.2833333' AS DateTime2), 2, N'Android 11', N'a4e30c4c-b5ef-4f07-b38c-8b3785b4f7f9', N'zh-CN')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (38, N'7673cf9e4919f8e0', N'dbdpDkUTTgW62m955x7lDw:APA91bHF9flTgfA-8awIuSUFBZ_FKQDl_sE7TVOPsdWD-LtmPUPfyGUn8UbukKaM2zajjkLjFbo4cOr6Ur_Zol7qsTJQ1x-d6eSIzQFrBhWyOI4WJHwS5Magzn4ZCPG4K5btikKto57p', N'Android', N'msmnile', N'samsung', N'', CAST(N'2021-09-01T09:09:21.6066667' AS DateTime2), N'N         ', CAST(N'2021-09-01T09:09:21.6066667' AS DateTime2), CAST(N'2021-09-01T09:09:21.6066667' AS DateTime2), 2, N'Android 11', N'3d729d35-d35b-491b-8a15-ef257e917fe6', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (39, N'129a1c9e963823f9', N'fN7wVJU3Raew6_5bKzg0lZ:APA91bFvfZcKO4ZQc73udPDhea7DPaeOdtHkDgBgN-9bxZ4B6k7tP3jKZ0XOX3fLySVrOtEd8I5Nrce5mTZt9rdF4jFUNjeZAWTDip7ftd1lYF98XTQeBs2K-KYXVQzaULhHQyblOK5_', N'Android', N'lahaina', N'OnePlus', N'', CAST(N'2021-09-07T03:43:16.0766667' AS DateTime2), N'N         ', CAST(N'2021-09-07T03:43:16.0766667' AS DateTime2), CAST(N'2021-09-07T03:43:16.0766667' AS DateTime2), 2, N'Android 11', N'7c5333ae-3225-464a-9432-14de9d8fc681', N'zh-CN')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (40, N'129a1c9e963823f9', N'cIb4mVX1Tw2xsIYIUp4Alu:APA91bHtkRsL7rmZQzF-HzTf4ARc_jrs44WiUmFWjhODIE2gJOxYMd4xsf7nR7SLq78N-P5jRclDWU9SAaKeiNGX4PGbUw-B3kbGZZlFAX8jYZKBXTicvwMdQVM37byfh78djzFpsCqe', N'Android', N'lahaina', N'OnePlus', N'', CAST(N'2021-09-07T03:56:14.2300000' AS DateTime2), N'N         ', CAST(N'2021-09-07T03:56:14.2300000' AS DateTime2), CAST(N'2021-09-07T03:56:14.2300000' AS DateTime2), 2, N'Android 11', N'e3bab89a-7b72-4956-986e-abcb5e27ba16', N'zh-CN')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (41, N'129a1c9e963823f9', N'cVhOOuAjQcS-X6VFp1Luie:APA91bFMlga8FdlFxKSWVUjFcKuQFjya4Q6jsuQuY3VbBGSpsrsFDRikXlc6ZiwlQgqVm9gLto3wmmVuTmdhzhCYEvwHPJe0uvTX1sMmPbOpdAxfuEw07lwByCabeSsySda-7g7plgWg', N'Android', N'lahaina', N'OnePlus', N'', CAST(N'2021-09-07T04:24:53.4700000' AS DateTime2), N'N         ', CAST(N'2021-09-07T04:24:53.4700000' AS DateTime2), CAST(N'2021-09-07T04:24:53.4700000' AS DateTime2), 2, N'Android 11', N'9dd99b51-8eda-4410-a5b7-fe24e6d999e2', N'zh-CN')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (42, N'129a1c9e963823f9', N'en-hYvw-RcKU9K41z6xhdH:APA91bGXAV5mo8NoDeo5F_V-_HcdkjkYgtDGEMKuPuYZVgOpKTpTAznLkX7BuS2-gd9KBWDCP-hMZnd3g0uwlKLb3bgKKC1BrvmbN5s1QexBQnhhxPTs49zpIdBUyKQBHvOXPaLklB3J', N'Android', N'lahaina', N'OnePlus', N'', CAST(N'2021-09-07T04:44:10.6600000' AS DateTime2), N'N         ', CAST(N'2021-09-07T04:44:10.6600000' AS DateTime2), CAST(N'2021-09-07T04:44:10.6600000' AS DateTime2), 2, N'Android 11', N'd84d6215-d02f-4f0a-8285-fa7105cf4d0b', N'zh-CN')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (43, N'E78EBB8A-2FE3-4A71-A662-F134D47EEA66', N'1350D1787FB15381D73A686E51502486F75BDFB2D586FC16DA10132599A0F166', N'iOS', N'iPhone12,1', N'Apple', N'', CAST(N'2021-09-07T10:07:39.4066667' AS DateTime2), N'N         ', CAST(N'2021-09-07T10:07:39.4066667' AS DateTime2), CAST(N'2021-09-07T10:07:39.4066667' AS DateTime2), 1, N'iOS 14.7.1', N'2b194ca6-4eeb-4d1a-96a3-5462e732d646', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (44, N'E78EBB8A-2FE3-4A71-A662-F134D47EEA66', N'07DA2FFA74C5F0CE427382A19597F034DB3D09798EB0AFCE0BEBF4FEA50925E6', N'iOS', N'iPhone12,1', N'Apple', N'', CAST(N'2021-09-07T10:15:26.3433333' AS DateTime2), N'N         ', CAST(N'2021-09-07T10:15:26.3433333' AS DateTime2), CAST(N'2021-09-07T10:15:26.3433333' AS DateTime2), 1, N'iOS 14.7.1', N'cb83066b-0dd9-4185-818a-1a2f9f51e3e5', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (45, N'7673cf9e4919f8e0', N'd3NQJcsRQjWQhXT7FY5Gt1:APA91bGqWku7jqsIgTjoOB_LAOcw5fhLtjEorUy6c6hYdeTD3Lg6o_GA3sQAv93IkblvjNbNCXPMGts2f3MjrClNctBfR2qlTbaze2JAw414LiTjwZnEY4DkGOBzzntSyjlHivzd-WE2', N'Android', N'msmnile', N'samsung', N'', CAST(N'2021-09-08T02:22:33.6266667' AS DateTime2), N'N         ', CAST(N'2021-09-08T02:22:33.6266667' AS DateTime2), CAST(N'2021-09-08T02:22:33.6266667' AS DateTime2), 2, N'Android 11', N'958cc45f-30a9-43cc-8f07-b9375c54d769', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (46, N'7673cf9e4919f8e0', N'cObpEaGpRNu1yzhHaNQ3ve:APA91bEVFHv0JTdFseNZl3afnilDLTds6v-nLIJOYPP6ZpMJJIXfZfJ3uEDvrwYPZYO4eK44LilGx5hD4TSnYEL6QX_Vme6odyi1DRCVaORlO8-EenxLIICeSQAnJ3jJrNWaUqMzOomV', N'Android', N'msmnile', N'samsung', N'', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-09-08T02:26:40.3266667' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 2, N'Android 11', N'f77a4047-eb89-4eef-9c2a-d970decdc291', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (47, N'E78EBB8A-2FE3-4A71-A662-F134D47EEA66', N'C0E8940627A0F5443E5692C2E97B67045B0703976773F50E9C104C70DB9154F1', N'iOS', N'iPhone12,1', N'Apple', N'', CAST(N'2021-09-08T03:09:47.1066667' AS DateTime2), N'N         ', CAST(N'2021-09-08T03:09:47.1066667' AS DateTime2), CAST(N'2021-09-08T03:09:47.1066667' AS DateTime2), 1, N'iOS 14.7.1', N'8752f36a-d0ba-4b37-9ef7-68f406a460d8', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (48, N'E78EBB8A-2FE3-4A71-A662-F134D47EEA66', N'F8C071C78C8BAB8A8B403B3E798A36AAEDF084ADB23F6419FEA709E916E8AAE3', N'iOS', N'iPhone12,1', N'Apple', N'', CAST(N'2021-09-08T09:05:49.2533333' AS DateTime2), N'N         ', CAST(N'2021-09-08T09:05:49.2533333' AS DateTime2), CAST(N'2021-09-08T09:05:49.2533333' AS DateTime2), 1, N'iOS 14.7.1', N'5c1316e3-3488-4145-b030-e1abe5ac19d7', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (49, N'E78EBB8A-2FE3-4A71-A662-F134D47EEA66', N'7C72334DBC823AA4F7605EEAC456AB72D22160AA831317F1B46C07088B11DFE0', N'iOS', N'iPhone12,1', N'Apple', N'', CAST(N'2021-09-10T10:05:29.0100000' AS DateTime2), N'N         ', CAST(N'2021-09-10T10:05:29.0100000' AS DateTime2), CAST(N'2021-09-10T10:05:29.0100000' AS DateTime2), 1, N'iOS 14.7.1', N'caf38dff-e860-40c8-9471-54023ea9d9db', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (50, N'E78EBB8A-2FE3-4A71-A662-F134D47EEA66', N'ABC51FD4F60764FD516159419792C5507638AF7E3F04872FAA60CBF99903D15E', N'iOS', N'iPhone12,1', N'Apple', N'', CAST(N'2021-09-10T10:17:09.4900000' AS DateTime2), N'N         ', CAST(N'2021-09-10T10:17:09.4900000' AS DateTime2), CAST(N'2021-09-10T10:17:09.4900000' AS DateTime2), 1, N'iOS 14.7.1', N'a927dd67-093b-4732-8297-fdc2ec5d4c10', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (51, N'E78EBB8A-2FE3-4A71-A662-F134D47EEA66', N'E9DEFC69E83752420102AA6D42087EADCAF2301CA364E00C5DFA4FBA1281EEF6', N'iOS', N'iPhone12,1', N'Apple', N'10017460', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-09-13T07:28:32.7033333' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 1, N'iOS 14.7.1', N'68e75ce7-b99b-40f4-bfd1-0e95058dc6f9', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (52, N'4E9C346B-8B49-4FD9-8C93-8F3E0DCD4FB5', N'9867E041B637304E02906D051F57195B1D5721CA2F9EFA5C4C9590EBD07AB0D3', N'iOS', N'iPhone11,8', N'Apple', N'', CAST(N'2021-09-13T07:31:35.9700000' AS DateTime2), N'N         ', CAST(N'2021-09-13T07:31:35.9700000' AS DateTime2), CAST(N'2021-09-13T07:31:35.9700000' AS DateTime2), 1, N'iOS 14.3', N'e2361842-7ba3-469c-8eee-9b1a148fd4a1', N'zh-CN')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (53, N'BAB1F454-B997-419E-87B4-D9B53D1E636A', N'B8DA1B389D6470078746A9A4FC24BEA01B0EBEF27DCFB237E576E44D535C1327', N'iOS', N'iPhone12,5', N'Apple', N'10030826', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-09-13T09:28:30.1300000' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 1, N'iOS 15.1', N'cf46efcf-82f3-47de-bb5e-96fb61aaecbc', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (54, N'17B6D57E-5EF5-48F4-A948-5D071CD9CE29', N'5A25EF45F04E8CA02A25333B34E5D10E3AA18558F9E443E61F950CC7308B2BD2', N'iOS', N'iPhone11,8', N'Apple', N'10017460', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-09-23T08:04:08.8333333' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 1, N'iOS 14.7.1', N'6aebe988-2953-45b6-9d84-81a8dcd2eff3', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (55, N'17B6D57E-5EF5-48F4-A948-5D071CD9CE29', N'D19FCFC911104CC394EC0681B6D11B177CF4676A17ADBDDA49293851875A4FAE', N'iOS', N'iPhone11,8', N'Apple', N'10017460', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-09-23T10:08:55.2133333' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 1, N'iOS 14.7.1', N'c61ce2f8-872a-4f0d-b513-fd649a5c061d', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (56, N'17B6D57E-5EF5-48F4-A948-5D071CD9CE29', N'8E4B348DC657D6559FFF71C9A7869A8036F6FF89DF34423F38D25200C39B33C9', N'iOS', N'iPhone11,8', N'Apple', N'10017460', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-09-27T09:38:10.5233333' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 1, N'iOS 14.7.1', N'2b6715b5-0b34-44c4-baab-79dceebc0d51', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (57, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'b66cd8e35e852fa2c26e4fcb6f8d1c639e48b42459ba313b4a1122fe52c55990', N'ios', N'iPhone 12', N'Apple', N'10030767', CAST(N'2021-09-28T10:18:52.2400000' AS DateTime2), N'N         ', CAST(N'2021-09-28T10:18:52.2400000' AS DateTime2), CAST(N'2021-09-28T10:18:52.2400000' AS DateTime2), 1, N'iOS 14', N'fd27bc4f-fc3c-4d47-93d2-f4994410f784', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (58, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'b66cd8e35e852fa2c26e4fcb6f8d1c639e48b42459ba313b4a1122fe52c55990', N'ios', N'iPhone 12', N'Apple', N'10030767', CAST(N'2021-09-28T10:19:08.2033333' AS DateTime2), N'N         ', CAST(N'2021-09-28T10:19:08.2033333' AS DateTime2), CAST(N'2021-09-28T10:19:08.2033333' AS DateTime2), 1, N'iOS 14', N'c7acd2fb-abd2-488e-8254-845c1b8d873d', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (59, N'qafd4cb8fd3-5681-477d-b16c-67c6f0e873f42', N'b66cd8e35e852fa2c26e4fcb6f8d1c639e48b42459ba313b4a1122fe52c55990', N'ios', N'iPhone 12', N'Apple', N'1000002', CAST(N'2021-09-29T03:29:12.7866667' AS DateTime2), N'N         ', CAST(N'2021-09-29T03:29:12.7866667' AS DateTime2), CAST(N'2021-09-29T03:29:12.7866667' AS DateTime2), 1, N'iOS 14', N'fda32813-781b-4c1d-bcbd-17d858967784', N'en')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (60, N'E78EBB8A-2FE3-4A71-A662-F134D47EEA66', N'70A40084054415CE40FCAF479E4E7481116A9275E65AD3AA6411DEC60EC6C051', N'iOS', N'iPhone12,1', N'Apple', NULL, CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-09-30T03:10:34.4233333' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 1, N'iOS 14.7.1', N'3901302f-606a-4fe1-972b-250f417df647', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (61, N'E78EBB8A-2FE3-4A71-A662-F134D47EEA66', N'DC6B0A34F528E628B80E4323A2F836CDBCA9B801107FE0603C337D563F27BBFD', N'iOS', N'iPhone12,1', N'Apple', N'10030826', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-09-30T03:22:24.0566667' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 1, N'iOS 14.7.1', N'0441ef82-25e4-465c-8689-66c1ab4422da', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (62, N'251855d2eb147fc6', N'f8XcIdMpTzqcRBMSaUH0p6:APA91bGACTyxKSe4H9tT6YVw_SWjZFRVTp3oy8xzou96eE8IDoW4WnAKuAox-3YIgrK-htC3v0mJiDmnHxLHbaUrzSdaKsnijNVJX1oePhWSpkd-675pDFLCdQqAP_PwGKhV18GFDWCw', N'Android', N'msmnile', N'samsung', N'10017460', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-10-07T02:16:20.7333333' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 2, N'Android 11', N'ef906a65-bc3a-4e2a-b492-50d024523fd9', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (63, N'098e2098dc0a6a7f', N'dgfKm8JRQ3C5SMkAbsn9Hn:APA91bH1rHpgWCG79_ul74l3IyzVhy9BRC6TTVZm8MENwBv3Xzm_ULFvNa9hw-JIObFzlcbXPioolXVWLu0ih_Drc9LvQCYpNsLtv6tuKIr7E_O5CgfUyQi8Jk43NJz9Hs79g7pMUXAc', N'Android', N'VOG', N'HUAWEI', N'10017564', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-10-08T07:13:27.3433333' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 2, N'Android 9', N'0ad1db64-ff8e-4beb-a71a-e2c51747e41b', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (64, N'7673cf9e4919f8e0', N'eUIgybEiQ_S0PPlhf0S0jU:APA91bFmtNa5zgUjL_TziFepxAzxQdwEEC06CO6FymeKM6Gi8hRolPj6FWvsq5s-NaxIltHNbmF647PjhgbwlECQUpbpdVPG-FSMBFjUjG0QFrv1n-ib5MPlQGM8bglbF-vweDsjauTK', N'Android', N'msmnile', N'samsung', N'10017460', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-10-11T08:15:44.3200000' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 2, N'Android 11', N'8aa104ef-46d0-4254-80cb-9ac00064d730', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (65, N'7673cf9e4919f8e0', N'f9goEO4aShevQOa9JzY8ng:APA91bFG5ioeF-cRIarqxR6jMwFaq5vs7JOtk3vz2i5O2OZpFTkLv8MSznsHwX9Xt5YnRHlsmGwFqtFKf87WsiOittlNkjRYHBskFoZdA8NTUaDF_aGijRSeEPfhbKbbUYbYL4R5R5j8', N'Android', N'msmnile', N'samsung', N'10017460', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-10-18T02:24:32.9033333' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 2, N'Android 11', N'a1228e23-5bad-451b-a3fd-c646183b1829', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (66, N'31e8db4ea78f0dd5', N'eUXRquziQvy40yduFEoOeL:APA91bE-Bk5Qo1bT3Plv50_QRMOALDquGIQ_KmKeNs_49y8jM0YUV53LLvd0qY_ICK7-Na24RFgDUB-eOKhp-gEXPtF_hI9UC0DxOsfADCs-y9mub61nXs8cHuVGHV_yo0Gc6GExak33', N'Android', N'msmnile', N'samsung', N'10017564', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-10-19T02:38:47.1466667' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 2, N'Android 10', N'39a3fedf-6962-49fb-87af-6c582ffc963a', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (67, N'01FBA4B2-2241-4807-A856-86256C10A360', N'206F15F90902DB172C0726B7FAF78022F24B320C6F2C821389AA528D8AFA3270', N'iOS', N'iPhone10,3', N'Apple', N'10017564', CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), N'N         ', CAST(N'2021-10-25T03:56:55.0300000' AS DateTime2), CAST(N'1753-01-01T00:00:00.0000000' AS DateTime2), 1, N'iOS 14.2', N'86ae62e7-c5d1-48f8-a4ec-1344e0ba122e', N'en-US')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (68, N'01FBA4B2-2241-4807-A856-86256C10A360', N'17B5530255037DD7BAE48EDEE30576E7F402EA885C93E1C4649792D677A5FBAF', N'iOS', N'iPhone10,3', N'Apple', N'', CAST(N'2021-10-25T07:14:48.5233333' AS DateTime2), N'N         ', CAST(N'2021-10-25T07:14:48.5233333' AS DateTime2), CAST(N'2021-10-25T07:14:48.5233333' AS DateTime2), 1, N'iOS 14.2', N'176471dc-8201-4552-a6cf-ef6adb62b348', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (69, N'17B6D57E-5EF5-48F4-A948-5D071CD9CE29', N'21858F97122DDE0B999FC52A4CC8361FB7ACCC184E0A706C7C5EEF1BD074DBDF', N'iOS', N'iPhone11,8', N'Apple', N'', CAST(N'2021-10-25T07:53:15.1966667' AS DateTime2), N'N         ', CAST(N'2021-10-25T07:53:15.1966667' AS DateTime2), CAST(N'2021-10-25T07:53:15.1966667' AS DateTime2), 1, N'iOS 14.7.1', N'71060cb0-5d24-4a0b-8a35-bc0ead17b706', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (70, N'17B6D57E-5EF5-48F4-A948-5D071CD9CE29', N'8813FC971B9436DD58FC7BECF91C4C8CA6B12C9D1BDEC5B231BDC6CB2814F1F0', N'iOS', N'iPhone11,8', N'Apple', N'', CAST(N'2021-10-25T08:26:07.1866667' AS DateTime2), N'N         ', CAST(N'2021-10-25T08:26:07.1866667' AS DateTime2), CAST(N'2021-10-25T08:26:07.1866667' AS DateTime2), 1, N'iOS 14.7.1', N'80b170c5-7f43-4263-b451-faf89f1a4161', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (71, N'17B6D57E-5EF5-48F4-A948-5D071CD9CE29', N'5BE834CE6255AAD6F094052A7AE4B1FB675FC4EF879D933A1F454CA8636C5949', N'iOS', N'iPhone11,8', N'Apple', N'', CAST(N'2021-10-25T08:54:20.4300000' AS DateTime2), N'N         ', CAST(N'2021-10-25T08:54:20.4300000' AS DateTime2), CAST(N'2021-10-25T08:54:20.4300000' AS DateTime2), 1, N'iOS 14.7.1', N'34f79aa2-dbb1-425f-9c17-a33cc555a9c1', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (72, N'17B6D57E-5EF5-48F4-A948-5D071CD9CE29', N'CED1E6B810368DE4F58A66BA6BA78C94A80BAECCD40BBE0E478152A005C475A4', N'iOS', N'iPhone11,8', N'Apple', N'', CAST(N'2021-10-25T09:03:49.3900000' AS DateTime2), N'N         ', CAST(N'2021-10-25T09:03:49.3900000' AS DateTime2), CAST(N'2021-10-25T09:03:49.3900000' AS DateTime2), 1, N'iOS 14.7.1', N'cbdb36cc-36fe-462c-b50d-e9274c0ebb46', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (73, N'1AA77803-CB6B-4925-A55F-DDECD695818D', N'325DEE000E1156440F380D5C2E15EE6C9319CB14A08F99E978EDB47C6A4CB336', N'iOS', N'iPhone8,2', N'Apple', N'', CAST(N'2021-10-25T09:30:00.4866667' AS DateTime2), N'N         ', CAST(N'2021-10-25T09:30:00.4866667' AS DateTime2), CAST(N'2021-10-25T09:30:00.4866667' AS DateTime2), 1, N'iOS 13.5.1', N'64e481be-dc3c-4a74-800d-39e6e0854ff3', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (74, N'1AA77803-CB6B-4925-A55F-DDECD695818D', N'BD6074BA923FD91ED9052FE7BDAE6A5511684E356A4F6E63F64B50BCC279F153', N'iOS', N'iPhone8,2', N'Apple', N'', CAST(N'2021-10-25T09:48:09.7900000' AS DateTime2), N'N         ', CAST(N'2021-10-25T09:48:09.7900000' AS DateTime2), CAST(N'2021-10-25T09:48:09.7900000' AS DateTime2), 1, N'iOS 13.5.1', N'b881bbfe-468c-4243-9f62-698b57969f76', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (75, N'1AA77803-CB6B-4925-A55F-DDECD695818D', N'C09E712FB428B5D547587F12510E05681ADBCB1854D31D8EBE73BDA3659CF651', N'iOS', N'iPhone8,2', N'Apple', N'', CAST(N'2021-10-25T10:06:49.2566667' AS DateTime2), N'N         ', CAST(N'2021-10-25T10:06:49.2566667' AS DateTime2), CAST(N'2021-10-25T10:06:49.2566667' AS DateTime2), 1, N'iOS 13.5.1', N'de81159d-c87e-4878-9c6f-08490360c9a5', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (76, N'1AA77803-CB6B-4925-A55F-DDECD695818D', N'9085839E50460C289336DB595B431212F32695AAE662DE1802FAAAB3494C8420', N'iOS', N'iPhone8,2', N'Apple', N'', CAST(N'2021-10-25T10:24:02.1166667' AS DateTime2), N'N         ', CAST(N'2021-10-25T10:24:02.1166667' AS DateTime2), CAST(N'2021-10-25T10:24:02.1166667' AS DateTime2), 1, N'iOS 13.5.1', N'03b47d65-48e7-4c82-9cc1-891401d075eb', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (77, N'1AA77803-CB6B-4925-A55F-DDECD695818D', N'39A43C0CDE046B33C0BB447C70BDF6539874FEE20220352BA6170256047207FD', N'iOS', N'iPhone8,2', N'Apple', N'', CAST(N'2021-10-25T10:42:03.9366667' AS DateTime2), N'N         ', CAST(N'2021-10-25T10:42:03.9366667' AS DateTime2), CAST(N'2021-10-25T10:42:03.9366667' AS DateTime2), 1, N'iOS 13.5.1', N'99783f41-92dd-496a-b914-7ca9e98042af', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (78, N'1AA77803-CB6B-4925-A55F-DDECD695818D', N'C1DE7FF52C1D679E2D3BC1F794662B9CB7B7A3B6A0E033DAF4B02FBBD7FA0FA5', N'iOS', N'iPhone8,2', N'Apple', N'', CAST(N'2021-10-25T10:57:12.1000000' AS DateTime2), N'N         ', CAST(N'2021-10-25T10:57:12.1000000' AS DateTime2), CAST(N'2021-10-25T10:57:12.1000000' AS DateTime2), 1, N'iOS 13.5.1', N'2e36135c-ae64-43ca-9d0e-eddca7a1cfe1', N'zh-TW')
INSERT [dbo].[devices] ([id], [device_uuid], [device_token], [device_type], [model], [manufacturer], [user_id], [last_connected_at], [status], [utc_create], [utc_modified], [push_type], [device_os], [device_id], [language]) VALUES (79, N'f76e9d78441e1692', N'cUhTVHBFRk-wGSWG0PyAMd:APA91bGpSZJ6WA1cyZXXhhOBOmY8xm2n0XXarCRAnacGoG9o2wcjjisrItn9U4ior_O_1obGjjirUMfhbf3onfC7ospGque3Y18XZl-OG3IEsgLUHeAfEfSd1lxZgJ8eAWbbFYGmR4jJ', N'Android', N'exynos9610', N'samsung', N'', CAST(N'2021-10-27T09:11:15.4600000' AS DateTime2), N'N         ', CAST(N'2021-10-27T09:11:15.4600000' AS DateTime2), CAST(N'2021-10-27T09:11:15.4600000' AS DateTime2), 2, N'Android 11', N'56f59e8b-cfe4-41d0-99b5-ccbd4c249578', N'en-US')
SET IDENTITY_INSERT [dbo].[devices] OFF
SET IDENTITY_INSERT [dbo].[message_types] ON 

INSERT [dbo].[message_types] ([id], [code], [description], [utc_create]) VALUES (1, N'1001', N'System message', CAST(N'2020-12-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[message_types] ([id], [code], [description], [utc_create]) VALUES (2, N'1002', N'Chat notification', CAST(N'2020-12-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[message_types] ([id], [code], [description], [utc_create]) VALUES (3, N'1003', N'SMS OTP', CAST(N'2020-12-10T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[message_types] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_msg_push_types_code]    Script Date: 11/16/2021 6:51:14 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_msg_push_types_code] ON [dbo].[message_types]
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_msg_messages_code]    Script Date: 11/16/2021 6:51:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_msg_messages_code] ON [dbo].[push_messages]
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_msg_messages_code_copy1]    Script Date: 11/16/2021 6:51:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_msg_messages_code_copy1] ON [dbo].[sms_messages]
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[devices] ADD  DEFAULT ('N') FOR [status]
GO
ALTER TABLE [dbo].[devices] ADD  DEFAULT ((1)) FOR [push_type]
GO
ALTER TABLE [dbo].[push_messages] ADD  DEFAULT ((1)) FOR [push_type]
GO
ALTER TABLE [dbo].[push_messages] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[user_badges] ADD  DEFAULT ((0)) FOR [badge]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'N: Normal  D: Disabled' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'devices', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1:APNs 2:Firebase' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'devices', @level2type=N'COLUMN',@level2name=N'push_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Device OS version
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'devices', @level2type=N'COLUMN',@level2name=N'device_os'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Device language' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'devices', @level2type=N'COLUMN',@level2name=N'language'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1:APNs 2:Firebase' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'push_messages', @level2type=N'COLUMN',@level2name=N'push_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0: Queue 1: Success 2: Fail' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'push_messages', @level2type=N'COLUMN',@level2name=N'status'
GO
USE [master]
GO
ALTER DATABASE [gm_notification] SET  READ_WRITE 
GO
