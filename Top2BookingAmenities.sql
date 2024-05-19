USE QLCC
DELIMITER //
CREATE PROCEDURE Top2BookingAmenities(IN p_month INT)
BEGIN
	-- Định nghĩa biến để lưu giá trị từ mỗi hàng
    DECLARE done INT DEFAULT FALSE;
    DECLARE amenityID INT;
    DECLARE amenityName VARCHAR(50);
    DECLARE bookingCount INT;
    -- Khai báo cursor
    DECLARE cur CURSOR FOR
        SELECT Amenity_ID, Name
        FROM Amenity;
	-- Khai báo handler để kết thúc vòng lặp khi cursor đến cuối tập kết quả
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Tạo bảng tạm thời để lưu trữ kết quả
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_top_amenities (
        Amenity_ID INT,
        Name VARCHAR(255),
        Booking_Count INT
    );
	-- Mở cursor
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO amenityID, amenityName;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Đếm số lượng booking cho mỗi tiện ích trong tháng được chỉ định
        SET bookingCount = (
            SELECT COUNT(*)
            FROM Booking
            WHERE Amenity_ID = amenityID
            AND MONTH(Start_Time) = p_month
        );

        -- Thêm kết quả vào bảng tạm thời
        INSERT INTO temp_top_amenities (Amenity_ID, Name, Booking_Count)
        VALUES (amenityID, amenityName, bookingCount);
    END LOOP;

    CLOSE cur;

    -- Lấy ra top 2 tiện ích có số lượng booking cao nhất
    SELECT Amenity_ID, Name, Booking_Count
    FROM temp_top_amenities
    ORDER BY Booking_Count DESC
    LIMIT 2;

    -- Xóa bảng tạm thời sau khi sử dụng
    DROP TEMPORARY TABLE IF EXISTS temp_top_amenities;
END //
DELIMITER ;