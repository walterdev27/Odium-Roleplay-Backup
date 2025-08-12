ENT.Type         = "anim"
ENT.Base         = "base_gmodentity"

ENT.PrintName    = "Coffre-fort"
ENT.Category     = "ODIUM | Maire"

ENT.Spawnable    = true
ENT.AdminOnly    = true

ENT.RenderGroup  = RENDERGROUP_BOTH

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Money")
	self:NetworkVar("Int", 1, "LockerState")
	self:NetworkVar("Int", 2, "LockerTimer")
	self:NetworkVar("Int", 3, "RestrictAccess")
	self:NetworkVar("Int", 4, "RestrictAccessTimer")
	self:NetworkVar("Int", 5, "LockerHealth")
end
