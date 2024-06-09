USE QLCC;

DELIMITER //

CREATE PROCEDURE AddAmenityAndUpdateCost(
    IN p_Amenity_ID CHAR(4),
    IN p_Property_ID CHAR(4),
    IN p_Amenity_Name VARCHAR(50),
    IN p_Description TEXT,
    IN p_Cost DECIMAL(5,2)
)
BEGIN
    -- Thêm tiện ích mới
    INSERT INTO Amenity (Amenity_ID, Property_ID, Amenity_Name, Description)
    VALUES (p_Amenity_ID, p_Property_ID, p_Amenity_Name, p_Description);

    -- Cập nhật giá trong bảng Booking nếu tiện ích đã tồn tại
    UPDATE Booking
    SET Cost = p_Cost
    WHERE Amenity_ID = p_Amenity_ID;
END //

DELIMITER ;
