ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Weapon"
ENT.Author = "Jukww2"
ENT.Category = "Odium"
ENT.Spawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Classs")
	self:NetworkVar("String", 1, "WeaponName")
end
