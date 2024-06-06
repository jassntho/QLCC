CREATE VIEW Amenity_Booking_Count AS
SELECT a.Amenity_ID, a.Amenity_Name, COUNT(b.Booking_ID) AS Booking_Count
FROM Amenity a
LEFT JOIN Booking b ON a.Amenity_ID = b.Amenity_ID
GROUP BY a.Amenity_ID, a.Amenity_Name;

GRANT SELECT ON qlcc.Amenity_Booking_Count TO tenant_role;