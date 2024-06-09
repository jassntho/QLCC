USE QLCC;
GO

CREATE TRIGGER TR_AMENITY_BeforeDelete
ON Amenity
INSTEAD OF DELETE
AS
BEGIN
    -- Update information for all bookings associated with the deleted amenity
    UPDATE Booking
    SET Amenity_ID = NULL, Tenant_ID = NULL, Cost = 0
    WHERE Amenity_ID IN (SELECT Amenity_ID FROM deleted);

    -- Proceed to delete the amenity
    DELETE FROM Amenity
    WHERE Amenity_ID IN (SELECT Amenity_ID FROM deleted);
END;
GO