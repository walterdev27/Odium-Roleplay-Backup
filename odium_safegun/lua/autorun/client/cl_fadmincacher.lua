--[[local allowedRanks = {
	["Fondateur"] = true,
	["superadmin"] = true,
	["admin"] = true,
}

local allowedTeams = {}
local publicTeams = {}

hook.Add("postLoadCustomDarkRPItems", "FAdminHideTeams", function()
	publicTeams = {
		[TEAM_GENDARME] = true,
		[TEAM_MGS] = true,
		[TEAM_FGN] = true,
		[TEAM_OLDR] = true,
		[TEAM_BRI] = true,
		[TEAM_OFFICIER] = true,
		[TEAM_GENERAL] = true,
		[TEAM_RECRUEGIGN] = true,
		[TEAM_UNITEDESECOURGIGN] = true,
		[TEAM_UNITEDASSAULTGIGN] = true,
		[TEAM_TIREURDELITEGIGN] = true,
		[TEAM_OFFICIERSUPERIEURGIGN] = true,
		[TEAM_GENERALGIGN] = true,
	
		[TEAM_STAFF] = true,
		
		[TEAM_ARMURIER] = true,
		
		[TEAM_CUISINE] = true,
		
		[TEAM_MEDECIN] = true,
		
		[TEAM_DEPAN] = true,
		
		[TEAM_MAYOR] = true,
		[TEAM_SECRETAIRE] = true,
		[TEAM_GARDE] = true
	}

	allowedTeams = {
		[TEAM_STAFF] = true
	}

	local PANEL = vgui.GetControlTable("FadminPlayerRow")

	function PANEL:UpdatePlayerData()
		if not self.Player then return end
		if not self.Player:IsValid() then return end

		self.lblName:SetText(DarkRP.deLocalise(self.Player:Nick()))
		self.lblTeam:SetText("")
		if publicTeams[self.Player:Team()] or allowedTeams[LocalPlayer():Team()] or allowedRanks[LocalPlayer():GetUserGroup()] then
			self.lblTeam:SetText((self.Player.DarkRPVars and DarkRP.deLocalise(self.Player:getDarkRPVar("job") or "")) or team.GetName(self.Player:Team()))
		end
		self.lblTeam:SizeToContents()
		self.lblFrags:SetText(self.Player:Frags())
		self.lblDeaths:SetText(self.Player:Deaths())
		self.lblPing:SetText(self.Player:Ping())
		self.lblWanted:SetText(self.Player:isWanted() and DarkRP.getPhrase("Wanted_text") or "")
	end
end)]]