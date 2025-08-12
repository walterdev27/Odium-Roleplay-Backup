-- [[ Create the SQL table ]] --
hook.Add("Initialize", "ZLS:JobTimer:CreateSQLTable", ZLS.JobTimer.CreateTables)

-- [[ Call the check player time function1 ]] --
local checkPlayerTimeHooks = {
    ["PlayerChangedTeam"] = function(ply, old, new)
        if not IsValid(ply) or not isnumber(new) then return end

        ply:ZLSJobTimer_CheckPlayerTime(team.GetName(old))
        ply:ZLSJobTimer_CheckPlayerTime(team.GetName(new))
    end,
    ["PlayerDisconnected"] = function(ply)
        if not IsValid(ply) then return end

        ply:ZLSJobTimer_CheckPlayerTime(team.GetName(ply:Team()))
    end,
    ["PlayerInitialSpawn"] = function(ply)
        if not IsValid(ply) then return end

        ply:ZLSJobTimer_CheckPlayerTime(team.GetName(ply:Team()))
    end,
    ["ShutDown"] = function()
        for k,v in ipairs(player.GetAll()) do
            if not IsValid(v) then continue end
            
            v:ZLSJobTimer_CheckPlayerTime(team.GetName(v:Team()))
        end
    end
}

for hookName, callback in pairs(checkPlayerTimeHooks) do

    hook.Add(hookName, "ZLS:JobTimer:CheckPlayerTime", callback)
end

-- [[ Command for open the menu ]] --
util.AddNetworkString("ZLS:JobTimer:OpenMenu")
hook.Add("PlayerSay", "ZLS:Jobtimer:OpenMenu", function(ply, text)
    if not IsValid(ply) then return end

    text = text:Trim()

    if text ~= ZLS.JobTimer.Config.Command then return end

    if not ply:ZLSJobTimer_CanOpenMenu() then return DarkRP.notify(ply, 1, 5, "Vous n'avez pas les permissions d'ouvrir cela !") end

    local timeList = ply:ZLSJobTimer_GetTimesList()
    
    local compress = ZLS.JobTimer.Compress(timeList)
    net.Start("ZLS:JobTimer:OpenMenu")
        net.WriteUInt(#compress, 32)
        net.WriteData(compress, #compress)
    net.Send(ply)    

    return tbl
end)