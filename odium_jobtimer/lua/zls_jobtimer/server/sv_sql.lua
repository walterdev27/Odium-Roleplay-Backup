-- [[ SQL Configuration ]] --
ZLS.JobTimer.Config = ZLS.JobTimer.Config or {}

-- Mysql is enable or disable ?
ZLS.JobTimer.Config.MysqlEnabled = false

-- If enable, insert here your sql identifiers
local mysqlInformations = {
    ["host"] = "194.147.5.53",
    ["username"] = "u1_BSs8CcJJIY",
    ["password"] = "HqHLELRZn62N5IKZ4=OqGZ+X",
    ["database"] = "s1_JobTimer",
    ["port"] = 3306
}

-- [[ End of the SQL Configuration ]] --
ZLS.JobTimer.succesfullConnect = ZLS.JobTimer.succesfullConnect or false

-- [[ Mysql database connection system ]] --
local mysqlDB
if ZLS.JobTimer.Config.MysqlEnabled then
    require("mysqloo")
    if not mysqloo then

        return print("[ZLS - JobTimer] Cannot require mysqloo module :\n"..requireError)
    end
  
    mysqlDB = mysqloo.connect(mysqlInformations["host"], mysqlInformations["username"], mysqlInformations["password"], mysqlInformations["database"], {["port"] = mysqlInformations["port"]})
    function mysqlDB:onConnected()   
        
        print("[ZLS - JobTimer] Succesfuly connected to the mysql database !")
        ZLS.JobTimer.succesfullConnect = true
    end
    
    function mysqlDB:onConnectionFailed(connectionError)
        
        print("[ZLS - JobTimer] Cannot establish database connection :\n"..connectionError)
        
        ZLS.JobTimer.succesfullConnect = false
    end
    
    mysqlDB:setAutoReconnect(true)
    mysqlDB:connect()
end

-- Mysqli compatibility
if not ZLS.JobTimer.Config.MysqlEnabled then
    
    print("[ZLS - JobTimer] Use mysqli connection")
end

-- [[ SQL Query ]] --
function ZLS.JobTimer.Query(query)
    if not isstring(query) then return end

    local result = {}
    -- Mysql connection
    if ZLS.JobTimer.succesfullConnect then

        query = mysqlDB:query(query)
        query:start()
        query:wait()

        local err = query:error()
        if err == "" then        

            return query:getData()
        else    
            print(err) -- TO DELETE
            return {false, err}
        end
    else

        result = sql.Query(query)
    end

    return (result or {})
end