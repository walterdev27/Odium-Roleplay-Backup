Anti_Noclip = Anti_Noclip or {}
Anti_Noclip.Config = Anti_Noclip.Config or {}

Anti_Noclip.Config.AdminsRank = {
	["admin"] = true,
	["Moderateur"] = true,
	["Moderateur Test"] = true,
    ["Helpeur"] = true,
}

Anti_Noclip.Config.JobsStaff = {
    ["Staff"] = true
}


hook.Add("PlayerNoClip", "Odium:AntiStaff:NoClip", function(ply)
    if MyLib.AllPerm[ply:GetUserGroup()] then return true end
    if Anti_Noclip.Config.AdminsRank[ply:GetUserGroup()] then 
        if not Anti_Noclip.Config.JobsStaff[ply:getDarkRPVar("job")] then DarkRP.notify(ply, 1, 5, "Tu n'es pas dans le métier staff !") return false end
        return true
    end
end)

--[[hook.Add("PlayerSay", "Odium:AntiStaff:PlayerSay", function(ply, text)
    if MyLib.AllPerm[ply:GetUserGroup()] then return true end
    if Anti_Noclip.Config.AdminsRank[ply:GetUserGroup()] then 
        if text == "!staff" then
            if not Anti_Noclip.Config.JobsStaff[ply:getDarkRPVar("job")] then DarkRP.notify(ply, 1, 5, "Tu n'es pas dans le métier staff !") return false end
        end
    end
end)]]

hook.Add("PlayerChangedTeam", "Odium:AntiStaff:ChangeTeam", function(ply, old, new)
    if MyLib.AllPerm[ply:GetUserGroup()] then return true end
    if Anti_Noclip.Config.AdminsRank[ply:GetUserGroup()] then 
        if Anti_Noclip.Config.JobsStaff[team.GetName(old)] then
            ply:SetMoveType(MOVETYPE_WALK)
            ply:SetCollisionGroup(COLLISION_GROUP_NONE)
        end
    end
end)