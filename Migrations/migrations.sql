IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822185520_InitialCreate'
)
BEGIN
    CREATE TABLE [Committees] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [Description] nvarchar(max) NULL,
        CONSTRAINT [PK_Committees] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822185520_InitialCreate'
)
BEGIN
    CREATE TABLE [Members] (
        [Id] int NOT NULL IDENTITY,
        [FirstName] nvarchar(max) NULL,
        [LastName] nvarchar(max) NULL,
        [Email] nvarchar(max) NULL,
        [JoinDate] datetime2 NOT NULL,
        CONSTRAINT [PK_Members] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822185520_InitialCreate'
)
BEGIN
    CREATE TABLE [Events] (
        [Id] int NOT NULL IDENTITY,
        [Title] nvarchar(max) NULL,
        [Description] nvarchar(max) NULL,
        [ImageUrl] nvarchar(max) NULL,
        [EventDate] datetime2 NOT NULL,
        [Location] nvarchar(max) NULL,
        [Price] decimal(18,2) NOT NULL,
        [CommitteeId] int NOT NULL,
        CONSTRAINT [PK_Events] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Events_Committees_CommitteeId] FOREIGN KEY ([CommitteeId]) REFERENCES [Committees] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822185520_InitialCreate'
)
BEGIN
    CREATE TABLE [Signups] (
        [Id] int NOT NULL IDENTITY,
        [MemberId] int NOT NULL,
        [EventId] int NOT NULL,
        [SignupDate] datetime2 NOT NULL,
        [PaymentCompleted] bit NOT NULL,
        CONSTRAINT [PK_Signups] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Signups_Events_EventId] FOREIGN KEY ([EventId]) REFERENCES [Events] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Signups_Members_MemberId] FOREIGN KEY ([MemberId]) REFERENCES [Members] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822185520_InitialCreate'
)
BEGIN
    CREATE TABLE [Payments] (
        [Id] int NOT NULL IDENTITY,
        [SignupId] int NOT NULL,
        [Amount] decimal(18,2) NOT NULL,
        [StripePaymentIntentId] nvarchar(max) NULL,
        [Status] nvarchar(max) NULL,
        [CreatedAt] datetime2 NOT NULL,
        CONSTRAINT [PK_Payments] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Payments_Signups_SignupId] FOREIGN KEY ([SignupId]) REFERENCES [Signups] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822185520_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Events_CommitteeId] ON [Events] ([CommitteeId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822185520_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Payments_SignupId] ON [Payments] ([SignupId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822185520_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Signups_EventId] ON [Signups] ([EventId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822185520_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Signups_MemberId] ON [Signups] ([MemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822185520_InitialCreate'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260822185520_InitialCreate', N'10.0.11');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822192645_FixDecimalPrecision'
)
BEGIN
    DECLARE @var nvarchar(max);
    SELECT @var = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Payments]') AND [c].[name] = N'Amount');
    IF @var IS NOT NULL EXEC(N'ALTER TABLE [Payments] DROP CONSTRAINT ' + @var + ';');
    ALTER TABLE [Payments] ALTER COLUMN [Amount] decimal(10,2) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822192645_FixDecimalPrecision'
)
BEGIN
    DECLARE @var1 nvarchar(max);
    SELECT @var1 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Events]') AND [c].[name] = N'Price');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Events] DROP CONSTRAINT ' + @var1 + ';');
    ALTER TABLE [Events] ALTER COLUMN [Price] decimal(10,2) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260822192645_FixDecimalPrecision'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260822192645_FixDecimalPrecision', N'10.0.11');
END;

COMMIT;
GO

