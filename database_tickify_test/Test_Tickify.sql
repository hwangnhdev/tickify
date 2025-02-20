USE [master]
GO
/****** Object:  Database [TickifyDB]    Script Date: 2/16/2025 8:24:34 PM ******/
CREATE DATABASE [TickifyDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TickifyDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TickifyDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TickifyDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TickifyDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TickifyDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TickifyDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TickifyDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TickifyDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TickifyDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TickifyDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TickifyDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TickifyDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TickifyDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TickifyDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TickifyDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TickifyDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TickifyDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TickifyDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TickifyDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TickifyDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TickifyDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TickifyDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TickifyDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TickifyDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TickifyDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TickifyDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TickifyDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TickifyDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TickifyDB] SET RECOVERY FULL 
GO
ALTER DATABASE [TickifyDB] SET  MULTI_USER 
GO
ALTER DATABASE [TickifyDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TickifyDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TickifyDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TickifyDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TickifyDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TickifyDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TickifyDB', N'ON'
GO
ALTER DATABASE [TickifyDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [TickifyDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TickifyDB]
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[admin_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[profile_picture] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](100) NOT NULL,
	[description] [text] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer_auths]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_auths](
	[customer_auth_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[auth_provider] [varchar](100) NOT NULL,
	[password] [varchar](255) NULL,
	[provider_id] [varchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_auth_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [varchar](255) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[address] [varchar](255) NULL,
	[phone] [varchar](15) NULL,
	[profile_picture] [varchar](255) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventImages]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventImages](
	[image_id] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NOT NULL,
	[image_url] [varchar](2083) NOT NULL,
	[image_title] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[image_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[category_id] [int] NULL,
	[event_name] [varchar](255) NOT NULL,
	[location] [varchar](255) NULL,
	[event_type] [varchar](100) NULL,
	[status] [varchar](100) NULL,
	[description] [text] NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[order_detail_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[ticket_type_id] [int] NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[voucher_id] [int] NULL,
	[total_price] [decimal](10, 2) NOT NULL,
	[order_date] [datetime] NULL,
	[payment_status] [varchar](100) NULL,
	[transaction_id] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organizers]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organizers](
	[organizer_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[event_id] [int] NOT NULL,
	[organization_name] [varchar](150) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[organizer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seats]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seats](
	[seat_id] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NULL,
	[seat_row] [varchar](10) NULL,
	[seat_number] [varchar](10) NULL,
	[status] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[seat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[ticket_id] [int] IDENTITY(1,1) NOT NULL,
	[order_detail_id] [int] NULL,
	[seat_id] [int] NULL,
	[ticket_code] [varchar](100) NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[status] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ticket_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TicketTypes]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketTypes](
	[ticket_type_id] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [text] NULL,
	[price] [decimal](10, 2) NOT NULL,
	[total_quantity] [int] NOT NULL,
	[sold_quantity] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ticket_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vouchers]    Script Date: 2/16/2025 8:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vouchers](
	[voucher_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](50) NOT NULL,
	[description] [text] NULL,
	[discount_type] [varchar](100) NULL,
	[discount_value] [decimal](10, 2) NULL,
	[expiration_date] [datetime] NULL,
	[usage_limit] [int] NULL,
	[status] [bit] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[voucher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admins] ON 
GO
INSERT [dbo].[Admins] ([admin_id], [name], [email], [password], [profile_picture]) VALUES (1, N'Admin One', N'admin1@example.com', N'hashed_password1', N'admin1.jpg')
GO
INSERT [dbo].[Admins] ([admin_id], [name], [email], [password], [profile_picture]) VALUES (2, N'Admin Two', N'admin2@example.com', N'hashed_password2', N'admin2.jpg')
GO
SET IDENTITY_INSERT [dbo].[Admins] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 
GO
INSERT [dbo].[Categories] ([category_id], [category_name], [description], [created_at], [updated_at]) VALUES (1, N'Concert', N'Live music performances.', CAST(N'2025-02-13T18:34:41.803' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime))
GO
INSERT [dbo].[Categories] ([category_id], [category_name], [description], [created_at], [updated_at]) VALUES (2, N'Technology', N'Tech events and conferences.', CAST(N'2025-02-13T18:34:41.803' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime))
GO
INSERT [dbo].[Categories] ([category_id], [category_name], [description], [created_at], [updated_at]) VALUES (3, N'Sports', N'Live sports events.', CAST(N'2025-02-13T18:34:41.803' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime))
GO
INSERT [dbo].[Categories] ([category_id], [category_name], [description], [created_at], [updated_at]) VALUES (4, N'Festival', N'Cultural and food festivals.', CAST(N'2025-02-13T18:34:41.803' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime))
GO
INSERT [dbo].[Categories] ([category_id], [category_name], [description], [created_at], [updated_at]) VALUES (5, N'Exhibition', N'Art, science, and industry exhibitions.', CAST(N'2025-02-13T18:34:41.803' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer_auths] ON 
GO
INSERT [dbo].[Customer_auths] ([customer_auth_id], [customer_id], [auth_provider], [password], [provider_id], [created_at], [updated_at]) VALUES (1, 1, N'EMAIL', N'hashed_password1', NULL, CAST(N'2025-02-13T18:34:41.817' AS DateTime), CAST(N'2025-02-13T18:34:41.817' AS DateTime))
GO
INSERT [dbo].[Customer_auths] ([customer_auth_id], [customer_id], [auth_provider], [password], [provider_id], [created_at], [updated_at]) VALUES (2, 2, N'GOOGLE', NULL, N'google_id_2', CAST(N'2025-02-13T18:34:41.817' AS DateTime), CAST(N'2025-02-13T18:34:41.817' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Customer_auths] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 
GO
INSERT [dbo].[Customers] ([customer_id], [full_name], [email], [address], [phone], [profile_picture], [status]) VALUES (1, N'John Doe', N'john@example.com', N'123 Main St', N'1234567890', N'john.jpg', 1)
GO
INSERT [dbo].[Customers] ([customer_id], [full_name], [email], [address], [phone], [profile_picture], [status]) VALUES (2, N'Alice Smith', N'alice@example.com', N'456 Park Ave', N'9876543210', N'alice.jpg', 1)
GO
INSERT [dbo].[Customers] ([customer_id], [full_name], [email], [address], [phone], [profile_picture], [status]) VALUES (3, N'Bob Johnson', N'bob@example.com', N'789 Elm St', N'5556667777', N'bob.jpg', 1)
GO
INSERT [dbo].[Customers] ([customer_id], [full_name], [email], [address], [phone], [profile_picture], [status]) VALUES (4, N'Emma Davis', N'emma@example.com', N'321 Pine St', N'1112223333', N'emma.jpg', 1)
GO
INSERT [dbo].[Customers] ([customer_id], [full_name], [email], [address], [phone], [profile_picture], [status]) VALUES (5, N'Michael Brown', N'michael@example.com', N'654 Oak St', N'4445556666', N'michael.jpg', 1)
GO
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[EventImages] ON 
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (69, 1, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624224/jhzu9yuyvsdueojghwsb.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (70, 2, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624227/v64ypkynhius2xccpzgk.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (71, 3, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624230/itymx6bdfneuxndmlcsg.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (72, 4, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624232/oifi1uh6riz2lrv5qytl.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (73, 5, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624234/t9zcn1fec9qrldoybnfy.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (74, 6, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624236/hrako2lufs64e2fo5juu.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (75, 7, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624238/woppu4tgnjl2vqbz1mne.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (76, 8, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624240/ph1s4mlbpdyxorbr84jl.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (77, 9, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624243/dppet5u1opx5k6gyoowg.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (78, 10, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624245/jkqdgt64euco7hijfykz.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (79, 11, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624246/bnekt6841nvpradzy7yr.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (80, 12, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624248/ijkynfulticfadwln7jy.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (81, 13, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624250/chzyvklgrlxiiynjkuxz.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (82, 14, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624252/ixkpfl0rypcz1bclus44.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (83, 15, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624254/zarbrniyk3m2e5m7us54.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (84, 16, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624255/xdnx6ritk0wkkr9fqu9d.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (85, 17, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624258/ntt2qhs9gxhabp13x5gp.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (86, 18, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624261/otkml3dyicode5flrism.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (87, 19, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624264/qq6glopvn8plusi4nuim.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (88, 20, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624266/uljkaa2xvree05iizsjf.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (89, 21, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624268/cbavynxl2pj9s8ts2olk.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (90, 22, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624270/hd2yyy91fahaluwqtwgp.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (91, 23, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624272/ml7bj4lukllatfyzmjxf.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (92, 24, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624275/jkxqdsiycc03abjymqdi.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (93, 25, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624277/uqmazzi3jz84f4qr70hp.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (94, 26, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624279/nsruqxgtyfkqjrkkaazl.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (95, 27, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624282/wn3uttlpprzhh8gbvdir.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (96, 28, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624284/azgdovktxjhhoauawfvl.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (97, 29, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624287/itefltb36h9rnnoglkq8.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (98, 30, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624357/ebz0mun9dnv4tv19uioh.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (99, 31, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624692/qmleizhralifopnflp3n.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (100, 32, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624695/wfkrejnukm10c8bmkfn4.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (101, 33, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624697/i6wd1lorujgfw5phdq6q.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (102, 34, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624699/qsi5cpl8jgnys3rif0wp.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (103, 35, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624701/yxhkufqwqoe1nx3vfcq4.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (104, 36, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624703/vytj3ldvluj8am9sawnw.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (105, 37, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624705/kpb0v7z6cvrkwciiqgxa.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (106, 38, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624708/upqo03ugyk2e7deh5phf.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (107, 39, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624710/qzqcyjozmyfqjsceup4u.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (108, 40, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624712/x0cgz6lxpwtynllkwse6.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (109, 41, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624714/y8hpbdpwqv1duxsdyzrc.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (110, 42, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624716/mmsd2eqav7jffavudcru.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (111, 43, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624718/shifsxhxixt41k9uw8pc.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (112, 44, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624720/svxrud00hehfoetipku8.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (113, 45, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624722/sg84dfmhbvrcevaghwrf.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (114, 46, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624724/weoybf6tlpe5tiajej9o.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (115, 47, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624726/rhitiyzxrotpykmsyoj0.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (116, 48, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624729/a7dd6bjtlphtpmg3izif.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (117, 49, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624732/oo0xrlvmeiajsbesyf9u.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (118, 50, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624734/ikx9rng3r3oyoy53hdmk.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (119, 51, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624737/fmebh5ypyamewckouqma.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (120, 52, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624739/yzdyoaodwpslnhnrywam.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (121, 53, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624741/vxgzrktg7hzvlipxkyts.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (122, 54, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624744/y4mbnx4f0jllav8m78ic.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (123, 55, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624746/z0wvpiwqsjn64vjanowf.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (124, 56, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624749/ir76nkfnwurddn6vwmhs.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (125, 57, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624751/x4baio4nhaou29pbtek6.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (126, 58, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624754/qtfmracqfmkyftoovkfl.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (127, 59, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624756/rjj2vefsmcb5itcxbteq.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (128, 60, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624759/xveb2t9u48ouh6wvlwxy.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (129, 61, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624761/iljkt1laxdlxjobcupxo.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (130, 62, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624763/smzduevsdkicxbxtdgtz.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (131, 63, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624765/nfae2zaxlba4apd1huhw.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (132, 64, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624767/wht4crswglvqgreqb60s.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (133, 65, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624769/naygxyof73aygxdw8f6h.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (134, 66, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624772/c6md77651t6wgpjvhdhy.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (135, 67, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624774/uonvnxtehtoezmwooj21.webp', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (136, 68, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624777/prhvgysb35yzfizemxqq.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (137, 69, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624779/dxfyqc8ipwlxdn2t7xk2.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (138, 70, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624782/yuykjnht7cnsux5jhwmp.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (139, 71, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624784/usxq68dg10ohiyjcxfnw.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (140, 72, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624788/qxuxnsyuof03lmhjcgj1.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (141, 73, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624790/rf7sueak6t7xbntiuzcj.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (142, 74, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624793/sbtebivpbkgr9indbdhy.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (143, 75, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624796/t2oe3nksdbtws5hhceju.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (144, 76, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624798/v73ukbbpor25w9lzhb3m.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (145, 77, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624800/k240hpwtibcpxwgeibay.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (146, 78, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624803/m3zniquykjqgnq0pjvdn.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (147, 79, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624806/g2rp1ikgtmoirtee89oz.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (148, 80, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624808/dibzegjb1ndg5pj1haj3.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (149, 81, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624810/fntav4efutjb86iaxqxl.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (150, 82, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624813/ygieutltce2yf4jk9b8d.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (151, 83, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624815/ovwkietclqrgmkxird8w.jpg', N'Music banner')
GO
INSERT [dbo].[EventImages] ([image_id], [event_id], [image_url], [image_title]) VALUES (152, 84, N'https://res.cloudinary.com/dnvpphtov/image/upload/v1739624817/bxdw0k9tmlg0ijvfbtup.jpg', N'Music banner')
GO
SET IDENTITY_INSERT [dbo].[EventImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Events] ON 
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (1, 1, N'Rock Festival', N'Open Arena', N'Music', N'Active', N'Rock bands live.', CAST(N'2025-06-20T00:00:00.000' AS DateTime), CAST(N'2025-06-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (2, 2, N'AI & Robotics Summit', N'Tech Hub', N'Technology', N'Active', N'Advancements in AI.', CAST(N'2025-07-25T00:00:00.000' AS DateTime), CAST(N'2025-07-26T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (3, 3, N'National Basketball League', N'Sports Arena', N'Sports', N'Active', N'Finals of national basketball.', CAST(N'2025-09-30T00:00:00.000' AS DateTime), CAST(N'2025-10-01T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (4, 4, N'Christmas Market', N'Downtown Plaza', N'Festival', N'Active', N'Holiday shopping & food.', CAST(N'2025-12-15T00:00:00.000' AS DateTime), CAST(N'2025-12-25T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (5, 5, N'Classic Paintings Showcase', N'Museum Hall', N'Exhibition', N'Active', N'Display of classic artworks.', CAST(N'2025-08-30T00:00:00.000' AS DateTime), CAST(N'2025-08-31T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime), CAST(N'2025-02-13T18:34:41.803' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (6, 1, N'Rock Festival', N'Open Arena', N'Music', N'Active', N'Rock bands live.', CAST(N'2025-06-20T00:00:00.000' AS DateTime), CAST(N'2025-06-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:07.177' AS DateTime), CAST(N'2025-02-13T18:40:07.177' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (7, 2, N'AI & Robotics Summit', N'Tech Hub', N'Technology', N'Active', N'Advancements in AI.', CAST(N'2025-07-25T00:00:00.000' AS DateTime), CAST(N'2025-07-26T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:07.177' AS DateTime), CAST(N'2025-02-13T18:40:07.177' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (8, 3, N'National Basketball League', N'Sports Arena', N'Sports', N'Active', N'Finals of national basketball.', CAST(N'2025-09-30T00:00:00.000' AS DateTime), CAST(N'2025-10-01T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:07.177' AS DateTime), CAST(N'2025-02-13T18:40:07.177' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (9, 4, N'Christmas Market', N'Downtown Plaza', N'Festival', N'Active', N'Holiday shopping & food.', CAST(N'2025-12-15T00:00:00.000' AS DateTime), CAST(N'2025-12-25T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:07.177' AS DateTime), CAST(N'2025-02-13T18:40:07.177' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (10, 5, N'Classic Paintings Showcase', N'Museum Hall', N'Exhibition', N'Active', N'Display of classic artworks.', CAST(N'2025-08-30T00:00:00.000' AS DateTime), CAST(N'2025-08-31T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:07.177' AS DateTime), CAST(N'2025-02-13T18:40:07.177' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (11, 1, N'Rock Festival', N'Open Arena', N'Music', N'Active', N'Rock bands live.', CAST(N'2025-06-20T00:00:00.000' AS DateTime), CAST(N'2025-06-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:09.590' AS DateTime), CAST(N'2025-02-13T18:40:09.590' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (12, 2, N'AI & Robotics Summit', N'Tech Hub', N'Technology', N'Active', N'Advancements in AI.', CAST(N'2025-07-25T00:00:00.000' AS DateTime), CAST(N'2025-07-26T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:09.590' AS DateTime), CAST(N'2025-02-13T18:40:09.590' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (13, 3, N'National Basketball League', N'Sports Arena', N'Sports', N'Active', N'Finals of national basketball.', CAST(N'2025-09-30T00:00:00.000' AS DateTime), CAST(N'2025-10-01T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:09.590' AS DateTime), CAST(N'2025-02-13T18:40:09.590' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (14, 4, N'Christmas Market', N'Downtown Plaza', N'Festival', N'Active', N'Holiday shopping & food.', CAST(N'2025-12-15T00:00:00.000' AS DateTime), CAST(N'2025-12-25T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:09.590' AS DateTime), CAST(N'2025-02-13T18:40:09.590' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (15, 5, N'Classic Paintings Showcase', N'Museum Hall', N'Exhibition', N'Active', N'Display of classic artworks.', CAST(N'2025-08-30T00:00:00.000' AS DateTime), CAST(N'2025-08-31T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:09.590' AS DateTime), CAST(N'2025-02-13T18:40:09.590' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (16, 1, N'Rock Festival', N'Open Arena', N'Music', N'Active', N'Rock bands live.', CAST(N'2025-06-20T00:00:00.000' AS DateTime), CAST(N'2025-06-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:10.713' AS DateTime), CAST(N'2025-02-13T18:40:10.713' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (17, 2, N'AI & Robotics Summit', N'Tech Hub', N'Technology', N'Active', N'Advancements in AI.', CAST(N'2025-07-25T00:00:00.000' AS DateTime), CAST(N'2025-07-26T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:10.713' AS DateTime), CAST(N'2025-02-13T18:40:10.713' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (18, 3, N'National Basketball League', N'Sports Arena', N'Sports', N'Active', N'Finals of national basketball.', CAST(N'2025-09-30T00:00:00.000' AS DateTime), CAST(N'2025-10-01T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:10.713' AS DateTime), CAST(N'2025-02-13T18:40:10.713' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (19, 4, N'Christmas Market', N'Downtown Plaza', N'Festival', N'Active', N'Holiday shopping & food.', CAST(N'2025-12-15T00:00:00.000' AS DateTime), CAST(N'2025-12-25T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:10.713' AS DateTime), CAST(N'2025-02-13T18:40:10.713' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (20, 5, N'Classic Paintings Showcase', N'Museum Hall', N'Exhibition', N'Active', N'Display of classic artworks.', CAST(N'2025-08-30T00:00:00.000' AS DateTime), CAST(N'2025-08-31T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:40:10.713' AS DateTime), CAST(N'2025-02-13T18:40:10.713' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (21, 1, N'Rock Festival', N'Open Arena', N'Music', N'Active', N'Rock bands live.', CAST(N'2025-06-20T00:00:00.000' AS DateTime), CAST(N'2025-06-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (22, 2, N'AI & Robotics Summit', N'Tech Hub', N'Technology', N'Active', N'Advancements in AI.', CAST(N'2025-07-25T00:00:00.000' AS DateTime), CAST(N'2025-07-26T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (23, 3, N'National Basketball League', N'Sports Arena', N'Sports', N'Active', N'Finals of national basketball.', CAST(N'2025-09-30T00:00:00.000' AS DateTime), CAST(N'2025-10-01T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (24, 4, N'Christmas Market', N'Downtown Plaza', N'Festival', N'Active', N'Holiday shopping & food.', CAST(N'2025-12-15T00:00:00.000' AS DateTime), CAST(N'2025-12-25T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (25, 5, N'Classic Paintings Showcase', N'Museum Hall', N'Exhibition', N'Active', N'Display of classic artworks.', CAST(N'2025-08-30T00:00:00.000' AS DateTime), CAST(N'2025-08-31T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (26, 1, N'Hip Hop Night', N'Club XYZ', N'Music', N'Active', N'Live hip hop music.', CAST(N'2025-07-10T00:00:00.000' AS DateTime), CAST(N'2025-07-11T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (27, 1, N'Jazz Evening', N'Jazz Lounge', N'Music', N'Active', N'Smooth jazz night.', CAST(N'2025-08-05T00:00:00.000' AS DateTime), CAST(N'2025-08-05T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (28, 2, N'Blockchain Expo', N'Tech Convention Center', N'Technology', N'Active', N'Blockchain innovations.', CAST(N'2025-09-20T00:00:00.000' AS DateTime), CAST(N'2025-09-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (29, 2, N'Cybersecurity Forum', N'Virtual Event', N'Technology', N'Active', N'Talks on cyber threats.', CAST(N'2025-10-12T00:00:00.000' AS DateTime), CAST(N'2025-10-13T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (30, 3, N'Marathon 2025', N'City Streets', N'Sports', N'Active', N'Annual city marathon.', CAST(N'2025-11-05T00:00:00.000' AS DateTime), CAST(N'2025-11-05T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (31, 3, N'Tennis Open', N'Grand Stadium', N'Sports', N'Active', N'National tennis tournament.', CAST(N'2025-12-01T00:00:00.000' AS DateTime), CAST(N'2025-12-05T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (32, 4, N'Food & Wine Festival', N'Park Grounds', N'Festival', N'Active', N'Gourmet food tasting.', CAST(N'2025-10-15T00:00:00.000' AS DateTime), CAST(N'2025-10-16T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (33, 4, N'Halloween Carnival', N'Downtown', N'Festival', N'Active', N'Costume party & games.', CAST(N'2025-10-31T00:00:00.000' AS DateTime), CAST(N'2025-10-31T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (34, 5, N'Tech Gadgets Expo', N'Convention Hall', N'Exhibition', N'Active', N'Latest tech gadgets.', CAST(N'2025-09-01T00:00:00.000' AS DateTime), CAST(N'2025-09-02T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (35, 5, N'Space Exploration Fair', N'Science Center', N'Exhibition', N'Active', N'Space tech innovations.', CAST(N'2025-11-10T00:00:00.000' AS DateTime), CAST(N'2025-11-12T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (36, 1, N'K-Pop Concert', N'Stadium ABC', N'Music', N'Active', N'Live K-Pop performances.', CAST(N'2025-12-20T00:00:00.000' AS DateTime), CAST(N'2025-12-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (37, 3, N'Football Championship', N'National Stadium', N'Sports', N'Active', N'Top football teams.', CAST(N'2025-11-30T00:00:00.000' AS DateTime), CAST(N'2025-12-01T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (38, 4, N'Christmas Celebration', N'Central Park', N'Festival', N'Active', N'Christmas music & lights.', CAST(N'2025-12-24T00:00:00.000' AS DateTime), CAST(N'2025-12-25T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (39, 2, N'Startup Pitch Night', N'Tech Hub', N'Technology', N'Active', N'Startup investment opportunities.', CAST(N'2025-09-15T00:00:00.000' AS DateTime), CAST(N'2025-09-15T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (40, 5, N'Photography Exhibition', N'Gallery Hall', N'Exhibition', N'Active', N'Showcasing world-class photography.', CAST(N'2025-08-25T00:00:00.000' AS DateTime), CAST(N'2025-08-26T00:00:00.000' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime), CAST(N'2025-02-13T18:49:46.317' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (41, 1, N'Rock Festival', N'Open Arena', N'Music', N'Active', N'Rock bands live.', CAST(N'2025-06-20T00:00:00.000' AS DateTime), CAST(N'2025-06-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (42, 2, N'AI & Robotics Summit', N'Tech Hub', N'Technology', N'Active', N'Advancements in AI.', CAST(N'2025-07-25T00:00:00.000' AS DateTime), CAST(N'2025-07-26T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (43, 3, N'National Basketball League', N'Sports Arena', N'Sports', N'Active', N'Finals of national basketball.', CAST(N'2025-09-30T00:00:00.000' AS DateTime), CAST(N'2025-10-01T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (44, 4, N'Christmas Market', N'Downtown Plaza', N'Festival', N'Active', N'Holiday shopping & food.', CAST(N'2025-12-15T00:00:00.000' AS DateTime), CAST(N'2025-12-25T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (45, 5, N'Classic Paintings Showcase', N'Museum Hall', N'Exhibition', N'Active', N'Display of classic artworks.', CAST(N'2025-08-30T00:00:00.000' AS DateTime), CAST(N'2025-08-31T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (46, 1, N'Hip Hop Night', N'Club XYZ', N'Music', N'Active', N'Live hip hop music.', CAST(N'2025-07-10T00:00:00.000' AS DateTime), CAST(N'2025-07-11T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (47, 1, N'Jazz Evening', N'Jazz Lounge', N'Music', N'Active', N'Smooth jazz night.', CAST(N'2025-08-05T00:00:00.000' AS DateTime), CAST(N'2025-08-05T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (48, 2, N'Blockchain Expo', N'Tech Convention Center', N'Technology', N'Active', N'Blockchain innovations.', CAST(N'2025-09-20T00:00:00.000' AS DateTime), CAST(N'2025-09-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (49, 2, N'Cybersecurity Forum', N'Virtual Event', N'Technology', N'Active', N'Talks on cyber threats.', CAST(N'2025-10-12T00:00:00.000' AS DateTime), CAST(N'2025-10-13T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (50, 3, N'Marathon 2025', N'City Streets', N'Sports', N'Active', N'Annual city marathon.', CAST(N'2025-11-05T00:00:00.000' AS DateTime), CAST(N'2025-11-05T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (51, 3, N'Tennis Open', N'Grand Stadium', N'Sports', N'Active', N'National tennis tournament.', CAST(N'2025-12-01T00:00:00.000' AS DateTime), CAST(N'2025-12-05T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (52, 4, N'Food & Wine Festival', N'Park Grounds', N'Festival', N'Active', N'Gourmet food tasting.', CAST(N'2025-10-15T00:00:00.000' AS DateTime), CAST(N'2025-10-16T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (53, 4, N'Halloween Carnival', N'Downtown', N'Festival', N'Active', N'Costume party & games.', CAST(N'2025-10-31T00:00:00.000' AS DateTime), CAST(N'2025-10-31T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (54, 5, N'Tech Gadgets Expo', N'Convention Hall', N'Exhibition', N'Active', N'Latest tech gadgets.', CAST(N'2025-09-01T00:00:00.000' AS DateTime), CAST(N'2025-09-02T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (55, 5, N'Space Exploration Fair', N'Science Center', N'Exhibition', N'Active', N'Space tech innovations.', CAST(N'2025-11-10T00:00:00.000' AS DateTime), CAST(N'2025-11-12T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (56, 1, N'K-Pop Concert', N'Stadium ABC', N'Music', N'Active', N'Live K-Pop performances.', CAST(N'2025-12-20T00:00:00.000' AS DateTime), CAST(N'2025-12-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (57, 3, N'Football Championship', N'National Stadium', N'Sports', N'Active', N'Top football teams.', CAST(N'2025-11-30T00:00:00.000' AS DateTime), CAST(N'2025-12-01T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (58, 4, N'Christmas Celebration', N'Central Park', N'Festival', N'Active', N'Christmas music & lights.', CAST(N'2025-12-24T00:00:00.000' AS DateTime), CAST(N'2025-12-25T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (59, 2, N'Startup Pitch Night', N'Tech Hub', N'Technology', N'Active', N'Startup investment opportunities.', CAST(N'2025-09-15T00:00:00.000' AS DateTime), CAST(N'2025-09-15T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (60, 5, N'Photography Exhibition', N'Gallery Hall', N'Exhibition', N'Active', N'Showcasing world-class photography.', CAST(N'2025-08-25T00:00:00.000' AS DateTime), CAST(N'2025-08-26T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (61, 1, N'Indie Rock Night', N'Music Hall', N'Music', N'Active', N'Live indie rock performances.', CAST(N'2025-07-15T00:00:00.000' AS DateTime), CAST(N'2025-07-15T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (62, 1, N'Electronic Dance Festival', N'Beachside Arena', N'Music', N'Active', N'A night of EDM and DJs.', CAST(N'2025-08-22T00:00:00.000' AS DateTime), CAST(N'2025-08-23T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (63, 2, N'Future Tech Conference', N'Innovation Hub', N'Technology', N'Active', N'Discussing future tech trends.', CAST(N'2025-11-20T00:00:00.000' AS DateTime), CAST(N'2025-11-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (64, 2, N'Virtual Reality Summit', N'Tech Center', N'Technology', N'Active', N'Exploring VR advancements.', CAST(N'2025-10-05T00:00:00.000' AS DateTime), CAST(N'2025-10-06T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (65, 3, N'International Chess Tournament', N'Grand Hall', N'Sports', N'Active', N'Global chess masters compete.', CAST(N'2025-09-10T00:00:00.000' AS DateTime), CAST(N'2025-09-15T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (66, 3, N'Extreme Sports Expo', N'Mountain Park', N'Sports', N'Active', N'Showcasing extreme sports.', CAST(N'2025-06-28T00:00:00.000' AS DateTime), CAST(N'2025-06-29T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (67, 4, N'Cultural Heritage Fair', N'City Square', N'Festival', N'Active', N'Traditional arts and crafts.', CAST(N'2025-07-05T00:00:00.000' AS DateTime), CAST(N'2025-07-07T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (68, 4, N'Lantern Festival', N'Riverside Park', N'Festival', N'Active', N'Lanterns lighting up the night.', CAST(N'2025-09-18T00:00:00.000' AS DateTime), CAST(N'2025-09-18T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (69, 5, N'Modern Art Exhibition', N'Art Gallery', N'Exhibition', N'Active', N'Contemporary art showcase.', CAST(N'2025-07-12T00:00:00.000' AS DateTime), CAST(N'2025-07-14T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (70, 5, N'Historical Artifacts Display', N'National Museum', N'Exhibition', N'Active', N'Ancient relics and history.', CAST(N'2025-11-02T00:00:00.000' AS DateTime), CAST(N'2025-11-05T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (71, 1, N'Acoustic Music Night', N'Cozy Café', N'Music', N'Active', N'Intimate acoustic performances.', CAST(N'2025-06-25T00:00:00.000' AS DateTime), CAST(N'2025-06-25T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (72, 2, N'AI Ethics Panel', N'Online Webinar', N'Technology', N'Active', N'Debating AI’s ethical impact.', CAST(N'2025-08-15T00:00:00.000' AS DateTime), CAST(N'2025-08-15T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (73, 3, N'City Cycling Race', N'Downtown Streets', N'Sports', N'Active', N'Annual city cycling event.', CAST(N'2025-09-08T00:00:00.000' AS DateTime), CAST(N'2025-09-08T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (74, 4, N'Oktoberfest Celebration', N'Beer Garden', N'Festival', N'Active', N'German beer & culture.', CAST(N'2025-10-10T00:00:00.000' AS DateTime), CAST(N'2025-10-12T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (75, 5, N'Futuristic Architecture Expo', N'Convention Center', N'Exhibition', N'Active', N'Innovations in architecture.', CAST(N'2025-12-05T00:00:00.000' AS DateTime), CAST(N'2025-12-07T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (76, 1, N'Blues & Soul Night', N'City Lounge', N'Music', N'Active', N'Relaxing blues and soul tunes.', CAST(N'2025-08-18T00:00:00.000' AS DateTime), CAST(N'2025-08-18T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (77, 2, N'Green Energy Forum', N'Sustainability Center', N'Technology', N'Active', N'Future of renewable energy.', CAST(N'2025-11-28T00:00:00.000' AS DateTime), CAST(N'2025-11-29T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (78, 3, N'Pro Wrestling Showdown', N'Stadium XYZ', N'Sports', N'Active', N'High-energy wrestling matches.', CAST(N'2025-07-30T00:00:00.000' AS DateTime), CAST(N'2025-07-30T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (79, 4, N'Harvest Festival', N'Farm Grounds', N'Festival', N'Active', N'Celebrating autumn harvest.', CAST(N'2025-10-05T00:00:00.000' AS DateTime), CAST(N'2025-10-07T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (80, 5, N'Anime & Manga Convention', N'Expo Hall', N'Exhibition', N'Active', N'Celebrating anime culture.', CAST(N'2025-09-22T00:00:00.000' AS DateTime), CAST(N'2025-09-23T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime), CAST(N'2025-02-13T23:21:07.920' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (81, 1, N'Rock Festival', N'Open Arena', N'Music', N'Active', N'Rock bands live.', CAST(N'2025-06-20T00:00:00.000' AS DateTime), CAST(N'2025-06-21T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:49.127' AS DateTime), CAST(N'2025-02-13T23:21:49.127' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (82, 2, N'AI & Robotics Summit', N'Tech Hub', N'Technology', N'Active', N'Advancements in AI.', CAST(N'2025-07-25T00:00:00.000' AS DateTime), CAST(N'2025-07-26T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:49.127' AS DateTime), CAST(N'2025-02-13T23:21:49.127' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (83, 3, N'National Basketball League', N'Sports Arena', N'Sports', N'Active', N'Finals of national basketball.', CAST(N'2025-09-30T00:00:00.000' AS DateTime), CAST(N'2025-10-01T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:49.127' AS DateTime), CAST(N'2025-02-13T23:21:49.127' AS DateTime))
GO
INSERT [dbo].[Events] ([event_id], [category_id], [event_name], [location], [event_type], [status], [description], [start_date], [end_date], [created_at], [updated_at]) VALUES (84, 4, N'Christmas Market', N'Downtown Plaza', N'Festival', N'Active', N'Holiday shopping & food.', CAST(N'2025-12-15T00:00:00.000' AS DateTime), CAST(N'2025-12-25T00:00:00.000' AS DateTime), CAST(N'2025-02-13T23:21:49.127' AS DateTime), CAST(N'2025-02-13T23:21:49.127' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Events] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (1, 1, 1, 2, CAST(180.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (2, 2, 2, 3, CAST(290.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (3, 3, 3, 1, CAST(350.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (4, 1, 1, 2, CAST(180.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (5, 2, 2, 3, CAST(290.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (6, 3, 3, 1, CAST(350.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (7, 4, 6, 2, CAST(300.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (8, 4, 7, 3, CAST(225.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (9, 5, 8, 5, CAST(250.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (10, 5, 9, 1, CAST(40.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (11, 5, 10, 2, CAST(400.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (12, 3, 11, 2, CAST(500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (13, 3, 12, 4, CAST(240.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (14, 2, 13, 3, CAST(270.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (15, 2, 14, 2, CAST(60.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([order_detail_id], [order_id], [ticket_type_id], [quantity], [price]) VALUES (16, 1, 15, 4, CAST(220.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (1, 1, NULL, CAST(180.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:34:41.810' AS DateTime), N'Completed', N'TXN123470', CAST(N'2025-02-13T18:34:41.810' AS DateTime), CAST(N'2025-02-13T18:34:41.810' AS DateTime))
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (2, 2, 1, CAST(290.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:34:41.810' AS DateTime), N'Completed', N'TXN123471', CAST(N'2025-02-13T18:34:41.810' AS DateTime), CAST(N'2025-02-13T18:34:41.810' AS DateTime))
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (3, 3, NULL, CAST(350.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:34:41.810' AS DateTime), N'Pending', N'TXN123472', CAST(N'2025-02-13T18:34:41.810' AS DateTime), CAST(N'2025-02-13T18:34:41.810' AS DateTime))
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (4, 1, NULL, CAST(180.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:49:59.183' AS DateTime), N'Completed', N'TXN123470', CAST(N'2025-02-13T18:49:59.183' AS DateTime), CAST(N'2025-02-13T18:49:59.183' AS DateTime))
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (5, 2, 1, CAST(290.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:49:59.183' AS DateTime), N'Completed', N'TXN123471', CAST(N'2025-02-13T18:49:59.183' AS DateTime), CAST(N'2025-02-13T18:49:59.183' AS DateTime))
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (6, 3, NULL, CAST(350.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:49:59.183' AS DateTime), N'Pending', N'TXN123472', CAST(N'2025-02-13T18:49:59.183' AS DateTime), CAST(N'2025-02-13T18:49:59.183' AS DateTime))
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (7, 1, NULL, CAST(500.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:49:59.183' AS DateTime), N'Completed', N'TXN123473', CAST(N'2025-02-13T18:49:59.183' AS DateTime), CAST(N'2025-02-13T18:49:59.183' AS DateTime))
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (8, 2, NULL, CAST(300.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:49:59.183' AS DateTime), N'Completed', N'TXN123474', CAST(N'2025-02-13T18:49:59.183' AS DateTime), CAST(N'2025-02-13T18:49:59.183' AS DateTime))
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (9, 3, NULL, CAST(400.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:49:59.183' AS DateTime), N'Completed', N'TXN123475', CAST(N'2025-02-13T18:49:59.183' AS DateTime), CAST(N'2025-02-13T18:49:59.183' AS DateTime))
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (10, 4, NULL, CAST(250.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:49:59.183' AS DateTime), N'Completed', N'TXN123476', CAST(N'2025-02-13T18:49:59.183' AS DateTime), CAST(N'2025-02-13T18:49:59.183' AS DateTime))
GO
INSERT [dbo].[Orders] ([order_id], [customer_id], [voucher_id], [total_price], [order_date], [payment_status], [transaction_id], [created_at], [updated_at]) VALUES (11, 5, NULL, CAST(350.00 AS Decimal(10, 2)), CAST(N'2025-02-13T18:49:59.183' AS DateTime), N'Completed', N'TXN123477', CAST(N'2025-02-13T18:49:59.183' AS DateTime), CAST(N'2025-02-13T18:49:59.183' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Organizers] ON 
GO
INSERT [dbo].[Organizers] ([organizer_id], [customer_id], [event_id], [organization_name], [created_at], [updated_at]) VALUES (1, 1, 1, N'Music Corp', CAST(N'2025-02-13T18:34:41.817' AS DateTime), CAST(N'2025-02-13T18:34:41.817' AS DateTime))
GO
INSERT [dbo].[Organizers] ([organizer_id], [customer_id], [event_id], [organization_name], [created_at], [updated_at]) VALUES (2, 2, 2, N'Tech World', CAST(N'2025-02-13T18:34:41.817' AS DateTime), CAST(N'2025-02-13T18:34:41.817' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Organizers] OFF
GO
SET IDENTITY_INSERT [dbo].[Seats] ON 
GO
INSERT [dbo].[Seats] ([seat_id], [event_id], [seat_row], [seat_number], [status]) VALUES (1, 1, N'A', N'1', N'Available')
GO
INSERT [dbo].[Seats] ([seat_id], [event_id], [seat_row], [seat_number], [status]) VALUES (2, 1, N'A', N'2', N'Booked')
GO
INSERT [dbo].[Seats] ([seat_id], [event_id], [seat_row], [seat_number], [status]) VALUES (3, 2, N'B', N'10', N'Available')
GO
INSERT [dbo].[Seats] ([seat_id], [event_id], [seat_row], [seat_number], [status]) VALUES (4, 2, N'B', N'11', N'Booked')
GO
SET IDENTITY_INSERT [dbo].[Seats] OFF
GO
SET IDENTITY_INSERT [dbo].[Tickets] ON 
GO
INSERT [dbo].[Tickets] ([ticket_id], [order_detail_id], [seat_id], [ticket_code], [price], [status], [created_at], [updated_at]) VALUES (1, 1, 1, N'TICKET123', CAST(100.00 AS Decimal(10, 2)), N'Valid', CAST(N'2025-02-13T18:34:41.813' AS DateTime), CAST(N'2025-02-13T18:34:41.813' AS DateTime))
GO
INSERT [dbo].[Tickets] ([ticket_id], [order_detail_id], [seat_id], [ticket_code], [price], [status], [created_at], [updated_at]) VALUES (2, 2, 2, N'TICKET124', CAST(50.00 AS Decimal(10, 2)), N'Valid', CAST(N'2025-02-13T18:34:41.813' AS DateTime), CAST(N'2025-02-13T18:34:41.813' AS DateTime))
GO
INSERT [dbo].[Tickets] ([ticket_id], [order_detail_id], [seat_id], [ticket_code], [price], [status], [created_at], [updated_at]) VALUES (3, 3, 3, N'TICKET125', CAST(40.00 AS Decimal(10, 2)), N'Used', CAST(N'2025-02-13T18:34:41.813' AS DateTime), CAST(N'2025-02-13T18:34:41.813' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Tickets] OFF
GO
SET IDENTITY_INSERT [dbo].[TicketTypes] ON 
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (1, 1, N'VIP', N'Front row seats', CAST(100.00 AS Decimal(10, 2)), 500, 0, CAST(N'2025-02-13T18:34:41.807' AS DateTime), CAST(N'2025-02-13T18:34:41.807' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (2, 1, N'Standard', N'Regular seats', CAST(50.00 AS Decimal(10, 2)), 1000, 0, CAST(N'2025-02-13T18:34:41.807' AS DateTime), CAST(N'2025-02-13T18:34:41.807' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (3, 2, N'Early Bird', N'Discounted tickets', CAST(40.00 AS Decimal(10, 2)), 300, 0, CAST(N'2025-02-13T18:34:41.807' AS DateTime), CAST(N'2025-02-13T18:34:41.807' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (4, 1, N'VIP', N'Front row seats', CAST(100.00 AS Decimal(10, 2)), 500, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (5, 1, N'Standard', N'Regular seats', CAST(50.00 AS Decimal(10, 2)), 1000, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (6, 2, N'Early Bird', N'Discounted tickets', CAST(40.00 AS Decimal(10, 2)), 300, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (7, 6, N'VIP', N'Exclusive access', CAST(150.00 AS Decimal(10, 2)), 300, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (8, 7, N'Standard', N'Regular ticket', CAST(75.00 AS Decimal(10, 2)), 500, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (9, 8, N'General', N'Entry ticket', CAST(50.00 AS Decimal(10, 2)), 1000, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (10, 9, N'Early Bird', N'Discounted ticket', CAST(40.00 AS Decimal(10, 2)), 200, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (11, 10, N'Premium', N'Front row seats', CAST(200.00 AS Decimal(10, 2)), 150, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (12, 11, N'VIP', N'Best seats', CAST(250.00 AS Decimal(10, 2)), 100, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (13, 12, N'General Admission', N'Standard entry', CAST(60.00 AS Decimal(10, 2)), 700, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (14, 13, N'Festival Pass', N'Access to all days', CAST(90.00 AS Decimal(10, 2)), 400, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (15, 14, N'Day Pass', N'One day entry', CAST(30.00 AS Decimal(10, 2)), 600, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
INSERT [dbo].[TicketTypes] ([ticket_type_id], [event_id], [name], [description], [price], [total_quantity], [sold_quantity], [created_at], [updated_at]) VALUES (16, 15, N'Standard', N'General entry', CAST(55.00 AS Decimal(10, 2)), 900, 0, CAST(N'2025-02-13T18:49:53.030' AS DateTime), CAST(N'2025-02-13T18:49:53.030' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[TicketTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Vouchers] ON 
GO
INSERT [dbo].[Vouchers] ([voucher_id], [code], [description], [discount_type], [discount_value], [expiration_date], [usage_limit], [status], [created_at], [updated_at]) VALUES (1, N'SUMMER10', N'10% off summer events', N'PERCENTAGE', CAST(10.00 AS Decimal(10, 2)), CAST(N'2025-08-31T00:00:00.000' AS DateTime), 1000, 1, CAST(N'2025-02-13T18:34:41.810' AS DateTime), CAST(N'2025-02-13T18:34:41.810' AS DateTime))
GO
INSERT [dbo].[Vouchers] ([voucher_id], [code], [description], [discount_type], [discount_value], [expiration_date], [usage_limit], [status], [created_at], [updated_at]) VALUES (2, N'WELCOME50', N'50K discount for new users', N'FIXED', CAST(50.00 AS Decimal(10, 2)), CAST(N'2025-12-31T00:00:00.000' AS DateTime), 500, 1, CAST(N'2025-02-13T18:34:41.810' AS DateTime), CAST(N'2025-02-13T18:34:41.810' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Vouchers] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Admins__AB6E616473438CBC]    Script Date: 2/16/2025 8:24:35 PM ******/
ALTER TABLE [dbo].[Admins] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__AB6E6164FD4FB80F]    Script Date: 2/16/2025 8:24:35 PM ******/
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Vouchers__357D4CF9BBD3F80A]    Script Date: 2/16/2025 8:24:35 PM ******/
ALTER TABLE [dbo].[Vouchers] ADD UNIQUE NONCLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Customer_auths] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Customer_auths] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[Events] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Events] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [order_date]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Organizers] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Organizers] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Tickets] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Tickets] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[TicketTypes] ADD  DEFAULT ((0)) FOR [sold_quantity]
GO
ALTER TABLE [dbo].[TicketTypes] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[TicketTypes] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Vouchers] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[Vouchers] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Vouchers] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Customer_auths]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[EventImages]  WITH CHECK ADD FOREIGN KEY([event_id])
REFERENCES [dbo].[Events] ([event_id])
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ticket_type_id])
REFERENCES [dbo].[TicketTypes] ([ticket_type_id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([voucher_id])
REFERENCES [dbo].[Vouchers] ([voucher_id])
GO
ALTER TABLE [dbo].[Organizers]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
GO
ALTER TABLE [dbo].[Organizers]  WITH CHECK ADD FOREIGN KEY([event_id])
REFERENCES [dbo].[Events] ([event_id])
GO
ALTER TABLE [dbo].[Seats]  WITH CHECK ADD FOREIGN KEY([event_id])
REFERENCES [dbo].[Events] ([event_id])
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([order_detail_id])
REFERENCES [dbo].[OrderDetails] ([order_detail_id])
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([seat_id])
REFERENCES [dbo].[Seats] ([seat_id])
GO
ALTER TABLE [dbo].[TicketTypes]  WITH CHECK ADD FOREIGN KEY([event_id])
REFERENCES [dbo].[Events] ([event_id])
GO
USE [master]
GO
ALTER DATABASE [TickifyDB] SET  READ_WRITE 
GO
