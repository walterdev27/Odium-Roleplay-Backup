ENT.Type         = "ai"
ENT.Base         = "base_ai"

ENT.PrintName    = "NPC Revente"
ENT.Category     = "ODIUM | Maire"

ENT.Spawnable    = true
ENT.AdminOnly    = true

--ENT.RenderGroup  = RENDERGROUP_BOTH

ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()
	--self:NetworkVar("Entity", 0, "owning_ent")
end

function ENT:SetAutomaticFrameAdvance(bUsingAnim)
	self.AutomaticFrameAdvance = bUsingAnim
end
