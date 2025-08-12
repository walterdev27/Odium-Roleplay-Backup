Nino_DeathScreen = Nino_DeathScreen or {}
Nino_DeathScreen.Config = Nino_DeathScreen.Config or {}
Nino_DeathScreen.Lang = Nino_DeathScreen.Lang or {}

// The folder he's can find all files of nino_deathscreen.
Nino_DeathScreen.FolderAddons = "nino_deathscreen"
	
if SERVER then	

	AddCSLuaFile(Nino_DeathScreen.FolderAddons .. "/client/cl_deathscreen.lua")
	

elseif CLIENT then

	include(Nino_DeathScreen.FolderAddons .. "/client/cl_deathscreen.lua")	
end
