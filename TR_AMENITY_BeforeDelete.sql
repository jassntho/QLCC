USE QLCC

DELIMITER //
CREATE TRIGGER TR_AMENITY_BeforeDelete
BEFORE DELETE ON Amenity
FOR EACH ROW
BEGIN
-- Update information for all products supplied by the deleted supplier
	UPDATE Booking
	SET Amenity_ID = NULL, Tenant_ID = NULL
	WHERE Amenity_ID = OLD.Amenity_ID;
END //
DELIMITER ;

