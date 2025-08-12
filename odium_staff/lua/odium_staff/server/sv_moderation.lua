util.AddNetworkString("SendPlayerWarnings")
util.AddNetworkString("AddPlayerWarning")
util.AddNetworkString("RequestRemovePlayerWarning")
util.AddNetworkString("RequestSteamIDWarnings")
util.AddNetworkString("ReceiveSteamIDWarnings")
util.AddNetworkString("SendSteamIDWarnings")
util.AddNetworkString("AddSteamIDWarning")
util.AddNetworkString("RequestRemoveSteamIDWarning")
util.AddNetworkString("RequestPlayerWarnings")
util.AddNetworkString("ReceivePlayerWarnings")
util.AddNetworkString("SendPlayerWarningsBySteamID")

if not sql.TableExists("player_warnings") then
    sql.Query("CREATE TABLE player_warnings (id INTEGER PRIMARY KEY AUTOINCREMENT, steamid TEXT, date TEXT, reason TEXT, author TEXT, expiration TEXT)")
end

net.Receive("AddPlayerWarning", function(len, ply)
    local target = net.ReadEntity()
    local reason = net.ReadString()
    local expiration = os.time() + 30 * 86400

    

    local steamid = target:SteamID()
    sql.Query("INSERT INTO player_warnings (steamid, reason, author, date, expiration) VALUES ('" .. steamid .. "', '" .. reason .. "', '" .. ply:Nick() .. "', '" .. os.date("%d/%m/%Y à %H:%M") .. "', '" .. os.date("%d/%m/%Y", expiration) .. "')")

    local warnings = sql.Query("SELECT * FROM player_warnings WHERE steamid = '" .. steamid .. "'")
    if not warnings then warnings = {} end
    print('')
    target:ChatPrint('Vous avez reçu un avertissement pour la raison : '..reason)

    net.Start("SendPlayerWarnings")
    net.WriteTable(warnings)
    net.Send(ply)

end)

function durationToSeconds(duration)
    local months = tonumber(string.match(duration, "(%d+) mois"))
    return months * 30 * 24 * 60 * 60
end

net.Receive("SendPlayerWarnings", function(len, ply)
    local target = net.ReadEntity()
    local steamid = target:SteamID()

    local warnings = sql.Query("SELECT * FROM player_warnings WHERE steamid = '" .. steamid .. "'")
    if not warnings then warnings = {} end

    net.Start("SendPlayerWarnings")
    net.WriteTable(warnings)
    net.Send(ply)
end)

net.Receive("RequestRemovePlayerWarning", function(len, ply)
    if not ply:IsAdmin() then return end

    local warningID = net.ReadUInt(32)
    sql.Query("DELETE FROM player_warnings WHERE id = " .. warningID)

    -- Renvoyer les avertissements mis à jour au client
    local target = net.ReadEntity()
    local steamid = target:SteamID()
    local warnings = sql.Query("SELECT * FROM player_warnings WHERE steamid = '" .. steamid .. "'")
    if not warnings then warnings = {} end

    net.Start("SendPlayerWarnings")
    net.WriteTable(warnings)
    net.Send(ply)
end)

net.Receive("AddSteamIDWarning", function(len, ply)
    local steamid = net.ReadString()
    local reason = net.ReadString()
    local duration = net.ReadUInt(32)
    local expiration = os.time() + duration * 86400

    sql.Query("INSERT INTO player_warnings (steamid, reason, author, date, expiration) VALUES ('" .. steamid .. "', '" .. reason .. "', '" .. ply:Nick() .. "', '" .. os.date("%d/%m/%Y à %H:%M") .. "', '" .. os.date("%d/%m/%Y", expiration) .. "')")

    local warnings = sql.Query("SELECT * FROM player_warnings WHERE steamid = '" .. steamid .. "'")
    if not warnings then warnings = {} end

    net.Start("ReceiveSteamIDWarnings")
    net.WriteTable(warnings)
    net.Send(ply)
end)

net.Receive("RequestSteamIDWarnings", function(len, ply)
    local steamID = net.ReadString()

    local warnings = sql.Query("SELECT * FROM player_warnings WHERE steamid = '" .. steamID .. "'")
    if not warnings then
        ply:ChatPrint("Aucun joueur trouvé avec ce SteamID.")
        warnings = {} 
    end

    net.Start("ReceiveSteamIDWarnings")
    net.WriteTable(warnings)
    net.Send(ply)

end)

net.Receive("RequestRemoveSteamIDWarning", function(len, ply)
    if not ply:IsAdmin() then return end

    local warningID = net.ReadUInt(32)
    sql.Query("DELETE FROM player_warnings WHERE id = " .. warningID)

    -- Récupérer le SteamID pour obtenir les avertissements mis à jour
    local steamID = net.ReadString()

    local warnings = sql.Query("SELECT * FROM player_warnings WHERE steamid = '" .. steamID .. "'")
    if not warnings then warnings = {} end

    net.Start("ReceiveSteamIDWarnings")
    net.WriteTable(warnings)
    net.Send(ply)
end)

function GetPlayerWarningsBySteamID(steamID)
    local warnings = sql.Query("SELECT * FROM player_warnings WHERE steamid = '" .. steamID .. "'")
    if not warnings then warnings = {} end
    return warnings
end

net.Receive("RequestPlayerWarnings", function(len, ply)
    local selectedPlayer = net.ReadEntity()
    local warnings = GetPlayerWarningsBySteamID(steamID)

    net.Start("SendPlayerWarningsBySteamID")
    net.WriteTable(warnings)
    net.Send(ply)
end)
