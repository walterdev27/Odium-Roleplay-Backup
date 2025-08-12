AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mayortablet_odium/mayortablet_odium.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetUseType(SIMPLE_USE)
	--self:DropToFloor()

	--local phys = self:GetPhysicsObject()
	--if phys:IsValid() then
	--	phys:Wake()
	--end
end

function ENT:SpawnFunction(ply, tr, class)
	if not tr.Hit then return end
	
	local ang = ply:EyeAngles()
	ang.p = 0
	ang.y = ang.y + -90

	local ent = ents.Create(class)
	ent:SetPos(tr.HitPos + tr.HitNormal * 16)
	ent:SetAngles(ang)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Use(act)
	if not IsValid(act) or not act:IsPlayer() then return end
	if not Odium_Mayor.Config.MayorJob[act:getDarkRPVar("job")] then DarkRP.notify(act, 1, 5, "Vous n'avez pas le bon métier") return end

	act.tabletOpening = act.tabletOpening or 0
	if act.tabletOpening > CurTime() then return end
	act.tabletOpening = CurTime() + 2

	net.Start("Odium:Mayor:TabletOpeningDerma")
		net.WriteString(Odium_Mayor.DataTable["Regime"])
	net.Send(act)
end