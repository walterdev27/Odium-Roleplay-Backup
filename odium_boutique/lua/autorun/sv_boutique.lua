concommand.Add("odium", function(ply, cmd, args, argStr)
    if SERVER then
        if IsValid(ply) then return end
        if not DarkRP then return end

        if args[1] == "addmoney" then
            local playerToAdd = args[2]
            if not playerToAdd then return end

            playerToAdd = player.GetBySteamID64(playerToAdd)
            if not playerToAdd then 
                print("Odium Boutique | Le joueur n'a pas été trouvé.")
                return
            end

            local moneyToAdd = tonumber(args[3]) or 100

            playerToAdd:addMoney(moneyToAdd)

            print(playerToAdd:Nick().." a reçu "..DarkRP.formatMoney(moneyToAdd))
            playerToAdd:ChatPrint("\n:information: Reçu de votre achat (BOUTIQUE): \n<hsv>Vous avez reçu "..DarkRP.formatMoney(moneyToAdd).." pour votre achat sur la boutique !</hsv>\n<url>https://odiumlibrary.com/shop/profile</url>")
        end
    end
end)

function InitializeDatabase()
    if not sql.TableExists("player_vape") then
        local query = "CREATE TABLE player_vape (steamid TEXT, pack_name TEXT, pack_amount INTEGER, PRIMARY KEY (steamid, pack_name))"
        sql.Query(query)
    end
end
hook.Add("Initialize", "InitializeDatabase", InitializeDatabase)

function AddVapeToDatabase(ply, packName, packAmount)
    local steamID = ply:SteamID64()

    if not steamID or not packName or not packAmount then return end

    local query = string.format("INSERT OR REPLACE INTO player_vape (steamid, pack_name, pack_amount) VALUES ('%s', '%s', %d)", steamID, packName, packAmount)
    sql.Query(query)
end

function addVapePack(ply, cmd, args)
    local target = args[1]
    local packName = args[2]
    local targetPly = player.GetBySteamID64(target)
    
    if targetPly then
        local packData = BoutiqueOD.VapePacks[packName]
        if packData then
            for _, weaponData in ipairs(packData["Weapons"]) do
                BoutiqueOD:SpawnVapeWeapon(targetPly, weaponData.Class) -- ajouter l'arme au joueur
            end
            AddVapeToDatabase(targetPly, packName, 1) -- ajouter le pack au joueur dans la base de données
            print("Pack ajouté au joueur "..targetPly:Nick().." : "..packName)
        else
            print("Le pack n'existe pas : "..packName)
        end
    else
        if BoutiqueOD.VapePacks[packName] then
            AddVapeToDatabase({SteamID64 = function() return target end}, packName, 1) -- ajouter le pack au joueur dans la base de données même s'il n'est pas sur le serveur
            print("Pack ajouté au joueur hors ligne : " .. target .. " : " .. packName)
        else
            print("Le pack n'existe pas : " .. packName)
        end
    end
end

concommand.Add("odium_addvapepack", addVapePack)

function GivePlayerVapes(ply)
    local steamid = ply:SteamID64()
    local query = string.format("SELECT pack_name, pack_amount FROM player_vape WHERE steamid='%s'", steamid)
    local result = sql.Query(query)
    if result then
        for _, row in ipairs(result) do
            local packName = row.pack_name
            local packAmount = tonumber(row.pack_amount)
            for i = 1, packAmount do
                for _, weaponData in ipairs(BoutiqueOD.VapePacks[packName].Weapons) do
                    BoutiqueOD:SpawnVapeWeapon(ply, weaponData.Class)
                end
            end
        end
    end
end

hook.Add("PlayerSpawn", "SpawnVapeWeaponsOnSpawn", function(ply)
    GivePlayerVapes(ply)
end)

function BoutiqueOD:SpawnVapeWeapon(ply, class)
    local wep = ply:Give(class)
    if BoutiqueOD.VapePacks[class] then
        wep:SetClip1(BoutiqueOD.VapePacks[class].Ammo)
        ply:ChatPrint("Vous avez reçu " .. BoutiqueOD.VapePacks[class].Name .. "!")
    end
end

function GiveVapePacksOnSpawn(ply)
    local steamid = ply:SteamID64()
    local query = string.format("SELECT pack_name, pack_amount FROM player_vape WHERE steamid='%s'", steamid)
    local result = sql.Query(query)
    if result then
        for _, row in ipairs(result) do
            local packName = row.pack_name
            local packAmount = tonumber(row.pack_amount)
            for i = 1, packAmount do
                for _, weaponData in ipairs(BoutiqueOD.VapePacks[packName].Weapons) do
                    BoutiqueOD:SpawnVapeWeapon(ply, weaponData.Class)
                end
            end
        end
    end
end

function SaveVapeWeapons(ply)
    local weapons = {}
    for _, wep in ipairs(ply:GetWeapons()) do
        if BoutiqueOD.VapePacks[wep:GetClass()] then
            table.insert(weapons, wep:GetClass())
        end
    end
    if #weapons > 0 then
        local steamid = ply:SteamID64()
        local query = string.format("UPDATE player_vape SET weapon_data=%s WHERE steamid='%s'", sql.SQLStr(util.TableToJSON(weapons)), steamid)
        sql.Query(query)
    end
end

function LoadVapeWeapons(ply)
    local steamid = ply:SteamID64()
    local query = string.format("SELECT weapon_data FROM player_vape WHERE steamid='%s'", steamid)
    local result = sql.Query(query)
    if result then
        local weapon_data = result[1] and result[1].weapon_data
        if weapon_data then
            local weapons = util.JSONToTable(weapon_data)
            for _, class in ipairs(weapons) do
                BoutiqueOD:SpawnVapeWeapon(ply, class)
            end
        end
    end
end

function RemoveVapePackFromDatabase(ply, packName)
    local steamID = ply:SteamID64()

    if not steamID or not packName then return end

    local query = string.format("UPDATE player_vape SET pack_amount = pack_amount - 1 WHERE steamid = '%s' AND pack_name = '%s'", steamID, packName)
    sql.Query(query)
end

function removeVapePack(ply, cmd, args)
    local target = args[1]
    local packName = args[2]

    if BoutiqueOD.VapePacks[packName] then
        local query = string.format("SELECT pack_amount FROM player_vape WHERE steamid='%s' AND pack_name='%s'", target, packName)
        local result = sql.Query(query)
        
        if result then
            local packAmount = tonumber(result[1].pack_amount) - 1
            if packAmount < 0 then packAmount = 0 end

            query = string.format("UPDATE player_vape SET pack_amount = %d WHERE steamid='%s' AND pack_name='%s'", packAmount, target, packName)
            result = sql.Query(query)

            if result == false then
                print("Erreur lors de la suppression du pack : " .. sql.LastError())
                return
            end

            local targetPly = player.GetBySteamID64(target)
            if targetPly then
                print("Pack retiré du joueur " .. targetPly:Nick() .. " : " .. packName)
            else
                print("Pack retiré du joueur hors ligne : " .. target .. " : " .. packName)
            end
        else
            print("Le joueur n'a pas ce pack : " .. packName)
        end
    else
        print("Le pack n'existe pas : " .. packName)
    end
end

concommand.Add("odium_removevapepack", removeVapePack)



hook.Add("PlayerDeath", "SpawnVapeWeaponsOnDeath", function(ply)
    ply:SetNWBool("player_dead", true)
    timer.Simple(0, function()
        if IsValid(ply) then
            GiveVapePacksOnSpawn(ply)
        end
    end)
end)

hook.Add("PlayerDeath", "SpawnVapeWeaponsOnDeath", function(ply)
    ply:SetNWBool("player_dead", true)
end)

hook.Add("PlayerDisconnected", "SaveVapeWeaponsOnDisconnect", function(ply)
    SaveVapeWeapons(ply)
end)

hook.Add("PlayerInitialSpawn", "GiveVapeWeaponsOnInitialSpawn", function(ply)
    timer.Simple(5, function() GivePlayerVapes(ply) end)
end)

hook.Add("PlayerSilentDeath", "SpawnVapeWeaponsOnSilentDeath", function(ply)
    ply:SetNWBool("player_dead", true)
end)