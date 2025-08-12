if (CLIENT) then

	timer.Create("ClearDecals", 150, 0, function()
	RunConsoleCommand("r_cleardecals", "")
	notification.AddLegacy( "Décalques de nettoyage réussis sur la carte!", NOTIFY_GENERIC, 5 )
	print("Décalques de nettoyage réussis sur la carte!")
	end)

	timer.Create("StopSound", 150, 0, function()
		RunConsoleCommand("stopsound", "")
		notification.AddLegacy( "Arrêt du son ambiant réussi!", NOTIFY_GENERIC, 5 )
		print("Arrêt du son ambiant réussi!")
		end)
	
end