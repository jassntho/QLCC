DELIMITER //

CREATE TRIGGER UpdatePaymentOnAmenityDeletion
AFTER DELETE ON Amenity
FOR EACH ROW
BEGIN
    -- Cập nhật số tiền trong Payment dựa trên tổng chi phí của các Booking liên quan đến Amenity bị xóa
    UPDATE Payment
    JOIN Lease ON Payment.Lease_ID = Lease.Lease_ID
    JOIN Tenant ON Lease.Tenant_ID = Tenant.Tenant_ID
    JOIN Booking ON Tenant.Tenant_ID = Booking.Tenant_ID
    SET Payment.Amount = Payment.Amount - (SELECT SUM(Booking.Cost) FROM Booking WHERE Booking.Amenity_ID = OLD.Amenity_ID AND Booking.Tenant_ID = Tenant.Tenant_ID)
    WHERE Booking.Amenity_ID = OLD.Amenity_ID;
END//

DELIMITER ;
