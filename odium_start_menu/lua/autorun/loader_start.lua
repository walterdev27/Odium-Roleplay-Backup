if SERVER then
    include("start_menu/server/sv_menustart.lua")
    AddCSLuaFile("start_menu/client/cl_hudmenustart.lua")
    AddCSLuaFile("start_menu/client/cl_menustart.lua")
    AddCSLuaFile("start_menu/shared/sh_config.lua") 
    //AddCSLuaFile("start_menu/shared.lua") 
else
    include("start_menu/client/cl_menustart.lua")
    include("start_menu/client/cl_hudmenustart.lua")
   // include("start_menu/shared.lua")
end

include("start_menu/shared/sh_config.lua") 
