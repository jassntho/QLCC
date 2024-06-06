ALTER TABLE Tenant ADD COLUMN Password VARCHAR(255);

CREATE VIEW Tenant_View AS
SELECT Tenant_ID, Tenant_Name, Phone_Number, Email, Date_of_Birth, Unit_Owner
FROM Tenant;

-- Thu hồi quyền SELECT trên bảng Tenant từ tenant_role
REVOKE SELECT ON qlcc.Tenant FROM tenant_role;

-- Cấp quyền SELECT trên view Tenant_View cho tenant_role
GRANT SELECT ON qlcc.Tenant_View TO tenant_role;

