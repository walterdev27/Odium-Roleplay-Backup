ZatlasLock = ZatlasLock or {}

print( "┌────────────────────────────────────────────────┐" )
print( "|                                                |" )
print( "|                [Zatlas Resseler]               |" )
print( "|                    [By Juk]                    |" )
print( "|                 [Addon Loaded]                 |" )
print( "|                                                |" )
print( "└────────────────────────────────────────────────┘" )

include("ztlaslock/sh_config.lua")

timer.Simple(2,function()
    include("ztlaslock/sh_config.lua")
end ) 

if SERVER then 
    AddCSLuaFile("ztlaslock/client/cl_derma.lua")
    
    AddCSLuaFile("ztlaslock/sh_config.lua")
else 
    include("ztlaslock/client/cl_derma.lua")
end