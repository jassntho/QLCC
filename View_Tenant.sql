CREATE VIEW Current_Tenants AS
SELECT t.Tenant_ID, t.Tenant_Name, t.Phone_Number, t.Email, t.Date_of_Birth, t.Unit_Owner, l.Unit_ID, l.Start_Date, l.End_Date
FROM Tenant t
JOIN Lease l ON t.Tenant_ID = l.Tenant_ID
WHERE l.End_Date >= CURDATE();

GRANT SELECT ON qlcc.Current_Tenants TO tenant_role;


