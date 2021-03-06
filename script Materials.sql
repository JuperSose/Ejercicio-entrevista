USE [master]
GO
/****** Object:  Database [Materials]    Script Date: 02/06/2022 03:44:51 p. m. ******/
CREATE DATABASE [Materials]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Materials', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Materials.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Materials_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Materials_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Materials] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Materials].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Materials] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Materials] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Materials] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Materials] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Materials] SET ARITHABORT OFF 
GO
ALTER DATABASE [Materials] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Materials] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Materials] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Materials] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Materials] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Materials] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Materials] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Materials] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Materials] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Materials] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Materials] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Materials] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Materials] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Materials] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Materials] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Materials] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Materials] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Materials] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Materials] SET  MULTI_USER 
GO
ALTER DATABASE [Materials] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Materials] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Materials] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Materials] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Materials] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Materials] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Materials] SET QUERY_STORE = OFF
GO
USE [Materials]
GO
/****** Object:  Table [dbo].[Buildings]    Script Date: 02/06/2022 03:44:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Buildings](
	[PKBuilding] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Buildings] PRIMARY KEY CLUSTERED 
(
	[PKBuilding] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 02/06/2022 03:44:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[PKCustomers] [int] IDENTITY(1,1) NOT NULL,
	[Customer] [varchar](50) NOT NULL,
	[Prefix] [varchar](5) NOT NULL,
	[FKBuilding] [int] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[PKCustomers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartNumbers]    Script Date: 02/06/2022 03:44:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartNumbers](
	[PKPartNumber] [int] IDENTITY(1,1) NOT NULL,
	[PartNumber] [varchar](50) NOT NULL,
	[FKCustomer] [int] NOT NULL,
	[Available] [bit] NOT NULL,
 CONSTRAINT [PK_PartNumbers] PRIMARY KEY CLUSTERED 
(
	[PKPartNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Buildings] FOREIGN KEY([FKBuilding])
REFERENCES [dbo].[Buildings] ([PKBuilding])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Buildings]
GO
ALTER TABLE [dbo].[PartNumbers]  WITH CHECK ADD  CONSTRAINT [FK_PartNumbers_Customers] FOREIGN KEY([FKCustomer])
REFERENCES [dbo].[Customers] ([PKCustomers])
GO
ALTER TABLE [dbo].[PartNumbers] CHECK CONSTRAINT [FK_PartNumbers_Customers]
GO
/****** Object:  StoredProcedure [dbo].[AddBuilding]    Script Date: 02/06/2022 03:44:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddBuilding] 
	-- Add the parameters for the stored procedure here
	@building Varchar(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO Buildings
	(Building)
VALUES
	(@building);
    
END
GO
/****** Object:  StoredProcedure [dbo].[AddCustomer]    Script Date: 02/06/2022 03:44:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE PROCEDURE [dbo].[AddCustomer] 
	-- Add the parameters for the stored procedure here
	@customer Varchar(50),
	@prefix Varchar(50), 
	@building Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO Customers
	(Customer, Prefix, FKBuilding)
VALUES
	(@customer, @prefix,@building
	);
    
END
GO
/****** Object:  StoredProcedure [dbo].[AddPartNumber]    Script Date: 02/06/2022 03:44:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- =============================================
CREATE PROCEDURE [dbo].[AddPartNumber] 
	-- Add the parameters for the stored procedure here
	@partnumber Varchar(50),
	@customer Int, 
	@available bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO PartNumbers
	(PartNumber, Available, FKCustomer)
VALUES
	(@partnumber, @available, @customer);
    
END
GO
/****** Object:  StoredProcedure [dbo].[GetBuildings]    Script Date: 02/06/2022 03:44:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetBuildings]

as

Begin

	select *
	from Buildings;
END

GO
/****** Object:  StoredProcedure [dbo].[GetCustomers]    Script Date: 02/06/2022 03:44:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetCustomers]

as

Begin

	select *
	from Customers;
END

GO
/****** Object:  StoredProcedure [dbo].[GetGridViewData]    Script Date: 02/06/2022 03:44:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetGridViewData]

AS
BEGIN

	SELECT 
	PartNumbers.PartNumber, Customers.Customer, Buildings.Building, PartNumbers.Available
FROM PartNumbers
INNER JOIN
	Customers
ON
	PartNumbers.FKCustomer = Customers.PKCustomers
INNER JOIN
	Buildings
ON
	Customers.FKBuilding = Buildings.PKBuilding

END
GO
/****** Object:  StoredProcedure [dbo].[GetPartNumbers]    Script Date: 02/06/2022 03:44:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetPartNumbers]

as

Begin

	select *
	from PartNumbers;
END

GO
USE [master]
GO
ALTER DATABASE [Materials] SET  READ_WRITE 
GO
