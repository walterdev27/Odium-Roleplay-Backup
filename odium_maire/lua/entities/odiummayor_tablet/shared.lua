ENT.Type         = "anim"
ENT.Base         = "base_gmodentity"

ENT.PrintName    = "Tablette"
ENT.Category     = "ODIUM | Maire"

ENT.Spawnable    = true
ENT.AdminOnly    = true

ENT.RenderGroup  = RENDERGROUP_BOTH

function ENT:SetupDataTables()
	--self:NetworkVar("Entity", 0, "owning_ent")
end
