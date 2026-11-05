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
