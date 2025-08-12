NUB = NUB or {}

include("nino_unblock/sh_config.lua")

if SERVER then
    AddCSLuaFile("nino_unblock/sh_config.lua")

    include("nino_unblock/server/sv_main.lua")

    AddCSLuaFile("nino_unblock/client/cl_main.lua")
else 
    include("nino_unblock/client/cl_main.lua")
end