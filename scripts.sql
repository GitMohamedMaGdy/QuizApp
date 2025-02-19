USE [master]
GO
/****** Object:  Database [QUIZDB]    Script Date: 2/12/2021 6:58:14 PM ******/
CREATE DATABASE [QUIZDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QUIZDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\QUIZDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QUIZDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\QUIZDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QUIZDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QUIZDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QUIZDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QUIZDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QUIZDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QUIZDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [QUIZDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QUIZDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QUIZDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QUIZDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QUIZDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QUIZDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QUIZDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QUIZDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QUIZDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QUIZDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QUIZDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QUIZDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QUIZDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QUIZDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QUIZDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QUIZDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QUIZDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QUIZDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QUIZDB] SET  MULTI_USER 
GO
ALTER DATABASE [QUIZDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QUIZDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QUIZDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QUIZDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
USE [QUIZDB]
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 2/12/2021 6:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[AdminId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](500) NOT NULL,
	[UserPassword] [varchar](500) NOT NULL,
 CONSTRAINT [PK_Admins] PRIMARY KEY CLUSTERED 
(
	[AdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Answers]    Script Date: 2/12/2021 6:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answers](
	[AnswerId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[AnswerText] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Answers] PRIMARY KEY CLUSTERED 
(
	[AnswerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2/12/2021 6:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Options]    Script Date: 2/12/2021 6:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Options](
	[OptionId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[optionName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Options] PRIMARY KEY CLUSTERED 
(
	[OptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 2/12/2021 6:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[QuestionText] [varchar](50) NOT NULL,
	[isActive] [bit] NOT NULL,
	[isMultiple] [bit] NOT NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Results]    Script Date: 2/12/2021 6:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Results](
	[ResultId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[AnswerText] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Results] PRIMARY KEY CLUSTERED 
(
	[ResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2/12/2021 6:58:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[LoginTime] [datetime] NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admins] ON 

INSERT [dbo].[Admins] ([AdminId], [UserName], [UserPassword]) VALUES (1, N'megs32769@gmail.com', N'12345')
SET IDENTITY_INSERT [dbo].[Admins] OFF
GO
SET IDENTITY_INSERT [dbo].[Answers] ON 

INSERT [dbo].[Answers] ([AnswerId], [QuestionId], [AnswerText]) VALUES (1, 2, N'5')
SET IDENTITY_INSERT [dbo].[Answers] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (1, N'Math')
INSERT [dbo].[Categories] ([CategoryId], [CategoryName]) VALUES (2, N'Science')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Options] ON 

INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (1, 2, N'4')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (2, 2, N'5')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (3, 2, N'20')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (4, 2, N'1')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (5, 3, N'1')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (6, 3, N'2')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (7, 3, N'10')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (8, 3, N'3')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (9, 5, N'12')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (10, 5, N'32')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (11, 5, N'21')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (12, 5, N'10')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (13, 4, N'1')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (14, 4, N'12')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (15, 4, N'21')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (16, 4, N'2')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (17, 1, N'2')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (19, 1, N'4')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (20, 1, N'3')
INSERT [dbo].[Options] ([OptionId], [QuestionId], [optionName]) VALUES (21, 1, N'5')
SET IDENTITY_INSERT [dbo].[Options] OFF
GO
SET IDENTITY_INSERT [dbo].[Questions] ON 

INSERT [dbo].[Questions] ([QuestionId], [CategoryId], [QuestionText], [isActive], [isMultiple]) VALUES (1, 1, N'2  + 3  = ?', 1, 0)
INSERT [dbo].[Questions] ([QuestionId], [CategoryId], [QuestionText], [isActive], [isMultiple]) VALUES (2, 1, N'4 + 3 = ?', 1, 0)
INSERT [dbo].[Questions] ([QuestionId], [CategoryId], [QuestionText], [isActive], [isMultiple]) VALUES (3, 1, N'10 -2 = ?', 1, 0)
INSERT [dbo].[Questions] ([QuestionId], [CategoryId], [QuestionText], [isActive], [isMultiple]) VALUES (4, 1, N'10 - 3 = ? ', 1, 0)
INSERT [dbo].[Questions] ([QuestionId], [CategoryId], [QuestionText], [isActive], [isMultiple]) VALUES (5, 1, N'3 *4 = ?', 1, 0)
SET IDENTITY_INSERT [dbo].[Questions] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (1, N'mohamed', CAST(N'2021-02-07T13:51:25.993' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (4, N'mohamed', CAST(N'2021-02-07T14:00:14.720' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (5, N'mohamed', CAST(N'2021-02-07T14:02:21.377' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (6, N'ahmed', CAST(N'2021-02-07T15:26:55.600' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (7, N'mm', CAST(N'2021-02-07T15:28:29.300' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (8, N'mkk', CAST(N'2021-02-07T15:33:54.533' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (9, N'omae', CAST(N'2021-02-07T15:43:14.820' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (10, N'omar', CAST(N'2021-02-07T15:46:14.307' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (11, N'salma', CAST(N'2021-02-07T15:48:22.357' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (12, N'ss', CAST(N'2021-02-07T15:52:10.673' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (13, N'ahmed', CAST(N'2021-02-07T15:56:04.750' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (14, N'nsnn', CAST(N'2021-02-07T16:00:48.407' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (15, N'sas', CAST(N'2021-02-07T16:05:31.627' AS DateTime), 1)
INSERT [dbo].[Users] ([UserId], [UserName], [LoginTime], [CategoryId]) VALUES (16, N'ewe', CAST(N'2021-02-07T16:08:10.043' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_Questions_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[Questions] ADD  CONSTRAINT [DF_Questions_isMultiple]  DEFAULT ((0)) FOR [isMultiple]
GO
ALTER TABLE [dbo].[Answers]  WITH CHECK ADD  CONSTRAINT [FK_Answers_Questions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([QuestionId])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_Questions]
GO
ALTER TABLE [dbo].[Options]  WITH CHECK ADD  CONSTRAINT [FK_Options_Questions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([QuestionId])
GO
ALTER TABLE [dbo].[Options] CHECK CONSTRAINT [FK_Options_Questions]
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([CategoryId])
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_Categories]
GO
ALTER TABLE [dbo].[Results]  WITH CHECK ADD  CONSTRAINT [FK_Results_Questions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([QuestionId])
GO
ALTER TABLE [dbo].[Results] CHECK CONSTRAINT [FK_Results_Questions]
GO
ALTER TABLE [dbo].[Results]  WITH CHECK ADD  CONSTRAINT [FK_Results_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Results] CHECK CONSTRAINT [FK_Results_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([CategoryId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Categories]
GO
USE [master]
GO
ALTER DATABASE [QUIZDB] SET  READ_WRITE 
GO
