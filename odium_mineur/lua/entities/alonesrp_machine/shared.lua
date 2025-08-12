ENT.Type         = "anim"
ENT.Base         = "base_gmodentity"

ENT.Author       = ""
ENT.PrintName    = "Briseur de pierre"
ENT.Category     = "ODIUM | Minage"

ENT.Spawnable    = true
ENT.AdminOnly    = true

ENT.RenderGroup  = RENDERGROUP_BOTH

ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "MachineState")
	self:NetworkVar("Int", 1, "MachineTimer")
end

function ENT:SetAutomaticFrameAdvance(bUsingAnim)
	self.AutomaticFrameAdvance = bUsingAnim
end