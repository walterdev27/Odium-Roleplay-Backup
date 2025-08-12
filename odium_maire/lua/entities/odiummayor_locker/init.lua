AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mayorlocker_odium/mayorlocker_odium.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetUseType(SIMPLE_USE)
	--self:DropToFloor()

	--local phys = self:GetPhysicsObject()
	--if phys:IsValid() then
	--	phys:Wake()
	--end

	self:SetMoney(0)
	self:SetLockerState(0)
	self:SetLockerTimer(0)
	self:SetRestrictAccess(0)
	self:SetRestrictAccessTimer(0)
	self:SetLockerHealth(Odium_Mayor.Config.LockerHealth)
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

function ENT:Think()
	if self:GetLockerState() == 1 then
		if CurTime() > self:GetLockerTimer() then
			self:SetLockerState(0)
			self:SetLockerTimer(0)
			self:SetMoney(0)

			self:SetLockerHealth(Odium_Mayor.Config.LockerHealth)

			self:SetPos(self.Pos)
		end
	end

	if self:GetRestrictAccess() == 1 then
		if CurTime() > self:GetRestrictAccessTimer() then
			self:SetRestrictAccess(2)
		end
	end
end

function ENT:Use(act)
	if not IsValid(act) or not act:IsPlayer() then return end
	if not Odium_Mayor.Config.MayorJob[act:getDarkRPVar("job")] then DarkRP.notify(act, 1, 5, "Vous n'avez pas le bon métier") return end

	act.lockerOpening = act.lockerOpening or 0
	if act.lockerOpening > CurTime() then return end
	act.lockerOpening = CurTime() + 2
	
	net.Start("Odium:Mayor:LockerOpeningDerma")
		net.WriteEntity(self)
		net.WriteFloat(Odium_Mayor.DataTable["Taxe"])
	net.Send(act)
end

function ENT:OnTakeDamage(dmg)
	if self:GetLockerState() == 1 then return end
	if self:GetMoney() <= 0 then return end

	local attacker = dmg:GetAttacker()

	if not Odium_Mayor.Config.RobJob[attacker:getDarkRPVar("job")] then DarkRP.notify(attacker, 1, 3, "Vous n'avez pas le bon job") return end

	if attacker:GetActiveWeapon():GetClass() == "tfa_nmrih_asaw" then
		self:SetLockerHealth(self:GetLockerHealth() - dmg:GetDamage())
		print(self:GetLockerHealth())
		if self:GetLockerHealth() <= 0 then
			attacker.lockerMoney = self:GetMoney()
			attacker:SetNWBool("LockerRobbed", true)
			self:SetLockerState(1)
			self:SetMoney(0)
			self:SetLockerTimer(CurTime() + Odium_Mayor.Config.RobberyDelay)

			self.Pos = self:GetPos()
			self:SetPos(self:GetPos() + Vector(0,0,-300))

			for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
				v:SetLockerMoney(0)
			end

			DarkRP.notify(attacker, 1, 3, "Vous venez de braquer le coffre du maire et vous avez un sac contenant "..DarkRP.formatMoney(attacker.lockerMoney))
			
			return 
		end
	end
end