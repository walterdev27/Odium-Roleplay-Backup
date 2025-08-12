AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/nino_atm/nino_atm.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:SpawnFunction(ply, tr, class)
	if not tr.Hit then return end
	
	local spawnAng = ply:EyeAngles()
	spawnAng.p = 0
	spawnAng.y = spawnAng.y + 180

	local ent = ents.Create(class)
	ent:SetPos(tr.HitPos + tr.HitNormal * 16)
	ent:SetAngles(spawnAng)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Use(activator)
	if !IsValid(activator) or !activator:IsPlayer() then return end
	if self:GetPos():DistToSqr(activator:GetPos()) > 5000 then return false end
	
	activator.checkSpamA = activator.checkSpamA or 0
	if activator.checkSpamA > CurTime() then return end
	activator.checkSpamA = CurTime() + 2
	
	net.Start("OdiumATM::Networking")
		net.WriteString("ATMOpenFrame")
		net.WriteEntity(self)
	net.Send(activator)
end