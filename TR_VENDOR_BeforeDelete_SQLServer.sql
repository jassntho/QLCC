USE QLCC;
GO

CREATE TRIGGER TR_VENDOR_BeforeDelete
ON Vendor
INSTEAD OF DELETE
AS
BEGIN
    -- Cập nhật lại giá tiền sau khi một nhà cung cấp bị xóa
    UPDATE Contract
    SET Vendor_ID = NULL, Cost = 0
    WHERE Vendor_ID IN (SELECT Vendor_ID FROM deleted);

    -- Tiến hành xóa nhà cung cấp
    DELETE FROM Vendor
    WHERE Vendor_ID IN (SELECT Vendor_ID FROM deleted);
END;
GO