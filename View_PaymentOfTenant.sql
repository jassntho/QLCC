CREATE VIEW Tenant_Payment_Details AS
SELECT p.Payment_ID, p.Date AS Payment_Date, p.Amount AS Payment_Amount, p.Payment_Type, t.Tenant_ID, t.Tenant_Name, t.Phone_Number, t.Email
FROM Payment p
JOIN Lease l ON p.Lease_ID = l.Lease_ID

JOIN Tenant t ON l.Tenant_ID = t.Tenant_ID;
GRANT SELECT ON qlcc.Tenant_Payment_Details TO tenant_role;