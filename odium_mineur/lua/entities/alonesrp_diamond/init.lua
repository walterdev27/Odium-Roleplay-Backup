AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/alonesrp_mining/ams2/ingot.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetColor(Color(0, 153, 255))

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self:SetDiamondPercent(math.random(1, 75))
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

function ENT:Use(act)
	if not IsValid(act) or not act:IsPlayer() then return end

	act:addMoney(AlonesRP_Mining.DiamondPercentPrice * self:GetDiamondPercent())
	self:Remove()
	DarkRP.notify(act, 0, 5, "Oh ?! Du diamant !!! Tu viens de gagner "..DarkRP.formatMoney(AlonesRP_Mining.DiamondPercentPrice * self:GetDiamondPercent()).." pour une qualité de "..self:GetDiamondPercent().."%")
end