if SERVER then 
	AddCSLuaFile("odium_shop/shared/config.lua")
end

if CLIENT then
	include("odium_shop/shared/config.lua")
end

Msg( "////////////////////////////////////////\n" )
Msg( "//           NINO Shop            //\n" )
Msg( "//    Tout droit réservé à Odium      //\n" )
Msg( "//           ✅ - Validé               //\n" )
Msg( "//                                    //\n" )
Msg( "////////////////////////////////////////\n" )