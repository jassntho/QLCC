USE QLCC

DELIMITER //
CREATE TRIGGER TR_UNIT_UPDATE_STATUS
AFTER INSERT ON Lease
FOR EACH ROW
BEGIN
	-- CAP NHAT LAI TRANG THAI CAN HO SAU KHI HOP DONG THUE BAT DAU
    UPDATE Unit 
    SET Status = 'Rented'
    WHERE Unit_ID = NEW.Unit_ID;
END//
DELIMITER ;
