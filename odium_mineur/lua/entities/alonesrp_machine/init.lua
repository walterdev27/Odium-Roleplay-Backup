AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:StopPlayingSound()
	if self.soundEngine then
		self.soundEngine:Stop()
		self.soundEngine = nil
	end
end

function ENT:Initialize()
	self:SetModel("models/alonesrp_mining/ams2/industrial_furnace.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self:SetMachineState(0)
	self:SetMachineTimer(0)

	self.playerGetter = nil
	self.cartCount = 0
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
--ambient/materials/cartrap_rope2.wav
function ENT:Think()
	if self:GetMachineState() == 1 then
		self.soundEngine = AlonesRP.PlaySound(self, "ambient/materials/cartrap_rope2.wav", 1, true)

		if CurTime() > self:GetMachineTimer() then
			self:SetMachineTimer(0)
			self:SetMachineState(0)

			local entCart = ents.Create("alonesrp_cart")
			entCart:SetPos(self:GetPos() + Vector(-100, 0, 30))
			entCart:SetAngles(Angle(0, 180, 0))
			entCart:CPPISetOwner(self.playerGetter)
			entCart:Spawn()

			self.playerGetter:addMoney(self.cartCount * AlonesRP_Mining.RockPrice)
			DarkRP.notify(self.playerGetter, 0, 5, "Vous venez de gagner "..DarkRP.formatMoney(self.cartCount * AlonesRP_Mining.RockPrice).." pour avoir traité vos "..self.cartCount.." pierres")

			self.cartCount = 0
			self.playerGetter = nil
			self:StopPlayingSound()
		end
	end
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "alonesrp_cart" then
		if self:GetMachineState() == 1 then return end
		if ent:GetCartCount() > 0 then
			self.playerGetter = AlonesRP.GetPickedPlayers(ent) or ent:CPPIGetOwner()
			self.cartCount = ent:GetCartCount()

			ent:Remove()

			self:SetMachineState(1)
			self:SetMachineTimer(CurTime() + AlonesRP_Mining.MachineTimer)

			DarkRP.notify(self.playerGetter, 0, 5, "Vos pierres sont en préparation pendant "..AlonesRP_Mining.MachineTimer.." secondes")
		end
	end
end