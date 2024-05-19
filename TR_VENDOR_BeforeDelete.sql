USE QLCC
DELIMITER //
CREATE TRIGGER TR_VENDOR_BeforeDelete
BEFORE DELETE ON Vendor
FOR EACH ROW
BEGIN
-- Cập nhật lại giá tiền sau khi một nhà cung cấp bị xóa
UPDATE Contract
SET Vendor_ID = NULL, Cost = 0
WHERE Vendor_ID = OLD.Vendor_ID;
END //
DELIMITER ;