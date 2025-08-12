if SERVER then
    include("trafique_organe/server/sv_trafique.lua")
    AddCSLuaFile("trafique_organe/client/cl_hudtrafique.lua")
    AddCSLuaFile("trafique_organe/client/cl_trafique.lua")
    AddCSLuaFile("trafique_organe/shared/sh_config.lua") 
    AddCSLuaFile("trafique_organe/shared.lua") 
else
    include("trafique_organe/client/cl_trafique.lua")
    include("trafique_organe/client/cl_hudtrafique.lua")
    include("trafique_organe/shared.lua")
end

include("trafique_organe/shared/sh_config.lua") 
