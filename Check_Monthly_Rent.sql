DELIMITER //
CREATE TRIGGER Check_Monthly_Rent BEFORE INSERT ON Lease
FOR EACH ROW
BEGIN
    IF NEW.Monthly_Rent < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Monthly_Rent can not be less than 0';
    END IF;
END//
DELIMITER ;
