USE [master]
GO
/****** Object:  Database [HPS]    Script Date: 7/23/2015 12:22:06 AM ******/
CREATE DATABASE [HPS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HPS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\HPS.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'HPS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\HPS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
ALTER DATABASE [HPS] SET RECOVERY FULL 
GO
ALTER DATABASE [HPS] SET  MULTI_USER 
GO
ALTER DATABASE [HPS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HPS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HPS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HPS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HPS', N'ON'
GO
USE [HPS]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 7/23/2015 12:22:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[BrandID] [int] IDENTITY(1,1) NOT NULL,
	[BrandName] [nvarchar](30) NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[BrandID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Consignment]    Script Date: 7/23/2015 12:22:06 AM ******/
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
	[FromDate] [datetime] NOT NULL,
	[ToDate] [datetime] NOT NULL,
	[RaiseWebDate] [date] NULL,
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
 CONSTRAINT [PK_Consignment] PRIMARY KEY CLUSTERED 
(
	[ConsignmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ConsignmentStatus]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Member]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Order]    Script Date: 7/23/2015 12:22:06 AM ******/
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
	[Address] [nvarchar](50) NULL,
	[Phone] [varchar](15) NULL,
	[TotalPrice] [float] NULL,
	[OrderStatusID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[SendPrice] [float] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product_Season]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductStatus]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Season]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StoreOwner]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StoreOwner_Category]    Script Date: 7/23/2015 12:22:06 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'ABCStore', N'123456', N'deactive', N'Hoang', N'12345 HCM', N'+841689191917', N'abce@yahoo.com', N'Paypal', N'storeOwner')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'admin1', N'123456', N'active', N'admin1', N'CVPM Quang Trung', N'+841689191917', N'admin1@gmail.com', N'admin', N'admin')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'customer1', N'123456', N'active', N'customer1', N'CVPM Quang Trung', N'+84917533644', N'HoangNH17193@gmail.com', N'customer1', N'member')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'customer5', N'123456', N'active', N'Hoang', N'HCM', N'+841633387893', N'abc@yahoo.com', N'', N'member')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'Guest', N'000000', N'active', N'Guest', NULL, NULL, NULL, NULL, N'guest')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'storeOwner1', N'123456', N'active', N'StoreOnwer1', N'123 Quang Trung', N'+841689191917', N'StoreOwner1@gmial.com', N'Staff1@gmail.com', N'storeOwner')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'storeOwner2', N'123456', N'active', N'storeOwner2', N'CVPM Quang Trung', N'+841633387893', N'storeOwner2', N'storeowner2', N'storeOwner')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'storeOwner3', N'123456', N'active', N'storeOwner3', N'CVPM Quang Trung', N'+84917533644', N'storeOwner3', N'', N'storeOwner')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'test', N'123456', N'deactive', N'abc', N'123', N'', N'test', N'', N'member')
INSERT [dbo].[Account] ([AccountID], [Password], [Status], [FullName], [Address], [Phone], [Email], [PaypalAccount], [Role]) VALUES (N'TestAccount', N'123456', N'active', N'ABC', N'', N'01671717171', N'', N'', N'member')
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
SET IDENTITY_INSERT [dbo].[ConsignmentStatus] ON 

INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (1, N'Waiting')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (2, N'Refuse')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (3, N'Accepted')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (4, N'Completed')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (5, N'Received')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (6, N'Expired')
INSERT [dbo].[ConsignmentStatus] ([ConsignmentStatusID], [ConsignmentStatusName]) VALUES (7, N'Cancel')
SET IDENTITY_INSERT [dbo].[ConsignmentStatus] OFF
SET IDENTITY_INSERT [dbo].[Member] ON 

INSERT [dbo].[Member] ([MemberID], [AccountID]) VALUES (1, N'customer1')
INSERT [dbo].[Member] ([MemberID], [AccountID]) VALUES (6, N'customer5')
INSERT [dbo].[Member] ([MemberID], [AccountID]) VALUES (5, N'Guest')
SET IDENTITY_INSERT [dbo].[Member] OFF
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusName]) VALUES (1, N'Waiting')
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusName]) VALUES (2, N'Completed')
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusName]) VALUES (3, N'Canceled')
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusName]) VALUES (4, N'Expired')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
SET IDENTITY_INSERT [dbo].[ProductStatus] ON 

INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (1, N'Not Available')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (2, N'Available')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (3, N'On Web')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (4, N'Ordered')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (5, N'Sold')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (6, N'Cancel')
INSERT [dbo].[ProductStatus] ([ProductStatusID], [ProductStatusName]) VALUES (7, N'Completed')
SET IDENTITY_INSERT [dbo].[ProductStatus] OFF
SET IDENTITY_INSERT [dbo].[Season] ON 

INSERT [dbo].[Season] ([SeasonID], [SeasonName]) VALUES (1, N'Xuân')
INSERT [dbo].[Season] ([SeasonID], [SeasonName]) VALUES (2, N'Hạ')
INSERT [dbo].[Season] ([SeasonID], [SeasonName]) VALUES (3, N'Thu')
INSERT [dbo].[Season] ([SeasonID], [SeasonName]) VALUES (4, N'Đông')
SET IDENTITY_INSERT [dbo].[Season] OFF
SET IDENTITY_INSERT [dbo].[StoreOwner] ON 

INSERT [dbo].[StoreOwner] ([StoreOwnerID], [AccountID], [Formula]) VALUES (1, N'storeOwner1', 10)
INSERT [dbo].[StoreOwner] ([StoreOwnerID], [AccountID], [Formula]) VALUES (2, N'storeOwner2', 12)
INSERT [dbo].[StoreOwner] ([StoreOwnerID], [AccountID], [Formula]) VALUES (3, N'storeOwner3', 15)
INSERT [dbo].[StoreOwner] ([StoreOwnerID], [AccountID], [Formula]) VALUES (6, N'ABCStore', 10)
SET IDENTITY_INSERT [dbo].[StoreOwner] OFF
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 5)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 6)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 7)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 8)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 9)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 10)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 11)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 12)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 13)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 14)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 15)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (1, 16)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 5)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 6)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 7)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 8)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (2, 9)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 10)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 11)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 12)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 13)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 14)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 15)
INSERT [dbo].[StoreOwner_Category] ([StoreOwnerID], [CategoryID]) VALUES (3, 16)
/****** Object:  Index [IX_Consignment]    Script Date: 7/23/2015 12:22:06 AM ******/
ALTER TABLE [dbo].[Consignment] ADD  CONSTRAINT [IX_Consignment] UNIQUE NONCLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_Table_1]    Script Date: 7/23/2015 12:22:06 AM ******/
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [UK_Table_1] UNIQUE NONCLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UX_Table_1]    Script Date: 7/23/2015 12:22:06 AM ******/
ALTER TABLE [dbo].[StoreOwner] ADD  CONSTRAINT [UX_Table_1] UNIQUE NONCLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Category] FOREIGN KEY([ParentID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Category]
GO
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_ConsignmentStatus] FOREIGN KEY([ConsignmentStatusID])
REFERENCES [dbo].[ConsignmentStatus] ([ConsignmentStatusID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_ConsignmentStatus]
GO
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_Customer] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_Customer]
GO
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_Product]
GO
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_StoreOwner] FOREIGN KEY([StoreOwnerID])
REFERENCES [dbo].[StoreOwner] ([StoreOwnerID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_StoreOwner]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Customer_Account]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Account]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Product]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY([OrderStatusID])
REFERENCES [dbo].[OrderStatus] ([OrderStatusID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductStatus] FOREIGN KEY([ProductStatusID])
REFERENCES [dbo].[ProductStatus] ([ProductStatusID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductStatus]
GO
ALTER TABLE [dbo].[Product_Season]  WITH CHECK ADD  CONSTRAINT [FK_Product_Season_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Product_Season] CHECK CONSTRAINT [FK_Product_Season_Product]
GO
ALTER TABLE [dbo].[Product_Season]  WITH CHECK ADD  CONSTRAINT [FK_Product_Season_Season] FOREIGN KEY([SeasonID])
REFERENCES [dbo].[Season] ([SeasonID])
GO
ALTER TABLE [dbo].[Product_Season] CHECK CONSTRAINT [FK_Product_Season_Season]
GO
ALTER TABLE [dbo].[StoreOwner]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[StoreOwner] CHECK CONSTRAINT [FK_StoreOwner_Account]
GO
ALTER TABLE [dbo].[StoreOwner_Category]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Category] FOREIGN KEY([StoreOwnerID])
REFERENCES [dbo].[StoreOwner] ([StoreOwnerID])
GO
ALTER TABLE [dbo].[StoreOwner_Category] CHECK CONSTRAINT [FK_StoreOwner_Category]
GO
ALTER TABLE [dbo].[StoreOwner_Category]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Category_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[StoreOwner_Category] CHECK CONSTRAINT [FK_StoreOwner_Category_Category]
GO
USE [master]
GO
ALTER DATABASE [HPS] SET  READ_WRITE 
GO
