USE QLCC
DELIMITER //
CREATE TRIGGER TR_Tenant_BeforeUpdate
BEFORE UPDATE ON Tenant
FOR EACH ROW
BEGIN
 IF DATEDIFF(CURDATE(), NEW.Date_of_Birth) < 6570 THEN
 -- Mã trạng thái thông báo lỗi --
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'Tenant must be at least 18 years old.';
 END IF;
END //
DELIMITER ;