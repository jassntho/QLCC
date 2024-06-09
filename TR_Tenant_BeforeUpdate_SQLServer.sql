USE QLCC;
GO

CREATE TRIGGER TR_Tenant_BeforeUpdate
ON Tenant
INSTEAD OF UPDATE
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
        UPDATE Tenant
        SET Tenant_ID = inserted.Tenant_ID,
            Tenant_Name = inserted.Tenant_Name,
            Phone_Number = inserted.Phone_Number,
            Tenant_Email = inserted.Tenant_Email,
            Date_of_Birth = inserted.Date_of_Birth,
            Host = inserted.Host
        FROM inserted
        WHERE Tenant.Tenant_ID = inserted.Tenant_ID;
    END
END;
GO