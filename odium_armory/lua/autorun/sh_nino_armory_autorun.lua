NAR = NAR or {}

include("nino_armory/sh_config.lua")

if SERVER then
    AddCSLuaFile("nino_armory/sh_config.lua")

    include("nino_armory/server/sv_main.lua")

    AddCSLuaFile("nino_armory/client/cl_main.lua")
else 
    include("nino_armory/client/cl_main.lua")
end