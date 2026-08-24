/*
    AabeDfwApiV2 - schema-only DDL
    Final state as of migration 20260822192645_FixDecimalPrecision.

    Hand-maintained companion to Migrations/migrations.sql. This script contains
    no __EFMigrationsHistory bookkeeping, so a database created from it will NOT
    be recognized by "dotnet ef database update". Use migrations.sql for real
    deployments; use this one for review, documentation, or a scratch database.

    Tables are created in FK-dependency order. Decimal columns are written at
    their final precision (10,2) rather than created at (18,2) and altered.
*/

CREATE TABLE [Committees] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NULL,
    [Description] nvarchar(max) NULL,
    CONSTRAINT [PK_Committees] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Members] (
    [Id] int NOT NULL IDENTITY,
    [FirstName] nvarchar(max) NULL,
    [LastName] nvarchar(max) NULL,
    [Email] nvarchar(max) NULL,
    [JoinDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Members] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Events] (
    [Id] int NOT NULL IDENTITY,
    [Title] nvarchar(max) NULL,
    [Description] nvarchar(max) NULL,
    [ImageUrl] nvarchar(max) NULL,
    [EventDate] datetime2 NOT NULL,
    [Location] nvarchar(max) NULL,
    [Price] decimal(10,2) NOT NULL,
    [CommitteeId] int NOT NULL,
    CONSTRAINT [PK_Events] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Events_Committees_CommitteeId] FOREIGN KEY ([CommitteeId]) REFERENCES [Committees] ([Id]) ON DELETE CASCADE
);
GO

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
GO

CREATE TABLE [Payments] (
    [Id] int NOT NULL IDENTITY,
    [SignupId] int NOT NULL,
    [Amount] decimal(10,2) NOT NULL,
    [StripePaymentIntentId] nvarchar(max) NULL,
    [Status] nvarchar(max) NULL,
    [CreatedAt] datetime2 NOT NULL,
    CONSTRAINT [PK_Payments] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Payments_Signups_SignupId] FOREIGN KEY ([SignupId]) REFERENCES [Signups] ([Id]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_Events_CommitteeId] ON [Events] ([CommitteeId]);
GO

CREATE INDEX [IX_Signups_EventId] ON [Signups] ([EventId]);
GO

CREATE INDEX [IX_Signups_MemberId] ON [Signups] ([MemberId]);
GO

CREATE INDEX [IX_Payments_SignupId] ON [Payments] ([SignupId]);
GO
