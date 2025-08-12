/*
* @Author: Diesel
* @Date:   2023-01-28 22:54:56
* @Last Modified time: 2023-01-28 23:09:19
* @File: init.lua
*/
util.AddNetworkString("SMedic::Frame")
util.AddNetworkString("SMedic::Healing")
util.AddNetworkString("SMedic::SaveNPC")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr, classname)
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create(classname)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Use(act, ply)
	if IsValid(ply) and ply:IsPlayer() then
		net.Start("SMedic::Frame")
		net.Send(ply)
	end
end

-- Messages
net.Receive("SMedic::Healing", function(len, ply)
    local id = net.ReadString()

    if SMedic.TeamDisallow then
        if team.NumPlayers(SMedic.Team) > 0 then return DarkRP.notify(ply,1,5,"Il y a actuellement un médecin en ville") end
    end

    if ply:Health() >= 100 then return DarkRP.notify(ply,1,5,"Tu est en pleine santé") end

    if id == "1" then

    	if not ply:canAfford(SMedic.Cost25) then return DarkRP.notify(ply,1,5,"Vous n'avez pas l'argent necéssaire") end

    	ply:SetHealth(math.Clamp(ply:Health() + 25, 1, 100))

    	ply:addMoney(-SMedic.Cost25)

    end
    if id == "2" then

    	if not ply:canAfford(SMedic.Cost50) then return DarkRP.notify(ply,1,5,"Vous n'avez pas l'argent necéssaire") end

    	ply:SetHealth(math.Clamp(ply:Health() + 50, 1, 100))

    	ply:addMoney(-SMedic.Cost50)

    end
    if id == "3" then

    	if not ply:canAfford(SMedic.Cost100) then return DarkRP.notify(ply,1,5,"Vous n'avez pas l'argent necéssaire") end

    	ply:SetHealth(100)

    	ply:addMoney(-SMedic.Cost100)

    end
end)

local function SpawnOCNPC()
    timer.Simple(.1, function()
        for _, v in pairs(ents.FindByClass("npc_healer")) do v:Remove() end
        local readthefile = file.Read("npc_healer/" .. string.lower(game.GetMap()) .. ".txt", "DATA")
        if not readthefile then return end
        for _, str in pairs(string.Explode("}", readthefile)) do
            if #str <= 1 then return end
            local infos = string.Explode(";", string.sub(str, 2))
            local pos, ang = string.Explode(",", infos[1]), string.Explode(",", infos[2])
            local ent = ents.Create("npc_healer")
            if !IsValid(ent) then return end
            ent:SetPos(Vector(tonumber(pos[1]), tonumber(pos[2]), tonumber(pos[3])))
            ent:SetAngles(Angle(tonumber(ang[1]), tonumber(ang[2]), tonumber(ang[3])))
            ent:DropToFloor()
            ent:Spawn()
            ent:Activate()
        end
        --print('Medic NPC Spawn')
    end)
end

hook.Add("InitPostEntity", "SpawnOCNPCInit", SpawnOCNPC)
hook.Add("PostCleanupMap", "SpawnOCNPCCleanup", SpawnOCNPC)

net.Receive("SMedic::SaveNPC", function(len, ply)
    if not ply:IsSuperAdmin() then return end

    if not file.IsDir("npc_healer", "DATA") then file.CreateDir("npc_healer") end
    local filename = "npc_healer/" .. string.lower(game.GetMap()) .. ".txt"
    if not file.Exists(filename, "DATA") then file.Write(filename, "") end

    file.Write(filename, "")
    for _, ent in pairs(ents.FindByClass("npc_healer")) do
        local pos, ang = ent:GetPos(), ent:GetAngles()
        file.Append(filename, "{" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ";" .. ang.p .. "," .. ang.y .. "," .. ang.r .. "}")
    end
SpawnOCNPC()
end)