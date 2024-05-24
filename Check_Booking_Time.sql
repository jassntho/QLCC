--Trigger kiểm tra xem thời gian kết thúc phải sau thời gian bắt đầu khi thêm một Booking mới
DELIMITER //
CREATE TRIGGER Check_Booking_Time 
BEFORE INSERT ON Booking
FOR EACH ROW
BEGIN
    IF NEW.End_Time <= NEW.Start_Time THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'End time must be after start time';
    END IF;
END//
DELIMITER ;