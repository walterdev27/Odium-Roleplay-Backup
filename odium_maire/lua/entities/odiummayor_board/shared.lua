ENT.Type         = "anim"
ENT.Base         = "base_gmodentity"

ENT.PrintName    = "Tableau"
ENT.Category     = "ODIUM | Maire"

ENT.Spawnable    = true
ENT.AdminOnly    = true

ENT.RenderGroup  = RENDERGROUP_BOTH

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "PoliticalRegime")
	self:NetworkVar("Float", 0, "MayorTaxes")
	self:NetworkVar("Int", 0, "LockerMoney")
end
