USE QLCC;
GO

CREATE PROCEDURE Tenant_GetList
AS
BEGIN
    -- Lấy danh sách cư dân từ các hợp đồng thuê đang hoạt động
    SELECT Tenant.Tenant_ID, Tenant.Tenant_Name, Tenant.Phone_Number, Tenant.Tenant_Email
    FROM Tenant
    JOIN Lease ON Tenant.Tenant_ID = Lease.Tenant_ID
    WHERE Lease.Start_Date <= GETDATE() AND Lease.End_Date >= GETDATE();
END;
GO