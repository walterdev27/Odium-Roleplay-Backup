NVT = NVT or {}

include("nino_vote/sh_config.lua")

if SERVER then
    AddCSLuaFile("nino_vote/sh_config.lua")

    include("nino_vote/server/sv_main.lua")

    AddCSLuaFile("nino_vote/client/cl_main.lua")
else
    include("nino_vote/client/cl_main.lua")
end
