USE QLCC;
GO

CREATE TRIGGER TR_Tenant_BeforeInsert
ON Tenant
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @CurrentDate DATE = GETDATE();
    DECLARE @DateOfBirth DATE;
    DECLARE @Age INT;

    SELECT @DateOfBirth = Date_of_Birth FROM inserted;

    SET @Age = DATEDIFF(YEAR, @DateOfBirth, @CurrentDate);

    IF @Age < 18
    BEGIN
        RAISERROR('Tenant must be at least 18 years old.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Tenant (Tenant_ID, Tenant_Name, Phone_Number, Tenant_Email, Date_of_Birth, Host)
        SELECT Tenant_ID, Tenant_Name, Phone_Number, Tenant_Email, Date_of_Birth, Host
        FROM inserted;
    END
END;
GO