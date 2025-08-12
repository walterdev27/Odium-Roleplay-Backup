OdiumATM = OdiumATM or {}

if SERVER then
    AddCSLuaFile("odium_atm/client/cl_font.lua")
    AddCSLuaFile("odium_atm/client/cl_home.lua")
    AddCSLuaFile("odium_atm/client/cl_atm.lua")
    AddCSLuaFile("odium_atm/client/cl_deposit.lua")
    AddCSLuaFile("odium_atm/client/cl_function.lua")
    AddCSLuaFile("odium_atm/client/cl_networking.lua")
    AddCSLuaFile("odium_atm/client/cl_transfert.lua")
    AddCSLuaFile("odium_atm/client/cl_withdraw.lua")

    include("odium_atm/server/sv_function.lua")
    include("odium_atm/server/sv_init.lua")
    include("odium_atm/server/sv_networking.lua")
end

if CLIENT then
    include("odium_atm/client/cl_font.lua")
    include("odium_atm/client/cl_home.lua")
    include("odium_atm/client/cl_atm.lua")
    include("odium_atm/client/cl_deposit.lua")
    include("odium_atm/client/cl_function.lua")
    include("odium_atm/client/cl_networking.lua")
    include("odium_atm/client/cl_transfert.lua")
    include("odium_atm/client/cl_withdraw.lua")
end