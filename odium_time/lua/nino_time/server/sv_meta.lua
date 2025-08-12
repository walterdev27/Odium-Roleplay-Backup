local PLAYER = FindMetaTable("Player")

--[[ Get playtime of a player ]]--
function PLAYER:GetPlayTime()
    local sID64 = self:SteamID64()

    NinoTime:CheckData(sID64)
    return tonumber( file.Read("ninotime/"..sID64..".txt", "DATA") or "0" )
end

--[[ Set playtime of a player ]]--
function PLAYER:SetPlayTime(iTime)
    if not isnumber(iTime) then return end

    local sID64 = self:SteamID64()

    NinoTime:CheckData(sID64)
    file.Write("ninotime/"..sID64..".txt", tostring(iTime))
end

--[[ Add playtime to a player ]]--
function PLAYER:AddPlayTime(iTimeAdd)
    local iPrevious = self:GetPlayTime() or 0
    return self:SetPlayTime( iPrevious + math.abs(iTimeAdd) )
end