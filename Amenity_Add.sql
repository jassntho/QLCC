USE QLCC;

DELIMITER //
CREATE PROCEDURE AddAmenity (
  IN prop_id CHAR(4),
  IN amenity_name VARCHAR(50),
  IN description TEXT
)
BEGIN
  INSERT INTO Amenity (Property_ID, Amenity_Name, Description)
  VALUES (prop_id, amenity_name, description);
END//
DELIMITER;
