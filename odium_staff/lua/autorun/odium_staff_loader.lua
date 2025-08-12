if SERVER then
    AddCSLuaFile("odium_staff/shared/sh_config.lua")
    AddCSLuaFile("odium_staff/shared/sh_init.lua")
    AddCSLuaFile("odium_staff/client/cl_function.lua")
    AddCSLuaFile("odium_staff/client/cl_init.lua")
    AddCSLuaFile("odium_staff/client/cl_report.lua")
    AddCSLuaFile("odium_staff/client/cl_ticket.lua")
    AddCSLuaFile("odium_staff/client/cl_tickets.lua")
    AddCSLuaFile("odium_staff/client/cl_admin.lua")
    AddCSLuaFile("odium_staff/client/cl_moderation.lua")

    include("odium_staff/shared/sh_config.lua")
    include("odium_staff/shared/sh_init.lua")
    include("odium_staff/server/sv_init.lua")
    include("odium_staff/server/sv_admin.lua")
    include("odium_staff/server/sv_moderation.lua")
    include("odium_staff/server/sv_tickets.lua")
end

if CLIENT then
    include("odium_staff/shared/sh_config.lua")
    include("odium_staff/shared/sh_init.lua")
    include("odium_staff/client/cl_function.lua")
    include("odium_staff/client/cl_init.lua")
    include("odium_staff/client/cl_report.lua")
    include("odium_staff/client/cl_ticket.lua")
    include("odium_staff/client/cl_tickets.lua")
    include("odium_staff/client/cl_admin.lua")
    include("odium_staff/client/cl_moderation.lua")
end