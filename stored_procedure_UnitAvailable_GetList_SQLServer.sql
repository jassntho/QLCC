USE QLCC;
GO

CREATE PROCEDURE UnitAvailable_GetList
AS
BEGIN
    -- Hiển thị danh sách căn hộ còn trống
    SELECT Unit_ID, Property_ID, Number, Floor, Rent
    FROM Unit
    WHERE Status = 'Trong';
END;
GO