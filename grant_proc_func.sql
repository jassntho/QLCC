
-- manager_role
-- Store Procedures, WITH GRANT OPTION: duoc cap quyen va co the cap quyen lai cho nguoi khac
GRANT EXECUTE ON PROCEDURE QLCC.Bill_unit_month TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE QLCC.UnitAvailable_GetList TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE QLCC.Tenant_GetList TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE QLCC.Amenity_Add TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE QLCC.BookAmenity TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON PROCEDURE QLCC.Add_Lease TO manager_role WITH GRANT OPTION;

-- functions 
GRANT EXECUTE ON FUNCTION QLCC.Rented_Unit_CountByYear TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION QLCC.GetResidentCountForBuilding TO manager_role WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION QLCC.Tenant_CountByMonth TO manager_role WITH GRANT OPTION;

-- tenant-role
-- Store Procedures
GRANT EXECUTE ON PROCEDURE QLCC.Bill_unit_month TO tenant_role;
GRANT EXECUTE ON PROCEDURE QLCC.UnitAvailable_GetList TO tenant_role;
GRANT EXECUTE ON PROCEDURE QLCC.BookAmenity TO tenant_role;

-- functions 
GRANT EXECUTE ON FUNCTION QLCC.Rented_Unit_CountByYear TO tenant_role;
GRANT EXECUTE ON FUNCTION QLCC.GetResidentCountForBuilding TO tenant_role;
GRANT EXECUTE ON FUNCTION QLCC.Tenant_CountByMonth TO tenant_role;
