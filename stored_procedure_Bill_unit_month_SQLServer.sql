USE QLCC;
GO

CREATE PROCEDURE Bill_unit_month
  @UnitID CHAR(4),
  @monthBill INT,
  @yearBill INT
AS
BEGIN
    -- Hiển thị hóa đơn 1 tháng của căn hộ
    DECLARE @rent DECIMAL(10,2);
    DECLARE @serviceCost DECIMAL(10,2);
    DECLARE @amenityCost DECIMAL(10,2);

    SELECT @rent = Rent 
    FROM Unit 
    WHERE Unit_ID = @UnitID;

    SELECT @serviceCost = SUM(Cost)
    FROM Contract 
    WHERE Property_ID IN (
        SELECT Property_ID 
        FROM Unit 
        WHERE Unit_ID = @UnitID 
    )
    AND YEAR(Start_Date) = @yearBill 
    AND MONTH(Start_Date) = @monthBill;

    SELECT @amenityCost = SUM(Cost)
    FROM Booking 
    WHERE Tenant_ID IN (
        SELECT Tenant_ID 
        FROM Lease 
        WHERE Unit_ID = @UnitID
    )
    AND YEAR(Start_Time) = @yearBill 
    AND MONTH(Start_Time) = @monthBill;

    UPDATE Payment
    SET Amount = @rent + @serviceCost + @amenityCost
    WHERE Lease_ID IN (
        SELECT Lease_ID
        FROM Lease 
        WHERE Unit_ID = @UnitID 
        AND YEAR(Start_Date) = @yearBill 
        AND MONTH(Start_Date) = @monthBill
    );
END;
GO