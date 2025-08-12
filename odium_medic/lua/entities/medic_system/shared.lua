/*
* @Author: Diesel
* @Date:   2023-01-28 22:55:58
* @Last Modified time: 2023-01-28 23:06:06
* @File: shared.lua
*/
SMedic = SMedic or {}

-- Indiquez le model que le NPC prendra comme apparence
SMedic.Model = "models/Kleiner.mdl" 
-- Texte afficher au dessus de la tête du NPC
SMedic.NPCName = "SAMU"

-- Si un médecin est en ville, le NPC est désactive (défaut : true)
SMedic.TeamDisallow = true
-- Medecins || pour indiquer plusieurs jobs, séparé d'une virgule tel que TEAM_MEDIC, TEAM_PROMEDIC
SMedic.Team = TEAM_MEDECIN

-- Le prix que coûte 100 HP
SMedic.Cost100 = 5000

-- END OF CONFIG

ENT.Base = "base_ai"
ENT.Type = "anim"
ENT.PrintName		= "Médecin"
ENT.Category		= "ODIUM | Medic" 
ENT.Author 			= "ODIUM"
ENT.Instructions	= ""
ENT.Spawnable		= true

function ENT:Initialize()
	self:SetModel(SMedic.Model)
	self:SetSolid(SOLID_BBOX)
	if SERVER then self:SetUseType(SIMPLE_USE) end
end