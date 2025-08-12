function OdiumATM:Notify(ply, type, time, msg)
	if not IsValid(ply) then return end
	if DarkRP then DarkRP.notify(ply, type, time, string.Trim(msg))
	else ply:PrintMessage(HUD_PRINTTALK, string.Trim(msg)) end
end

function OdiumATM:CreateTable()
    sql.Query("CREATE TABLE IF NOT EXISTS player_bankaccount ( SteamID TEXT, Money INTEGER )")
end

function OdiumATM:SavePlayerToDataBase(ply, Money)
    local data = sql.Query("SELECT * FROM player_bankaccount WHERE SteamID = "..sql.SQLStr( ply:SteamID64() )..";")
    if ( data ) then
        sql.Query("UPDATE player_bankaccount SET Money = "..Money.." WHERE SteamID = "..sql.SQLStr(ply:SteamID64())..";")
    else
        sql.Query("INSERT INTO player_bankaccount ( SteamID, Money ) VALUES( ".. sql.SQLStr(ply:SteamID64())..", "..Money.." )")
    end
end

function OdiumATM:LoadPlayerToDataBase(ply)
    local val = sql.QueryValue("SELECT Money FROM player_bankaccount WHERE SteamID = "..sql.SQLStr(ply:SteamID64())..";")
    return val
end

function OdiumATM:GetAccountAmount(ply)
    return ply:GetNWInt("playerBankAccount")
end