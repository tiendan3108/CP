USE [master]
GO
/****** Object:  Database [HPS]    Script Date: 06/25/2015 22:14:55 ******/
CREATE DATABASE [HPS] ON  PRIMARY 
( NAME = N'HPS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\HPS.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'HPS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\HPS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [HPS] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HPS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HPS] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [HPS] SET ANSI_NULLS OFF
GO
ALTER DATABASE [HPS] SET ANSI_PADDING OFF
GO
ALTER DATABASE [HPS] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [HPS] SET ARITHABORT OFF
GO
ALTER DATABASE [HPS] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [HPS] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [HPS] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [HPS] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [HPS] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [HPS] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [HPS] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [HPS] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [HPS] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [HPS] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [HPS] SET  DISABLE_BROKER
GO
ALTER DATABASE [HPS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [HPS] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [HPS] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [HPS] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [HPS] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [HPS] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [HPS] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [HPS] SET  READ_WRITE
GO
ALTER DATABASE [HPS] SET RECOVERY FULL
GO
ALTER DATABASE [HPS] SET  MULTI_USER
GO
ALTER DATABASE [HPS] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [HPS] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'HPS', N'ON'
GO
USE [HPS]
GO
/****** Object:  Table [dbo].[Season]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Season](
	[SeasonID] [int] IDENTITY(1,1) NOT NULL,
	[SeasonName] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Season] PRIMARY KEY CLUSTERED 
(
	[SeasonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Season] ON
INSERT [dbo].[Season] ([SeasonID], [SeasonName]) VALUES (1, N'Xuân')
INSERT [dbo].[Season] ([SeasonID], [SeasonName]) VALUES (2, N'Hạ')
INSERT [dbo].[Season] ([SeasonID], [SeasonName]) VALUES (3, N'Thu')
INSERT [dbo].[Season] ([SeasonID], [SeasonName]) VALUES (4, N'Đông')
SET IDENTITY_INSERT [dbo].[Season] OFF
/****** Object:  Table [dbo].[ProductStatus]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductStatus](
	[ProductStatusID] [int] IDENTITY(1,1) NOT NULL,
	[ProductStatusName] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[ProductStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ProductStatus] ON
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (1, N'Not Available')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (2, N'Available')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (3, N'On Web')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (4, N'Ordered')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (5, N'Sold')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (6, N'Cancel')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (7, N'Completed')
SET IDENTITY_INSERT [dbo].[ProductStatus] OFF
/****** Object:  Table [dbo].[Category]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[ParentID] [int] NULL,
	[EnglishName] [varchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (1, N'Nam', NULL, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (2, N'Nữ', NULL, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (3, N'Trẻ em', NULL, N'FashionBoys')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (5, N'Giày', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (6, N'Quần Jean', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (7, N'Đồng hồ', 1, N'Watches')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (8, N'Giày', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (9, N'Túi xách', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (10, N'Đồng hồ', 2, N'Watches')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (11, N'Quần Jean', 3, N'FashionBoys')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (12, N'Áo thun', 3, N'FashionBoys')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (13, N'Quần Jean', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (14, N'Đồng hồ', 2, N'Watches')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (15, N'Áo Khoác', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (16, N'Áo thun', 1, N'FashionMen')
SET IDENTITY_INSERT [dbo].[Category] OFF
/****** Object:  Table [dbo].[Brand]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[BrandName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[BrandName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Adidas')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Altra')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Asic')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Casio')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Citizen')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Fortis')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Fossil')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Gucci')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Hamilton')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Hublot')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Jordan')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Kenneth')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'LG')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Luminox')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Maurice')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Motorola')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Movado')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'New Balance')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'NIKE')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'NIXON')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Omega')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Pearl')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Raymond')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Reebok')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Rolex')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Salomon')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Samsung')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Seiko')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'SO&CO')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Stuhrling')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Timex')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Tissot')
INSERT [dbo].[Brand] ([BrandName]) VALUES (N'Tommy Hilfiger')
/****** Object:  Table [dbo].[Account]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Status] [varchar](20) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](250) NULL,
	[Phone] [varchar](15) NULL,
	[Email] [varchar](50) NULL,
	[PaypalAccount] [varchar](30) NULL,
	[Role] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'admin1', N'123456', N'active', N'admin1', N'CVPM Quang Trung', N'3456789876', N'admin1@gmail.com', N'admin', N'admin')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'customer1', N'123456', N'active', N'customer1', N'CVPM Quang Trung', N'98134567876', N'HoangNH17193@gmail.com', N'customer1', N'member')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'Guest', N'000000', N'active', N'Guest', NULL, NULL, NULL, NULL, N'guest')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'storeOwner1', N'123456', N'active', N'StoreOnwer1', N'123 Quang Trung', N'1234567890', N'StoreOwner1@gmial.com', N'Staff1@gmail.com', N'storeOwner')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'storeOwner2', N'123456', N'active', N'storeOwner2', N'CVPM Quang Trung', N'1234567890', N'storeOwner2', N'storeowner2', N'storeOwner')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'storeOwner3', N'123456', N'active', N'storeOwner3', N'CVPM Quang Trung', N'3456787657', N'storeOwner3', N'', N'storeOwner')
/****** Object:  Table [dbo].[ConsignmentStatus]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConsignmentStatus](
	[ConsignmentStatusID] [int] IDENTITY(1,1) NOT NULL,
	[ConsignmentStatusName] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_ConsignmentStatus] PRIMARY KEY CLUSTERED 
(
	[ConsignmentStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ConsignmentStatus] ON
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (1, N'Waiting')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (2, N'Refuse')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (3, N'Accepted')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (4, N'Completed')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (5, N'Received')
SET IDENTITY_INSERT [dbo].[ConsignmentStatus] OFF
/****** Object:  Table [dbo].[Member]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Member](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_Table_1] UNIQUE NONCLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Member] ON
INSERT [dbo].[Member] ([MemberID], [AccountID]) VALUES (1, N'customer1')
INSERT [dbo].[Member] ([MemberID], [AccountID]) VALUES (5, N'Guest')
SET IDENTITY_INSERT [dbo].[Member] OFF
/****** Object:  Table [dbo].[StoreOwner]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StoreOwner](
	[StoreOwnerID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [varchar](50) NOT NULL,
	[Formula] [float] NOT NULL,
 CONSTRAINT [PK_StoreOwner] PRIMARY KEY CLUSTERED 
(
	[StoreOwnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UX_Table_1] UNIQUE NONCLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[StoreOwner] ON
INSERT [dbo].[StoreOwner] ([StoreOwnerID], [AccountID], [Formula]) VALUES (1, N'storeOwner1', 10)
INSERT [dbo].[StoreOwner] ([StoreOwnerID], [AccountID], [Formula]) VALUES (2, N'storeOwner2', 12)
INSERT [dbo].[StoreOwner] ([StoreOwnerID], [AccountID], [Formula]) VALUES (3, N'storeOwner3', 15)
SET IDENTITY_INSERT [dbo].[StoreOwner] OFF
/****** Object:  Table [dbo].[StoreOwner_Category]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreOwner_Category](
	[StoreOwnerID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_StoreOwner_Category] PRIMARY KEY CLUSTERED 
(
	[StoreOwnerID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 5)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 7)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 8)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 10)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 6)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 9)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 11)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 12)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 5)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 6)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 7)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 8)
/****** Object:  Table [dbo].[Order]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [varchar](10) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Date] [date] NULL,
	[Email] [varchar](50) NULL,
	[FullName] [varchar](30) NULL,
	[Address] [varchar](50) NULL,
	[Phone] [varchar](15) NULL,
	[TotalPrice] [float] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'0KTIRUINL5', 5, CAST(0x183A0B00 AS Date), N'', N'', N'', N'0979146541', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'2FB68AILS1', 5, CAST(0x1A3A0B00 AS Date), N'HoangNHSE61007@fpt.edu.vn', N'', N'', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'5UN6F91GA5', 1, CAST(0x173A0B00 AS Date), N'HoangNH17193@gmail.com', N'customer1', N'CVPM Quang Trung', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'69KJVTUXO3', 5, CAST(0x183A0B00 AS Date), N'', N'', N'', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'FG08H2BPEE', 5, CAST(0x173A0B00 AS Date), N'', N'', N'', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'FKJN7A68Z3', 5, CAST(0x173A0B00 AS Date), N'', N'', N'', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'KVIWFAQ38W', 5, CAST(0x173A0B00 AS Date), N'', N'', N'', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'L50ENNMNI9', 5, CAST(0x183A0B00 AS Date), N'', N'', N'', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'LJXCRD4NIW', 5, CAST(0x183A0B00 AS Date), N'', N'', N'', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'MX9EZXXS3X', 5, CAST(0x173A0B00 AS Date), N'', N'', N'', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'NTQIKOVDD6', 1, CAST(0x173A0B00 AS Date), N'HoangNH17193@gmail.com', N'customer1', N'CVPM Quang Trung', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'OM9ZTL8BZP', 1, CAST(0x173A0B00 AS Date), N'HoangNH17193@gmail.com', N'customer1', N'CVPM Quang Trung', N'98134567876', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'SKARH1GZYT', 5, CAST(0x113A0B00 AS Date), N'abc@yahoo.com', NULL, NULL, NULL, NULL)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'VWN5EN44I6', 5, CAST(0x173A0B00 AS Date), N'', N'', N'', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'XKNJ8X4ZU2', 5, CAST(0x173A0B00 AS Date), N'', N'', N'', N'01689191917', 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice]) VALUES (N'YHB66FARTM', 5, CAST(0x183A0B00 AS Date), N'', N'', N'', N'01689191917', 0)
/****** Object:  Table [dbo].[Product]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SerialNumber] [varchar](20) NULL,
	[PurchasedDate] [date] NULL,
	[CategoryID] [int] NOT NULL,
	[Brand] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[Image] [varchar](100) NOT NULL,
	[ProductStatusID] [int] NOT NULL,
	[SellingPrice] [float] NULL,
	[OrderID] [varchar](10) NULL,
	[SellDate] [date] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (2, N'Casio Gshock GA110', N'1234567890', CAST(0xBE320B00 AS Date), 7, N'Casio', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/GA110AC-7A_xlarge.png', 5, 500000, N'69KJVTUXO3', NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (3, N'Casio Gshock GA 400', N'34567890', CAST(0xB9350B00 AS Date), 7, N'Casio', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/GA400-4B_xlarge.png', 3, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (7, N'Citizen 2014', N'987655678', CAST(0x21380B00 AS Date), 7, N'Citizen', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/citizen1.JPG', 2, 500000, N'2FB68AILS1', NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (8, N'Tag Heuer 2014', N'868677676', CAST(0xFC380B00 AS Date), 7, N'Tag Heuer', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/tag1.jpg', 2, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (9, N'Tag Heuer 2015', N'567895678', CAST(0x6F390B00 AS Date), 7, N'Tag Heuer', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/tag2.jpg', 4, 500000, N'0KTIRUINL5', NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (10, N'Nike Jordan 4', N'972387838', CAST(0x3E380B00 AS Date), 5, N'Nike', N'JORDAN RETRO, dòng sản phẩm đang gây nên cơn sốt cho các sneakerhead trên toàn thế giới, nay đã lên kệ tại thị trường Việt Nam.', N'assets/image/nike_air_jordan_4_retro_2013110110_0.jpg', 3, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (11, N'Levis 501 ', N'878347384', CAST(0xEA390B00 AS Date), 6, N'Levis', N'Levi Strauss & Co (LS & CO) là một công ty quần áo tư nhân nổi tiếng trên toàn thế giới với thương hiệu Levi’s (phiên âm tiếng Anh: /’liːvʌɪz/) dành cho quần jean', N'assets/image/LevisJean.jpg', 3, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (13, N'skinyJean 302 ', N'3456789875', CAST(0x663A0B00 AS Date), 13, N'Levis', N'Levi Strauss & Co (LS & CO) là một công ty quần áo tư nhân nổi tiếng trên toàn thế giới với thương hiệu Levi’s (phiên âm tiếng Anh: /’liːvʌɪz/) dành cho quần jean', N'assets/image/skinyJean.jpg', 3, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (15, N'Nike Jordan 6', N'456787654', CAST(0x663A0B00 AS Date), 5, N'Nike', N'JORDAN RETRO, dòng sản phẩm đang gây nên cơn sốt cho các sneakerhead trên toàn thế giới, nay đã lên kệ tại thị trường Việt Nam.', N'assets/image/jordan6.jpg', 3, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (17, N'levis 511', N'24324324324', CAST(0xC13A0B00 AS Date), 6, N'Levis', N'Levi Strauss & Co (LS & CO) là một công ty quần áo tư nhân nổi tiếng trên toàn thế giới với thương hiệu Levi’s (phiên âm tiếng Anh: /’liːvʌɪz/) dành cho quần jean', N'assets/image/levis 511.jpg', 3, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (18, N'Jordano 2015', N'6785678765', CAST(0xC13A0B00 AS Date), 16, N'Jordano', N'Dạo phố sành điệu và thời trang cùng áo thun GIORDANO chất liệu thun cao cấp, cực kì thoáng mát, đính logo của hãng thời trang nổi tiếng. Giúp cho bạn nam thêm cá tính, năng động và trẻ trung.', N'assets/image/jordano.jpg', 3, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (20, N'Jordano 12AB', N'343243243', CAST(0xC13A0B00 AS Date), 16, N'Jordano', N'Dạo phố sành điệu và thời trang cùng áo thun GIORDANO chất liệu thun cao cấp, cực kì thoáng mát, đính logo của hãng thời trang nổi tiếng. Giúp cho bạn nam thêm cá tính, năng động và trẻ trung.', N'assets/image/jordano2.jpg', 6, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (21, N'Nike Jordan 1', N'23232323', CAST(0xC13A0B00 AS Date), 5, N'Nike', N'JORDAN RETRO, dòng sản phẩm đang gây nên cơn sốt cho các sneakerhead trên toàn thế giới, nay đã lên kệ tại thị trường Việt Nam.', N'assets/image/jordan1.jpg', 6, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (24, N'Adidas Color AB-1', N'3232323', CAST(0xC13A0B00 AS Date), 5, N'Adidas', N' Adidas là nhà sản xuất lớn nhất thể thao ở Đức và châu Âu và các nhà sản xuất đồ thể thao lớn thứ hai trên thế giới, sau Nike .', N'assets/image/adidas2.jpg', 1, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (25, N'Adidas super color', N'34324324', CAST(0xC13A0B00 AS Date), 5, N'Adidas', N' Adidas là nhà sản xuất lớn nhất thể thao ở Đức và châu Âu và các nhà sản xuất đồ thể thao lớn thứ hai trên thế giới, sau Nike .', N'assets/image/adidas-supercolor.jpg', 3, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (26, N'Gshock GA1000-2A', N'32432432A', CAST(0xC13A0B00 AS Date), 7, N'Casio', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/GA1000-2A.jpg', 2, 500000, N'YHB66FARTM', NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (27, N'Gshock GA 1000-2B', N'AB38433', CAST(0xC13A0B00 AS Date), 7, N'Casio', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/GA1000-2B_xlarge.png', 2, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (28, N'Gshock GA 120A', N'GB323232', CAST(0xC13A0B00 AS Date), 7, N'Casio', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/GA120.jpg', 3, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (31, N'guuci', N'', NULL, 7, N'', N'', N'./assets/image/nike_air_jordan_4_retro_2013110110_0.jpg', 4, 500000, N'L50ENNMNI9', NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (32, N'dsadsadsa', N'', CAST(0x663A0B00 AS Date), 10, N'', N'', N'./assets/image/nike_air_jordan_4_retro_2013110110_0.jpg', 4, 500000, N'LJXCRD4NIW', NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (33, N'Casio Men''s PRW-3000', N'', CAST(0x053A0B00 AS Date), 7, N'Casio', N'Mới mua 2 ngày', N'assets/image/0V07C8JURSGilgamesh.png', 3, 500000, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (34, N'Casio Gshock', NULL, CAST(0xE9390B00 AS Date), 7, N'Casio', NULL, N'assets/image/FMH80X1N6I13705704461904051487christmas_ball-1.jpg', 2, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (35, N'Jordan Men', NULL, CAST(0x053A0B00 AS Date), 5, N'Jordan', N'Mới mua 2 ngày thôi mà', N'assets/image/XF3XEC18LEkamen_rider_gaim___team_gaim___logo_by_nac129-d6qs04l.png', 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (36, N'adidas Men''s ADP3166', NULL, CAST(0xAB390B00 AS Date), 7, N'Adidas', N'Sản phẩm với tinh năng hoàn hảo và còn như mới,', N'assets/image/VGZQWN9VMQmotohiro-hata-kotonoha.jpg', 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID], [SellDate]) VALUES (37, N'Raymond Weil Men''s 77', N'123412341234', CAST(0x053A0B00 AS Date), 5, N'Raymond', N'Mới mua 2 ngày thôi', N'assets/image/IJVID45S7E600_75416c07-3928-408d-8eeb-e9943d82e9e3.jpg', 1, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
/****** Object:  Table [dbo].[Notification]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notification](
	[NotificationID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [varchar](50) NOT NULL,
	[ProductID] [int] NOT NULL,
	[IsViewed] [bit] NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product_Season]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Season](
	[ProductID] [int] NOT NULL,
	[SeasonID] [int] NOT NULL,
 CONSTRAINT [PK_Product_Season] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[SeasonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (2, 1)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (2, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (3, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (7, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (7, 3)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (7, 4)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (10, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (11, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (11, 4)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (13, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (24, 1)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (24, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (25, 1)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (26, 1)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (27, 1)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (28, 4)
/****** Object:  Table [dbo].[Consignment]    Script Date: 06/25/2015 22:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Consignment](
	[ConsignmentID] [char](10) NOT NULL,
	[ProductID] [int] NOT NULL,
	[MemberID] [int] NULL,
	[StoreOwnerID] [int] NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](250) NULL,
	[Phone] [varchar](15) NULL,
	[Email] [varchar](50) NULL,
	[PaypalAccount] [varchar](30) NULL,
	[FromDate] [date] NOT NULL,
	[ToDate] [date] NOT NULL,
	[RaiseWebDate] [date] NULL,
	[Period] [int] NOT NULL,
	[MaxPrice] [float] NULL,
	[MinPrice] [float] NULL,
	[ReturnedPrice] [float] NULL,
	[ReceivedDate] [date] NULL,
	[CreatedDate] [date] NULL,
	[ConsignmentStatusID] [int] NOT NULL,
	[CancelDate] [date] NULL,
 CONSTRAINT [PK_Consignment] PRIMARY KEY CLUSTERED 
(
	[ConsignmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Consignment] UNIQUE NONCLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'0V07C8JURS', 33, NULL, 1, N'Huỳnh Công Đức', N'asdas', N'0917533644', NULL, NULL, CAST(0x1B3A0B00 AS Date), CAST(0x1E3A0B00 AS Date), CAST(0x1B3A0B00 AS Date), 30, 130.1, 70.2, NULL, CAST(0x1B3A0B00 AS Date), CAST(0x1B3A0B00 AS Date), 5, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'2345456gdr', 8, 1, 1, N'adbsdbsbd', N'12342323', NULL, NULL, NULL, CAST(0x133A0B00 AS Date), CAST(0x163A0B00 AS Date), CAST(0x133A0B00 AS Date), 60, 1000, 600, NULL, CAST(0x1D3A0B00 AS Date), CAST(0x133A0B00 AS Date), 5, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'2345544532', 7, 1, 1, N'erwrewre', NULL, N'3423432423', NULL, NULL, CAST(0x133A0B00 AS Date), CAST(0x223A0B00 AS Date), CAST(0x133A0B00 AS Date), 60, 80, 1000, NULL, CAST(0x1D3A0B00 AS Date), CAST(0x133A0B00 AS Date), 5, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'34243254tg', 28, 1, 1, N'd', NULL, NULL, NULL, NULL, CAST(0x133A0B00 AS Date), CAST(0x133A0B00 AS Date), CAST(0x133A0B00 AS Date), 60, 50000, 5090, NULL, CAST(0x183A0B00 AS Date), CAST(0x133A0B00 AS Date), 5, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'7682786126', 10, 1, 1, N'c', NULL, NULL, NULL, NULL, CAST(0x133A0B00 AS Date), CAST(0x163A0B00 AS Date), CAST(0x133A0B00 AS Date), 60, NULL, NULL, NULL, CAST(0x133A0B00 AS Date), CAST(0x133A0B00 AS Date), 3, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'897DSD7UJG', 24, 1, 1, N'DFJ', NULL, N'2439423048', NULL, NULL, CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), 60, 43, 434, NULL, CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), 2, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'ABV1234584', 2, 1, 1, N'Customer1', N'1234567', N'016987656789', N'customer1@gmail.com', N'customer1', CAST(0x0E3A0B00 AS Date), CAST(0x133A0B00 AS Date), NULL, 60, 1000, 100, 23, CAST(0x183A0B00 AS Date), NULL, 5, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'DFGDFJD763', 21, 1, 1, N'FDSFDSF', NULL, N'8347384', NULL, NULL, CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), 60, 374, 8343, NULL, CAST(0x1B3A0B00 AS Date), CAST(0x143A0B00 AS Date), 5, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'DSSDSERFNX', 27, 1, 1, N'ABC', NULL, NULL, N'DFDF', NULL, CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), 60, 1000, 5000, NULL, CAST(0x1B3A0B00 AS Date), CAST(0x143A0B00 AS Date), 5, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'FMH80X1N6I', 34, 5, 1, N'Đăng Hoàng', N'117', N'+841289948591', NULL, NULL, CAST(0x1B3A0B00 AS Date), CAST(0x203A0B00 AS Date), NULL, 30, 77, 30, NULL, CAST(0x1B3A0B00 AS Date), CAST(0x1B3A0B00 AS Date), 5, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'fsdfsdfdsf', 9, 1, 1, N'b', NULL, NULL, NULL, NULL, CAST(0x133A0B00 AS Date), CAST(0x173A0B00 AS Date), CAST(0x133A0B00 AS Date), 60, 0, 5000, NULL, CAST(0x143A0B00 AS Date), CAST(0x133A0B00 AS Date), 3, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'IJVID45S7E', 37, 5, 1, N'Huỳnh Công Đức', N'118 Phan Văn Trị, phường 10, Ho Chi Minh, Vietnam', N'+841289948591', NULL, NULL, CAST(0x1C3A0B00 AS Date), CAST(0x1E3A0B00 AS Date), NULL, 30, NULL, NULL, NULL, NULL, CAST(0x1D3A0B00 AS Date), 1, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'JDFJDFHJJD', 26, 1, 1, N'bca', NULL, N'4738784574', NULL, NULL, CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), 60, 1000, 2000, NULL, CAST(0x1B3A0B00 AS Date), CAST(0x143A0B00 AS Date), 5, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'JDHFJDYH87', 20, 1, 1, N'FDKFJK', NULL, NULL, NULL, NULL, CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), 60, 10000, 100, NULL, CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), 2, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'KDJFDJGI98', 25, 1, 1, N'SDSDSD', NULL, N'24343', NULL, NULL, CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), CAST(0x143A0B00 AS Date), 60, 5, 10, NULL, CAST(0x163A0B00 AS Date), CAST(0x143A0B00 AS Date), 2, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'SADSADSAD2', 3, 1, 1, N'fdsfsdf', NULL, NULL, NULL, NULL, CAST(0x2B3A0B00 AS Date), CAST(0x593A0B00 AS Date), CAST(0x133A0B00 AS Date), 60, 100000, 15000, 233, CAST(0x153A0B00 AS Date), CAST(0x133A0B00 AS Date), 3, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'T52IWB5KCE', 31, NULL, 3, N'dsadsfsdf', NULL, N'45345435435', NULL, NULL, CAST(0x223A0B00 AS Date), CAST(0x143A0B00 AS Date), CAST(0x113A0B00 AS Date), 60, NULL, NULL, 2000000, CAST(0x113A0B00 AS Date), CAST(0x113A0B00 AS Date), 3, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'UR70DHVQ26', 32, NULL, 1, N'sadasdasd', NULL, N'232323232', NULL, NULL, CAST(0x2B3A0B00 AS Date), CAST(0x1A3A0B00 AS Date), CAST(0x113A0B00 AS Date), 60, NULL, NULL, 12121212, CAST(0x113A0B00 AS Date), CAST(0x113A0B00 AS Date), 3, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'VGZQWN9VMQ', 36, 5, 1, N'Âu Dương Gia Huy', N'123123', N'+841289948591', NULL, NULL, CAST(0x1C3A0B00 AS Date), CAST(0x223A0B00 AS Date), NULL, 30, 24.7896014436722, 13.386384424964895, NULL, NULL, CAST(0x1C3A0B00 AS Date), 1, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID], [CancelDate]) VALUES (N'XF3XEC18LE', 35, 5, 1, N'Âu Dương Phong', N'Hoa Quả Sơn', N'+841289948591', NULL, NULL, CAST(0x1B3A0B00 AS Date), CAST(0x223A0B00 AS Date), NULL, 30, NULL, NULL, NULL, NULL, CAST(0x1B3A0B00 AS Date), 1, NULL)
/****** Object:  ForeignKey [FK_Category_Category]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Category] FOREIGN KEY([ParentID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Category]
GO
/****** Object:  ForeignKey [FK_Customer_Account]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Customer_Account]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Account]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[StoreOwner]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[StoreOwner] CHECK CONSTRAINT [FK_StoreOwner_Account]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Category]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[StoreOwner_Category]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Category] FOREIGN KEY([StoreOwnerID])
REFERENCES [dbo].[StoreOwner] ([StoreOwnerID])
GO
ALTER TABLE [dbo].[StoreOwner_Category] CHECK CONSTRAINT [FK_StoreOwner_Category]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Category_Category]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[StoreOwner_Category]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Category_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[StoreOwner_Category] CHECK CONSTRAINT [FK_StoreOwner_Category_Category]
GO
/****** Object:  ForeignKey [FK_Order_Customer]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
/****** Object:  ForeignKey [FK_Product_Category]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
/****** Object:  ForeignKey [FK_Product_Order]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Order]
GO
/****** Object:  ForeignKey [FK_Product_ProductStatus]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductStatus] FOREIGN KEY([ProductStatusID])
REFERENCES [dbo].[ProductStatus] ([ProductStatusID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductStatus]
GO
/****** Object:  ForeignKey [FK_Notification_Account]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Account]
GO
/****** Object:  ForeignKey [FK_Notification_Product]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Product]
GO
/****** Object:  ForeignKey [FK_Product_Season_Product]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Product_Season]  WITH CHECK ADD  CONSTRAINT [FK_Product_Season_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Product_Season] CHECK CONSTRAINT [FK_Product_Season_Product]
GO
/****** Object:  ForeignKey [FK_Product_Season_Season]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Product_Season]  WITH CHECK ADD  CONSTRAINT [FK_Product_Season_Season] FOREIGN KEY([SeasonID])
REFERENCES [dbo].[Season] ([SeasonID])
GO
ALTER TABLE [dbo].[Product_Season] CHECK CONSTRAINT [FK_Product_Season_Season]
GO
/****** Object:  ForeignKey [FK_Consignment_ConsignmentStatus]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_ConsignmentStatus] FOREIGN KEY([ConsignmentStatusID])
REFERENCES [dbo].[ConsignmentStatus] ([ConsignmentStatusID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_ConsignmentStatus]
GO
/****** Object:  ForeignKey [FK_Consignment_Customer]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_Customer] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_Customer]
GO
/****** Object:  ForeignKey [FK_Consignment_Product]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_Product]
GO
/****** Object:  ForeignKey [FK_Consignment_StoreOwner]    Script Date: 06/25/2015 22:14:58 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_StoreOwner] FOREIGN KEY([StoreOwnerID])
REFERENCES [dbo].[StoreOwner] ([StoreOwnerID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_StoreOwner]
GO
