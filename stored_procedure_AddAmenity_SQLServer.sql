USE QLCC;
GO

CREATE PROCEDURE AddAmenity 
  @prop_id CHAR(4),
  @amenity_name VARCHAR(50),
  @description TEXT
AS
BEGIN
  INSERT INTO Amenity (Property_ID, Amenity_Name, Description)
  VALUES (@prop_id, @amenity_name, @description);
END;
GO