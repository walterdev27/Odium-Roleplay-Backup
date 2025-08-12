AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("Zatlas:Cooldowns")

function ENT:Initialize()
	self:SetModel(ZatlasLock.NPCModel)
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	local sequence = self:LookupSequence( "cower" )
	self:SetSequence( sequence )
end

function ENT:OnTakeDamage()
    return 0    
end

function ENT:Use(act, ply) 
	if not act:IsPlayer() then return end
	if not IsValid(act) then return end
	if ply:GetNWBool("Zatlas:IsStolen") then
		if table.HasValue(ZatlasLock.AllowedTeams, ply:Team()) then
			--if not ent:getDoorOwner() == ply:Nick() then
				for ind, ent in pairs(ents.FindInSphere(self:GetPos(), 15 ^ 2)) do
			        if ent:GetClass() == "prop_vehicle_jeep" then 
			            ent:Remove()
			            ply:SetNWBool("Zatlas:IsStolen", false)
			            local delay = ZatlasLock.TimeAfterSentece
			            timer.Simple(delay, function()
	        				if not IsValid(ply) then return end
				            local rand = math.random(ZatlasLock.PriceLower, ZatlasLock.PriceHiger)
				            DarkRP.notify(ply, 2 , 4, "Vous avez vendu le véhicule ! Vous remportez "..DarkRP.formatMoney(rand).." !")
				            ply:addMoney(rand)
				            hook.Remove("HUDPaint", "ZatlasLock:PaintTimeLeft")
				        end)
				    	net.Start("Zatlas:Cooldowns")
						    net.WriteUInt(delay, 8)
						net.Send(ply)
			        end
		    	end
			--end
		else
			DarkRP.notify(ply, 2 , 4, "Vous ne pouvez pas voler un véhicule avec votre métier !")
		end
	else
		DarkRP.notify(ply, 1 , 2, "Casse toi !")
	end
end

util.AddNetworkString("Zatlas:DrawInformations")
hook.Add("onLockpickCompleted", "Zatlas:OnLockPicking", function(ply, success, ent)
	if not ply:IsPlayer() then return end
	if not IsValid(ply) then return end
	if ent:GetClass()!= "prop_vehicle_jeep" then return end
 	if table.HasValue(ZatlasLock.AllowedTeams, ply:Team()) then
		if ent:GetClass() == "prop_vehicle_jeep" && success then
			ply:SetNWBool("Zatlas:IsStolen", true)
			net.Start("Zatlas:DrawInformations")
				net.WriteBool(success)
			net.Send(ply)
			DarkRP.notify(ply, 2 , 4, "Un point vous a été donner pour vendre le véhicule volé !")
		end
	else
		DarkRP.notify(ply, 2 , 4, "Vous ne pouvez pas voler un véhicule avec votre métier !")
	end
end)