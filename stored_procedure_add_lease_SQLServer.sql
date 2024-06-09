USE QLCC;
GO

CREATE PROCEDURE add_lease 
  @lease_id CHAR(4),
  @unit_id CHAR(4),
  @tenant_id CHAR(4),
  @start_date DATE,
  @end_date DATE,
  @monthly_rent DECIMAL(10,2),
  @deposit DECIMAL(10,2)
AS
BEGIN
  -- Check if Unit exists and is available
  DECLARE @Unit_Available INT;
  
  SELECT @Unit_Available = COUNT(*)
  FROM Unit
  WHERE Unit_ID = @unit_id
    AND Status = 'Available';

  IF @Unit_Available = 0
  BEGIN
    RAISERROR('Unit is not available for lease', 16, 1);
    RETURN;
  END;

  -- Insert new lease record
  INSERT INTO Lease (
    Lease_ID,
    Unit_ID,
    Tenant_ID,
    Start_Date,
    End_Date,
    Monthly_Rent,
    Deposit
  ) VALUES (
    @lease_id,
    @unit_id,
    @tenant_id,
    @start_date,
    @end_date,
    @monthly_rent,
    @deposit
  );

  -- Update Unit status to 'Rented'
  UPDATE Unit
  SET Status = 'Rented'
  WHERE Unit_ID = @unit_id;
END;
GO