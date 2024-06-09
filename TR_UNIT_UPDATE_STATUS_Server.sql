USE QLCC;
GO

CREATE TRIGGER TR_UNIT_UPDATE_STATUS
ON Lease
AFTER INSERT
AS
BEGIN
    -- Cập nhật lại trạng thái căn hộ sau khi hợp đồng thuê bắt đầu
    UPDATE Unit
    SET Status = 'Rented'
    WHERE Unit_ID IN (SELECT Unit_ID FROM inserted);
END;
GO