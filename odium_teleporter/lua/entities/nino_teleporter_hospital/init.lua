--[[
  _____ ___    _      ___         _   __              ___        _  _ _          
 |_   _| _ \  (_)    / __|_  _ __| |_ \_\ _ __  ___  | _ )_  _  | \| (_)_ _  ___ 
   | | |  _/   _     \__ \ || (_-<  _/ -_) '  \/ -_) | _ \ || | | .` | | ' \/ _ \
   |_| |_|    (_)    |___/\_, /__/\__\___|_|_|_\___| |___/\_, | |_|\_|_|_||_\___/
                          |__/                            |__/                   
--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:SetMaterial("models/effects/vol_light001")
	self:SetColor(Color(255, 255, 255, 0))	
	self:PhysicsInit(SOLID_VPHYSICS) 
	self:SetMoveType(MOVETYPE_NONE) 
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Touch(ent)
    if not ent:IsPlayer() then return end

	if not isnumber(player.nino_teleporter_hospital_antispam) then player.nino_teleporter_hospital_antispam = 0 end
	if player.nino_teleporter_hospital_antispam > CurTime() then return end
	player.nino_teleporter_hospital_antispam = CurTime() + 2
    Nino_Teleporter_TeleportToHospital(ent)
end