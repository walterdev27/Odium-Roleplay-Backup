util.AddNetworkString("MonAddonAdmin:HealPlayer")
util.AddNetworkString("MonAddonAdmin:FeedPlayer")
util.AddNetworkString("MonAddonAdmin:KillPlayer")
util.AddNetworkString("MonAddonAdmin:FreezePlayer")
util.AddNetworkString("MonAddonAdmin:UpdateFreezeState")
util.AddNetworkString("MonAddonAdmin:SetPlayerJob")
util.AddNetworkString("MonAddonAdmin:TeleportToCar")
util.AddNetworkString("MonAddonAdmin:TeleportToPlayer")

-- Soigner
net.Receive("MonAddonAdmin:HealPlayer", function(len, ply)
    if not ply:IsAdmin() then return end
    local target = net.ReadEntity()
    if not target or not target:IsValid() or not target:IsPlayer() then return end

    target:SetHealth(target:GetMaxHealth()) 
end)
-- Nourir
net.Receive("MonAddonAdmin:FeedPlayer", function(len, ply)
    if not ply:IsAdmin() then return end
    local target = net.ReadEntity()
    if not target or not target:IsValid() or not target:IsPlayer() then return end

    target:setDarkRPVar("Energy", 100)
end)
-- Kill un joueur
net.Receive("MonAddonAdmin:KillPlayer", function(len, ply)
    if not ply:IsAdmin() then return end
    local target = net.ReadEntity()
    if not target or not target:IsValid() or not target:IsPlayer() then return end

    target:Kill()
end)
-- Geler le joueur
net.Receive("MonAddonAdmin:FreezePlayer", function(len, ply)
    if not ply:IsAdmin() then return end
    local target = net.ReadEntity()
    if not target or not target:IsValid() or not target:IsPlayer() then return end

    local newFreezeState = not target:IsFrozen()
    target:Freeze(newFreezeState)

    net.Start("MonAddonAdmin:UpdateFreezeState")
    net.WriteEntity(target)
    net.WriteBool(newFreezeState)
    net.Broadcast()
end)
-- Changer de metier
net.Receive("MonAddonAdmin:SetPlayerJob", function(len, ply)
    if not ply:IsAdmin() then return end
    local target = net.ReadEntity()
    local jobID = net.ReadUInt(16)

    if not target or not target:IsValid() or not target:IsPlayer() then return end
    if not RPExtraTeams[jobID] then return end

    target:changeTeam(jobID, true)
end)
-- teleporter a sa voiture
net.Receive("MonAddonAdmin:TeleportToCar", function(len, ply)
    if not ply:IsAdmin() then return end
    local target = net.ReadEntity()
    if not IsValid(target) or not target:IsPlayer() then return end

    local foundCar = false
    for _, ent in ipairs(ents.FindByClass("prop_vehicle_jeep")) do
        if ent:CPPIGetOwner() == target then
            ply:SetPos(ent:GetPos() + Vector(100, 0, 50))
            ply:ChatPrint("Téléporté à la voiture de " .. target:Nick() .. ".")
            foundCar = true
            break
        end
    end

    if not foundCar then
        ply:ChatPrint("Aucune voiture en vue pour " .. target:Nick() .. ".")
    end
end)
-- teleporter a un joueur
net.Receive("MonAddonAdmin:TeleportToPlayer", function(len, ply)
    if not ply:IsAdmin() then return end
    local target1 = net.ReadEntity()
    local target2 = net.ReadEntity()
    if not IsValid(target1) or not target1:IsPlayer() then return end
    if not IsValid(target2) or not target2:IsPlayer() then return end

    local target2Pos = target2:GetPos()
    target1:SetPos(target2Pos + Vector(50, 0, 50))
    ply:ChatPrint("Téléporté " .. target1:Nick() .. " à " .. target2:Nick() .. ".")
end)

