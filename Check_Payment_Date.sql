--Trigger này sẽ kiểm tra xem ngày thanh toán không được trước ngày bắt đầu của hợp đồng thuê.
DELIMITER //
CREATE TRIGGER Check_Payment_Date 
BEFORE INSERT ON Payment
FOR EACH ROW
BEGIN
    DECLARE lease_start_date DATE;
    SELECT Start_Date INTO lease_start_date
    FROM Lease
    WHERE Lease_ID = NEW.Lease_ID;
    
    IF NEW.Date < lease_start_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment date cannot be before lease start date';
    END IF;
END//
DELIMITER ;