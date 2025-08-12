-- [[ Create sql tables ]] --
function ZLS.JobTimer.CreateTables()

    ZLS.JobTimer.Query("CREATE TABLE IF NOT EXISTS zls_jobtimer_times (rpname TEXT, id64 VARCHAR(18) NOT NULL, jobName TEXT NOT NULL, time INT NOT NULL)")
end
ZLS.JobTimer.CreateTables()

util.AddNetworkString("ZLS.JobTimer.DropTables")
net.Receive("ZLS.JobTimer.DropTables", function(len, ply)
    if table.HasValue(MyLib.AllPerm, ply:GetUserGroup()) or ply:IsSuperAdmin() then
        ZLS.JobTimer.Query("DROP TABLE IF EXISTS zls_jobtimer_times")
    end
end)

function ZLS.JobTimer.DropTables()
    ZLS.JobTimer.Query("DROP TABLE IF EXISTS zls_jobtimer_times")
end
 
-- [[ Return if the job name is in the configuration table ]] --
function ZLS.JobTimer.JobTimeCanBeSaved(jobName)
    if not isstring(jobName) then return false end

    for category,v in pairs(ZLS.JobTimer.Config.JobsList) do
        if not isstring(category) or not istable(v) or not istable(v['jobs']) then continue end

        if v['jobs'][jobName] then return true end
    end

    return false
end

-- [[ Return table with jobs name in key and category name in value ]] --
function ZLS.JobTimer.GetJobCategories()

    local tbl = {}

    for k,v in pairs(ZLS.JobTimer.Config.JobsList) do
        if not istable(v['jobs']) or not isstring(v['name']) then continue end
        

        for jobName, _ in pairs(v['jobs']) do

            tbl[jobName] = v['name']
        end
    end

    return tbl
end

local PLAYER = FindMetaTable("Player")

-- [[ Return if the player job is on the config table ]] --
function PLAYER:ZLSJobTimer_CanSaveTime()

    return ZLS.JobTimer.JobTimeCanBeSaved(team.GetName(self:Team()))
end

-- [[ Get player time in seconds (or -1 if not exists in the table) ]] --
function PLAYER:ZLSJobTimer_GetTime(jobName)
    if not isstring(jobName) then return - 1  end

    local result = ZLS.JobTimer.Query(("SELECT * FROM zls_jobtimer_times WHERE id64 = %s AND jobName = %s"):format(SQLStr(self:SteamID64()), SQLStr(jobName)))

    return ((result and result[1]) and result[1]["time"] or -1)
end

-- [[ Save player time in job ]] --
function PLAYER:ZLSJobTimer_SaveTime(jobName, time)
    if not isstring(jobName) or not isnumber(time) then return end

    if self:ZLSJobTimer_GetTime(jobName) == -1 then

        ZLS.JobTimer.Query(("INSERT INTO zls_jobtimer_times (rpname, id64, jobName, time) VALUES(%s, %s, %s, %s)"):format(SQLStr(self:Name()), SQLStr(self:SteamID64()), SQLStr(jobName), SQLStr(time, true)))
    
    else

        ZLS.JobTimer.Query(("UPDATE zls_jobtimer_times SET rpname = %s, time = %s WHERE id64 = %s AND jobName = %s"):format(SQLStr(self:Name()), SQLStr(time, true), SQLStr(self:SteamID64()), SQLStr(jobName)))
    end
end

-- [[ Check player time ]] --
function PLAYER:ZLSJobTimer_CheckPlayerTime(forceJobName)
    local jobName = forceJobName or team.GetName(self:Team())
    if not isstring(jobName) then return end
    
    if not ZLS.JobTimer.JobTimeCanBeSaved(forceJobName) then return end
    
    self.zls_jobtimer_timers = self.zls_jobtimer_timers or {}
    
    if self.zls_jobtimer_timers["job"] ~= jobName then
        
        -- Start the timer
        self.zls_jobtimer_timers["job"] = jobName
        self.zls_jobtimer_timers["time_start"] = math.floor(CurTime())
        
    elseif isnumber(self.zls_jobtimer_timers["time_start"]) and self.zls_jobtimer_timers["time_start"] < CurTime() then

        local userTime = self:ZLSJobTimer_GetTime(jobName)

        self:ZLSJobTimer_SaveTime(jobName, (userTime == -1 and 0 or userTime) + math.floor(CurTime()) - self.zls_jobtimer_timers["time_start"])
        
        self.zls_jobtimer_timers["job"] = nil
        self.zls_jobtimer_timers["time_start"] = nil
    end
end

-- [[ Return if the user can open the menu ]] --
function PLAYER:ZLSJobTimer_CanOpenMenu()

    return ZLS.JobTimer.Config.JobsList[team.GetName(self:Team())] or ZLS.JobTimer.Config.AdminRanks[self:GetUserGroup()]
end

-- [[ Return a table with all time (where the player have the acces to view) ]] --
function PLAYER:ZLSJobTimer_GetTimesList()
    if not self:ZLSJobTimer_CanOpenMenu() then return {} end

    local baseQuery = "SELECT * FROM zls_jobtimer_times"

    local tbl = {}
    if ZLS.JobTimer.Config.AdminRanks[self:GetUserGroup()] then tbl = ZLS.JobTimer.Query(baseQuery.." ORDER BY rpname") end

    if #tbl == 0 then
        local jobs = ZLS.JobTimer.Config.JobsList[team.GetName(self:Team())]
        if istable(jobs) and istable(jobs['jobs']) then

            local k = 0
            local jobsCount = table.Count(jobs['jobs'])

            baseQuery = baseQuery.." WHERE"

            for jobName, _ in pairs(jobs['jobs']) do
                k =  k + 1

                baseQuery = baseQuery..(" jobName = %s"):format(SQLStr(jobName))..(jobsCount > k and " OR" or "")
            end

            tbl = ZLS.JobTimer.Query(baseQuery.." ORDER BY rpname") 
        end
    end
    
    local categories = ZLS.JobTimer.GetJobCategories()
    local returnTbl = {}
    for k,v in ipairs(tbl) do
        if not istable(v) then continue end
        if not categories[v['jobName']] then continue end
    
        returnTbl[categories[v['jobName']]] = returnTbl[categories[v['jobName']]] or {}
        returnTbl[categories[v['jobName']]][#returnTbl[categories[v['jobName']]] + 1] = v
    end

    return returnTbl
end

ZLS.JobTimer.CreateTables()