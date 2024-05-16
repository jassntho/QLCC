DELIMITER //
CREATE FUNCTION Rented_Unit_CountByYear(target_year INT)
RETURNS INT
DETERMINISTIC -- ket qua ham chi phu thuoc vao target_year
READS SQL DATA
BEGIN
	DECLARE total_rented INT;
    
    SELECT COUNT(*) INTO total_rented
    FROM Lease
    WHERE year(Start_Date) = target_year;
    
    RETURN total_rented;
END//
DELIMITER ;
