ZLS = ZLS or {}
ZLS.JobTimer = ZLS.JobTimer or {}

local basePath = "zls_jobtimer/"

-- [[ Include shared files ]] --
include(basePath.."shared/sh_config.lua")
include(basePath.."shared/sh_functions.lua")
if SERVER then
    
    -- [[ AddCSLua shared files ]] --
    AddCSLuaFile(basePath.."shared/sh_config.lua")
    AddCSLuaFile(basePath.."shared/sh_functions.lua")

    -- [[ Include server files ]] --
    include(basePath.."server/sv_sql.lua")
    include(basePath.."server/sv_hooks.lua")
    include(basePath.."server/sv_functions.lua")

    -- [[ AddCSLua client file ]] --
    AddCSLuaFile(basePath.."client/cl_derma.lua")

else

    -- [[ Include client file ]] --
    include(basePath.."client/cl_derma.lua")
end 

Msg( "////////////////////////////////////////\n" )
Msg( "//           NINO JobTimer            //\n" )
Msg( "//    Tout droit réservé à Odium      //\n" )
Msg( "//           ✅ - Validé               //\n" )
Msg( "//                                    //\n" )
Msg( "////////////////////////////////////////\n" )