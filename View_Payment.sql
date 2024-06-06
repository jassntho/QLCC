CREATE VIEW Payment_View AS
SELECT Payment_ID, Lease_ID, Date, Payment_Type
FROM Payment;

-- Thu hồi quyền SELECT trên bảng Payment từ tenant_role
REVOKE SELECT ON qlcc.Payment FROM tenant_role;

-- Cấp quyền SELECT trên view Payment_View cho tenant_role
GRANT SELECT ON qlcc.Payment_View TO tenant_role;

