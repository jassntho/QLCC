//t?o bang TenantHistory ?? l?u th�ng tin l?ch s? thu�
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
        -- L?u tr? th�ng tin thu� v�o TenantHistory
        INSERT INTO TenantHistory (Tenant_ID, Unit_ID, Start_Date, End_Date)
        SELECT Tenant_ID, Unit_ID, Start_Date, End_Date
        FROM Lease
        WHERE Lease_ID = NEW.Lease_ID;
        
        -- X�a th�ng tin c? d�n kh?i b?ng Tenant
        DELETE FROM Tenant WHERE Tenant_ID = (SELECT Tenant_ID FROM Lease WHERE Lease_ID = NEW.Lease_ID);
        
        -- C?p nh?t tr?ng th�i c?a ??n v? th�nh 'Available'
        UPDATE Unit
        SET Status = 'Available'
        WHERE Unit_ID = NEW.Unit_ID;
    END IF;
END//

DELIMITER ;
