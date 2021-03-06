USE [master]
GO
/****** Object:  Database [ORM_STORE]    Script Date: 22.03.2022 11:46:39 ******/
CREATE DATABASE [ORM_STORE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ORM_STORE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ORM_STORE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ORM_STORE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ORM_STORE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ORM_STORE] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ORM_STORE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ORM_STORE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ORM_STORE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ORM_STORE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ORM_STORE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ORM_STORE] SET ARITHABORT OFF 
GO
ALTER DATABASE [ORM_STORE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ORM_STORE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ORM_STORE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ORM_STORE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ORM_STORE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ORM_STORE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ORM_STORE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ORM_STORE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ORM_STORE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ORM_STORE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ORM_STORE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ORM_STORE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ORM_STORE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ORM_STORE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ORM_STORE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ORM_STORE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ORM_STORE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ORM_STORE] SET RECOVERY FULL 
GO
ALTER DATABASE [ORM_STORE] SET  MULTI_USER 
GO
ALTER DATABASE [ORM_STORE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ORM_STORE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ORM_STORE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ORM_STORE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ORM_STORE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ORM_STORE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ORM_STORE] SET QUERY_STORE = OFF
GO
USE [ORM_STORE]
GO
/****** Object:  UserDefinedFunction [dbo].[TotalPriceCalc]    Script Date: 22.03.2022 11:46:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE FUNCTION [dbo].[TotalPriceCalc]
( 
  -- Parametrelerin eklendiği yer
  @number decimal(18,0),
  @price decimal(18,0)
)
RETURNS decimal(18,2)
AS
BEGIN
  -- Önce Geri dönecek değer tanımlanır.
  
  -- Sql ifadeleri dönen parametreye değer aktarımı gibi işlemler
  RETURN  @number*@price
END
GO
/****** Object:  Table [dbo].[CATEGORY]    Script Date: 22.03.2022 11:46:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORY](
	[CID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NULL,
	[Name] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MAINCATEGORY]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MAINCATEGORY](
	[ParentID] [int] IDENTITY(1,1) NOT NULL,
	[ParentName] [varchar](50) NULL,
 CONSTRAINT [PK_PARENT] PRIMARY KEY CLUSTERED 
(
	[ParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDERDETAILS]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDERDETAILS](
	[OrderDetayID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductPrice] [decimal](18, 2) NULL,
	[Number] [decimal](18, 2) NULL,
	[UserID] [int] NULL,
 CONSTRAINT [PK_ORDERDETAILS] PRIMARY KEY CLUSTERED 
(
	[OrderDetayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORDERS]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDERS](
	[OID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[UserAddress] [varchar](50) NULL,
	[CreateDate] [date] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[Order_detay_id] [int] NULL,
 CONSTRAINT [PK_ORDER] PRIMARY KEY CLUSTERED 
(
	[OID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCT]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCT](
	[PID] [int] IDENTITY(1,1) NOT NULL,
	[PName] [varchar](50) NULL,
	[CategoryID] [int] NULL,
	[Brand] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[PDescription] [varchar](50) NULL,
	[Price] [decimal](18, 2) NULL,
	[Tax]  AS ([Price]*(0.2)) PERSISTED,
	[Stock] [int] NULL,
 CONSTRAINT [PK_PRODUCT] PRIMARY KEY CLUSTERED 
(
	[PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAdress]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAdress](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Title] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Adress] [varchar](50) NULL,
 CONSTRAINT [PK_UserAdress] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[EMail] [varchar](50) NULL,
	[Telephone] [varchar](50) NULL,
	[TC] [char](11) NULL,
 CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CATEGORY] ON 

INSERT [dbo].[CATEGORY] ([CID], [ParentID], [Name], [IsActive]) VALUES (2, 2, N'DIVIDED', 1)
INSERT [dbo].[CATEGORY] ([CID], [ParentID], [Name], [IsActive]) VALUES (3, 3, N'CASUAL', 1)
INSERT [dbo].[CATEGORY] ([CID], [ParentID], [Name], [IsActive]) VALUES (4, 2, N'LOG', 1)
INSERT [dbo].[CATEGORY] ([CID], [ParentID], [Name], [IsActive]) VALUES (5, 3, N'Baby', 1)
INSERT [dbo].[CATEGORY] ([CID], [ParentID], [Name], [IsActive]) VALUES (6, 2, N'Blue-Divided', 1)
INSERT [dbo].[CATEGORY] ([CID], [ParentID], [Name], [IsActive]) VALUES (7, 1, N'Trend', 1)
INSERT [dbo].[CATEGORY] ([CID], [ParentID], [Name], [IsActive]) VALUES (8, 1, N'Classic', 1)
SET IDENTITY_INSERT [dbo].[CATEGORY] OFF
GO
SET IDENTITY_INSERT [dbo].[MAINCATEGORY] ON 

INSERT [dbo].[MAINCATEGORY] ([ParentID], [ParentName]) VALUES (1, N'WOMAN')
INSERT [dbo].[MAINCATEGORY] ([ParentID], [ParentName]) VALUES (2, N'MAN')
INSERT [dbo].[MAINCATEGORY] ([ParentID], [ParentName]) VALUES (3, N'KIDS')
SET IDENTITY_INSERT [dbo].[MAINCATEGORY] OFF
GO
SET IDENTITY_INSERT [dbo].[ORDERDETAILS] ON 

INSERT [dbo].[ORDERDETAILS] ([OrderDetayID], [ProductID], [ProductPrice], [Number], [UserID]) VALUES (37, 1, CAST(50.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), 1)
SET IDENTITY_INSERT [dbo].[ORDERDETAILS] OFF
GO
SET IDENTITY_INSERT [dbo].[ORDERS] ON 

INSERT [dbo].[ORDERS] ([OID], [UserID], [UserAddress], [CreateDate], [TotalPrice], [Order_detay_id]) VALUES (38, 1, NULL, CAST(N'2022-03-21' AS Date), NULL, 37)
SET IDENTITY_INSERT [dbo].[ORDERS] OFF
GO
SET IDENTITY_INSERT [dbo].[PRODUCT] ON 

INSERT [dbo].[PRODUCT] ([PID], [PName], [CategoryID], [Brand], [Model], [PDescription], [Price], [Stock]) VALUES (1, N'Crop T-Shirt', 2, N'H&M', N'Crop', N'Basic %100 Cotton', CAST(49.99 AS Decimal(18, 2)), 294)
INSERT [dbo].[PRODUCT] ([PID], [PName], [CategoryID], [Brand], [Model], [PDescription], [Price], [Stock]) VALUES (2, N'Basic Short', 2, N'H&M', N'Short', N'Basic %100 Cotton', CAST(29.99 AS Decimal(18, 2)), 267)
INSERT [dbo].[PRODUCT] ([PID], [PName], [CategoryID], [Brand], [Model], [PDescription], [Price], [Stock]) VALUES (3, N'Classic Jacket', 2, N'ZARA', N'Classic', N'%100 Linen', CAST(250.00 AS Decimal(18, 2)), 199)
INSERT [dbo].[PRODUCT] ([PID], [PName], [CategoryID], [Brand], [Model], [PDescription], [Price], [Stock]) VALUES (4, N'Jeans', 3, N'BELSHIKA', N'Flare', N'Standard', CAST(300.00 AS Decimal(18, 2)), 25)
SET IDENTITY_INSERT [dbo].[PRODUCT] OFF
GO
SET IDENTITY_INSERT [dbo].[UserAdress] ON 

INSERT [dbo].[UserAdress] ([UID], [UserID], [Title], [City], [Adress]) VALUES (1, 1, N'Customer', N'İstanbul', N'Etiler')
INSERT [dbo].[UserAdress] ([UID], [UserID], [Title], [City], [Adress]) VALUES (2, 2, N'Customer', N'İstanbul', N'Beşiktaş')
INSERT [dbo].[UserAdress] ([UID], [UserID], [Title], [City], [Adress]) VALUES (3, 3, N'Customer', N'İstanbul', N'Bebek')
SET IDENTITY_INSERT [dbo].[UserAdress] OFF
GO
SET IDENTITY_INSERT [dbo].[USERS] ON 

INSERT [dbo].[USERS] ([ID], [Name], [LastName], [EMail], [Telephone], [TC]) VALUES (1, N'Kübra ', N'Özyakışır', N'kbrozyksr@gmail.com', N'5302589625', N'51524871452')
INSERT [dbo].[USERS] ([ID], [Name], [LastName], [EMail], [Telephone], [TC]) VALUES (2, N'Nazlı ', N'Güner', N'nazlı@icloud.com', N'5326523698', N'51524785214')
INSERT [dbo].[USERS] ([ID], [Name], [LastName], [EMail], [Telephone], [TC]) VALUES (3, N'Melisa ', N'Mert', N'melisa@gmail.com', N'(258) 963-2145', N'21545665546')
SET IDENTITY_INSERT [dbo].[USERS] OFF
GO
ALTER TABLE [dbo].[ORDERS] ADD  CONSTRAINT [DateConstraint]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[UserAdress] ADD  CONSTRAINT [Title]  DEFAULT ('Customer') FOR [Title]
GO
ALTER TABLE [dbo].[CATEGORY]  WITH CHECK ADD  CONSTRAINT [FK_CATEGORY_PARENT] FOREIGN KEY([ParentID])
REFERENCES [dbo].[MAINCATEGORY] ([ParentID])
GO
ALTER TABLE [dbo].[CATEGORY] CHECK CONSTRAINT [FK_CATEGORY_PARENT]
GO
ALTER TABLE [dbo].[CATEGORY]  WITH CHECK ADD  CONSTRAINT [FKParent] FOREIGN KEY([ParentID])
REFERENCES [dbo].[MAINCATEGORY] ([ParentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CATEGORY] CHECK CONSTRAINT [FKParent]
GO
ALTER TABLE [dbo].[ORDERDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_ORDERDETAILS_PRODUCT] FOREIGN KEY([ProductID])
REFERENCES [dbo].[PRODUCT] ([PID])
GO
ALTER TABLE [dbo].[ORDERDETAILS] CHECK CONSTRAINT [FK_ORDERDETAILS_PRODUCT]
GO
ALTER TABLE [dbo].[ORDERDETAILS]  WITH CHECK ADD  CONSTRAINT [FKPID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[PRODUCT] ([PID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ORDERDETAILS] CHECK CONSTRAINT [FKPID]
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_ORDERDETAILS] FOREIGN KEY([Order_detay_id])
REFERENCES [dbo].[ORDERDETAILS] ([OrderDetayID])
GO
ALTER TABLE [dbo].[ORDERS] CHECK CONSTRAINT [FK_ORDER_ORDERDETAILS]
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD  CONSTRAINT [FK_ORDERS_USERS] FOREIGN KEY([UserID])
REFERENCES [dbo].[USERS] ([ID])
GO
ALTER TABLE [dbo].[ORDERS] CHECK CONSTRAINT [FK_ORDERS_USERS]
GO
ALTER TABLE [dbo].[ORDERS]  WITH CHECK ADD  CONSTRAINT [FKORDERSTransactions] FOREIGN KEY([Order_detay_id])
REFERENCES [dbo].[ORDERDETAILS] ([OrderDetayID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ORDERS] CHECK CONSTRAINT [FKORDERSTransactions]
GO
ALTER TABLE [dbo].[UserAdress]  WITH CHECK ADD  CONSTRAINT [FK_UserAdress_USERS] FOREIGN KEY([UserID])
REFERENCES [dbo].[USERS] ([ID])
GO
ALTER TABLE [dbo].[UserAdress] CHECK CONSTRAINT [FK_UserAdress_USERS]
GO
ALTER TABLE [dbo].[UserAdress]  WITH CHECK ADD  CONSTRAINT [FKUSERS] FOREIGN KEY([UserID])
REFERENCES [dbo].[USERS] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserAdress] CHECK CONSTRAINT [FKUSERS]
GO
ALTER TABLE [dbo].[ORDERDETAILS]  WITH CHECK ADD  CONSTRAINT [CK_Number] CHECK  (([Number]>(0)))
GO
ALTER TABLE [dbo].[ORDERDETAILS] CHECK CONSTRAINT [CK_Number]
GO
ALTER TABLE [dbo].[PRODUCT]  WITH CHECK ADD  CONSTRAINT [CK_Price] CHECK  (([Price]>(0)))
GO
ALTER TABLE [dbo].[PRODUCT] CHECK CONSTRAINT [CK_Price]
GO
ALTER TABLE [dbo].[PRODUCT]  WITH CHECK ADD  CONSTRAINT [CK_Stock] CHECK  (([Stock]>(0)))
GO
ALTER TABLE [dbo].[PRODUCT] CHECK CONSTRAINT [CK_Stock]
GO
/****** Object:  StoredProcedure [dbo].[Calculate]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Calculate](
@ProductPrice decimal(18,0),
@Number decimal(18,0))
as begin
insert into ORDERS(TotalPrice) values(@ProductPrice*@Number) end
GO
/****** Object:  StoredProcedure [dbo].[CategoryEkle]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[CategoryEkle](
@ParentID int,
@Name varchar(50),
@IsActive bit ) 
as begin
insert into CATEGORY(ParentID,Name,IsActive) values (@ParentID,@Name,@IsActive) end
GO
/****** Object:  StoredProcedure [dbo].[CategoryList]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[CategoryList]
as begin
select *from CATEGORY end
GO
/****** Object:  StoredProcedure [dbo].[CategorySearch]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------SEARCH KOMUTLARI--------------
CREATE PROC [dbo].[CategorySearch](
@CID int )
as begin
select *from CATEGORY where CID=@CID end
GO
/****** Object:  StoredProcedure [dbo].[CategorySil]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[CategorySil](
@CID int )
as begin
delete from CATEGORY where CID=@CID end
GO
/****** Object:  StoredProcedure [dbo].[CategoryUpdate]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[CategoryUpdate](
@CID int,
@ParentID int,
@Name varchar(50),
@IsActive bit )
as begin
update CATEGORY set ParentID=@ParentID,Name=@Name,IsActive=@IsActive where CID=@CID end
GO
/****** Object:  StoredProcedure [dbo].[DetailsAdd]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DetailsAdd](
@ProductID int
)
as begin
insert into ORDERDETAILS(ProductID) values (@ProductID) end
GO
/****** Object:  StoredProcedure [dbo].[DetailsDelete]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DetailsDelete](
@OrderDetayID int )
as begin
delete from ORDERDETAILS where OrderDetayID=@OrderDetayID end
GO
/****** Object:  StoredProcedure [dbo].[DetailsList]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DetailsList]
as begin
select *from ORDERDETAILS END
GO
/****** Object:  StoredProcedure [dbo].[DetailsUpdate]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[DetailsUpdate](
@OrderDetayID int,
@ProductID int )
as begin
update ORDERDETAILS set ProductID=@ProductID where OrderDetayID=@OrderDetayID END
GO
/****** Object:  StoredProcedure [dbo].[Main_category_add]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Main_category_add](
@ParentName varchar(50))
as begin
insert into MAINCATEGORY(ParentName) values(@ParentName) end
GO
/****** Object:  StoredProcedure [dbo].[Main_category_delete]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Main_category_delete](
@ParentID int) 
as begin
delete from MAINCATEGORY where ParentID=@ParentID end
GO
/****** Object:  StoredProcedure [dbo].[Main_category_list]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Main_category_list]
as begin
select *from MAINCATEGORY end
GO
/****** Object:  StoredProcedure [dbo].[Main_category_update]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[Main_category_update](
@ParentID int,
@ParentName varchar(50))
as begin
update MAINCATEGORY set ParentName=@ParentName where ParentID=@ParentID end
GO
/****** Object:  StoredProcedure [dbo].[MainSearch]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[MainSearch]
@ParentID int
as begin
select *from MAINCATEGORY where ParentID=@ParentID end
GO
/****** Object:  StoredProcedure [dbo].[OrderAdd]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[OrderAdd](
@UserID int,
@UserAddress varchar(50),
@CreateDate date,
@TotalPrice decimal(18,2),
@Order_detay_id int )
as begin
insert  into  ORDERS(UserID,UserAddress,CreateDate,TotalPrice,Order_detay_id) values(@UserID,@UserAddress,@CreateDate,@TotalPrice,@Order_detay_id) end
GO
/****** Object:  StoredProcedure [dbo].[OrderDelete]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[OrderDelete](
@OID int
)
as begin
delete from ORDERS where OID=@OID end
GO
/****** Object:  StoredProcedure [dbo].[OrderDetailAdd]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[OrderDetailAdd](
 @ProductID int,
 @ProductPrice decimal(18,2),
 @Number decimal(18,2),
 @UserID int )
 as begin
 insert into ORDERDETAILS(ProductID,ProductPrice,Number,UserID) values(@ProductID,@ProductPrice,@Number,@UserID) end
GO
/****** Object:  StoredProcedure [dbo].[OrderDetailDelete]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[OrderDetailDelete](
 @OrderDetayID int)
 as begin
 delete from ORDERDETAILS where OrderDetayID=@OrderDetayID end
GO
/****** Object:  StoredProcedure [dbo].[OrderDetailList]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[OrderDetailList]
 as begin
 select *from ORDERDETAILS end
GO
/****** Object:  StoredProcedure [dbo].[OrderDetailsUpdate]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[OrderDetailsUpdate](
@OrderDetayID int,
 @ProductID int,
 @ProductPrice decimal(18,2),
 @Number decimal(18,2),
 @UserID int)
 as begin
update ORDERDETAILS set ProductID=@ProductID,ProductPrice=@ProductPrice,Number=@Number,UserID=@UserID where OrderDetayID=@OrderDetayID end
GO
/****** Object:  StoredProcedure [dbo].[OrderDetaySearch]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[OrderDetaySearch]
@OrderDetayID int
as begin
select *from ORDERDETAILS where OrderDetayID=@OrderDetayID end
GO
/****** Object:  StoredProcedure [dbo].[OrderList]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[OrderList]
as begin
select *from ORDERS end
GO
/****** Object:  StoredProcedure [dbo].[OrderSearch]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[OrderSearch]
@OID int
as begin
select *from ORDERS where OID=@OID end
GO
/****** Object:  StoredProcedure [dbo].[OrderUpdate]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[OrderUpdate](
@OID int,
@UserID int,
@UserAddress varchar(50),
@CreateDate date,
@TotalPrice decimal(18,2),
@Order_detay_id int ) 
as begin
update ORDERS set UserId=@UserId,UserAddress=@UserAddress,CreateDate=@CreateDate,TotalPrice=@TotalPrice,Order_detay_id=@Order_detay_id where OID=@OID end
GO
/****** Object:  StoredProcedure [dbo].[ProductDelete]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ProductDelete](
@PID int )
as begin
delete from PRODUCT where PID=@PID end
GO
/****** Object:  StoredProcedure [dbo].[ProductEkle]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ProductEkle](
@PName varchar(50),
@CategoryID int,
@Brand varchar(50),
@Model varchar(50),
@PDescription varchar(50),
@Price decimal(18,2),
@Stock int ) 
as begin
insert into PRODUCT(PName,CategoryID,Brand,Model,PDescription,Price,Stock) values(@PName,@CategoryID,@Brand,@Model,@PDescription,@Price,@Stock) end
GO
/****** Object:  StoredProcedure [dbo].[ProductList]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ProductList]
AS begin
select *from PRODUCT END
GO
/****** Object:  StoredProcedure [dbo].[ProductSearch]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ProductSearch]
@PID int
as begin
select *from PRODUCT where PID=@PID end
GO
/****** Object:  StoredProcedure [dbo].[ProductUpdate]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ProductUpdate](
@PID int,
@PName varchar(50),
@CategoryID int,
@Brand varchar(50),
@Model varchar(50),
@PDescription varchar(50),
@Price decimal(18,2),
@Stock int ) 
as begin
Update PRODUCT set PName=@PName,CategoryID=@CategoryID,Brand=@Brand,Model=@Model,PDescription=@PDescription,Price=@Price,Stock=@Stock where PID=@PID end
GO
/****** Object:  StoredProcedure [dbo].[UserAdd]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UserAdd](
@Name varchar(50),
@LastName varchar(50),
@EMail varchar(50),
@Telephone varchar(50),
@TC char(11) )
as begin
insert into USERS(Name,LastName,EMail,Telephone,TC) values(@Name,@LastName,@EMail,@Telephone,@TC) END
GO
/****** Object:  StoredProcedure [dbo].[UserAddressUpdate]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UserAddressUpdate](
@UID int,
@UserID int,
@Title varchar(50),
@City varchar(50),
@Adress varchar(50))
as begin
update UserAdress set UserID=@UserID,Title=@Title,City=@City,Adress=@Adress where UID=@UID end
GO
/****** Object:  StoredProcedure [dbo].[UserAdresSearch]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[UserAdresSearch](
 @UID int )
 as begin
 select *from UserAdress where UID=@UID end
GO
/****** Object:  StoredProcedure [dbo].[UserAdressList]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[UserAdressList]
  as begin
  select *from UserAdress END
GO
/****** Object:  StoredProcedure [dbo].[UserDelete]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UserDelete](
@ID int)
as begin
delete from USERS where ID=@ID end
GO
/****** Object:  StoredProcedure [dbo].[UserList]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UserList] 
as begin
select *from USERS end
GO
/****** Object:  StoredProcedure [dbo].[UserSearch]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UserSearch]
@ID int
as begin
select *from USERS where ID=@ID end
GO
/****** Object:  StoredProcedure [dbo].[UsersUpdate]    Script Date: 22.03.2022 11:46:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UsersUpdate](
@ID int,
@Name varchar(50),
@LastName varchar(50),
@EMail varchar(50),
@Telephone varchar(50),
@TC char(11) )
as begin
update USERS set Name=@Name,LastName=@LastName,EMail=@EMail,Telephone=@Telephone,TC=@TC where ID=@ID end
GO
USE [master]
GO
ALTER DATABASE [ORM_STORE] SET  READ_WRITE 
GO
