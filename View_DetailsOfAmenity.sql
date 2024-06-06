CREATE VIEW Amenity_Details AS
SELECT a.Amenity_ID, a.Amenity_Name, a.A_Description, p.Property_ID, p.Property_Name, p.Property_Address
FROM Amenity a
JOIN Property p ON a.Property_ID = p.Property_ID;

GRANT SELECT ON qlcc.Amenity_Details TO tenant_role