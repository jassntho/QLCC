DELIMITER //
CREATE PROCEDURE add_lease (
  IN lease_id INT,
  IN unit_id INT,
  IN tenant_id INT,
  IN start_date DATE,
  IN end_date DATE,
  IN monthly_rent DECIMAL(10,2),
  IN deposit DECIMAL(10,2)
)
BEGIN
  -- Check if Unit exists and is available
  DECLARE Unit_Available INT;
  SELECT COUNT(*) INTO Unit_Available
  FROM Unit
  WHERE Unit_ID = unit_id
    AND Status = 'Available';

  IF Unit_Available = 0 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unit is not available for lease' ;
  END IF;

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
    lease_id,
    unit_id,
    tenant_id,
    start_date,
    end_date,
    monthly_rent,
    deposit
  );

  -- Update Unit status to 'Occupied'
  UPDATE Unit
  SET Status = 'Rented'
  WHERE Unit_ID = unit_id;
END //
DELIMITER ;


