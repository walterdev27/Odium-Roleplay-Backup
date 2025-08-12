AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mayorboard_odium/mayorboard_odium.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	--self:DropToFloor()

	--local phys = self:GetPhysicsObject()
	--if phys:IsValid() then
	--	phys:Wake()
	--end
	
	self:SetPoliticalRegime("")
	self:SetMayorTaxes(0.99)
	self:SetLockerMoney(0)
end

function ENT:SpawnFunction(ply, tr, class)
	if not tr.Hit then return end
	
	local ang = ply:EyeAngles()
	ang.p = 0
	ang.y = ang.y + 90

	local ent = ents.Create(class)
	ent:SetPos(tr.HitPos + tr.HitNormal * 16)
	ent:SetAngles(ang)
	ent:Spawn()
	ent:Activate()

	return ent
end
