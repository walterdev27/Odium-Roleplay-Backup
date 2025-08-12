ZatlasLock = ZatlasLock or {}

ZatlasLock.NameNPC = "Receleur"

ZatlasLock.NPCModel = "models/breen.mdl"

-- TEMPS AVANT DE REMPORTER L'ARGENT
ZatlasLock.TimeAfterSentece = 60 -- en secondes

-- RECOMPENSE LA PLUS BASSE
ZatlasLock.PriceLower = 10000

-- RECOMPENSE LA PLUS HAUTE
ZatlasLock.PriceHiger = 50000

-- TEAMS AUTORISER A VOLER
ZatlasLock.AllowedTeams = {
	TEAM_VOLEUR,
	TEAM_CAMBRIOLEUR,
}