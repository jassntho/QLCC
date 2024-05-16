USE QLCC

DELIMITER //
CREATE FUNCTION Tenant_CountByMonth(tenant_id INT, month_year DATE)
RETURNS INT
BEGIN
    DECLARE amenities_count INT;

    SELECT COUNT(DISTINCT Amenity_ID) INTO amenities_count
    FROM Booking
    WHERE Tenant_ID = tenant_id
    AND YEAR(Start_Time) = YEAR(month_year)
    AND MONTH(Start_Time) = MONTH(month_year);

    RETURN amenities_count;
END//
DELIMITER ;
