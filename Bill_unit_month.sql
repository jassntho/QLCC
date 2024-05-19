DELIMITER //
CREATE PROCEDURE Bill_unit_month(IN UnitID INT, IN monthBill INT, IN yearBill INT)
BEGIN
-- Hiển thị hóa đơn 1 tháng của căn hộ
    DECLARE rent DECIMAL(10,2);
    DECLARE serviceCost DECIMAL(10,2);
    DECLARE amenityCost DECIMAL(10,2);
    SELECT Rent INTO rent FROM Unit WHERE Unit_ID = UnitID;
    SELECT SUM(Cost) INTO serviceCost 
    FROM Contract 
    WHERE Property_ID IN (
		SELECT Property_ID 
        FROM Unit 
        WHERE Unit_ID = UnitID 
        AND YEAR(Contract.Start_Date) = yearBill 
        AND MONTH(Contract.Start_Date) = monthBill
	);
    SELECT SUM(Cost) INTO amenityCost 
    FROM Booking 
    WHERE Tenant_ID IN (
        SELECT Tenant_ID 
        FROM Lease 
        WHERE Unit_ID = UnitID
        AND YEAR(Booking.Start_Date) = yearBill 
        AND MONTH(Booking.Start_Date) = monthBill
    );
    UPDATE Payment
        SET Amount = rent + serviceCost + amenityCost
        WHERE Lease_ID IN (
            SELECT Lease_ID
            FROM Lease 
            WHERE Unit_ID = unitID 
            AND YEAR(Start_Date) = yearBill 
            AND MONTH(Start_Date) = monthBill
        );
END //
DELIMITER ;