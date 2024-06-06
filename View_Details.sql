CREATE VIEW Invoice_Details AS
SELECT p.Payment_ID, p.Date AS Payment_Date, p.Amount AS Payment_Amount, p.Payment_Type, l.Lease_ID, t.Tenant_ID, t.Tenant_Name, t.Phone_Number, t.Email, u.Unit_ID, u.Number AS Unit_Number, u.Floor AS Unit_Floor, u.Rent AS Unit_Rent
FROM Payment p
JOIN Lease l ON p.Lease_ID = l.Lease_ID
JOIN Tenant t ON l.Tenant_ID = t.Tenant_ID
JOIN Unit u ON l.Unit_ID = u.Unit_ID;

GRANT SELECT ON qlcc.Invoice_Details TO tenant_role;