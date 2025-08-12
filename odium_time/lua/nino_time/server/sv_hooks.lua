util.AddNetworkString("NinoTime:ClientChat")

--[[ When a player is making the time command ]]--
hook.Add("PlayerSay", "NinoTime:PlayerSay", function(pPlayer, sText)
    if not IsValid(pPlayer) or not isstring(sText) then return end

    if sText:Trim():lower():StartWith(NinoTime.Config.PlayerCommand) then
        local iTime = 0
        local sAnswer = "Vous avez actuellement %s de temps de jeu !"

        local tExplode = string.Explode(" ", sText:Trim())
        local sTarget = tExplode[2]
        if isstring(sTarget) then
            sTarget = sTarget:Trim()

            local pTarget = player.GetBySteamID(sTarget)
            if not IsValid(pTarget) then return pPlayer:PrintMessage(HUD_PRINTTALK, "Ce SteamID est introuvable sur le serveur !") end

            iTime = pTarget:GetPlayTime()
            sAnswer = "Le joueur a actuellement %s de temps de jeu !"
        else 
            iTime = pPlayer:GetPlayTime()
        end

        if not isnumber(iTime) then return "" end
        sAnswer = sAnswer:format( NinoTime:FormatTime(iTime) )

        net.Start("NinoTime:ClientChat")
            net.WriteString(sAnswer)
        net.Send(pPlayer)

        return ""
    end
end)

--[[ Initialize playtimer timer ]]--
hook.Add("PlayerLoadout", "NinoTime:PlayerInitialSpawn", function(pPlayer)
    if not IsValid(pPlayer) then return end
    if timer.Exists("NinoTime:PlayTimeTimer") then return end

    timer.Create("NinoTime:PlayTimeTimer", NinoTime.Config.CooldownTime, 0, function()
        if #player.GetAll() == 0 then return timer.Remove("NinoTime:PlayTimeTimer") end

        for _, p in pairs(player.GetAll()) do
            if not IsValid(p) then continue end
            p:AddPlayTime(NinoTime.Config.CooldownTime)
        end
    end)
end)