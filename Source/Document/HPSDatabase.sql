USE [master]
GO
/****** Object:  Database [HPS]    Script Date: 08/07/2015 12:35:35 ******/
CREATE DATABASE [HPS] ON  PRIMARY 
( NAME = N'HPS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008\MSSQL\DATA\HPS.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'HPS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008\MSSQL\DATA\HPS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
USE [HPS]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 08/07/2015 12:35:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[OrderStatusID] [int] IDENTITY(1,1) NOT NULL,
	[OrderStatusName] [nvarchar](30) NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[OrderStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusName]) VALUES (1, N'Waiting')
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusName]) VALUES (2, N'Completed')
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusName]) VALUES (3, N'Canceled')
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusName]) VALUES (4, N'Expired')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
/****** Object:  Table [dbo].[Season]    Script Date: 08/07/2015 12:35:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Season](
	[SeasonID] [int] IDENTITY(1,1) NOT NULL,
	[SeasonName] [nvarchar](20) NOT NULL,
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
/****** Object:  Table [dbo].[ProductStatus]    Script Date: 08/07/2015 12:35:38 ******/
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
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (8, N'NotYetReceive')
SET IDENTITY_INSERT [dbo].[ProductStatus] OFF
/****** Object:  Table [dbo].[Category]    Script Date: 08/07/2015 12:35:38 ******/
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
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (5, N'Giày Dép', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (6, N'Quần', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (7, N'Đồng hồ', 1, N'Watches')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (8, N'Giày Dép', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (9, N'Túi xách', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (10, N'Đồng hồ', 2, N'Watches')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (11, N'Quần', 3, N'FashionBoys')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (12, N'Áo thun', 3, N'FashionBoys')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (13, N'Quần ', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (14, N'Đồng hồ', 2, N'Watches')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (15, N'Áo Khoác', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (16, N'Áo thun', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (17, N'Nón', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (18, N'Mắt Kính', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (19, N'Mắt Kính', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (20, N'Nón', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (21, N'Áo Khoác', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (22, N'Thắt Lưng', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (23, N'Thắt Lưng', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (24, N'Thắt Lưng', 3, N'FashionBoys')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (25, N'Áo Khoác', 3, N'FashionBoys')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (26, N'Nón', 3, N'FashionBoys')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (27, N'Balo', 1, N'FashionMen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (28, N'Váy', 2, N'FashionWomen')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (29, N'Giày Dép', 3, N'FashionBoys')
SET IDENTITY_INSERT [dbo].[Category] OFF
/****** Object:  Table [dbo].[Brand]    Script Date: 08/07/2015 12:35:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[BrandID] [int] IDENTITY(1,1) NOT NULL,
	[BrandName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[BrandID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Brand] ON
INSERT [dbo].[Brand] ([BrandID], [BrandName]) VALUES (1, N'Casio')
INSERT [dbo].[Brand] ([BrandID], [BrandName]) VALUES (2, N'Nike')
INSERT [dbo].[Brand] ([BrandID], [BrandName]) VALUES (3, N'Adidas')
INSERT [dbo].[Brand] ([BrandID], [BrandName]) VALUES (4, N'Jordano')
INSERT [dbo].[Brand] ([BrandID], [BrandName]) VALUES (5, N'Converse')
INSERT [dbo].[Brand] ([BrandID], [BrandName]) VALUES (6, N'Tag Heuer')
INSERT [dbo].[Brand] ([BrandID], [BrandName]) VALUES (7, N'Levis')
INSERT [dbo].[Brand] ([BrandID], [BrandName]) VALUES (8, N'Citizen')
SET IDENTITY_INSERT [dbo].[Brand] OFF
/****** Object:  Table [dbo].[Account]    Script Date: 08/07/2015 12:35:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [varchar](50) NOT NULL,
	[Password] [varchar](20) NOT NULL,
	[Status] [varchar](15) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](250) NULL,
	[Phone] [varchar](15) NULL,
	[Email] [varchar](50) NULL,
	[PaypalAccount] [varchar](50) NULL,
	[Role] [varchar](10) NOT NULL,
	[GcmID] [text] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role], [GcmID]) VALUES (N'ABCStore', N'123456', N'deactive', N'Hoang', N'12345 HCM', N'01689191917', N'abce@yahoo.com', N'Paypal', N'storeOwner', NULL)
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role], [GcmID]) VALUES (N'admin1', N'123456', N'active', N'admin1', N'CVPM Quang Trung', N'3456789876', N'admin1@gmail.com', N'admin', N'admin', NULL)
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role], [GcmID]) VALUES (N'customer1', N'123456', N'active', N'customer1', N'CVPM Quang Trung', N'+841689191917', N'HoangNH17193@gmail.com', N'customer1', N'member', NULL)
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role], [GcmID]) VALUES (N'customer5', N'123456', N'active', N'Hoang', N'HCM', N'+841689191917', N'abc@yahoo.com', N'', N'member', NULL)
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role], [GcmID]) VALUES (N'Guest', N'000000', N'active', N'Guest', NULL, NULL, NULL, NULL, N'guest', NULL)
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role], [GcmID]) VALUES (N'HoangNguyen', N'123456', N'active', N'ABC', N'', N'+841689191917', N'', N'', N'member', NULL)
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role], [GcmID]) VALUES (N'HoangNH', N'123456', N'deactive', N'abc', N'123', N'+841689191917', N'test', N'', N'member', NULL)
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role], [GcmID]) VALUES (N'storeOwner1', N'123456', N'active', N'StoreOnwer1', N'CVPM Quang Trung, TPHCM', N'+841689191917', N'StoreOwner1@gmail.com', N'Staff1@gmail.com', N'storeOwner', N'fsiENlf0Ir4:APA91bGjplwivH0lYdBm0CXvu8554MhpvSV-Had54_VMiDYICw5aD6duAfSiv7RqV4ZtxgVhaR0qqPTZGHDtyuX1qzavyBhlJ1_yhNZTiTV6n4FJEx5e51vO92xJI6ZJf9Wwj4VClaDl')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role], [GcmID]) VALUES (N'storeOwner2', N'123456', N'active', N'storeOwner2', N'CVPM Quang Trung', N'1234567890', N'storeOwner2', N'storeowner2', N'storeOwner', N'fsiENlf0Ir4:APA91bGjplwivH0lYdBm0CXvu8554MhpvSV-Had54_VMiDYICw5aD6duAfSiv7RqV4ZtxgVhaR0qqPTZGHDtyuX1qzavyBhlJ1_yhNZTiTV6n4FJEx5e51vO92xJI6ZJf9Wwj4VClaDl')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role], [GcmID]) VALUES (N'storeOwner3', N'123456', N'active', N'storeOwner3', N'CVPM Quang Trung', N'3456787657', N'storeOwner3', N'', N'storeOwner', N'fsiENlf0Ir4:APA91bGjplwivH0lYdBm0CXvu8554MhpvSV-Had54_VMiDYICw5aD6duAfSiv7RqV4ZtxgVhaR0qqPTZGHDtyuX1qzavyBhlJ1_yhNZTiTV6n4FJEx5e51vO92xJI6ZJf9Wwj4VClaDl')
/****** Object:  Table [dbo].[ConsignmentStatus]    Script Date: 08/07/2015 12:35:38 ******/
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
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (6, N'Expired')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (7, N'Cancel')
SET IDENTITY_INSERT [dbo].[ConsignmentStatus] OFF
/****** Object:  Table [dbo].[Member]    Script Date: 08/07/2015 12:35:38 ******/
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
INSERT [dbo].[Member] ([MemberID], [AccountID]) VALUES (6, N'customer5')
INSERT [dbo].[Member] ([MemberID], [AccountID]) VALUES (5, N'Guest')
SET IDENTITY_INSERT [dbo].[Member] OFF
/****** Object:  Table [dbo].[Product]    Script Date: 08/07/2015 12:35:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[SerialNumber] [varchar](20) NULL,
	[PurchasedDate] [datetime] NULL,
	[CategoryID] [int] NOT NULL,
	[Brand] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[Image] [varchar](100) NOT NULL,
	[ProductStatusID] [int] NOT NULL,
	[SellingPrice] [float] NULL,
	[SellDate] [datetime] NULL,
	[IsSpecial] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (87, N'Casio Sport Solar-Powered Blue', N'079767960599', CAST(0x0000A4D500000000 AS DateTime), 7, N'Casio', N'new 100% fullbox', N'assets/image/MTWMPELC3I_51kCfkAfkuL.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (88, N'Nike Men''s Air Jordan III Retro Infrared 23 Baskeball Shoe  White/Infrared/Black  8 D(M) US', N'', NULL, 5, N'Nike', N'', N'assets/image/0UVCM1WT8T_41IK2tx8FaL.jpg', 8, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (89, N'Nike Jordan Men''s Jordan Super Fly 2 PO Black/White/Black Basketball Shoe 10 Men US', N'', NULL, 5, N'Nike', N'', N'assets/image/ARXB6F68CV_41OsAP8OJQL.jpg', 7, 1150000, CAST(0x0000A4EC00981408 AS DateTime), 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (90, N'Nike Jordan 1 Flight 2 555798 033 Basketball (11 5)', N'', NULL, 5, N'Nike', N'', N'assets/image/UU609T8F71_410Bk8dFjNL.jpg', 6, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (91, N'Nike Jordan Men''s Jordan Hydro 4 Black/White/Black Sandal 8 Men US', NULL, NULL, 5, N'Nike', N'', N'assets/image/4ITA0MFZ3T_41X9KFcUrKL.jpg', 1, NULL, NULL, 0)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (92, N'Nike Jordan Men''s Jordan Hydro ', N'', NULL, 5, N'Nike', N'', N'assets/image/MS2C00DO72_41X9KFcUrKL.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (93, N'Nike JORDAN FLIGHT', N'', NULL, 5, N'Nike', N'', N'assets/image/YEUHXEYEO8_nike_air_jordan_4_retro_2013110110_0.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (94, N'Nike Air Jordan 12 Retro XII', N'', NULL, 5, N'Nike', N'', N'assets/image/GGIG1U2UVY_41jlPmTa_2B0L.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (95, N'Nike Jordan Men''s Jordan Flight', N'', NULL, 5, N'Nike', N'', N'assets/image/Q9SA1EPCP3_nike_air_jordan_4_retro_2013110110_0.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (96, N'Converse Unisex Chuck Taylor Two Fold', N'', NULL, 8, N'Converse', N'', N'assets/image/0EFOIHJXMQ_41i4iaiOZEL.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (97, N'Converse Chuck Taylor Allstar Low Monocrom', N'', NULL, 5, N'Converse', N'', N'assets/image/5G2IM74Y93_giay-converse.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (98, N'Citizen "Eco-Drive" Stainless Steel ', N'', NULL, 7, N'Citizen', N'', N'assets/image/5HXSIAJIWL_51mK0O_2B5HDL.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (99, N'Citizen Eco-Drive Shock Proof Titanium', N'', NULL, 7, N'Citizen', N'', N'assets/image/MSXTNJ98KU_51XegThAIqL.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (100, N'Casio "G-Shock"  Digital Watch', N'', NULL, 7, N'Casio', N'', N'assets/image/ZWTTA354HM_41ssUGGPD0L.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (101, N'TAG Heuer Men''s WAY1110 FT8021 300 Aquaracer Analog Display Swiss Quartz Black Watch', NULL, NULL, 7, N'', N'', N'assets/image/E7X1K0FD21_51zXZ59tQ_2BL.jpg', 2, NULL, NULL, 0)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (102, N'TAG Heuer Analog Display Swiss Automatic ', N'', NULL, 7, N'Tag Heuer', N'', N'assets/image/6TPMD0JW27_515eUoGjZfL.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (103, N'TAG Heuer Men''s WAY1112 BA0910 Analog Display Quartz Silver Watch', NULL, NULL, 7, N'Tag Heuer', N'', N'assets/image/E5RUH3HFLS_41wBjNCRlyL.jpg', 2, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (104, N'TAG Heuer Formula 1 Black Dial', N'', NULL, 7, N'Tag Heuer', N'', N'assets/image/6YWVFQVAKH_51QELmhbl4L.jpg', 3, NULL, NULL, 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (105, N'Citizen Men''s JY8035-04E "Navihawk" Stainless Steel Eco-Drive Watch', NULL, NULL, 7, N'Citizen', N'', N'assets/image/G332GDM17Y_517RE5Ze9iL.jpg', 2, NULL, NULL, 0)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (106, N'Levi''s Men''s 517 Boot Cut Jean  Dark Stonewash  36x34', NULL, NULL, 6, N'Levis', NULL, N'assets/image/1T0HRMPCJH_41K12doIaDL.jpg', 1, NULL, NULL, 0)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (107, N'Nike Men''s Flyknit Lunar 2  TOTAL ORANGE/WHITE-GM ROYAL-DRK OBSIDIAN  9 M US', NULL, CAST(0x0000A4B200000000 AS DateTime), 5, N'Nike', N'Mới 100%, fullbox', N'assets/image/SKD7B1WTDM_41lcUpLTuLL.jpg', 6, NULL, NULL, 0)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [SellDate], [IsSpecial]) VALUES (108, N'Tag Heuer Monaco Men''s Watch WW2110 FC6177', NULL, NULL, 7, N'Tag Heuer', N'', N'assets/image/CUGIK8P8IF_41bdjz81MuL.jpg', 1, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Product] OFF
/****** Object:  Table [dbo].[StoreOwner]    Script Date: 08/07/2015 12:35:38 ******/
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
INSERT [dbo].[StoreOwner] ([StoreOwnerID], [AccountID], [Formula]) VALUES (6, N'ABCStore', 10)
SET IDENTITY_INSERT [dbo].[StoreOwner] OFF
/****** Object:  Table [dbo].[StoreOwner_Category]    Script Date: 08/07/2015 12:35:38 ******/
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
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 6)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 7)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 8)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 10)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 16)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 22)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 6)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 9)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 11)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 12)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 5)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 6)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 7)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 8)
/****** Object:  Table [dbo].[Order]    Script Date: 08/07/2015 12:35:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [varchar](10) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Date] [datetime] NULL,
	[Email] [varchar](50) NULL,
	[FullName] [nvarchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[Phone] [varchar](15) NULL,
	[TotalPrice] [float] NULL,
	[OrderStatusID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[SendPrice] [float] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice], [OrderStatusID], [ProductID], [SendPrice]) VALUES (N'97AZIFI29Q', 5, CAST(0x0000A4EC00979A28 AS DateTime), N'', N'Hoang', N'123, Ho Chi Minh City, Ho Chi Minh, Vietnam', N'+841689191917', 0, 2, 89, 1200000)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Date], [Email], [FullName], [Address], [Phone], [TotalPrice], [OrderStatusID], [ProductID], [SendPrice]) VALUES (N'H80ROAZ2E3', 5, CAST(0x0000A4EC0097C584 AS DateTime), N'', N'Hoang', N'', N'+8412342544254', 0, 3, 89, 1200000)
/****** Object:  Table [dbo].[Product_Season]    Script Date: 08/07/2015 12:35:38 ******/
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
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (87, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (88, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (92, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (97, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (98, 2)
INSERT [dbo].[Product_Season] ([ProductID], [SeasonID]) VALUES (100, 2)
/****** Object:  Table [dbo].[Consignment]    Script Date: 08/07/2015 12:35:38 ******/
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
	[PaypalAccount] [varchar](50) NULL,
	[FromDate] [datetime] NOT NULL,
	[ToDate] [datetime] NOT NULL,
	[RaiseWebDate] [datetime] NULL,
	[Period] [int] NOT NULL,
	[MaxPrice] [float] NULL,
	[MinPrice] [float] NULL,
	[ReturnedPrice] [float] NULL,
	[ReviewProductDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[ConsignmentStatusID] [int] NOT NULL,
	[CancelDate] [datetime] NULL,
	[isExpiredMessage] [int] NULL,
	[ExpiredFee] [float] NULL,
	[Reason] [nvarchar](200) NULL,
	[NegotiatedPrice] [float] NULL,
	[AppointmentDate] [datetime] NULL,
	[ReviewRequestDate] [datetime] NULL,
	[CancelFee] [float] NULL,
	[AgreeCancelDate] [datetime] NULL,
	[ReturnDate] [datetime] NULL,
	[ReceivedDate] [datetime] NULL,
	[DeliveryMethod] [int] NULL,
	[RemainExtendFee] [float] NULL,
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
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'0EFOIHJXMQ', 96, 5, 1, N'Hoang', N'542 Cách Mạng Tháng Tám, District 3, Ho Chi Minh, Vietnam', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4ED00A09C68 AS DateTime), 30, 725000, 593000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00BDADD0 AS DateTime), 5, NULL, NULL, NULL, NULL, 560000, CAST(0x0000A4EC00C042C0 AS DateTime), CAST(0x0000A4EC00BF98D4 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'0UVCM1WT8T', 88, 5, 1, N'Hoang', N'542 Cách Mạng Tháng Tám, Quận 3, Hồ Chí Minh, Việt Nam', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00000000 AS DateTime), 30, 5445000, 4455000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC0093D80C AS DateTime), 7, CAST(0x0000A4EC00990326 AS DateTime), NULL, NULL, NULL, 4000000, CAST(0x0000A4EC0095B050 AS DateTime), CAST(0x0000A4EC0094EA44 AS DateTime), 600000, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'1T0HRMPCJH', 106, 5, 1, N'Hoang', NULL, N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), NULL, 30, 624000, 511000, NULL, NULL, CAST(0x0000A4EC016496B8 AS DateTime), 2, NULL, NULL, NULL, N'sản phẩm không phù hợp', NULL, NULL, CAST(0x0000A4EC016542FC AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'4ITA0MFZ3T', 91, 5, 1, N'Hoang', NULL, N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), NULL, 30, 652000, 534000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC009E640C AS DateTime), 2, NULL, NULL, NULL, N'quá cũ,', NULL, CAST(0x0000A4EC009F4D40 AS DateTime), CAST(0x0000A4EC009E8158 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'5G2IM74Y93', 97, 5, 1, N'Hoang', N'', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00A95BDC AS DateTime), 30, NULL, NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00BDF420 AS DateTime), 5, NULL, NULL, NULL, NULL, 1500000, CAST(0x0000A4EC00C042C0 AS DateTime), CAST(0x0000A4EC00BF8F74 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'5HXSIAJIWL', 98, 5, 1, N'Hoang', N'', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00A8E328 AS DateTime), 30, 2124000, 1737000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00BE530C AS DateTime), 5, NULL, NULL, NULL, NULL, 1800000, CAST(0x0000A4EC00C042C0 AS DateTime), CAST(0x0000A4EC00BF8740 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'6TPMD0JW27', 102, 5, 1, N'Hoang', N'543 Lý Thường Kiệt, Hồ Chí Minh, Việt Nam', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4ED00A076E8 AS DateTime), 30, 30477000, 24936000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC0155A93C AS DateTime), 5, NULL, NULL, NULL, NULL, 25000000, CAST(0x0000A4EC0167CD60 AS DateTime), CAST(0x0000A4EC01574DF0 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'6YWVFQVAKH', 104, 5, 1, N'Hoang', N'548 Cộng Hòa, Hồ Chí Minh, Việt Nam', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00A96FC8 AS DateTime), 30, 19115000, 15640000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC01583D00 AS DateTime), 5, NULL, NULL, NULL, NULL, 16000000, CAST(0x0000A4EC0158B230 AS DateTime), CAST(0x0000A4EC01586988 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'ARXB6F68CV', 89, 5, 1, N'Hoang', N'311 Điện Biên Phủ, Hồ Chí Minh, Việt Nam', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00000000 AS DateTime), 30, 1255000, 1027000, 900000, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00944D3C AS DateTime), 4, NULL, NULL, NULL, NULL, 1000000, CAST(0x0000A4EC0095B050 AS DateTime), CAST(0x0000A4EC0094DC34 AS DateTime), NULL, NULL, CAST(0x0000A4EC0098385C AS DateTime), NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'CUGIK8P8IF', 108, 5, 1, N'Hoang', N'529 Huỳnh Văn Bánh, Hồ Chí Minh, Việt Nam', N'+841689191917', NULL, NULL, CAST(0x0000A4ED00000000 AS DateTime), CAST(0x0000A4F100000000 AS DateTime), NULL, 30, 45738000, 37422000, NULL, CAST(0x0000A4ED00000000 AS DateTime), CAST(0x0000A4ED009F56A0 AS DateTime), 2, NULL, NULL, NULL, N'giá trị quá lớn', NULL, CAST(0x0000A4ED00B12790 AS DateTime), CAST(0x0000A4ED009F8C88 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'E5RUH3HFLS', 103, 5, 1, N'Hoang', N'', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), NULL, 30, 15246000, 12474000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC0155E758 AS DateTime), 5, NULL, NULL, NULL, NULL, 12000000, CAST(0x0000A4EC01666DD0 AS DateTime), CAST(0x0000A4EC01564AF4 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'E7X1K0FD21', 101, 5, 1, N'Hoang', NULL, N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), NULL, 30, 14215000, 11630000, NULL, CAST(0x0000A4EC0157BF9C AS DateTime), CAST(0x0000A4EC01557228 AS DateTime), 5, NULL, NULL, NULL, NULL, 24000000, CAST(0x0000A4EC01784820 AS DateTime), CAST(0x0000A4EC01575E58 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'G332GDM17Y', 105, 5, 1, N'Hoang', NULL, N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), NULL, 30, 7079000, 5791000, NULL, CAST(0x0000A4EC01658370 AS DateTime), CAST(0x0000A4EC016378C8 AS DateTime), 5, NULL, NULL, NULL, NULL, 6000000, CAST(0x0000A4EC01650E40 AS DateTime), CAST(0x0000A4EC016569A8 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'GGIG1U2UVY', 94, 5, 1, N'Hoang', N'', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00A99FD4 AS DateTime), 30, 4835000, 3956000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00BC80A4 AS DateTime), 5, NULL, NULL, NULL, NULL, 500000, CAST(0x0000A4EC00C042C0 AS DateTime), CAST(0x0000A4EC00BFADEC AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'MS2C00DO72', 92, 5, 1, N'Hoang', N'', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00A90FB0 AS DateTime), 30, 652000, 534000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00A9EAD4 AS DateTime), 5, NULL, NULL, NULL, NULL, 550000, CAST(0x0000A4EC00AE6870 AS DateTime), CAST(0x0000A4EC00ADB074 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'MSXTNJ98KU', 99, 5, 1, N'Nguyen Van B', N'123, Ho Chi Minh City, Ho Chi Minh, Vietnam', N'+8491753 3644', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4ED00A08D2C AS DateTime), 30, 5391000, 4410000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00BEC134 AS DateTime), 5, NULL, NULL, NULL, NULL, 4000000000, CAST(0x0000A4EC00C042C0 AS DateTime), CAST(0x0000A4EC00BF7CB4 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'MTWMPELC3I', 87, 5, 1, N'Hoang', N'744/4 Nguyễn Kiệm, Hồ Chí Minh, Việt Nam', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00A94B74 AS DateTime), 30, 517000, 423000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00938AB4 AS DateTime), 5, NULL, NULL, NULL, NULL, 400000, CAST(0x0000A4EC0095B050 AS DateTime), CAST(0x0000A4EC0094F728 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'Q9SA1EPCP3', 95, 5, 1, N'Nguyễn Văn A', N'', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00A9ACB8 AS DateTime), 30, NULL, NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00BD1C80 AS DateTime), 5, NULL, NULL, NULL, NULL, 1000000, CAST(0x0000A4EC00C042C0 AS DateTime), CAST(0x0000A4EC00BFA108 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'SKD7B1WTDM', 107, 5, 1, N'Hoang', N'542 Cách Mạng Tháng Tám, Quận 3, Hồ Chí Minh, Việt Nam', N'+841689191917', NULL, NULL, CAST(0x0000A4ED00000000 AS DateTime), CAST(0x0000A4F100000000 AS DateTime), NULL, 30, 1911000, 1563000, NULL, NULL, CAST(0x0000A4ED00977CDC AS DateTime), 3, CAST(0x0000A4ED009B0FAF AS DateTime), NULL, NULL, NULL, NULL, CAST(0x0000A4ED00986F70 AS DateTime), CAST(0x0000A4ED0097C584 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'UU609T8F71', 90, 5, 1, N'Hoang', N'123, Hồ Chí Minh, Việt Nam', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00000000 AS DateTime), 30, 1307000, 1069000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00949008 AS DateTime), 5, CAST(0x0000A4EC0099E5A9 AS DateTime), NULL, NULL, NULL, 600000, CAST(0x0000A4EC0095B050 AS DateTime), CAST(0x0000A4EC0094CCF8 AS DateTime), 90000, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'YEUHXEYEO8', 93, 5, 1, N'Hoang', N'', N'+841689191917', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00A8FF48 AS DateTime), 30, NULL, NULL, NULL, CAST(0x0000A4ED00B3D774 AS DateTime), CAST(0x0000A4EC00AF6A40 AS DateTime), 2, NULL, NULL, NULL, N'jhjhj', 500000, CAST(0x0000A4ED00AFC800 AS DateTime), CAST(0x0000A4EC00AFEB28 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReviewProductDate], [CreatedDate], [ConsignmentStatusID], [CancelDate], [isExpiredMessage], [ExpiredFee], [Reason], [NegotiatedPrice], [AppointmentDate], [ReviewRequestDate], [CancelFee], [AgreeCancelDate], [ReturnDate], [ReceivedDate], [DeliveryMethod], [RemainExtendFee]) VALUES (N'ZWTTA354HM', 100, 5, 1, N'Hu Truc', N'540 Cách Mạng Tháng 8, Ho Chi Minh City, Ho Chi Minh, Vietnam', N'+84917533644', NULL, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4F000000000 AS DateTime), CAST(0x0000A4EC00A991C4 AS DateTime), 30, 550000, 450000, NULL, CAST(0x0000A4EC00000000 AS DateTime), CAST(0x0000A4EC00BF4474 AS DateTime), 5, NULL, NULL, NULL, NULL, 500000, CAST(0x0000A4EC00C042C0 AS DateTime), CAST(0x0000A4EC00BF7480 AS DateTime), NULL, NULL, NULL, NULL, 0, NULL)
/****** Object:  ForeignKey [FK_Category_Category]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Category] FOREIGN KEY([ParentID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Category]
GO
/****** Object:  ForeignKey [FK_Member_Account]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Member_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Member_Account]
GO
/****** Object:  ForeignKey [FK_Product_Category]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
/****** Object:  ForeignKey [FK_Product_ProductStatus]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductStatus] FOREIGN KEY([ProductStatusID])
REFERENCES [dbo].[ProductStatus] ([ProductStatusID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductStatus]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Account]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[StoreOwner]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[StoreOwner] CHECK CONSTRAINT [FK_StoreOwner_Account]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Category]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[StoreOwner_Category]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Category] FOREIGN KEY([StoreOwnerID])
REFERENCES [dbo].[StoreOwner] ([StoreOwnerID])
GO
ALTER TABLE [dbo].[StoreOwner_Category] CHECK CONSTRAINT [FK_StoreOwner_Category]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Category_Category]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[StoreOwner_Category]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Category_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[StoreOwner_Category] CHECK CONSTRAINT [FK_StoreOwner_Category_Category]
GO
/****** Object:  ForeignKey [FK_Order_Customer]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
/****** Object:  ForeignKey [FK_Order_OrderStatus]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY([OrderStatusID])
REFERENCES [dbo].[OrderStatus] ([OrderStatusID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus]
GO
/****** Object:  ForeignKey [FK_Order_Product1]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Product1] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Product1]
GO
/****** Object:  ForeignKey [FK_Product_Season_Product]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Product_Season]  WITH CHECK ADD  CONSTRAINT [FK_Product_Season_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Product_Season] CHECK CONSTRAINT [FK_Product_Season_Product]
GO
/****** Object:  ForeignKey [FK_Product_Season_Season]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Product_Season]  WITH CHECK ADD  CONSTRAINT [FK_Product_Season_Season] FOREIGN KEY([SeasonID])
REFERENCES [dbo].[Season] ([SeasonID])
GO
ALTER TABLE [dbo].[Product_Season] CHECK CONSTRAINT [FK_Product_Season_Season]
GO
/****** Object:  ForeignKey [FK_Consignment_ConsignmentStatus]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_ConsignmentStatus] FOREIGN KEY([ConsignmentStatusID])
REFERENCES [dbo].[ConsignmentStatus] ([ConsignmentStatusID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_ConsignmentStatus]
GO
/****** Object:  ForeignKey [FK_Consignment_Customer]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_Customer] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_Customer]
GO
/****** Object:  ForeignKey [FK_Consignment_Product]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_Product]
GO
/****** Object:  ForeignKey [FK_Consignment_StoreOwner]    Script Date: 08/07/2015 12:35:38 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_StoreOwner] FOREIGN KEY([StoreOwnerID])
REFERENCES [dbo].[StoreOwner] ([StoreOwnerID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_StoreOwner]
GO
