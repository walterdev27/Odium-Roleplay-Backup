ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Armory"
ENT.Author = ""
ENT.Category = "ODIUM | Armory"
ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "IsRobable")
	self:NetworkVar("Bool", 1, "Reload")
	self:NetworkVar("Int", 0, "Status")
end
