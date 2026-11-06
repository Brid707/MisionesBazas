-- =========================================================================================
-- TrickTakingMissions - ConfiguraciÃ³n y Carga Inicial de Base de Datos (OpciÃ³n B)
-- Motor: Microsoft SQL Server (localhost / .\SQLEXPRESS)
-- =========================================================================================
-- NOTA PREVIA IMPORTANTE:
-- SQL Server debe tener habilitada la 'AutenticaciÃ³n en modo mixto' (SQL Server y Windows).
-- Si aÃºn no la tienes activa:
--   1. En SSMS haz clic derecho sobre la instancia -> Propiedades -> Seguridad.
--   2. Selecciona 'Modo de autenticaciÃ³n de SQL Server y de Windows'.
--   3. Haz clic derecho sobre el servidor y selecciona 'Reiniciar'.
-- =========================================================================================

USE [master];
GO

-- 1. Crear o actualizar inicio de sesiÃ³n (Login)
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'TrickTakingMissionsUser')
BEGIN
    CREATE LOGIN [TrickTakingMissionsUser] 
    WITH PASSWORD = N'bukxuk-1cafgi-myCfyp', 
         DEFAULT_DATABASE = [master], 
         CHECK_EXPIRATION = OFF, 
         CHECK_POLICY = OFF;
END
ELSE
BEGIN
    ALTER LOGIN [TrickTakingMissionsUser] 
    WITH PASSWORD = N'bukxuk-1cafgi-myCfyp',
         CHECK_EXPIRATION = OFF, 
         CHECK_POLICY = OFF;
END
GO

-- 2. Crear la base de datos si no existe
IF DB_ID(N'TrickTakingMissionsBD') IS NULL
BEGIN
    CREATE DATABASE [TrickTakingMissionsBD];
END
GO

USE [TrickTakingMissionsBD];
GO

-- 3. Crear el usuario de BD y asignarle rol db_owner
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'TrickTakingMissionsUser')
BEGIN
    CREATE USER [TrickTakingMissionsUser] FOR LOGIN [TrickTakingMissionsUser];
END
GO
ALTER ROLE [db_owner] ADD MEMBER [TrickTakingMissionsUser];
GO

-- =========================================================
-- 4. CreaciÃ³n de tablas base
-- =========================================================
USE [TrickTakingMissionsBD];
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET ARITHABORT ON;
SET NUMERIC_ROUNDABORT OFF;
SET XACT_ABORT ON;
GO

-- Ejecutar en base nueva. No elimina ni modifica tablas existentes.
BEGIN TRANSACTION;

CREATE TABLE dbo.[User] (
    [IdUser] INT IDENTITY(1,1) NOT NULL,
    [Username] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(150) NULL,
    [PasswordHash] NVARCHAR(255) NULL,
    [Status] TINYINT NOT NULL CONSTRAINT [DF_User_Status] DEFAULT (1),
    [CreatedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_User_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [LastLoginAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_User_0] PRIMARY KEY ([IdUser]),
    CONSTRAINT [UQ_User_1] UNIQUE ([Username]),
    CONSTRAINT [CK_User_0] CHECK (Status BETWEEN 1 AND 3),
    CONSTRAINT [CK_User_1] CHECK (LastLoginAt IS NULL OR (CreatedAt IS NOT NULL AND LastLoginAt >= CreatedAt)),
    CONSTRAINT [CK_User_2] CHECK ((Email IS NULL AND PasswordHash IS NULL) OR (Email IS NOT NULL AND PasswordHash IS NOT NULL))
);

CREATE TABLE dbo.[PlayerProfile] (
    [IdUser] INT NOT NULL,
    [DisplayName] NVARCHAR(80) NOT NULL,
    [AvatarPath] NVARCHAR(255) NULL,
    [Biography] NVARCHAR(300) NULL,
    [CreatedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_PlayerProfile_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [UpdatedAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_PlayerProfile_0] PRIMARY KEY ([IdUser]),
    CONSTRAINT [CK_PlayerProfile_0] CHECK (UpdatedAt IS NULL OR (CreatedAt IS NOT NULL AND UpdatedAt >= CreatedAt))
);

CREATE TABLE dbo.[Friendship] (
    [IdUserLow] INT NOT NULL,
    [IdUserHigh] INT NOT NULL,
    [RequestedByLow] BIT NOT NULL,
    [Status] TINYINT NOT NULL CONSTRAINT [DF_Friendship_Status] DEFAULT (1),
    [RequestedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_Friendship_RequestedAt] DEFAULT (SYSUTCDATETIME()),
    [RespondedAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_Friendship_0] PRIMARY KEY ([IdUserLow], [IdUserHigh]),
    CONSTRAINT [CK_Friendship_0] CHECK (Status BETWEEN 1 AND 3),
    CONSTRAINT [CK_Friendship_1] CHECK (RespondedAt IS NULL OR (RequestedAt IS NOT NULL AND RespondedAt >= RequestedAt)),
    CONSTRAINT [CK_Friendship_2] CHECK (IdUserLow < IdUserHigh)
);

CREATE TABLE dbo.[PlayerBlock] (
    [IdBlockerUser] INT NOT NULL,
    [IdBlockedUser] INT NOT NULL,
    [CreatedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_PlayerBlock_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT [PK_PlayerBlock_0] PRIMARY KEY ([IdBlockerUser], [IdBlockedUser]),
    CONSTRAINT [CK_PlayerBlock_0] CHECK (IdBlockerUser <> IdBlockedUser)
);

CREATE TABLE dbo.[Lobby] (
    [IdLobby] INT IDENTITY(1,1) NOT NULL,
    [LobbyCode] VARCHAR(20) NOT NULL,
    [IdHostUser] INT NOT NULL,
    [Status] TINYINT NOT NULL CONSTRAINT [DF_Lobby_Status] DEFAULT (1),
    [PrivacyMode] TINYINT NOT NULL CONSTRAINT [DF_Lobby_PrivacyMode] DEFAULT (1),
    [PlayerLimit] TINYINT NOT NULL CONSTRAINT [DF_Lobby_PlayerLimit] DEFAULT (4),
    [TargetMissionCount] TINYINT NOT NULL CONSTRAINT [DF_Lobby_TargetMissionCount] DEFAULT (1),
    [CreatedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_Lobby_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [ClosedAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_Lobby_0] PRIMARY KEY ([IdLobby]),
    CONSTRAINT [UQ_Lobby_1] UNIQUE ([LobbyCode]),
    CONSTRAINT [CK_Lobby_0] CHECK (Status BETWEEN 1 AND 4),
    CONSTRAINT [CK_Lobby_1] CHECK (ClosedAt IS NULL OR (CreatedAt IS NOT NULL AND ClosedAt >= CreatedAt)),
    CONSTRAINT [CK_Lobby_2] CHECK (PlayerLimit IN (3,4)),
    CONSTRAINT [CK_Lobby_3] CHECK (PrivacyMode IN (1,2)),
    CONSTRAINT [CK_Lobby_4] CHECK (TargetMissionCount BETWEEN 1 AND 50)
);

CREATE TABLE dbo.[LobbyPlayer] (
    [IdLobby] INT NOT NULL,
    [IdUser] INT NOT NULL,
    [IsReady] BIT NOT NULL CONSTRAINT [DF_LobbyPlayer_IsReady] DEFAULT (0),
    [JoinedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_LobbyPlayer_JoinedAt] DEFAULT (SYSUTCDATETIME()),
    [LeftAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_LobbyPlayer_0] PRIMARY KEY ([IdLobby], [IdUser]),
    CONSTRAINT [CK_LobbyPlayer_0] CHECK (LeftAt IS NULL OR (JoinedAt IS NOT NULL AND LeftAt >= JoinedAt))
);

CREATE TABLE dbo.[Invitation] (
    [IdInvitation] INT IDENTITY(1,1) NOT NULL,
    [IdLobby] INT NOT NULL,
    [IdSenderUser] INT NOT NULL,
    [IdReceiverUser] INT NOT NULL,
    [Status] TINYINT NOT NULL CONSTRAINT [DF_Invitation_Status] DEFAULT (1),
    [SentAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_Invitation_SentAt] DEFAULT (SYSUTCDATETIME()),
    [ResolvedAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_Invitation_0] PRIMARY KEY ([IdInvitation]),
    CONSTRAINT [CK_Invitation_0] CHECK (Status BETWEEN 1 AND 4),
    CONSTRAINT [CK_Invitation_1] CHECK (ResolvedAt IS NULL OR (SentAt IS NOT NULL AND ResolvedAt >= SentAt)),
    CONSTRAINT [CK_Invitation_2] CHECK (IdSenderUser <> IdReceiverUser)
);

CREATE TABLE dbo.[Game] (
    [IdGame] INT IDENTITY(1,1) NOT NULL,
    [IdLobby] INT NOT NULL,
    [Status] TINYINT NOT NULL CONSTRAINT [DF_Game_Status] DEFAULT (1),
    [TargetMissionCount] TINYINT NOT NULL CONSTRAINT [DF_Game_TargetMissionCount] DEFAULT (1),
    [DistressSignalEnabled] BIT NOT NULL CONSTRAINT [DF_Game_DistressSignalEnabled] DEFAULT (1),
    [CreatedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_Game_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [StartedAt] DATETIME2(0) NULL,
    [FinishedAt] DATETIME2(0) NULL,
    [XPGrantedPerPlayer] INT NOT NULL CONSTRAINT [DF_Game_XPGrantedPerPlayer] DEFAULT (0),
    [XPGrantedAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_Game_0] PRIMARY KEY ([IdGame]),
    CONSTRAINT [CK_Game_0] CHECK (Status BETWEEN 1 AND 6),
    CONSTRAINT [CK_Game_1] CHECK (StartedAt IS NULL OR (CreatedAt IS NOT NULL AND StartedAt >= CreatedAt)),
    CONSTRAINT [CK_Game_2] CHECK (FinishedAt IS NULL OR (StartedAt IS NOT NULL AND FinishedAt >= StartedAt)),
    CONSTRAINT [CK_Game_3] CHECK (TargetMissionCount BETWEEN 1 AND 50),
    CONSTRAINT [CK_Game_4] CHECK (XPGrantedPerPlayer >= 0),
    CONSTRAINT [CK_Game_5] CHECK ((XPGrantedAt IS NULL AND XPGrantedPerPlayer = 0) OR (XPGrantedAt IS NOT NULL AND XPGrantedPerPlayer > 0 AND Status = 4 AND FinishedAt IS NOT NULL AND XPGrantedAt >= FinishedAt))
);

CREATE TABLE dbo.[GamePlayer] (
    [IdGame] INT NOT NULL,
    [Seat] TINYINT NOT NULL,
    [IdUser] INT NOT NULL,
    [ConnectionStatus] TINYINT NOT NULL CONSTRAINT [DF_GamePlayer_ConnectionStatus] DEFAULT (1),
    [JoinedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_GamePlayer_JoinedAt] DEFAULT (SYSUTCDATETIME()),
    [LeftAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_GamePlayer_0] PRIMARY KEY ([IdGame], [Seat]),
    CONSTRAINT [UQ_GamePlayer_1] UNIQUE ([IdGame], [IdUser]),
    CONSTRAINT [CK_GamePlayer_0] CHECK (Seat BETWEEN 1 AND 4),
    CONSTRAINT [CK_GamePlayer_1] CHECK (LeftAt IS NULL OR (JoinedAt IS NOT NULL AND LeftAt >= JoinedAt)),
    CONSTRAINT [CK_GamePlayer_2] CHECK (ConnectionStatus IN (1,2,3))
);

CREATE TABLE dbo.[Card] (
    [IdCard] INT NOT NULL,
    CONSTRAINT [PK_Card_0] PRIMARY KEY ([IdCard])
);

CREATE TABLE dbo.[NormalCard] (
    [IdCard] INT NOT NULL,
    [Color] TINYINT NOT NULL,
    [Number] TINYINT NOT NULL,
    CONSTRAINT [PK_NormalCard_0] PRIMARY KEY ([IdCard]),
    CONSTRAINT [UQ_NormalCard_1] UNIQUE ([Color], [Number]),
    CONSTRAINT [CK_NormalCard_0] CHECK (Color BETWEEN 1 AND 4),
    CONSTRAINT [CK_NormalCard_1] CHECK (Number BETWEEN 1 AND 9)
);

CREATE TABLE dbo.[SpecialCard] (
    [IdCard] INT NOT NULL,
    [Symbol] VARCHAR(10) NOT NULL,
    [Rank] TINYINT NOT NULL,
    CONSTRAINT [PK_SpecialCard_0] PRIMARY KEY ([IdCard]),
    CONSTRAINT [UQ_SpecialCard_1] UNIQUE ([Symbol]),
    CONSTRAINT [UQ_SpecialCard_2] UNIQUE ([Rank]),
    CONSTRAINT [CK_SpecialCard_0] CHECK (Rank BETWEEN 1 AND 4)
);

CREATE TABLE dbo.[Mission] (
    [IdMission] TINYINT NOT NULL,
    [ObjectiveCount] TINYINT NOT NULL,
    [IsActive] BIT NOT NULL CONSTRAINT [DF_Mission_IsActive] DEFAULT (1),
    CONSTRAINT [PK_Mission_0] PRIMARY KEY ([IdMission]),
    CONSTRAINT [CK_Mission_0] CHECK (IdMission BETWEEN 1 AND 50),
    CONSTRAINT [CK_Mission_1] CHECK (ObjectiveCount BETWEEN 0 AND 36)
);

CREATE TABLE dbo.[RuleDefinition] (
    [RuleCode] VARCHAR(40) NOT NULL,
    [Description] NVARCHAR(300) NOT NULL,
    CONSTRAINT [PK_RuleDefinition_0] PRIMARY KEY ([RuleCode])
);

CREATE TABLE dbo.[MissionRestriction] (
    [IdMission] TINYINT NOT NULL,
    [RuleCode] VARCHAR(40) NOT NULL,
    [IntegerValue] INT NULL,
    CONSTRAINT [PK_MissionRestriction_0] PRIMARY KEY ([IdMission], [RuleCode])
);

CREATE TABLE dbo.[MissionToken] (
    [IdMission] TINYINT NOT NULL,
    [TokenSlot] TINYINT NOT NULL,
    [OrderType] TINYINT NOT NULL,
    [OrderNumber] TINYINT NULL,
    CONSTRAINT [PK_MissionToken_0] PRIMARY KEY ([IdMission], [TokenSlot]),
    CONSTRAINT [CK_MissionToken_0] CHECK (TokenSlot BETWEEN 1 AND 50),
    CONSTRAINT [CK_MissionToken_1] CHECK (OrderType BETWEEN 1 AND 5),
    CONSTRAINT [CK_MissionToken_2] CHECK ((OrderType = 2 AND OrderNumber IS NOT NULL AND OrderNumber BETWEEN 1 AND 36) OR (OrderType <> 2 AND OrderNumber IS NULL))
);

CREATE TABLE dbo.[GameMission] (
    [IdGame] INT NOT NULL,
    [MissionOrder] TINYINT NOT NULL,
    [IdMission] TINYINT NOT NULL,
    CONSTRAINT [PK_GameMission_0] PRIMARY KEY ([IdGame], [MissionOrder]),
    CONSTRAINT [UQ_GameMission_1] UNIQUE ([IdGame], [IdMission]),
    CONSTRAINT [CK_GameMission_0] CHECK (MissionOrder BETWEEN 1 AND 50)
);

CREATE TABLE dbo.[MissionAttempt] (
    [IdGame] INT NOT NULL,
    [MissionOrder] TINYINT NOT NULL,
    [AttemptNumber] INT NOT NULL,
    [Status] TINYINT NOT NULL CONSTRAINT [DF_MissionAttempt_Status] DEFAULT (1),
    [CaptainSeat] TINYINT NULL,
    [CreatedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_MissionAttempt_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    [StartedAt] DATETIME2(0) NULL,
    [FinishedAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_MissionAttempt_0] PRIMARY KEY ([IdGame], [MissionOrder], [AttemptNumber]),
    CONSTRAINT [CK_MissionAttempt_0] CHECK (Status BETWEEN 1 AND 5),
    CONSTRAINT [CK_MissionAttempt_1] CHECK (MissionOrder BETWEEN 1 AND 50),
    CONSTRAINT [CK_MissionAttempt_2] CHECK (AttemptNumber BETWEEN 1 AND 2147483647),
    CONSTRAINT [CK_MissionAttempt_3] CHECK (CaptainSeat BETWEEN 1 AND 4),
    CONSTRAINT [CK_MissionAttempt_4] CHECK (StartedAt IS NULL OR (CreatedAt IS NOT NULL AND StartedAt >= CreatedAt)),
    CONSTRAINT [CK_MissionAttempt_5] CHECK (FinishedAt IS NULL OR (StartedAt IS NOT NULL AND FinishedAt >= StartedAt))
);

CREATE TABLE dbo.[AttemptCard] (
    [IdGame] INT NOT NULL,
    [MissionOrder] TINYINT NOT NULL,
    [AttemptNumber] INT NOT NULL,
    [IdCard] INT NOT NULL,
    [OwnerSeat] TINYINT NULL,
    CONSTRAINT [PK_AttemptCard_0] PRIMARY KEY ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]),
    CONSTRAINT [CK_AttemptCard_0] CHECK (MissionOrder BETWEEN 1 AND 50),
    CONSTRAINT [CK_AttemptCard_1] CHECK (AttemptNumber BETWEEN 1 AND 2147483647),
    CONSTRAINT [CK_AttemptCard_2] CHECK (OwnerSeat BETWEEN 1 AND 4)
);

CREATE TABLE dbo.[AttemptObjective] (
    [IdGame] INT NOT NULL,
    [MissionOrder] TINYINT NOT NULL,
    [AttemptNumber] INT NOT NULL,
    [IdCard] INT NOT NULL,
    [AssignedSeat] TINYINT NULL,
    [OrderType] TINYINT NOT NULL CONSTRAINT [DF_AttemptObjective_OrderType] DEFAULT (1),
    [OrderNumber] TINYINT NULL,
    [Status] TINYINT NOT NULL CONSTRAINT [DF_AttemptObjective_Status] DEFAULT (1),
    [CompletedAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_AttemptObjective_0] PRIMARY KEY ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]),
    CONSTRAINT [CK_AttemptObjective_0] CHECK (Status BETWEEN 1 AND 3),
    CONSTRAINT [CK_AttemptObjective_1] CHECK (MissionOrder BETWEEN 1 AND 50),
    CONSTRAINT [CK_AttemptObjective_2] CHECK (AttemptNumber BETWEEN 1 AND 2147483647),
    CONSTRAINT [CK_AttemptObjective_3] CHECK (AssignedSeat BETWEEN 1 AND 4),
    CONSTRAINT [CK_AttemptObjective_4] CHECK (OrderType BETWEEN 1 AND 5),
    CONSTRAINT [CK_AttemptObjective_5] CHECK ((OrderType = 2 AND OrderNumber IS NOT NULL AND OrderNumber BETWEEN 1 AND 36) OR (OrderType <> 2 AND OrderNumber IS NULL)),
    CONSTRAINT [CK_AttemptObjective_6] CHECK ((Status = 2 AND CompletedAt IS NOT NULL) OR (Status <> 2 AND CompletedAt IS NULL))
);

CREATE TABLE dbo.[AttemptRulePlayer] (
    [IdGame] INT NOT NULL,
    [MissionOrder] TINYINT NOT NULL,
    [AttemptNumber] INT NOT NULL,
    [RuleCode] VARCHAR(40) NOT NULL,
    [Seat] TINYINT NOT NULL,
    [RoleCode] VARCHAR(30) NOT NULL,
    CONSTRAINT [PK_AttemptRulePlayer_0] PRIMARY KEY ([IdGame], [MissionOrder], [AttemptNumber], [RuleCode], [Seat]),
    CONSTRAINT [CK_AttemptRulePlayer_0] CHECK (MissionOrder BETWEEN 1 AND 50),
    CONSTRAINT [CK_AttemptRulePlayer_1] CHECK (AttemptNumber BETWEEN 1 AND 2147483647),
    CONSTRAINT [CK_AttemptRulePlayer_2] CHECK (Seat BETWEEN 1 AND 4)
);

CREATE TABLE dbo.[Trick] (
    [IdGame] INT NOT NULL,
    [MissionOrder] TINYINT NOT NULL,
    [AttemptNumber] INT NOT NULL,
    [TrickNumber] TINYINT NOT NULL,
    [StartingSeat] TINYINT NOT NULL,
    [WinningSeat] TINYINT NULL,
    [StartedAt] DATETIME2(0) NOT NULL,
    [FinishedAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_Trick_0] PRIMARY KEY ([IdGame], [MissionOrder], [AttemptNumber], [TrickNumber]),
    CONSTRAINT [CK_Trick_0] CHECK (MissionOrder BETWEEN 1 AND 50),
    CONSTRAINT [CK_Trick_1] CHECK (AttemptNumber BETWEEN 1 AND 2147483647),
    CONSTRAINT [CK_Trick_2] CHECK (TrickNumber BETWEEN 1 AND 13),
    CONSTRAINT [CK_Trick_3] CHECK (StartingSeat BETWEEN 1 AND 4),
    CONSTRAINT [CK_Trick_4] CHECK (WinningSeat BETWEEN 1 AND 4),
    CONSTRAINT [CK_Trick_5] CHECK (FinishedAt IS NULL OR (StartedAt IS NOT NULL AND FinishedAt >= StartedAt))
);

CREATE TABLE dbo.[Play] (
    [IdGame] INT NOT NULL,
    [MissionOrder] TINYINT NOT NULL,
    [AttemptNumber] INT NOT NULL,
    [TrickNumber] TINYINT NOT NULL,
    [PlayOrder] TINYINT NOT NULL,
    [Seat] TINYINT NOT NULL,
    [IdCard] INT NOT NULL,
    [PlayedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_Play_PlayedAt] DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT [PK_Play_0] PRIMARY KEY ([IdGame], [MissionOrder], [AttemptNumber], [TrickNumber], [PlayOrder]),
    CONSTRAINT [UQ_Play_1] UNIQUE ([IdGame], [MissionOrder], [AttemptNumber], [TrickNumber], [Seat]),
    CONSTRAINT [UQ_Play_2] UNIQUE ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]),
    CONSTRAINT [CK_Play_0] CHECK (MissionOrder BETWEEN 1 AND 50),
    CONSTRAINT [CK_Play_1] CHECK (AttemptNumber BETWEEN 1 AND 2147483647),
    CONSTRAINT [CK_Play_2] CHECK (TrickNumber BETWEEN 1 AND 13),
    CONSTRAINT [CK_Play_3] CHECK (PlayOrder BETWEEN 1 AND 4),
    CONSTRAINT [CK_Play_4] CHECK (Seat BETWEEN 1 AND 4)
);

CREATE TABLE dbo.[Communication] (
    [IdGame] INT NOT NULL,
    [MissionOrder] TINYINT NOT NULL,
    [AttemptNumber] INT NOT NULL,
    [Seat] TINYINT NOT NULL,
    [IdCard] INT NOT NULL,
    [CommunicationType] TINYINT NOT NULL,
    [BeforeTrickNumber] TINYINT NOT NULL,
    [CreatedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_Communication_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT [PK_Communication_0] PRIMARY KEY ([IdGame], [MissionOrder], [AttemptNumber], [Seat]),
    CONSTRAINT [CK_Communication_0] CHECK (MissionOrder BETWEEN 1 AND 50),
    CONSTRAINT [CK_Communication_1] CHECK (AttemptNumber BETWEEN 1 AND 2147483647),
    CONSTRAINT [CK_Communication_2] CHECK (Seat BETWEEN 1 AND 4),
    CONSTRAINT [CK_Communication_3] CHECK (BeforeTrickNumber BETWEEN 1 AND 13),
    CONSTRAINT [CK_Communication_4] CHECK (CommunicationType IN (1,2,3))
);

CREATE TABLE dbo.[DistressUse] (
    [IdGame] INT NOT NULL,
    [MissionOrder] TINYINT NOT NULL,
    [AttemptNumber] INT NOT NULL,
    [Direction] TINYINT NOT NULL,
    [CreatedAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_DistressUse_CreatedAt] DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT [PK_DistressUse_0] PRIMARY KEY ([IdGame], [MissionOrder], [AttemptNumber]),
    CONSTRAINT [CK_DistressUse_0] CHECK (MissionOrder BETWEEN 1 AND 50),
    CONSTRAINT [CK_DistressUse_1] CHECK (AttemptNumber BETWEEN 1 AND 2147483647),
    CONSTRAINT [CK_DistressUse_2] CHECK (Direction IN (1,2))
);

CREATE TABLE dbo.[DistressTransfer] (
    [IdGame] INT NOT NULL,
    [MissionOrder] TINYINT NOT NULL,
    [AttemptNumber] INT NOT NULL,
    [FromSeat] TINYINT NOT NULL,
    [ToSeat] TINYINT NOT NULL,
    [IdCard] INT NOT NULL,
    CONSTRAINT [PK_DistressTransfer_0] PRIMARY KEY ([IdGame], [MissionOrder], [AttemptNumber], [FromSeat]),
    CONSTRAINT [UQ_DistressTransfer_1] UNIQUE ([IdGame], [MissionOrder], [AttemptNumber], [ToSeat]),
    CONSTRAINT [UQ_DistressTransfer_2] UNIQUE ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]),
    CONSTRAINT [CK_DistressTransfer_0] CHECK (MissionOrder BETWEEN 1 AND 50),
    CONSTRAINT [CK_DistressTransfer_1] CHECK (AttemptNumber BETWEEN 1 AND 2147483647),
    CONSTRAINT [CK_DistressTransfer_2] CHECK (FromSeat BETWEEN 1 AND 4),
    CONSTRAINT [CK_DistressTransfer_3] CHECK (ToSeat BETWEEN 1 AND 4),
    CONSTRAINT [CK_DistressTransfer_4] CHECK (FromSeat <> ToSeat)
);

CREATE TABLE dbo.[LobbyMessage] (
    [IdLobbyMessage] INT IDENTITY(1,1) NOT NULL,
    [IdLobby] INT NOT NULL,
    [IdSenderUser] INT NOT NULL,
    [Message] NVARCHAR(500) NOT NULL,
    [SentAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_LobbyMessage_SentAt] DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT [PK_LobbyMessage_0] PRIMARY KEY ([IdLobbyMessage])
);

CREATE TABLE dbo.[GameSystemMessage] (
    [IdGameSystemMessage] INT IDENTITY(1,1) NOT NULL,
    [IdGame] INT NOT NULL,
    [ResourceKey] VARCHAR(100) NOT NULL,
    [SentAt] DATETIME2(0) NOT NULL CONSTRAINT [DF_GameSystemMessage_SentAt] DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT [PK_GameSystemMessage_0] PRIMARY KEY ([IdGameSystemMessage])
);

CREATE TABLE dbo.[Experience] (
    [IdUser] INT NOT NULL,
    [TotalXP] BIGINT NOT NULL CONSTRAINT [DF_Experience_TotalXP] DEFAULT (0),
    [UpdatedAt] DATETIME2(0) NULL,
    CONSTRAINT [PK_Experience_0] PRIMARY KEY ([IdUser]),
    CONSTRAINT [CK_Experience_0] CHECK (TotalXP >= 0)
);

ALTER TABLE dbo.[PlayerProfile] WITH CHECK ADD CONSTRAINT [FK_R01_PlayerProfile_User] FOREIGN KEY ([IdUser]) REFERENCES dbo.[User] ([IdUser]);
ALTER TABLE dbo.[Friendship] WITH CHECK ADD CONSTRAINT [FK_R02_Friendship_User] FOREIGN KEY ([IdUserLow]) REFERENCES dbo.[User] ([IdUser]);
ALTER TABLE dbo.[Friendship] WITH CHECK ADD CONSTRAINT [FK_R03_Friendship_User] FOREIGN KEY ([IdUserHigh]) REFERENCES dbo.[User] ([IdUser]);
ALTER TABLE dbo.[PlayerBlock] WITH CHECK ADD CONSTRAINT [FK_R04_PlayerBlock_User] FOREIGN KEY ([IdBlockerUser]) REFERENCES dbo.[User] ([IdUser]);
ALTER TABLE dbo.[PlayerBlock] WITH CHECK ADD CONSTRAINT [FK_R05_PlayerBlock_User] FOREIGN KEY ([IdBlockedUser]) REFERENCES dbo.[User] ([IdUser]);
ALTER TABLE dbo.[Lobby] WITH CHECK ADD CONSTRAINT [FK_R06_Lobby_User] FOREIGN KEY ([IdHostUser]) REFERENCES dbo.[User] ([IdUser]);
ALTER TABLE dbo.[LobbyPlayer] WITH CHECK ADD CONSTRAINT [FK_R07_LobbyPlayer_Lobby] FOREIGN KEY ([IdLobby]) REFERENCES dbo.[Lobby] ([IdLobby]);
ALTER TABLE dbo.[LobbyPlayer] WITH CHECK ADD CONSTRAINT [FK_R08_LobbyPlayer_User] FOREIGN KEY ([IdUser]) REFERENCES dbo.[User] ([IdUser]);
ALTER TABLE dbo.[Invitation] WITH CHECK ADD CONSTRAINT [FK_R09_Invitation_LobbyPlayer] FOREIGN KEY ([IdLobby], [IdSenderUser]) REFERENCES dbo.[LobbyPlayer] ([IdLobby], [IdUser]);
ALTER TABLE dbo.[Invitation] WITH CHECK ADD CONSTRAINT [FK_R10_Invitation_User] FOREIGN KEY ([IdReceiverUser]) REFERENCES dbo.[User] ([IdUser]);
ALTER TABLE dbo.[Game] WITH CHECK ADD CONSTRAINT [FK_R11_Game_Lobby] FOREIGN KEY ([IdLobby]) REFERENCES dbo.[Lobby] ([IdLobby]);
ALTER TABLE dbo.[GamePlayer] WITH CHECK ADD CONSTRAINT [FK_R12_GamePlayer_Game] FOREIGN KEY ([IdGame]) REFERENCES dbo.[Game] ([IdGame]);
ALTER TABLE dbo.[GamePlayer] WITH CHECK ADD CONSTRAINT [FK_R13_GamePlayer_User] FOREIGN KEY ([IdUser]) REFERENCES dbo.[User] ([IdUser]);
ALTER TABLE dbo.[NormalCard] WITH CHECK ADD CONSTRAINT [FK_R14_NormalCard_Card] FOREIGN KEY ([IdCard]) REFERENCES dbo.[Card] ([IdCard]);
ALTER TABLE dbo.[SpecialCard] WITH CHECK ADD CONSTRAINT [FK_R15_SpecialCard_Card] FOREIGN KEY ([IdCard]) REFERENCES dbo.[Card] ([IdCard]);
ALTER TABLE dbo.[MissionRestriction] WITH CHECK ADD CONSTRAINT [FK_R16_MissionRestriction_Mission] FOREIGN KEY ([IdMission]) REFERENCES dbo.[Mission] ([IdMission]);
ALTER TABLE dbo.[MissionRestriction] WITH CHECK ADD CONSTRAINT [FK_R17_MissionRestriction_RuleDefinition] FOREIGN KEY ([RuleCode]) REFERENCES dbo.[RuleDefinition] ([RuleCode]);
ALTER TABLE dbo.[MissionToken] WITH CHECK ADD CONSTRAINT [FK_R18_MissionToken_Mission] FOREIGN KEY ([IdMission]) REFERENCES dbo.[Mission] ([IdMission]);
ALTER TABLE dbo.[GameMission] WITH CHECK ADD CONSTRAINT [FK_R19_GameMission_Game] FOREIGN KEY ([IdGame]) REFERENCES dbo.[Game] ([IdGame]);
ALTER TABLE dbo.[GameMission] WITH CHECK ADD CONSTRAINT [FK_R20_GameMission_Mission] FOREIGN KEY ([IdMission]) REFERENCES dbo.[Mission] ([IdMission]);
ALTER TABLE dbo.[MissionAttempt] WITH CHECK ADD CONSTRAINT [FK_R21_MissionAttempt_GameMission] FOREIGN KEY ([IdGame], [MissionOrder]) REFERENCES dbo.[GameMission] ([IdGame], [MissionOrder]);
ALTER TABLE dbo.[MissionAttempt] WITH CHECK ADD CONSTRAINT [FK_R22_MissionAttempt_GamePlayer] FOREIGN KEY ([IdGame], [CaptainSeat]) REFERENCES dbo.[GamePlayer] ([IdGame], [Seat]);
ALTER TABLE dbo.[AttemptCard] WITH CHECK ADD CONSTRAINT [FK_R23_AttemptCard_MissionAttempt] FOREIGN KEY ([IdGame], [MissionOrder], [AttemptNumber]) REFERENCES dbo.[MissionAttempt] ([IdGame], [MissionOrder], [AttemptNumber]);
ALTER TABLE dbo.[AttemptCard] WITH CHECK ADD CONSTRAINT [FK_R24_AttemptCard_Card] FOREIGN KEY ([IdCard]) REFERENCES dbo.[Card] ([IdCard]);
ALTER TABLE dbo.[AttemptCard] WITH CHECK ADD CONSTRAINT [FK_R25_AttemptCard_GamePlayer] FOREIGN KEY ([IdGame], [OwnerSeat]) REFERENCES dbo.[GamePlayer] ([IdGame], [Seat]);
ALTER TABLE dbo.[AttemptObjective] WITH CHECK ADD CONSTRAINT [FK_R26_AttemptObjective_AttemptCard] FOREIGN KEY ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]) REFERENCES dbo.[AttemptCard] ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]);
ALTER TABLE dbo.[AttemptObjective] WITH CHECK ADD CONSTRAINT [FK_R27_AttemptObjective_NormalCard] FOREIGN KEY ([IdCard]) REFERENCES dbo.[NormalCard] ([IdCard]);
ALTER TABLE dbo.[AttemptObjective] WITH CHECK ADD CONSTRAINT [FK_R28_AttemptObjective_GamePlayer] FOREIGN KEY ([IdGame], [AssignedSeat]) REFERENCES dbo.[GamePlayer] ([IdGame], [Seat]);
ALTER TABLE dbo.[AttemptRulePlayer] WITH CHECK ADD CONSTRAINT [FK_R29_AttemptRulePlayer_MissionAttempt] FOREIGN KEY ([IdGame], [MissionOrder], [AttemptNumber]) REFERENCES dbo.[MissionAttempt] ([IdGame], [MissionOrder], [AttemptNumber]);
ALTER TABLE dbo.[AttemptRulePlayer] WITH CHECK ADD CONSTRAINT [FK_R30_AttemptRulePlayer_RuleDefinition] FOREIGN KEY ([RuleCode]) REFERENCES dbo.[RuleDefinition] ([RuleCode]);
ALTER TABLE dbo.[AttemptRulePlayer] WITH CHECK ADD CONSTRAINT [FK_R31_AttemptRulePlayer_GamePlayer] FOREIGN KEY ([IdGame], [Seat]) REFERENCES dbo.[GamePlayer] ([IdGame], [Seat]);
ALTER TABLE dbo.[Trick] WITH CHECK ADD CONSTRAINT [FK_R32_Trick_MissionAttempt] FOREIGN KEY ([IdGame], [MissionOrder], [AttemptNumber]) REFERENCES dbo.[MissionAttempt] ([IdGame], [MissionOrder], [AttemptNumber]);
ALTER TABLE dbo.[Trick] WITH CHECK ADD CONSTRAINT [FK_R33_Trick_GamePlayer] FOREIGN KEY ([IdGame], [StartingSeat]) REFERENCES dbo.[GamePlayer] ([IdGame], [Seat]);
ALTER TABLE dbo.[Trick] WITH CHECK ADD CONSTRAINT [FK_R34_Trick_GamePlayer] FOREIGN KEY ([IdGame], [WinningSeat]) REFERENCES dbo.[GamePlayer] ([IdGame], [Seat]);
ALTER TABLE dbo.[Play] WITH CHECK ADD CONSTRAINT [FK_R35_Play_Trick] FOREIGN KEY ([IdGame], [MissionOrder], [AttemptNumber], [TrickNumber]) REFERENCES dbo.[Trick] ([IdGame], [MissionOrder], [AttemptNumber], [TrickNumber]);
ALTER TABLE dbo.[Play] WITH CHECK ADD CONSTRAINT [FK_R36_Play_GamePlayer] FOREIGN KEY ([IdGame], [Seat]) REFERENCES dbo.[GamePlayer] ([IdGame], [Seat]);
ALTER TABLE dbo.[Play] WITH CHECK ADD CONSTRAINT [FK_R37_Play_AttemptCard] FOREIGN KEY ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]) REFERENCES dbo.[AttemptCard] ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]);
ALTER TABLE dbo.[Communication] WITH CHECK ADD CONSTRAINT [FK_R38_Communication_AttemptCard] FOREIGN KEY ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]) REFERENCES dbo.[AttemptCard] ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]);
ALTER TABLE dbo.[Communication] WITH CHECK ADD CONSTRAINT [FK_R39_Communication_NormalCard] FOREIGN KEY ([IdCard]) REFERENCES dbo.[NormalCard] ([IdCard]);
ALTER TABLE dbo.[Communication] WITH CHECK ADD CONSTRAINT [FK_R40_Communication_GamePlayer] FOREIGN KEY ([IdGame], [Seat]) REFERENCES dbo.[GamePlayer] ([IdGame], [Seat]);
ALTER TABLE dbo.[DistressUse] WITH CHECK ADD CONSTRAINT [FK_R41_DistressUse_MissionAttempt] FOREIGN KEY ([IdGame], [MissionOrder], [AttemptNumber]) REFERENCES dbo.[MissionAttempt] ([IdGame], [MissionOrder], [AttemptNumber]);
ALTER TABLE dbo.[DistressTransfer] WITH CHECK ADD CONSTRAINT [FK_R42_DistressTransfer_DistressUse] FOREIGN KEY ([IdGame], [MissionOrder], [AttemptNumber]) REFERENCES dbo.[DistressUse] ([IdGame], [MissionOrder], [AttemptNumber]);
ALTER TABLE dbo.[DistressTransfer] WITH CHECK ADD CONSTRAINT [FK_R43_DistressTransfer_AttemptCard] FOREIGN KEY ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]) REFERENCES dbo.[AttemptCard] ([IdGame], [MissionOrder], [AttemptNumber], [IdCard]);
ALTER TABLE dbo.[DistressTransfer] WITH CHECK ADD CONSTRAINT [FK_R44_DistressTransfer_NormalCard] FOREIGN KEY ([IdCard]) REFERENCES dbo.[NormalCard] ([IdCard]);
ALTER TABLE dbo.[DistressTransfer] WITH CHECK ADD CONSTRAINT [FK_R45_DistressTransfer_GamePlayer] FOREIGN KEY ([IdGame], [FromSeat]) REFERENCES dbo.[GamePlayer] ([IdGame], [Seat]);
ALTER TABLE dbo.[DistressTransfer] WITH CHECK ADD CONSTRAINT [FK_R46_DistressTransfer_GamePlayer] FOREIGN KEY ([IdGame], [ToSeat]) REFERENCES dbo.[GamePlayer] ([IdGame], [Seat]);
ALTER TABLE dbo.[LobbyMessage] WITH CHECK ADD CONSTRAINT [FK_R47_LobbyMessage_LobbyPlayer] FOREIGN KEY ([IdLobby], [IdSenderUser]) REFERENCES dbo.[LobbyPlayer] ([IdLobby], [IdUser]);
ALTER TABLE dbo.[GameSystemMessage] WITH CHECK ADD CONSTRAINT [FK_R48_GameSystemMessage_Game] FOREIGN KEY ([IdGame]) REFERENCES dbo.[Game] ([IdGame]);
ALTER TABLE dbo.[Experience] WITH CHECK ADD CONSTRAINT [FK_R49_Experience_User] FOREIGN KEY ([IdUser]) REFERENCES dbo.[User] ([IdUser]);
CREATE UNIQUE INDEX UX_User_Email ON dbo.[User] ([Email]) WHERE [Email] IS NOT NULL;
CREATE UNIQUE INDEX UX_MissionAttempt_Active ON dbo.MissionAttempt (IdGame, MissionOrder) WHERE Status = 2;
COMMIT;
GO

-- =========================================================
-- 5. Carga de catÃ¡logos y datos iniciales
-- =========================================================
USE [TrickTakingMissionsBD];
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET ARITHABORT ON;
SET NUMERIC_ROUNDABORT OFF;
SET XACT_ABORT ON;
GO

-- Datos ficticios. Catálogo de misiones y jerarquía K de demostración.
BEGIN TRY
BEGIN TRANSACTION;
IF EXISTS (SELECT 1 FROM dbo.[User]) THROW 51000, 'Ejecutar datos únicamente en una base vacía.', 1;
SET IDENTITY_INSERT dbo.[User] ON;
INSERT INTO dbo.[User] ([IdUser], [Username], [Email], [PasswordHash], [Status], [CreatedAt], [LastLoginAt]) VALUES
(1, N'jugador_demo_1', N'jugador1@example.invalid', N'HASH_DE_PRUEBA_NO_AUTENTICABLE', 1, N'2026-09-13T12:00:00', NULL),
(2, N'jugador_demo_2', N'jugador2@example.invalid', N'HASH_DE_PRUEBA_NO_AUTENTICABLE', 1, N'2026-09-13T12:00:00', NULL),
(3, N'jugador_demo_3', N'jugador3@example.invalid', N'HASH_DE_PRUEBA_NO_AUTENTICABLE', 1, N'2026-09-13T12:00:00', NULL),
(4, N'jugador_demo_4', N'jugador4@example.invalid', N'HASH_DE_PRUEBA_NO_AUTENTICABLE', 1, N'2026-09-13T12:00:00', NULL),
(5, N'jugador_demo_5', NULL, NULL, 1, N'2026-09-13T12:00:00', NULL),
(6, N'jugador_demo_6', NULL, NULL, 3, N'2026-09-13T12:00:00', NULL);
SET IDENTITY_INSERT dbo.[User] OFF;
INSERT INTO dbo.[Card] ([IdCard]) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40);
INSERT INTO dbo.[Mission] ([IdMission], [ObjectiveCount], [IsActive]) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 0, 1);
INSERT INTO dbo.[RuleDefinition] ([RuleCode], [Description]) VALUES
(N'DEMO_NO_TRICK', N'Regla de prueba: jugador designado no gana bazas; no es catálogo oficial');
INSERT INTO dbo.[PlayerProfile] ([IdUser], [DisplayName], [AvatarPath], [Biography], [CreatedAt], [UpdatedAt]) VALUES
(1, N'Jugador de prueba 1', NULL, N'Datos ficticios para validar el modelo', N'2026-09-13T12:00:00', NULL),
(2, N'Jugador de prueba 2', NULL, N'Datos ficticios para validar el modelo', N'2026-09-13T12:00:00', NULL),
(3, N'Jugador de prueba 3', NULL, N'Datos ficticios para validar el modelo', N'2026-09-13T12:00:00', NULL),
(4, N'Jugador de prueba 4', NULL, N'Datos ficticios para validar el modelo', N'2026-09-13T12:00:00', NULL),
(5, N'Jugador de prueba 5', NULL, N'Datos ficticios para validar el modelo', N'2026-09-13T12:00:00', NULL),
(6, N'Jugador de prueba 6', NULL, N'Datos ficticios para validar el modelo', N'2026-09-13T12:00:00', NULL);
INSERT INTO dbo.[Friendship] ([IdUserLow], [IdUserHigh], [RequestedByLow], [Status], [RequestedAt], [RespondedAt]) VALUES
(1, 2, 1, 2, N'2026-09-13T12:00:00', N'2026-09-13T12:10:00'),
(2, 3, 1, 1, N'2026-09-13T12:00:00', NULL);
INSERT INTO dbo.[PlayerBlock] ([IdBlockerUser], [IdBlockedUser], [CreatedAt]) VALUES
(1, 6, N'2026-09-13T12:00:00');
SET IDENTITY_INSERT dbo.[Lobby] ON;
INSERT INTO dbo.[Lobby] ([IdLobby], [LobbyCode], [IdHostUser], [Status], [PrivacyMode], [PlayerLimit], [TargetMissionCount], [CreatedAt], [ClosedAt]) VALUES
(1, N'DEMO-1', 1, 3, 1, 3, 2, N'2026-09-13T12:00:00', NULL),
(2, N'DEMO-2', 1, 3, 2, 4, 1, N'2026-09-13T12:00:00', NULL);
SET IDENTITY_INSERT dbo.[Lobby] OFF;
INSERT INTO dbo.[NormalCard] ([IdCard], [Color], [Number]) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 2, 1),
(11, 2, 2),
(12, 2, 3),
(13, 2, 4),
(14, 2, 5),
(15, 2, 6),
(16, 2, 7),
(17, 2, 8),
(18, 2, 9),
(19, 3, 1),
(20, 3, 2),
(21, 3, 3),
(22, 3, 4),
(23, 3, 5),
(24, 3, 6),
(25, 3, 7),
(26, 3, 8),
(27, 3, 9),
(28, 4, 1),
(29, 4, 2),
(30, 4, 3),
(31, 4, 4),
(32, 4, 5),
(33, 4, 6),
(34, 4, 7),
(35, 4, 8),
(36, 4, 9);
INSERT INTO dbo.[SpecialCard] ([IdCard], [Symbol], [Rank]) VALUES
(37, N'Espada', 1),
(38, N'Corazon', 2),
(39, N'Trebol', 3),
(40, N'Diamante', 4);
INSERT INTO dbo.[MissionRestriction] ([IdMission], [RuleCode], [IntegerValue]) VALUES
(3, N'DEMO_NO_TRICK', NULL);
INSERT INTO dbo.[MissionToken] ([IdMission], [TokenSlot], [OrderType], [OrderNumber]) VALUES
(2, 1, 2, 1);
INSERT INTO dbo.[Experience] ([IdUser], [TotalXP], [UpdatedAt]) VALUES
(1, 0, NULL),
(2, 0, NULL),
(3, 0, NULL),
(4, 0, NULL),
(5, 0, NULL),
(6, 0, NULL);
INSERT INTO dbo.[LobbyPlayer] ([IdLobby], [IdUser], [IsReady], [JoinedAt], [LeftAt]) VALUES
(1, 1, 1, N'2026-09-13T12:00:00', NULL),
(1, 2, 1, N'2026-09-13T12:00:00', NULL),
(1, 3, 1, N'2026-09-13T12:00:00', NULL),
(2, 1, 1, N'2026-09-13T12:00:00', NULL),
(2, 2, 1, N'2026-09-13T12:00:00', NULL),
(2, 3, 1, N'2026-09-13T12:00:00', NULL),
(2, 4, 1, N'2026-09-13T12:00:00', NULL);
SET IDENTITY_INSERT dbo.[Game] ON;
INSERT INTO dbo.[Game] ([IdGame], [IdLobby], [Status], [TargetMissionCount], [DistressSignalEnabled], [CreatedAt], [StartedAt], [FinishedAt], [XPGrantedPerPlayer], [XPGrantedAt]) VALUES
(1, 1, 2, 2, 1, N'2026-09-13T12:00:00', N'2026-09-13T12:00:00', NULL, 0, NULL),
(2, 2, 2, 1, 1, N'2026-09-13T12:00:00', N'2026-09-13T12:00:00', NULL, 0, NULL);
SET IDENTITY_INSERT dbo.[Game] OFF;
SET IDENTITY_INSERT dbo.[Invitation] ON;
INSERT INTO dbo.[Invitation] ([IdInvitation], [IdLobby], [IdSenderUser], [IdReceiverUser], [Status], [SentAt], [ResolvedAt]) VALUES
(1, 1, 1, 5, 1, N'2026-09-13T12:00:00', NULL),
(2, 2, 1, 4, 2, N'2026-09-13T12:00:00', N'2026-09-13T12:10:00');
SET IDENTITY_INSERT dbo.[Invitation] OFF;
INSERT INTO dbo.[GamePlayer] ([IdGame], [Seat], [IdUser], [ConnectionStatus], [JoinedAt], [LeftAt]) VALUES
(1, 1, 1, 1, N'2026-09-13T12:00:00', NULL),
(1, 2, 2, 1, N'2026-09-13T12:00:00', NULL),
(1, 3, 3, 1, N'2026-09-13T12:00:00', NULL),
(2, 1, 1, 1, N'2026-09-13T12:00:00', NULL),
(2, 2, 2, 1, N'2026-09-13T12:00:00', NULL),
(2, 3, 3, 1, N'2026-09-13T12:00:00', NULL),
(2, 4, 4, 1, N'2026-09-13T12:00:00', NULL);
INSERT INTO dbo.[GameMission] ([IdGame], [MissionOrder], [IdMission]) VALUES
(1, 1, 1),
(2, 1, 2),
(1, 2, 3);
SET IDENTITY_INSERT dbo.[LobbyMessage] ON;
INSERT INTO dbo.[LobbyMessage] ([IdLobbyMessage], [IdLobby], [IdSenderUser], [Message], [SentAt]) VALUES
(1, 1, 1, N'Preparados para comenzar', N'2026-09-13T12:00:00');
SET IDENTITY_INSERT dbo.[LobbyMessage] OFF;
SET IDENTITY_INSERT dbo.[GameSystemMessage] ON;
INSERT INTO dbo.[GameSystemMessage] ([IdGameSystemMessage], [IdGame], [ResourceKey], [SentAt]) VALUES
(1, 1, N'Game.Started', N'2026-09-13T12:00:00'),
(2, 2, N'Game.Started', N'2026-09-13T12:00:00');
SET IDENTITY_INSERT dbo.[GameSystemMessage] OFF;
INSERT INTO dbo.[MissionAttempt] ([IdGame], [MissionOrder], [AttemptNumber], [Status], [CaptainSeat], [CreatedAt], [StartedAt], [FinishedAt]) VALUES
(1, 1, 1, 2, 1, N'2026-09-13T12:00:00', N'2026-09-13T12:00:00', NULL),
(2, 1, 1, 2, 1, N'2026-09-13T12:00:00', N'2026-09-13T12:00:00', NULL),
(1, 2, 1, 1, NULL, N'2026-09-13T12:00:00', NULL, NULL);
INSERT INTO dbo.[AttemptCard] ([IdGame], [MissionOrder], [AttemptNumber], [IdCard], [OwnerSeat]) VALUES
(1, 1, 1, 1, 1),
(1, 1, 1, 2, 2),
(1, 1, 1, 3, 3),
(1, 1, 1, 4, 1),
(1, 1, 1, 5, 2),
(1, 1, 1, 6, 3),
(1, 1, 1, 7, 1),
(1, 1, 1, 8, 2),
(1, 1, 1, 9, 3),
(1, 1, 1, 10, 1),
(1, 1, 1, 11, 2),
(1, 1, 1, 12, 3),
(1, 1, 1, 13, 1),
(1, 1, 1, 14, 2),
(1, 1, 1, 15, 3),
(1, 1, 1, 16, 1),
(1, 1, 1, 17, 2),
(1, 1, 1, 18, 3),
(1, 1, 1, 19, 1),
(1, 1, 1, 20, 2),
(1, 1, 1, 21, 3),
(1, 1, 1, 22, 1),
(1, 1, 1, 23, 2),
(1, 1, 1, 24, 3),
(1, 1, 1, 25, 1),
(1, 1, 1, 26, 2),
(1, 1, 1, 27, 3),
(1, 1, 1, 28, 1),
(1, 1, 1, 29, 2),
(1, 1, 1, 30, 3),
(1, 1, 1, 31, 1),
(1, 1, 1, 32, 2),
(1, 1, 1, 33, 3),
(1, 1, 1, 34, 1),
(1, 1, 1, 35, 2),
(1, 1, 1, 36, 3),
(1, 1, 1, 37, 1),
(1, 1, 1, 38, 2),
(1, 1, 1, 39, 3),
(1, 1, 1, 40, 1),
(2, 1, 1, 1, 1),
(2, 1, 1, 2, 2),
(2, 1, 1, 3, 3),
(2, 1, 1, 4, 4),
(2, 1, 1, 5, 1),
(2, 1, 1, 6, 2),
(2, 1, 1, 7, 3),
(2, 1, 1, 8, 4),
(2, 1, 1, 9, 1),
(2, 1, 1, 10, 2),
(2, 1, 1, 11, 3),
(2, 1, 1, 12, 4),
(2, 1, 1, 13, 1),
(2, 1, 1, 14, 2),
(2, 1, 1, 15, 3),
(2, 1, 1, 16, 4),
(2, 1, 1, 17, 1),
(2, 1, 1, 18, 2),
(2, 1, 1, 19, 3),
(2, 1, 1, 20, 4),
(2, 1, 1, 21, 1),
(2, 1, 1, 22, 2),
(2, 1, 1, 23, 3),
(2, 1, 1, 24, 4),
(2, 1, 1, 25, 1),
(2, 1, 1, 26, 2),
(2, 1, 1, 27, 3),
(2, 1, 1, 28, 4),
(2, 1, 1, 29, 1),
(2, 1, 1, 30, 2),
(2, 1, 1, 31, 3),
(2, 1, 1, 32, 4),
(2, 1, 1, 33, 1),
(2, 1, 1, 34, 2),
(2, 1, 1, 35, 3),
(2, 1, 1, 36, 4),
(2, 1, 1, 37, 1),
(2, 1, 1, 38, 2),
(2, 1, 1, 39, 3),
(2, 1, 1, 40, 4),
(1, 2, 1, 7, 2),
(1, 2, 1, 8, 3),
(1, 2, 1, 9, 1);
INSERT INTO dbo.[AttemptRulePlayer] ([IdGame], [MissionOrder], [AttemptNumber], [RuleCode], [Seat], [RoleCode]) VALUES
(1, 2, 1, N'DEMO_NO_TRICK', 3, N'RestrictedPlayer');
INSERT INTO dbo.[Trick] ([IdGame], [MissionOrder], [AttemptNumber], [TrickNumber], [StartingSeat], [WinningSeat], [StartedAt], [FinishedAt]) VALUES
(1, 1, 1, 1, 1, NULL, N'2026-09-13T12:00:00', NULL),
(2, 1, 1, 1, 1, NULL, N'2026-09-13T12:00:00', NULL);
INSERT INTO dbo.[DistressUse] ([IdGame], [MissionOrder], [AttemptNumber], [Direction], [CreatedAt]) VALUES
(1, 2, 1, 1, N'2026-09-13T12:00:00');
INSERT INTO dbo.[AttemptObjective] ([IdGame], [MissionOrder], [AttemptNumber], [IdCard], [AssignedSeat], [OrderType], [OrderNumber], [Status], [CompletedAt]) VALUES
(1, 1, 1, 1, 1, 1, NULL, 1, NULL),
(2, 1, 1, 1, 1, 1, NULL, 1, NULL);
INSERT INTO dbo.[Play] ([IdGame], [MissionOrder], [AttemptNumber], [TrickNumber], [PlayOrder], [Seat], [IdCard], [PlayedAt]) VALUES
(1, 1, 1, 1, 1, 1, 1, N'2026-09-13T12:00:00'),
(1, 1, 1, 1, 2, 2, 2, N'2026-09-13T12:00:00'),
(2, 1, 1, 1, 1, 1, 1, N'2026-09-13T12:00:00'),
(2, 1, 1, 1, 2, 2, 2, N'2026-09-13T12:00:00');
INSERT INTO dbo.[Communication] ([IdGame], [MissionOrder], [AttemptNumber], [Seat], [IdCard], [CommunicationType], [BeforeTrickNumber], [CreatedAt]) VALUES
(2, 1, 1, 3, 35, 1, 1, N'2026-09-13T12:00:00');
INSERT INTO dbo.[DistressTransfer] ([IdGame], [MissionOrder], [AttemptNumber], [FromSeat], [ToSeat], [IdCard]) VALUES
(1, 2, 1, 1, 2, 7),
(1, 2, 1, 2, 3, 8),
(1, 2, 1, 3, 1, 9);
COMMIT;
END TRY
BEGIN CATCH
 IF @@TRANCOUNT > 0 ROLLBACK;
 THROW;
END CATCH;
GO

-- =========================================================
-- 6. Triggers y procedimientos de reglas de juego
-- =========================================================
USE [TrickTakingMissionsBD];
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

-- La exclusión entre subtipos se comprueba al modificar cada subtipo.
-- El bloqueo de la fila padre serializa altas concurrentes del mismo IdCard.
CREATE OR ALTER TRIGGER dbo.TR_NormalCard_Disjoint ON dbo.[NormalCard]
AFTER INSERT, UPDATE AS
BEGIN
 SET NOCOUNT ON;
 DECLARE @locked int;
 SELECT @locked = c.IdCard FROM dbo.Card c WITH (UPDLOCK, HOLDLOCK)
 JOIN inserted i ON i.IdCard=c.IdCard;
 IF EXISTS (SELECT 1 FROM inserted i JOIN dbo.[SpecialCard] b ON b.IdCard=i.IdCard)
   THROW 51001, 'Una carta no puede ser normal y especial simultaneamente.', 1;
END;
GO

CREATE OR ALTER TRIGGER dbo.TR_SpecialCard_Disjoint ON dbo.[SpecialCard]
AFTER INSERT, UPDATE AS
BEGIN
 SET NOCOUNT ON;
 DECLARE @locked int;
 SELECT @locked = c.IdCard FROM dbo.Card c WITH (UPDLOCK, HOLDLOCK)
 JOIN inserted i ON i.IdCard=c.IdCard;
 IF EXISTS (SELECT 1 FROM inserted i JOIN dbo.[NormalCard] b ON b.IdCard=i.IdCard)
   THROW 51001, 'Una carta no puede ser normal y especial simultaneamente.', 1;
END;
GO

-- Usar esta operación para pasar de Creada a En curso, no UPDATE directo.
CREATE OR ALTER PROCEDURE dbo.IniciarPartida @IdGame int AS
BEGIN
 SET NOCOUNT ON;
 SET XACT_ABORT ON;
 BEGIN TRY
  BEGIN TRANSACTION;
  DECLARE @status tinyint, @limit tinyint, @lobby int, @n int;
  SELECT @status=Status, @lobby=IdLobby FROM dbo.Game WITH (UPDLOCK,HOLDLOCK) WHERE IdGame=@IdGame;
  IF @status IS NULL THROW 51002, 'Partida inexistente.', 1;
  IF @status<>1 THROW 51003, 'La partida debe estar creada.', 1;
  SELECT @limit=PlayerLimit FROM dbo.Lobby WITH (UPDLOCK,HOLDLOCK) WHERE IdLobby=@lobby;
  SELECT @n=COUNT(*) FROM dbo.GamePlayer WITH (UPDLOCK,HOLDLOCK) WHERE IdGame=@IdGame AND LeftAt IS NULL;
  IF @n NOT IN (3,4) OR @n<>@limit THROW 51004, 'Cantidad de participantes incompatible con la sala.', 1;
  IF EXISTS (SELECT 1 FROM dbo.GamePlayer gp WHERE gp.IdGame=@IdGame AND
    (gp.LeftAt IS NOT NULL OR gp.ConnectionStatus<>1 OR NOT EXISTS
      (SELECT 1 FROM dbo.LobbyPlayer lp WHERE lp.IdLobby=@lobby AND lp.IdUser=gp.IdUser AND lp.LeftAt IS NULL AND lp.IsReady=1)))
   THROW 51005, 'Los participantes deben estar activos, conectados y preparados en la sala.', 1;
  UPDATE dbo.Game SET Status=2, StartedAt=SYSUTCDATETIME() WHERE IdGame=@IdGame;
  COMMIT;
 END TRY
 BEGIN CATCH
  IF @@TRANCOUNT>0 ROLLBACK;
  THROW;
 END CATCH;
END;
GO
-- Totalidad: verificar al finalizar la carga transaccional del catalogo.
-- Los CHECK de SQL Server no pueden expresar por si solos esta regla entre tablas.

-- =========================================================
-- 7. Experiencia, niveles y recompensas
-- =========================================================
USE [TrickTakingMissionsBD];
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO
-- Toda cuenta nueva comienza con cero XP. Las cuentas de prueba se cargaron en 03.
CREATE OR ALTER TRIGGER dbo.TR_User_CreateExperience ON dbo.[User]
AFTER INSERT AS
BEGIN
 SET NOCOUNT ON;
 INSERT dbo.Experience(IdUser,TotalXP,UpdatedAt)
 SELECT IdUser,0,NULL FROM inserted;
END;
GO
-- Solo el servicio autorizado debe ejecutar esta operación.
-- El motor confirma objetivos y victoria antes de marcar Game.Status=4.
-- Regla adoptada: victoria cooperativa, para quienes no abandonaron al finalizar.
-- @XPPorVictoria es obligatorio: no se fija una recompensa oficial.
CREATE OR ALTER PROCEDURE dbo.OtorgarExperienciaVictoria
 @IdGame int, @XPPorVictoria int
AS
BEGIN
 SET NOCOUNT ON;
 SET XACT_ABORT ON;
 IF @XPPorVictoria IS NULL OR @XPPorVictoria<=0
   THROW 51100, 'La recompensa debe ser positiva.', 1;
 BEGIN TRY
  BEGIN TRANSACTION;
  DECLARE @status tinyint,@granted datetime2(0),@finished datetime2(0),@now datetime2(0)=SYSUTCDATETIME();
  SELECT @status=Status,@granted=XPGrantedAt,@finished=FinishedAt
  FROM dbo.Game WITH (UPDLOCK,HOLDLOCK) WHERE IdGame=@IdGame;
  IF @status IS NULL THROW 51101, 'Partida inexistente.', 1;
  IF @status<>4 OR @finished IS NULL
    THROW 51102, 'La partida debe estar ganada y finalizada.', 1;
  IF @granted IS NOT NULL
  BEGIN
   COMMIT;
   RETURN; -- Reintento: no vuelve a sumar, aunque cambie el parametro.
  END;
  IF @finished>@now THROW 51103, 'Fecha de finalizacion futura.', 1;
  DECLARE @winners TABLE(IdUser int PRIMARY KEY);
  INSERT @winners SELECT IdUser FROM dbo.GamePlayer WITH (UPDLOCK,HOLDLOCK)
    WHERE IdGame=@IdGame AND LeftAt IS NULL AND ConnectionStatus IN (1,2);
  IF NOT EXISTS(SELECT 1 FROM @winners)
    THROW 51104, 'La partida no tiene participantes elegibles.', 1;
  -- Bloqueos sobre los saldos serializan actualizaciones del mismo usuario.
  DECLARE @locked bigint;
  SELECT @locked=e.TotalXP FROM dbo.Experience e WITH (UPDLOCK,HOLDLOCK)
    JOIN @winners w ON w.IdUser=e.IdUser;
  IF EXISTS(SELECT 1 FROM @winners w WHERE NOT EXISTS
    (SELECT 1 FROM dbo.Experience e WHERE e.IdUser=w.IdUser))
    THROW 51105, 'Falta el registro de experiencia de un participante.', 1;
  IF EXISTS(SELECT 1 FROM dbo.Experience e JOIN @winners w ON e.IdUser=w.IdUser
    WHERE e.TotalXP>CONVERT(bigint,9223372036854775807)-@XPPorVictoria)
    THROW 51106, 'La experiencia excederia el rango permitido.', 1;
  UPDATE e SET TotalXP=TotalXP+CONVERT(bigint,@XPPorVictoria),UpdatedAt=@now
    FROM dbo.Experience e JOIN @winners w ON e.IdUser=w.IdUser;
  UPDATE dbo.Game SET XPGrantedPerPlayer=@XPPorVictoria,XPGrantedAt=@now
    WHERE IdGame=@IdGame;
  COMMIT;
 END TRY
 BEGIN CATCH
  IF @@TRANCOUNT>0 ROLLBACK;
  THROW;
 END CATCH;
END;
GO
-- Umbral uniforme parametrizado. No almacena niveles ni duplica TotalXP en User.
-- Con umbral invalido no devuelve filas; el servicio debe exigir un entero > 0.
CREATE OR ALTER FUNCTION dbo.NivelesJugadores(@XPPorNivel int)
RETURNS TABLE
AS RETURN
 SELECT u.IdUser,u.Username,COALESCE(e.TotalXP,CONVERT(bigint,0)) AS TotalXP,
   CONVERT(decimal(20,0),COALESCE(e.TotalXP,0)/NULLIF(@XPPorNivel,0))+1 AS Nivel,
   COALESCE(e.TotalXP,0)%NULLIF(@XPPorNivel,0) AS XPEnNivel,
   @XPPorNivel-COALESCE(e.TotalXP,0)%NULLIF(@XPPorNivel,0) AS XPFaltante
 FROM dbo.[User] u LEFT JOIN dbo.Experience e ON e.IdUser=u.IdUser
 WHERE @XPPorNivel>0;
GO
-- Ejemplo de consulta; 500 NO es un requisito definitivo.
SELECT * FROM dbo.NivelesJugadores(500) ORDER BY TotalXP DESC,IdUser;
GO

-- =========================================================
-- 8. MigraciÃ³n 001 - ModeraciÃ³n de Chat
-- =========================================================
USE [TrickTakingMissionsBD];
GO
SET XACT_ABORT ON;
BEGIN TRANSACTION;
IF OBJECT_ID(N'dbo.ChatModerationAccount', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ChatModerationAccount
    (
        AccountUserId int NOT NULL PRIMARY KEY,
        AccumulatedChatInfractionPoints int NOT NULL DEFAULT 0 CHECK (AccumulatedChatInfractionPoints >= 0),
        ThreateningChatMessageCount int NOT NULL DEFAULT 0 CHECK (ThreateningChatMessageCount >= 0),
        PreviousTemporaryChatBanCount int NOT NULL DEFAULT 0 CHECK (PreviousTemporaryChatBanCount >= 0),
        IsChatAccountPermanentlyBanned bit NOT NULL DEFAULT 0,
        ChatAccountBanEndsAtUtc datetime2 NULL
    );
END;
IF OBJECT_ID(N'dbo.ChatModerationSubmission', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ChatModerationSubmission
    (
        AccountUserId int NOT NULL,
        ChatMessageSubmissionId uniqueidentifier NOT NULL,
        ChatMessageContentDigest nvarchar(44) NOT NULL,
        CurrentMessageInfractionPoints int NOT NULL,
        SubmittedAtUtc datetime2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT PK_ChatModerationSubmission PRIMARY KEY (AccountUserId, ChatMessageSubmissionId),
        CONSTRAINT FK_ChatModerationSubmission_Account FOREIGN KEY (AccountUserId)
            REFERENCES dbo.ChatModerationAccount(AccountUserId)
    );
END;
COMMIT;

GO
-- =========================================================
-- 9. MigraciÃ³n 002 - Bloqueo permanente de cuentas
-- =========================================================
USE [TrickTakingMissionsBD];
GO
SET XACT_ABORT ON;
BEGIN TRANSACTION;
IF OBJECT_ID(N'dbo.PermanentlyBlockedAccountEmail', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.PermanentlyBlockedAccountEmail
    (
        NormalizedAccountEmailDigest binary(32) NOT NULL PRIMARY KEY,
        BlockedAtUtc datetime2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END;
-- Preserve restrictions for accounts sanctioned before this migration.
INSERT INTO dbo.PermanentlyBlockedAccountEmail (NormalizedAccountEmailDigest)
SELECT DISTINCT HASHBYTES('SHA2_256', CONVERT(nvarchar(320), UPPER(LTRIM(RTRIM(u.Email)))))
FROM dbo.[User] u
JOIN dbo.ChatModerationAccount m ON m.AccountUserId = u.IdUser
WHERE m.IsChatAccountPermanentlyBanned = 1 AND u.Email IS NOT NULL
AND NOT EXISTS
(
    SELECT 1 FROM dbo.PermanentlyBlockedAccountEmail b
    WHERE b.NormalizedAccountEmailDigest =
        HASHBYTES('SHA2_256', CONVERT(nvarchar(320), UPPER(LTRIM(RTRIM(u.Email)))))
);
COMMIT;

GO
