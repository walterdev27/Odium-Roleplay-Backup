if SERVER then 
	AddCSLuaFile("hud/client/odium_hud.lua")
    AddCSLuaFile("hud/client/odium_death.lua")
end

if CLIENT then
	include("hud/client/odium_hud.lua")
    include("hud/client/odium_death.lua")
end
