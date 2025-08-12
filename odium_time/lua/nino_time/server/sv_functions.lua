--[[ Check data ]]--
function NinoTime:CheckData(sID64)
    if not file.IsDir("ninotime/", "DATA") then
        file.CreateDir("ninotime/")
    end

    if isstring(sID64) then
        if not file.Exists("ninotime/"..sID64..".txt", "DATA") then
            file.Write("ninotime/"..sID64..".txt", "0")
        end
    end
end

--[[ Convert time (sec) to formatted duration ]]--
function NinoTime:FormatTime(iTime)
    if not isnumber(iTime) then return end

    local d = math.floor(iTime / 24 / 60 / 60)
    local h = math.floor(iTime / 60 / 60 - d * 24)
    local m = math.floor(iTime / 60 - d * 24 * 60 - h * 60)
    local s = iTime % 60

    local tFinal = {}

    if d > 0 then
        d = d.." jours"
        table.insert(tFinal, d)
    end

    if h > 0 then
        h = h.." heures"
        table.insert(tFinal, h)
    end

    if m > 0 then
        m = m.." minutes"
        table.insert(tFinal, m)
    end

    if s > 0 then
        s = s.." secondes"
        table.insert(tFinal, s)
    end

    local sFinalString = ""
    for iID, sStr in ipairs(tFinal) do
        
        if iID == 1 then
            sFinalString = sStr
        elseif iID == #tFinal then
            sFinalString = sFinalString.." et "..sStr
        else
            sFinalString = sFinalString..", "..sStr
        end

    end

    sFinalString = sFinalString:Trim()
    if string.len(sFinalString) == 0 then
        sFinalString = "0 seconde"
    end

    return sFinalString
end