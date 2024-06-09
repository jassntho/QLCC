USE QLCC;
GO

CREATE PROCEDURE BookAmenity 
  @tenant_id CHAR(4),
  @amenity_id CHAR(4),
  @start_time DATETIME,
  @end_time DATETIME
AS
BEGIN
    -- Chèn dữ liệu đặt chỗ
    INSERT INTO Booking (Tenant_ID, Amenity_ID, Start_Time, End_Time)
    VALUES (@tenant_id, @amenity_id, @start_time, @end_time);
END;
GO