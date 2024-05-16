USE QLCC

DELIMITER //

CREATE PROCEDURE Tenant_GetList()
BEGIN
    -- Lấy danh sách cư dân từ các hợp đồng thuê đang hoạt động
    SELECT Tenant.Tenant_ID, Tenant.Name, Tenant.Phone_Number, Tenant.Email
    FROM Tenant
    JOIN Lease ON Tenant.Tenant_ID = Lease.Tenant_ID
    WHERE Lease.Start_Date <= CURDATE() AND Lease.End_Date >= CURDATE();
END//

DELIMITER ;
