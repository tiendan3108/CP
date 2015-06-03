USE [master]
GO
/****** Object:  Database [HPS]    Script Date: 06/03/2015 09:11:36 ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 06/03/2015 09:11:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
	[ParentID] [int] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Account]    Script Date: 06/03/2015 09:11:39 ******/
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
	[CardNumber] [varchar](15) NULL,
	[CardOwner] [varchar](50) NULL,
	[Role] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StoreOwner]    Script Date: 06/03/2015 09:11:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StoreOwner](
	[StoreOwnerID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [varchar](50) NOT NULL,
	[Formular] [float] NOT NULL,
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
/****** Object:  Table [dbo].[Member]    Script Date: 06/03/2015 09:11:39 ******/
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
/****** Object:  Table [dbo].[Consignment]    Script Date: 06/03/2015 09:11:39 ******/
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
	[CardNumber] [varchar](20) NULL,
	[CardOwner] [varchar](50) NULL,
	[FromDate] [date] NOT NULL,
	[ToDate] [date] NOT NULL,
	[RaiseWebDate] [date] NULL,
	[Status] [varchar](50) NOT NULL,
	[Period] [int] NOT NULL,
	[MaxPrice] [float] NULL,
	[ReturnedPrice] [float] NULL,
	[ReceivedDate] [date] NULL,
 CONSTRAINT [PK_Consignment] PRIMARY KEY CLUSTERED 
(
	[ConsignmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StoreOwner_Category]    Script Date: 06/03/2015 09:11:39 ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 06/03/2015 09:11:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Date] [date] NULL,
	[Email] [varchar](50) NULL,
	[CardNumber] [varchar](20) NULL,
	[CardOwner] [varchar](50) NULL,
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
/****** Object:  Table [dbo].[Product]    Script Date: 06/03/2015 09:11:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[SerialNumber] [varchar](20) NULL,
	[PurchasedDate] [date] NULL,
	[CategoryID] [int] NOT NULL,
	[Brand] [varchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[Image] [varchar](100) NOT NULL,
	[Status] [int] NOT NULL,
	[SellingPrice] [float] NULL,
	[OrderID] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 06/03/2015 09:11:39 ******/
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
/****** Object:  ForeignKey [FK_Category_Category]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Category] FOREIGN KEY([ParentID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Category]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Account]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[StoreOwner]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[StoreOwner] CHECK CONSTRAINT [FK_StoreOwner_Account]
GO
/****** Object:  ForeignKey [FK_Customer_Account]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Customer_Account]
GO
/****** Object:  ForeignKey [FK_Consignment_Customer]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_Customer] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_Customer]
GO
/****** Object:  ForeignKey [FK_Consignment_StoreOwner]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[Consignment]  WITH CHECK ADD  CONSTRAINT [FK_Consignment_StoreOwner] FOREIGN KEY([StoreOwnerID])
REFERENCES [dbo].[StoreOwner] ([StoreOwnerID])
GO
ALTER TABLE [dbo].[Consignment] CHECK CONSTRAINT [FK_Consignment_StoreOwner]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Category]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[StoreOwner_Category]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Category] FOREIGN KEY([StoreOwnerID])
REFERENCES [dbo].[StoreOwner] ([StoreOwnerID])
GO
ALTER TABLE [dbo].[StoreOwner_Category] CHECK CONSTRAINT [FK_StoreOwner_Category]
GO
/****** Object:  ForeignKey [FK_StoreOwner_Category_Category]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[StoreOwner_Category]  WITH CHECK ADD  CONSTRAINT [FK_StoreOwner_Category_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[StoreOwner_Category] CHECK CONSTRAINT [FK_StoreOwner_Category_Category]
GO
/****** Object:  ForeignKey [FK_Order_Customer]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
/****** Object:  ForeignKey [FK_Product_Category]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
/****** Object:  ForeignKey [FK_Product_Order]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Order]
GO
/****** Object:  ForeignKey [FK_Notification_Account]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Account]
GO
/****** Object:  ForeignKey [FK_Notification_Product]    Script Date: 06/03/2015 09:11:39 ******/
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Product]
GO
