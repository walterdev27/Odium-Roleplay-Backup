if SERVER then
    AddCSLuaFile("nino-echap-menu/client.lua")
    AddCSLuaFile("nino-echap-menu/config.lua")
    include("nino-echap-menu/config.lua")
    include("nino-echap-menu/server.lua")
else
    include("nino-echap-menu/client.lua")
    include("nino-echap-menu/config.lua")
end