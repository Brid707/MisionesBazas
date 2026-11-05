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
