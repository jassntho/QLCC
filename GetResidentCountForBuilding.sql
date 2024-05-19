USE QLCC
DELIMITER //
CREATE FUNCTION GetResidentCountForBuilding(BuildingID INT, p_year INT) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE sltenant_count INT;
    -- Tính số lượng cư dân bằng cách đếm số lượng tenant mà có hợp đồng thuê tại các unit của tòa nhà trong năm
    SELECT COUNT(DISTINCT Tenant_ID) INTO sltenant_count
    FROM Lease
    WHERE Unit_ID IN (
        SELECT Unit_ID
        FROM Unit
        WHERE Property_ID = buildingID
    ) AND YEAR(Start_Date) = p_year;
    RETURN sltenant_count;
END //
DELIMITER ;