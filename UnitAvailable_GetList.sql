USE QLCC
DELIMITER //
CREATE PROCEDURE UnitAvailable_GetList()
BEGIN
-- Hiển thị danh sách căn hộ còn trống
SELECT Unit_ID, Property_ID, Number, Floor, Rent
FROM Unit
WHERE Status = 'Trong';
END
//
DELIMITER ;