USE QLCC

DELIMITER //

CREATE PROCEDURE CancelLeasesAndUpdateUnits()
BEGIN
    -- Định nghĩa biến để lưu giá trị từ mỗi hàng
    DECLARE v_lease_id INT;

  DECLARE v_unit_id INT;
    
    -- Biến kiểm soát vòng lặp
    DECLARE done INT DEFAULT FALSE;
    
    -- Khai báo cursor cho các hợp đồng thuê hết hạn
    DECLARE lease_cursor CURSOR FOR 
        SELECT Lease_ID, Unit_ID 
        FROM Lease 
        WHERE End_Date < CURDATE();
    
    -- Khai báo handler để kết thúc vòng lặp khi cursor đến cuối tập kết quả
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Mở cursor
    OPEN lease_cursor;
    
    lease_loop: LOOP
        FETCH lease_cursor INTO v_lease_id, v_unit_id;
        IF done THEN
            LEAVE lease_loop;
        END IF;
        
        -- Hủy hợp đồng thuê bằng cách cập nhật trạng thái
        DELETE FROM Lease
        WHERE Lease_ID = v_lease_id;
        
        -- Cập nhật trạng thái của căn hộ thành 'Available'
        UPDATE Unit
        SET Status = 'Available'
        WHERE Unit_ID = v_unit_id;
        
    END LOOP;
    
    -- Đóng cursor
    CLOSE lease_cursor;
END//

DELIMITER ;
