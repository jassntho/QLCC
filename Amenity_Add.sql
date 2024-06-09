USE QLCC;

DELIMITER //

CREATE PROCEDURE AddAmenity(
    IN p_Amenity_ID CHAR(4),
    IN p_Property_ID CHAR(4),
    IN p_Amenity_Name VARCHAR(50),
    IN p_Description TEXT
)
BEGIN
    INSERT INTO Amenity (Amenity_ID, Property_ID, Amenity_Name, Description)
    VALUES (p_Amenity_ID, p_Property_ID, p_Amenity_Name, p_Description);
END //

DELIMITER ;
