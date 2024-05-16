USE QLCC

DELIMITER //
CREATE PROCEDURE AddAmenity (
  IN prop_id INT,
  IN amenity_name VARCHAR(50),
  IN description TEXT
)
BEGIN
  INSERT INTO Amenity (Property_ID, Name, Description)
  VALUES (property_id, amenity_name, description);
END//
DELIMITER ;
