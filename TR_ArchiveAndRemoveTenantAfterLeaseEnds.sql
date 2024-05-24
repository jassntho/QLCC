//t?o bang TenantHistory ?? l?u thông tin l?ch s? thuê
CREATE TABLE TenantHistory (
    History_ID INT AUTO_INCREMENT PRIMARY KEY,
    Tenant_ID INT,
    Unit_ID INT,
    Start_Date DATE,
    End_Date DATE,
    FOREIGN KEY (Tenant_ID) REFERENCES Tenant(Tenant_ID),
    FOREIGN KEY (Unit_ID) REFERENCES Unit(Unit_ID)
);

//t?o trigger
DELIMITER //

CREATE TRIGGER ArchiveAndRemoveTenantAfterLeaseEnds
AFTER UPDATE ON Lease
FOR EACH ROW
BEGIN
    IF NEW.End_Date < CURDATE() AND NEW.Status = 'Terminated' THEN
        -- L?u tr? thông tin thuê vào TenantHistory
        INSERT INTO TenantHistory (Tenant_ID, Unit_ID, Start_Date, End_Date)
        SELECT Tenant_ID, Unit_ID, Start_Date, End_Date
        FROM Lease
        WHERE Lease_ID = NEW.Lease_ID;
        
        -- Xóa thông tin c? dân kh?i b?ng Tenant
        DELETE FROM Tenant WHERE Tenant_ID = (SELECT Tenant_ID FROM Lease WHERE Lease_ID = NEW.Lease_ID);
        
        -- C?p nh?t tr?ng thái c?a ??n v? thành 'Available'
        UPDATE Unit
        SET Status = 'Available'
        WHERE Unit_ID = NEW.Unit_ID;
    END IF;
END//

DELIMITER ;
