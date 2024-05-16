USE QLCC 

DELIMITER //

CREATE PROCEDURE BookAmenity (
  IN tenant_id INT,
  IN amenity_id INT,
  IN start_time DATETIME,
  IN end_time DATETIME
)
BEGIN
      -- Chèn dữ liệu đặt chỗ
       INSERT INTO Booking (Tenant_ID, Amenity_ID,        Start_Time, End_Time)
       VALUES (tenant_id, amenity_id, start_time, end_time);
END//
DELIMITER;

