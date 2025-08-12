Odium_Mayor = Odium_Mayor or {}
Odium_Mayor.Config = Odium_Mayor.Config or {}

-- Job où les joueurs virés seront placés
Odium_Mayor.Config.BaseJob = TEAM_CITOYEN

-- Jobs qui ont accès à la tablette
Odium_Mayor.Config.MayorJob = {
    ["Maire"] = true,
}

-- Unique job du maire
Odium_Mayor.Config.MayorJobName = "Maire"

-- Jobs qui reçevront les notifications d'alertes
Odium_Mayor.Config.CopsJobs = {
	["Maire"] = true,
    ["Cadets"] = true,
	["Police"] = true,
	["SWAT"] = true,
	["FBI"] = true,
	["ERI"] = true,
	["Chef Police"] = true,
	["Chef SWAT"] = true

}

-- Jobs qui pourront être virés par le maire
Odium_Mayor.Config.GuardJobs = {
    ["Garde Du Maire"] = true,
}

-- Jobs qui peuvent braquer le coffre
Odium_Mayor.Config.RobJob = {
    ["Chef du Cartel"] = true,
	["Cartel"] = true,
	["Cartel V.I.P"] = true,
	["Chef des Gangster"] = true,
	["Gangster"] = true,
	["Gangster V.I.P"] = true,
	["Parrain"] = true,
	["Mafieux"] = true,
	["Mafieux V.I.P"] = true,
	["Chef des Bandidos"] = true,
	["Bandidos"] = true,
	["Bandidos V.I.P"] = true,
	["Chef des Ballas"] = true,
	["Ballas"] = true,
	["Ballas V.I.P"] = true,
	["Chef des Families"] = true,
	["Families"] = true,
	["Families V.I.P"] = true,
	["Azarov"] = true,
    ["Parkinson"] = true,
	["Ottoman"] = true,
}

-- Jobs qui seront pas pris en compte lors des taxes
Odium_Mayor.Config.RestrictedTaxesJobs = {
	["Maire"] = true,
	["Garde Du Maire"] = true,
	["Secretaire Du Maire"] = true,
    ["Staff"] = true,
}

-- Temps de changements des lois sur le tableau des lois
Odium_Mayor.Config.TimerChange = 5

-- Configuration des taxes
-- [taxe] = pourcentage,
Odium_Mayor.Config.Taxes = {
    [0.1] = 0.001,
    [0.2] = 0.002,
    [0.3] = 0.003,
    [0.4] = 0.004,
}

-- Delai entre deux prises de taxes
Odium_Mayor.Config.TaxesDelay = 600

-- Delai entre deux braquages de coffre
Odium_Mayor.Config.RobberyDelay = 1500

-- Points de vie du locker 
Odium_Mayor.Config.LockerHealth = 6000  -- Correspond à une quinzaine de secondes de sciage

-- Model du NPC
Odium_Mayor.Config.NPCModel = "models/gman_high.mdl"

-- Titre du NPC
Odium_Mayor.Config.NPCText = "Revente sac du maire"

-- Temps entre l'application des taxes et celui où le maire peut récupérer l'argent
Odium_Mayor.Config.MayorLockerTimerRecup = 2100

-- Minimum de policiers en ville pour que le maire puisse virer quelqu'un
Odium_Mayor.Config.MinimumPlayersInCity = 16; 