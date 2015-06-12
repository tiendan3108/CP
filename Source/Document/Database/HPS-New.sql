USE [master]
GO
/****** Object:  Database [HPS]    Script Date: 06/12/2015 10:46:34 ******/
CREATE DATABASE [HPS] ON  PRIMARY 
( NAME = N'HPS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008\MSSQL\DATA\HPS.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
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
/****** Object:  Table [dbo].[Season]    Script Date: 06/12/2015 10:46:37 ******/
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
/****** Object:  Table [dbo].[ProductStatus]    Script Date: 06/12/2015 10:46:37 ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 06/12/2015 10:46:37 ******/
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
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (1, N'Nam', NULL, N'Men')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (2, N'Nữ', NULL, N'Women')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (3, N'Trẻ em', NULL, N'Kid')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (5, N'Giày', 1, N'Shoes')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (6, N'Quần Jean', 1, N'Jean')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (7, N'Đồng hồ', 1, N'Watch')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (8, N'Giày', 2, NULL)
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (9, N'Túi xách', 2, N'Shoes')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (10, N'Đồng hồ', 2, N'Watch')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (11, N'Quần Jean', 3, N'Jean')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (12, N'Áo thun', 3, N'T-shirt')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (13, N'Quần Jean', 2, N'Jean')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (14, N'Đồng hồ', 2, N'Watch')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (15, N'Áo Khoác', 1, N'Jacket')
INSERT [dbo].[Category] ([CategoryID], [CategoryName], [ParentID], [EnglishName]) VALUES (16, N'Áo thun', 1, N'T-shirt')
SET IDENTITY_INSERT [dbo].[Category] OFF
/****** Object:  Table [dbo].[Account]    Script Date: 06/12/2015 10:46:37 ******/
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
/****** Object:  Table [dbo].[ConsignmentStatus]    Script Date: 06/12/2015 10:46:37 ******/
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
/****** Object:  Table [dbo].[Member]    Script Date: 06/12/2015 10:46:37 ******/
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
/****** Object:  Table [dbo].[StoreOwner]    Script Date: 06/12/2015 10:46:37 ******/
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
/****** Object:  Table [dbo].[StoreOwner_Category]    Script Date: 06/12/2015 10:46:37 ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 06/12/2015 10:46:37 ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 06/12/2015 10:46:37 ******/
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
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (2, N'Casio Gshock GA110', N'1234567890', CAST(0xBE320B00 AS Date), 7, N'Casio', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/GA110AC-7A_xlarge.png', 3, 2000000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (3, N'Casio Gshock GA 400', N'34567890', CAST(0xB9350B00 AS Date), 7, N'Casio', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/GA400-4B_xlarge.png', 3, 2000000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (7, N'Citizen 2014', N'987655678', CAST(0x21380B00 AS Date), 7, N'Citizen', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/citizen1.JPG', 3, 6000000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (8, N'Tag Heuer 2014', N'868677676', CAST(0xFC380B00 AS Date), 7, N'Tag Heuer', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/tag1.jpg', 3, 10000000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (9, N'Tag Heuer 2015', N'567895678', CAST(0x6F390B00 AS Date), 7, N'Tag Heuer', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/tag2.jpg', 3, 5000000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (10, N'Nike Jordan 4', N'972387838', CAST(0x3E380B00 AS Date), 5, N'Nike', N'JORDAN RETRO, dòng sản phẩm đang gây nên cơn sốt cho các sneakerhead trên toàn thế giới, nay đã lên kệ tại thị trường Việt Nam.', N'assets/image/nike_air_jordan_4_retro_2013110110_0.jpg', 3, 4000000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (11, N'Levis 501 ', N'878347384', CAST(0xEA390B00 AS Date), 6, N'Levis', N'Levi Strauss & Co (LS & CO) là một công ty quần áo tư nhân nổi tiếng trên toàn thế giới với thương hiệu Levi’s (phiên âm tiếng Anh: /’liːvʌɪz/) dành cho quần jean', N'assets/image/LevisJean.jpg', 3, 400000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (13, N'skinyJean 302 ', N'3456789875', CAST(0x663A0B00 AS Date), 13, N'Levis', N'Levi Strauss & Co (LS & CO) là một công ty quần áo tư nhân nổi tiếng trên toàn thế giới với thương hiệu Levi’s (phiên âm tiếng Anh: /’liːvʌɪz/) dành cho quần jean', N'assets/image/skinyJean.jpg', 3, 200000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (15, N'Nike Jordan 6', N'456787654', CAST(0x663A0B00 AS Date), 5, N'Nike', N'JORDAN RETRO, dòng sản phẩm đang gây nên cơn sốt cho các sneakerhead trên toàn thế giới, nay đã lên kệ tại thị trường Việt Nam.', N'assets/image/jordan6.jpg', 3, 4000000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (17, N'levis 511', N'24324324324', CAST(0xC13A0B00 AS Date), 6, N'Levis', N'Levi Strauss & Co (LS & CO) là một công ty quần áo tư nhân nổi tiếng trên toàn thế giới với thương hiệu Levi’s (phiên âm tiếng Anh: /’liːvʌɪz/) dành cho quần jean', N'assets/image/levis 511.jpg', 3, 2000000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (18, N'Jordano 2015', N'6785678765', CAST(0xC13A0B00 AS Date), 16, N'Jordano', N'Dạo phố sành điệu và thời trang cùng áo thun GIORDANO chất liệu thun cao cấp, cực kì thoáng mát, đính logo của hãng thời trang nổi tiếng. Giúp cho bạn nam thêm cá tính, năng động và trẻ trung.', N'assets/image/jordano.jpg', 3, 300000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (20, N'Jordano 12AB', N'343243243', CAST(0xC13A0B00 AS Date), 16, N'Jordano', N'Dạo phố sành điệu và thời trang cùng áo thun GIORDANO chất liệu thun cao cấp, cực kì thoáng mát, đính logo của hãng thời trang nổi tiếng. Giúp cho bạn nam thêm cá tính, năng động và trẻ trung.', N'assets/image/jordano2.jpg', 3, 250000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (21, N'Nike Jordan 1', N'23232323', CAST(0xC13A0B00 AS Date), 5, N'Nike', N'JORDAN RETRO, dòng sản phẩm đang gây nên cơn sốt cho các sneakerhead trên toàn thế giới, nay đã lên kệ tại thị trường Việt Nam.', N'assets/image/jordan1.jpg', 3, 1500000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (24, N'Adidas Color AB-1', N'3232323', CAST(0xC13A0B00 AS Date), 5, N'Adidas', N' Adidas là nhà sản xuất lớn nhất thể thao ở Đức và châu Âu và các nhà sản xuất đồ thể thao lớn thứ hai trên thế giới, sau Nike .', N'assets/image/adidas2.jpg', 3, 1200000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (25, N'Adidas super color', N'34324324', CAST(0xC13A0B00 AS Date), 5, N'Adidas', N' Adidas là nhà sản xuất lớn nhất thể thao ở Đức và châu Âu và các nhà sản xuất đồ thể thao lớn thứ hai trên thế giới, sau Nike .', N'assets/image/adidas-supercolor.jpg', 3, 1300000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (26, N'Gshock GA1000-2A', N'32432432A', CAST(0xC13A0B00 AS Date), 7, N'Casio', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/GA1000-2A.jpg', 3, 2000000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (27, N'Gshock GA 1000-2B', N'AB38433', CAST(0xC13A0B00 AS Date), 7, N'Casio', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/GA1000-2B_xlarge.png', 3, 1500000, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [SerialNumber], [PurchasedDate], [CategoryID], [Brand], [Description], [Image], [ProductStatusID], [SellingPrice], [OrderID]) VALUES (28, N'Gshock GA 120A', N'GB323232', CAST(0xC13A0B00 AS Date), 7, N'Casio', N'Dòng GAC-110 mới này đi kèm với mẫu đồng hồ kim. GAC-110 có màu đen cơ bản hoặc các màu sáng hơn, Mặt kính khoáng, Chống va đập,Chống nước ở độ sâu 200 mét', N'assets/image/GA120.jpg', 3, 1000000, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
/****** Object:  Table [dbo].[Notification]    Script Date: 06/12/2015 10:46:37 ******/
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
/****** Object:  Table [dbo].[Product_Season]    Script Date: 06/12/2015 10:46:37 ******/
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
/****** Object:  Table [dbo].[Consignment]    Script Date: 06/12/2015 10:46:37 ******/
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
INSERT [dbo].[Consignment] ([ConsignmentID], [ProductID], [MemberID], [StoreOwnerID], [FullName], [Address], [Phone], [Email], [PaypalAccount], [FromDate], [ToDate], [RaiseWebDate], [Period], [MaxPrice], [MinPrice], [ReturnedPrice], [ReceivedDate], [CreatedDate], [ConsignmentStatusID]) VALUES (N'ABV1234584', 2, 1, 1, N'Customer1', N'1234567', N'016987656789', N'customer1@gmail.com', N'customer1', CAST(0x0E3A0B00 AS Date), CAST(0x133A0B00 AS Date), NULL, 30, 1000, NULL, NULL, NULL, NULL, 1)
/****** Object:  ForeignKey [FK_Category_Category]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Category] FOREIGN KEY([ParentID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Category]
GO
/****** Object:  ForeignKey [FK_Customer_Account]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Customer_Account]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Account]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[StoreOwner]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[StoreOwner] CHECK CONSTRAINT [FK_StoreOwner_Account]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Category]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[StoreOwner_Category]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Category] FOREIGN KEY([StoreOwnerID])
REFERENCES [dbo].[StoreOwner] ([StoreOwnerID])
GO
ALTER TABLE [dbo].[StoreOwner_Category] CHECK CONSTRAINT [FK_StoreOwner_Category]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Category_Category]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[StoreOwner_Category]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Category_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[StoreOwner_Category] CHECK CONSTRAINT [FK_StoreOwner_Category_Category]
GO
/****** Object:  ForeignKey [FK_Order_Customer]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
/****** Object:  ForeignKey [FK_Product_Category]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
/****** Object:  ForeignKey [FK_Product_Order]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Order]
GO
/****** Object:  ForeignKey [FK_Product_ProductStatus]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductStatus] FOREIGN KEY([ProductStatusID])
REFERENCES [dbo].[ProductStatus] ([ProductStatusID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductStatus]
GO
/****** Object:  ForeignKey [FK_Notification_Account]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Account]
GO
/****** Object:  ForeignKey [FK_Notification_Product]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Product]
GO
/****** Object:  ForeignKey [FK_Product_Season_Product]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Product_Season]  WITH CHECK ADD  CONSTRAINT [FK_Product_Season_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Product_Season] CHECK CONSTRAINT [FK_Product_Season_Product]
GO
/****** Object:  ForeignKey [FK_Product_Season_Season]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Product_Season]  WITH CHECK ADD  CONSTRAINT [FK_Product_Season_Season] FOREIGN KEY([SeasonID])
REFERENCES [dbo].[Season] ([SeasonID])
GO
ALTER TABLE [dbo].[Product_Season] CHECK CONSTRAINT [FK_Product_Season_Season]
GO
/****** Object:  ForeignKey [FK_Consignment_ConsignmentStatus]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_ConsignmentStatus] FOREIGN KEY([ConsignmentStatusID])
REFERENCES [dbo].[ConsignmentStatus] ([ConsignmentStatusID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_ConsignmentStatus]
GO
/****** Object:  ForeignKey [FK_Consignment_Customer]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_Customer] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_Customer]
GO
/****** Object:  ForeignKey [FK_Consignment_Product]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_Product]
GO
/****** Object:  ForeignKey [FK_Consignment_StoreOwner]    Script Date: 06/12/2015 10:46:37 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_StoreOwner] FOREIGN KEY([StoreOwnerID])
REFERENCES [dbo].[StoreOwner] ([StoreOwnerID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_StoreOwner]
GO
