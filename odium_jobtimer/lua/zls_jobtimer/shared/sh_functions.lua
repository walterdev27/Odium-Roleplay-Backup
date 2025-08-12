-- [[ Compress table ]] --
function ZLS.JobTimer.Compress(tbl)
    if not istable(tbl) then tbl = {} end

    return util.Compress(util.TableToJSON(tbl))
end

-- [[ Uncompress table ]] --
function ZLS.JobTimer.UnCompress(compress)
    if not isstring(compress) then return {} end

    return (util.JSONToTable(util.Decompress(compress)) or {})
end