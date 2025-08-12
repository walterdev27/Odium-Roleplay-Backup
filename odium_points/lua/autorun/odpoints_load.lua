odpoints = odpoints or {} 

if SERVER then
    AddCSLuaFile("odpoints/shared/configuration.lua")
    AddCSLuaFile("odpoints/shared/sh_odpoints.lua")
    AddCSLuaFile("odpoints/client/cl_odpoints.lua")

    include("odpoints/shared/configuration.lua")
    include("odpoints/shared/sh_odpoints.lua")
    include("odpoints/server/sv_odpoints.lua")
end

if CLIENT then
    include("odpoints/shared/configuration.lua")
    include("odpoints/shared/sh_odpoints.lua")
    include("odpoints/client/cl_odpoints.lua")
end

local prefix = '[ODPOINTS] '
local AddonName = "ODPOINTS"
local RacineName = "odpoints"


Msg('[====================================  '..AddonName.."  ==================================]\n")   
Msg('CLIENT : \n')
for _, file in ipairs( file.Find( RacineName..'/client/*.lua', 'LUA' ) ) do                    
	Msg( prefix .. file .. string.rep( ' ', 25 - file:len() ) .. '\n' )
end
Msg('SERVER : \n')


for _, file in ipairs( file.Find( RacineName..'/server/*.lua', 'LUA' ) ) do
	Msg( prefix .. file .. string.rep( ' ', 25 - file:len() ) .. '\n' )
end

Msg('SHARED : \n')

for _, file in ipairs( file.Find( RacineName..'/shared/*.lua', 'LUA' ) ) do
	Msg( prefix .. file .. string.rep( ' ', 25 - file:len() ) .. '\n' )
end
Msg('[==================================================================================]\n')