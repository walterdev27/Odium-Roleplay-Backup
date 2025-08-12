AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(Odium_Mayor.Config.NPCModel)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:SetBloodColor(BLOOD_COLOR_RED)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE, CAP_TURN_HEAD)
	self:SetMaxYawSpeed(90)
	self:DropToFloor()
end

function ENT:SpawnFunction(ply, tr, class)
	if not tr.Hit then return end
	
	local ang = ply:EyeAngles()
	ang.p = 0
	ang.y = ang.y + 180

	local ent = ents.Create(class)
	ent:SetPos(tr.HitPos + tr.HitNormal * 16)
	ent:SetAngles(ang)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Use(act)
	if not IsValid(act) or not act:IsPlayer() then return end

	if act:GetNWBool("LockerRobbed") == true then
		act:addMoney(act.lockerMoney)
		DarkRP.notify(act, 0, 4, "Vous venez de gagner "..DarkRP.formatMoney(act.lockerMoney).." avec le braquage du coffre du maire !")
		act.lockerMoney = 0
		act:SetNWBool("LockerRobbed", false)
	end
end