USE [master]
GO
/****** Object:  Database [OnlineFoodDelivery]    Script Date: 11/08/2023 07.29.31 ******/
CREATE DATABASE [OnlineFoodDelivery]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineFoodDelivery', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\OnlineFoodDelivery.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlineFoodDelivery_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\OnlineFoodDelivery_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [OnlineFoodDelivery] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineFoodDelivery].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineFoodDelivery] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineFoodDelivery] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlineFoodDelivery] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OnlineFoodDelivery] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineFoodDelivery] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OnlineFoodDelivery] SET  MULTI_USER 
GO
ALTER DATABASE [OnlineFoodDelivery] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineFoodDelivery] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineFoodDelivery] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlineFoodDelivery] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OnlineFoodDelivery] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OnlineFoodDelivery] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [OnlineFoodDelivery] SET QUERY_STORE = OFF
GO
USE [OnlineFoodDelivery]
GO
/****** Object:  Table [dbo].[ApiLog]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApiLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Endpoint] [nvarchar](255) NULL,
	[Method] [nvarchar](10) NULL,
	[RequestBody] [nvarchar](max) NULL,
	[ResponseBody] [nvarchar](max) NULL,
	[LogTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[ProductName] [nvarchar](100) NULL,
	[Price] [decimal](18, 2) NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Endpoint] [nvarchar](255) NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[LogTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterModules]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterModules](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MasterRoles]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](100) NULL,
	[OrderDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](500) NULL,
	[Price] [decimal](18, 2) NULL,
	[Category] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleAccessMapping]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleAccessMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdRole] [int] NOT NULL,
	[IdModules] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteOrder]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteOrder]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Orders WHERE Id = @Id)
    BEGIN
        THROW 50004, 'Order not found.', 1;
    END

    DELETE FROM CartItems WHERE OrderId = @Id;
    DELETE FROM Orders WHERE Id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[GetOrdersWithCartItems]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetOrdersWithCartItems]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT o.Id, o.CustomerName, o.OrderDate,
           c.Id AS CartItemId, c.ProductId, c.ProductName, c.Price, c.Quantity
    FROM Orders o
    LEFT JOIN CartItems c ON o.Id = c.OrderId;
END
GO
/****** Object:  StoredProcedure [dbo].[InsertCartItem]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertCartItem]
    @OrderId INT,
    @ProductId INT,
    @ProductName NVARCHAR(100),
    @Price DECIMAL(18, 2),
    @Quantity INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Orders WHERE Id = @OrderId)
    BEGIN
        THROW 50002, 'Order not found.', 1;
    END

    IF @ProductId IS NULL OR @ProductName IS NULL OR @Price IS NULL OR @Quantity IS NULL
    BEGIN
        THROW 50003, 'Invalid cart item data.', 1;
    END

    INSERT INTO CartItems (OrderId, ProductId, ProductName, Price, Quantity)
    VALUES (@OrderId, @ProductId, @ProductName, @Price, @Quantity);
END
GO
/****** Object:  StoredProcedure [dbo].[InsertOrder]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertOrder]
    @CustomerName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF @CustomerName IS NULL
    BEGIN
        THROW 50001, 'Customer name cannot be null.', 1;
    END

    INSERT INTO Orders (CustomerName, OrderDate)
    VALUES (@CustomerName, GETDATE());

    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateCartItem]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateCartItem]
    @OrderId INT,
    @ProductId INT,
    @Quantity INT,
    @Price DECIMAL(18, 2)
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the cart item
    UPDATE CartItems
    SET Quantity = @Quantity,
        Price = @Price
    WHERE OrderId = @OrderId AND ProductId = @ProductId;

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrder]    Script Date: 11/08/2023 07.29.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateOrder]
    @Id INT,
    @CustomerName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Orders WHERE Id = @Id)
    BEGIN
        THROW 50004, 'Order not found.', 1;
    END

    IF @CustomerName IS NULL
    BEGIN
        THROW 50001, 'Customer name cannot be null.', 1;
    END

    UPDATE Orders
    SET CustomerName = @CustomerName
    WHERE Id = @Id;
END
GO
USE [master]
GO
ALTER DATABASE [OnlineFoodDelivery] SET  READ_WRITE 
GO
