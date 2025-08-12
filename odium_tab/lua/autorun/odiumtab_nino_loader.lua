odiumtab = odiumtab or {}

if SERVER then 
	AddCSLuaFile("odium_tab/client/frame.lua")
	AddCSLuaFile('odium_tab/server/sv_tab.lua')
	include('odium_tab/server/sv_tab.lua')
end

if CLIENT then
	include("odium_tab/client/frame.lua")
end

Msg( "////////////////////////////////////////\n" )
Msg( "//           NINO Tab            //\n" )
Msg( "//    Tout droit réservé à Odium      //\n" )
Msg( "//           ✅ - Validé               //\n" )
Msg( "//                                    //\n" )
Msg( "////////////////////////////////////////\n" )