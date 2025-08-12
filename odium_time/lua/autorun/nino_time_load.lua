NinoTime = NinoTime or {}

local function inc(f) return include("nino_time/"..f) end
local function addcs(f) return AddCSLuaFile("nino_time/"..f) end

if SERVER then

    addcs("config.lua")
    inc("config.lua")

    inc("server/sv_meta.lua")
    inc("server/sv_functions.lua")
    inc("server/sv_hooks.lua")

    addcs("client/cl_main.lua")

else

    inc("config.lua")
    inc("client/cl_main.lua")

end