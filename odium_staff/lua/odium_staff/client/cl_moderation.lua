// last modif 19/11/2023 by Walter

ODIUM = ODIUM or {}

-- Automatic responsive functions
ODIUM.iW = ScrW()
ODIUM.iH = ScrH()

local function RX(x)
    return x / 3840 * ODIUM.iW
end

local function RY(y)
    return y / 2160 * ODIUM.iH
end

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChanged", function()

    ODIUM.iW = ScrW()
    ODIUM.iH = ScrH()

end)

local totalWarns = 0
local warningsList
local totalWarnsLabel
local propertySheet

local function UpdateTotalWarns()
    local totalWarns = 0
    for _, _ in ipairs(warningsList:GetLines()) do
        totalWarns = totalWarns + 1
    end
    totalWarnsLabel:SetText("Warns totaux: " .. totalWarns)
end

local function UpdateSteamIDWarnings()
    net.Start("RequestSteamIDWarnings")
    net.WriteString(steamIDSearchBar:GetValue())
    net.SendToServer()
end

local function IsValidSteamID(steamID)
    local pattern = "^STEAM_%d:%d:%d+$"
    return string.match(steamID, pattern) ~= nil
end

local function SelectPlayerBySteamID(steamID)
    for _, child in ipairs(scrollPanel:GetCanvas():GetChildren()) do
        local ply = player.GetBySteamID(steamID)
        if ply and ply:Nick() == child:GetText() then
            child:DoClick()
            break
        end
    end
end

local function UpdatePlayerWarnings(steamID)
    net.Start("RequestPlayerWarnings")
    net.WriteString(steamID)
    net.SendToServer()
end

local function UpdateWarningsList(steamID)
    net.Start("SendPlayerWarningsBySteamID")
    net.WriteString(steamID)
    net.SendToServer()
end

local function SetActiveTab(index)
    if not propertySheet then return end
    propertySheet:SetActiveTab(propertySheet:GetItems()[index].Tab)
end

surface.CreateFont( "fontTueuragage1", {
	font = "Righteous", 
	extended = false,
	size = RX(50),
    weight = RY(500)
} )

surface.CreateFont( "fontStaff2", {
	font = "Righteous", 
	extended = false,
	size = RX(65),
    weight = RY(500)
} )

surface.CreateFont( "fontStaff3", {
	font = "Righteous", 
	extended = false,
	size = RX(65),
    weight = RY(500)
} )

local function OpenWarnJoueurPanel(selectedPlayer)
    
    local frameJoueur = vgui.Create("DFrame")
    frameJoueur:SetSize(RX(2700), RY(1800))
    frameJoueur:SetTitle("")
    frameJoueur:SetSizable(true)
    frameJoueur:ShowCloseButton(false)
    frameJoueur:Center()
    frameJoueur:MakePopup()
    frameJoueur.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
        draw.RoundedBox(0, 0, 0, RX(10), h, MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, 0, w, RY(10), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, RY(1790), w, RY(10), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, RX(2690), 0, RX(10), h, MyLib.ColorServer["Green"])
        draw.SimpleTextOutlined("Panel Warn Odium", "fontStaff3", RX(1300), RY(70), MyLib.ColorServer["Black"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Green"])
    end

    net.Receive("SendPlayerWarnings", function()
        local warnings = net.ReadTable()
        local steamid = net.ReadString()
    
        warningsList1:Clear()
        for i, warning in ipairs(warnings) do
            warningsList1:AddLine(warning.id, warning.date, warning.reason, warning.author, warning.expiration /*warning.expiration*/)
        end
        totalWarnsLabel:SetText("Warns totaux: " .. #warnings)

        print(warnings.expiration)

    end)

    local closeFrameJoueur = vgui.Create("DButton", frameJoueur)
    closeFrameJoueur:SetPos(RX(2590), RY(35))
    closeFrameJoueur:SetSize(RX(65), RY(65))
    closeFrameJoueur:SetText("");
    closeFrameJoueur.isSound = false
    closeFrameJoueur.Paint = function(s,w,h)
		if closeFrameJoueur:IsHovered() then
			closeFrameJoueur:SetTextColor(MyLib.ColorServer["ServerColor"])
			draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
			if not closeFrameJoueur.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				closeFrameJoueur.isSound = true
			end
			draw.SimpleText("X", "fontStaff2", RX(15), RY(-0), MyLib.ColorServer["Black"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		else
			closeFrameJoueur:SetTextColor(color_white)
			draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
			closeFrameJoueur.isSound = false
			draw.SimpleText("X", "fontStaff2", RX(15), RY(-0), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end

	end
	closeFrameJoueur.DoClick = function()
		if IsValid(frameJoueur) then frameJoueur:Remove() end
	end

    warningsList1 = vgui.Create("DListView", frameJoueur)
    warningsList1:SetSize(RX(2660), RY(1530))
    warningsList1:SetPos(RX(20), RY(150))
    warningsList1:SetMultiSelect(false)
    warningsList1:AddColumn("ID"):SetFixedWidth(RX(100))
    warningsList1:AddColumn("Date"):SetFixedWidth(RX(250))
    warningsList1:AddColumn("Raison"):SetFixedWidth(RX(1300))
    warningsList1:AddColumn("Auteur"):SetFixedWidth(RX(400))
    warningsList1:AddColumn("Expiration"):SetFixedWidth(RX(200))
    // warningsList1:AddColumn("Expiration"):SetFixedWidth(RX(200))
    warningsList1.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
    end
    

    totalWarnsLabel = vgui.Create("DLabel", frameJoueur)
    totalWarnsLabel:SetPos(RX(45), RY(1700))
    totalWarnsLabel:SetSize(RX(900), RY(50))
    totalWarnsLabel:SetFont("Nino7:10")
    totalWarnsLabel:SetText("Warns totaux: " .. totalWarns)

    if IsValid(frameJoueur) then
        net.Start("SendPlayerWarnings")
        net.WriteEntity(ply)
        net.SendToServer()
    end
end

local function OpenModerationPanel(selectedPlayer)
    local frame = vgui.Create("DFrame")
    frame:SetSize(RX(2700), RY(1800))
    frame:SetTitle("")
    frame:SetSizable(true)
    frame:ShowCloseButton(false)
    frame:Center()
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
        draw.RoundedBox(0, 0, 0, RX(10), h, MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, 0, w, RY(10), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, RY(1790), w, RY(10), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, RX(2690), 0, RX(10), h, MyLib.ColorServer["Green"])
        draw.SimpleTextOutlined("Panel Moderation Odium", "fontStaff3", RX(1300), RY(70), MyLib.ColorServer["Black"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Green"])
    end

        local closeFrame = vgui.Create("DButton", frame)
        closeFrame:SetPos(RX(2590), RY(35))
		closeFrame:SetSize(RX(65), RY(65))
		closeFrame:SetText("");
		closeFrame.isSound = false
		closeFrame.Paint = function(s,w,h)
			if closeFrame:IsHovered() then
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
				if not closeFrame.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					closeFrame.isSound = true
				end
				draw.SimpleText("X", "fontStaff2", RX(15), RY(-0), MyLib.ColorServer["Black"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			else
				closeFrame:SetTextColor(color_white)
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
				closeFrame.isSound = false
				draw.SimpleText("X", "fontStaff2", RX(15), RY(-0), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end

		end
		closeFrame.DoClick = function()
			if IsValid(frame) then frame:Remove() end
		end

        propertySheet = vgui.Create("DPropertySheet", frame)
        propertySheet:SetSize(frame:GetWide() * 0.99, frame:GetTall() * 0.94)
        propertySheet:SetPos(frame:GetWide() * 0.006, frame:GetTall() * 0.05)

    local warningsPanel = vgui.Create("DPanel")
    propertySheet:AddSheet("Avertissements", warningsPanel, "icon16/error.png")
    warningsPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
        --draw.RoundedBox(0, RX(9), RY(1350.5), RX(2100), RY(150), MyLib.ColorServer["Green"])
        --for _, ply in ipairs(player.GetAll()) do
        --    draw.SimpleTextOutlined(ply:Nick(), "Nino7:10", RX(1400), RY(1465), MyLib.ColorServer["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        --end
        draw.SimpleTextOutlined("Raison:", "Nino7:10", RX(140), RY(1560), MyLib.ColorServer["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        // draw.SimpleTextOutlined("Expiration:", "Nino7:10", RX(1350), RY(1560), MyLib.ColorServer["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
    end

    local playerSelected = false
    warningsList = vgui.Create("DListView", warningsPanel)
    warningsList:SetSize(RX(2100), RY(1380))
    warningsList:SetPos(RX(9), RY(20))
    warningsList:SetMultiSelect(false)
    warningsList:AddColumn("ID"):SetFixedWidth(RX(100))
    warningsList:AddColumn("Date"):SetFixedWidth(RX(250))
    warningsList:AddColumn("Raison"):SetFixedWidth(RX(1300))
    warningsList:AddColumn("Auteur"):SetFixedWidth(RX(250))
    warningsList:AddColumn("Expiration"):SetFixedWidth(RX(200))
   // warningsList:AddColumn("Expiration"):SetFixedWidth(RX(200))
    warningsList.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
    end

    warningsList.OnRowRightClick = function(panel, lineIndex, line)
        local menu = DermaMenu()
        menu:AddOption("Supprimer", function()
            surface.PlaySound("pcasino/basicslotmachine/win_tune.wav")
            local warningID = tonumber(line:GetValue(1))
        
            warningsList:RemoveLine(lineIndex)
            net.Start("RequestRemovePlayerWarning")
            net.WriteUInt(warningID, 32)
            net.SendToServer()
        
            timer.Simple(0.5, function()
                UpdateTotalWarns()
            end)
        end)
        menu:Open()
    end

    net.Receive("ReceivePlayerWarnings", function(len)
        local warnings = net.ReadTable()
    
        warningsList:Clear()
    
        for _, warning in ipairs(warnings) do
            warningsList:AddLine(warning.ID, warning.Date, warning.Raison, warning.Auteur,warning.expiration /*warning.Expiration*/)
            notification.AddLegacy("Vous avez reçus un warn pour la raison "..warning.Raison.." par "..warning.Auteur,NOTIFY_HINT,5)
        end
    
        UpdateTotalWarns()
        
    end)    

    local selectedPlayerLabel = vgui.Create("DLabel", warningsPanel)
    selectedPlayerLabel:SetPos(RX(40), RY(1440))
    selectedPlayerLabel:SetSize(RX(1310), RY(50))
    selectedPlayerLabel:SetFont("Nino7:10")
    selectedPlayerLabel:SetText("Joueur sélectionné: Aucun")
    
    totalWarnsLabel = vgui.Create("DLabel", warningsPanel)
    totalWarnsLabel:SetPos(RX(1700), RY(1440))
    totalWarnsLabel:SetSize(RX(900), RY(50))
    totalWarnsLabel:SetFont("Nino7:10")
    totalWarnsLabel:SetText("Warns totaux: 0")

    local selectedPlayer
    selectedButton = nil

    local dPanelscroll = vgui.Create("DPanel", warningsPanel)
    dPanelscroll:SetSize(RX(500), RY(1480))
    dPanelscroll:SetPos(RX(2130), RY(120))
    dPanelscroll.Paint = nil

    local scrollPanel = vgui.Create("DScrollPanel", dPanelscroll)
    scrollPanel:Dock(FILL)

    local sbar = scrollPanel:GetVBar()
    function sbar:Paint(w, h)
        draw.RoundedBox(0, RX((5)), 0, w, h, MyLib.ColorServer["Black"])
    end
    function sbar.btnUp:Paint(w, h)
        draw.RoundedBox(0, RX((5)), 0, w, h, MyLib.ColorServer["white"])
    end
    function sbar.btnDown:Paint(w, h)
        draw.RoundedBox(0, RX((5)), 0, w, h, MyLib.ColorServer["white"])
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, RX((5)), 0, w, h, MyLib.ColorServer["white"])
    end
    
    for _, ply in ipairs(player.GetAll()) do
        local playerName = vgui.Create("DButton", scrollPanel)
        playerName:SetText(ply:Nick())
        playerName:SetSize(RX(0), RY(50))
        playerName:Dock(TOP)
        playerName:DockMargin(5, 3, 5, 0)
        playerName.isSound = false
        playerName:SetFont("fontTueuragage1")
        playerName:SetTextColor(MyLib.ColorServer["Black"])
        playerName.Paint = function(self, w, h)
            if self == selectedButton then
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            elseif playerName:IsHovered() then
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
                if not playerName.isSound then
                    surface.PlaySound("UI/buttonrollover.wav")
                    playerName.isSound = true
                end
            else
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
                playerName.isSound = false
            end
        end
        playerName.DoClick = function()
            if selectedPlayer == ply then return end
        
            if selectedButton then
                selectedButton:SetTextColor(MyLib.ColorServer["Black"])
            end
        
            selectedPlayer = ply
            selectedButton = playerName
            playerName:SetTextColor(MyLib.ColorServer["Black"])
        
            selectedPlayerLabel:SetText("Joueur sélectionné: " .. ply:Nick())
        
            net.Start("SendPlayerWarnings")
            net.WriteEntity(ply)
            net.SendToServer()
            
            UpdateTotalWarns()
        end
        if ply == selectedPlayer then
            playerName:DoClick()
        end
    end

    local searchBar = vgui.Create("DTextEntry", warningsPanel)
    searchBar:SetSize(RX(455), RY(70))
    searchBar:SetPos(RX(2140), RY(30))
    searchBar:SetPlaceholderText("Recherche")
    searchBar.OnTextChanged = function()
        local searchText = string.lower(searchBar:GetValue())
        UpdateWarningsList(searchText)
        
        if searchText:match("^STEAM_%d:%d:%d+$") then
            UpdatePlayerWarnings(searchText)
        else
            for _, child in ipairs(scrollPanel:GetCanvas():GetChildren()) do
                if string.find(string.lower(child:GetText()), searchText) then
                    child:SetVisible(true)
                else
                    child:SetVisible(false)
                end
            end
        end
    end

    local reasonEntry = vgui.Create("DTextEntry", warningsPanel)
    reasonEntry:SetSize(RX(900), RY(70))
    reasonEntry:SetPos(RX(280), RY(1525))
    reasonEntry:SetPlaceholderText("Raison")

    // local durationComboBox = vgui.Create("DComboBox", warningsPanel)
    // durationComboBox:SetSize(RX(150), RY(70))
    // durationComboBox:SetPos(RX(1540), RY(1525))
    // durationComboBox:SetValue("Durée")
    // durationComboBox:AddChoice("1 mois")
    // durationComboBox:AddChoice("2 mois")
    // durationComboBox:AddChoice("3 mois")

    local validateButton = vgui.Create("DButton", warningsPanel)
    validateButton:SetText("Sanctionner")
    validateButton:SetSize(RX(411), RY(70))
    validateButton:SetPos(RX(1700), RY(1525))
    validateButton:SetFont("fontTueuragage1")
    validateButton.isSound = false
    validateButton:SetTextColor(MyLib.ColorServer["Black"])
    validateButton.Paint = function(self, w, h)
        if validateButton:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            if not validateButton.isSound then
                surface.PlaySound("UI/buttonrollover.wav")
                validateButton.isSound = true
            end
        else
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
            draw.RoundedBox(0, 0, RY(60), w, RY(25), MyLib.ColorServer["GreentSecond"])
            validateButton.isSound = false
        end
    end
    if MyLib.StaffGeneralPrincipalePerm[LocalPlayer():GetUserGroup()] or LocalPlayer():IsSuperAdmin() then
        validateButton.DoClick = function()
            surface.PlaySound("pcasino/basicslotmachine/fail_tune.wav")
            if not selectedPlayer or reasonEntry:GetValue() == "" then
                chat.AddText(Color(255, 0, 0), "Veuillez sélectionner un joueur, écrire une raison.")
            else
                // local durationInDays = 0
                // if durationComboBox:GetValue() == "1 mois" then
                //     durationInDays = 30
                // elseif durationComboBox:GetValue() == "2 mois" then
                //     durationInDays = 60
                // elseif durationComboBox:GetValue() == "3 mois" then
                //     durationInDays = 90
                // end
            
                net.Start("AddPlayerWarning")
                net.WriteEntity(selectedPlayer)
                net.WriteString(reasonEntry:GetValue())
                // net.WriteUInt(durationInDays, 32) 
                net.SendToServer()
            
                reasonEntry:SetValue("")
                // durationComboBox:SetValue("Durée")
            end
        end    
    end

    net.Receive("SendPlayerWarnings", function()
        local warnings = net.ReadTable()
        local steamid = net.ReadString()
    
        warningsList:Clear()
        for _, warning in ipairs(warnings) do
            warningsList:AddLine(warning.id, warning.date, warning.reason, warning.author,warning.expiration /*warning.expiration*/)
        end
        totalWarnsLabel:SetText("Warns totaux: " .. #warnings)
    end)

    net.Receive("AddPlayerWarning", function()
        local warning = net.ReadTable()
        warningsList:AddLine(warning.id, warning.date, warning.reason, warning.author,warning.expiration /*warning.expiration*/)
        notification.AddLegacy("Vous avez reçus un avertissement pour la raison "..warning.Raison.." par "..warning.Auteur,NOTIFY_HINT,5)
        UpdateTotalWarns()
    end)

    local AverSteamIDPanel = vgui.Create("DPanel")
    propertySheet:AddSheet("Avertissements SteamID", AverSteamIDPanel, "icon16/error.png")
    AverSteamIDPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
        draw.SimpleTextOutlined("Raison:", "Nino7:10", RX(140), RY(1560), MyLib.ColorServer["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        // draw.SimpleTextOutlined("Expiration:", "Nino7:10", RX(1350), RY(1560), MyLib.ColorServer["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
    end
    
    local steamIDSearchBar = vgui.Create("DTextEntry", AverSteamIDPanel)
    steamIDSearchBar:SetSize(RX(200.5), RY(70))
    steamIDSearchBar:SetPos(RX(2127.5), RY(1525))
    steamIDSearchBar:SetPlaceholderText("Entrez un SteamID")

    local validateSteamIDButton = vgui.Create("DButton", AverSteamIDPanel)
    validateSteamIDButton:SetText("Rechercher")
    validateSteamIDButton:SetSize(RX(293.5), RY(70))
    validateSteamIDButton:SetPos(RX(2338), RY(1525))
    validateSteamIDButton:SetFont("fontTueuragage1")
    validateSteamIDButton.isSound = false
    validateSteamIDButton:SetTextColor(MyLib.ColorServer["Black"])
    validateSteamIDButton.Paint = function(self, w, h)
        if validateSteamIDButton:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            if not validateSteamIDButton.isSound then
                surface.PlaySound("UI/buttonrollover.wav")
                validateSteamIDButton.isSound = true
            end
        else
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
            draw.RoundedBox(0, 0, RY(60), w, RY(25), MyLib.ColorServer["GreentSecond"])
            validateSteamIDButton.isSound = false
        end
    end
    validateSteamIDButton.DoClick = function()
        if steamIDSearchBar:GetValue() == "" then
            chat.AddText(Color(255, 0, 0), "Veuillez entrer un SteamID.")
        elseif not IsValidSteamID(steamIDSearchBar:GetValue()) then
            chat.AddText(Color(255, 0, 0), "Veuillez entrer un SteamID valide.")
        else
            net.Start("RequestSteamIDWarnings")
            net.WriteString(steamIDSearchBar:GetValue())
            net.SendToServer()
        end
    end

    local steamIDWarningsList = vgui.Create("DListView", AverSteamIDPanel)
    steamIDWarningsList:SetSize(RX(2625), RY(1480))
    steamIDWarningsList:SetPos(RX(9), RY(20))
    steamIDWarningsList:SetMultiSelect(false)
    steamIDWarningsList:AddColumn("ID"):SetFixedWidth(RX(100))
    steamIDWarningsList:AddColumn("Date"):SetFixedWidth(RX(250))
    steamIDWarningsList:AddColumn("Raison"):SetFixedWidth(RX(1785))
    steamIDWarningsList:AddColumn("Auteur"):SetFixedWidth(RX(250))
    //steamIDWarningsList:AddColumn("Expiration"):SetFixedWidth(RX(240))
    steamIDWarningsList.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
    end
    steamIDWarningsList.OnRowRightClick = function(panel, lineIndex)
        local line = panel:GetLine(lineIndex)
        local menu = DermaMenu()
        
        menu:AddOption("Supprimer", function()
            surface.PlaySound("pcasino/basicslotmachine/win_tune.wav")
            local warningID = tonumber(line:GetValue(1))
        
            steamIDWarningsList:RemoveLine(lineIndex)
            net.Start("RequestRemoveSteamIDWarning")
            net.WriteUInt(warningID, 32)
            net.SendToServer()
        
            net.Start("RequestSteamIDWarnings")
            net.WriteString(steamIDSearchBar:GetValue())
            net.SendToServer()
        
            UpdateTotalWarns()
            
            -- Ajoutez cette ligne pour mettre à jour la liste après la suppression
            validateSteamIDButton.DoClick()
        end)
        
        
        menu:Open()
    end
    

    -- local durationSteamIDComboBox = vgui.Create("DComboBox", AverSteamIDPanel)
    -- durationSteamIDComboBox:SetSize(RX(150), RY(70))
    -- durationSteamIDComboBox:SetPos(RX(1540), RY(1525))
    -- durationSteamIDComboBox:SetValue("Durée")
    -- durationSteamIDComboBox:AddChoice("1 mois")
    -- durationSteamIDComboBox:AddChoice("2 mois")
    -- durationSteamIDComboBox:AddChoice("3 mois")
    

    local steamIDReasonEntry = vgui.Create("DTextEntry", AverSteamIDPanel)
    steamIDReasonEntry:SetSize(RX(900), RY(70))
    steamIDReasonEntry:SetPos(RX(280), RY(1525))
    steamIDReasonEntry:SetPlaceholderText("Raison")

    local steamIDValidateButton = vgui.Create("DButton", AverSteamIDPanel)
    steamIDValidateButton:SetText("Sanctionner")
    steamIDValidateButton:SetSize(RX(411), RY(70))
    steamIDValidateButton:SetPos(RX(1700), RY(1525))
    steamIDValidateButton:SetFont("fontTueuragage1")
    steamIDValidateButton.isSound = false
    steamIDValidateButton:SetTextColor(MyLib.ColorServer["Black"])
    steamIDValidateButton.Paint = function(self, w, h)
        if steamIDValidateButton:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            if not steamIDValidateButton.isSound then
                surface.PlaySound("UI/buttonrollover.wav")
                steamIDValidateButton.isSound = true
            end
        else
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
            draw.RoundedBox(0, 0, RY(60), w, RY(25), MyLib.ColorServer["GreentSecond"])
            steamIDValidateButton.isSound = false
        end
    end
    if MyLib.StaffGeneralPrincipalePerm[LocalPlayer():GetUserGroup()] or LocalPlayer():IsSuperAdmin() then
        steamIDValidateButton.DoClick = function()
            surface.PlaySound("pcasino/basicslotmachine/fail_tune.wav")
            if steamIDSearchBar:GetValue() == "" or steamIDReasonEntry:GetValue() == "" then
                chat.AddText(Color(255, 0, 0), "Veuillez écrire un SteamID, une raison.")
            elseif not IsValidSteamID(steamIDSearchBar:GetValue()) then
                chat.AddText(Color(255, 0, 0), "Veuillez entrer un SteamID valide.")
            else
              -- local durationInDays = 0
              -- if durationSteamIDComboBox:GetValue() == "1 mois" then
              --     durationInDays = 30
              -- elseif durationSteamIDComboBox:GetValue() == "2 mois" then
              --     durationInDays = 60
              -- elseif durationSteamIDComboBox:GetValue() == "3 mois" then
              --     durationInDays = 90
              -- end
            
                net.Start("AddSteamIDWarning")
                net.WriteString(steamIDSearchBar:GetValue())
                net.WriteString(steamIDReasonEntry:GetValue())
                //net.WriteUInt(durationInDays, 32)
                net.SendToServer()
            
                steamIDSearchBar:SetValue("")
                steamIDReasonEntry:SetValue("")
            end
        end      
    end
    
    net.Receive("SendSteamIDWarnings", function()
        print("Received SteamID warnings from the server.") 
    
        local warnings = net.ReadTable()
        print("Received SteamID warnings from the server.")
    
        steamIDWarningsList:Clear()
        for _, warning in ipairs(warnings) do
            steamIDWarningsList:AddLine(warning.id, warning.date, warning.reason, warning.author,warning.expiration /*warning.expiration*/)
        end
    end)

    local bansPanel = vgui.Create("DPanel")
    propertySheet:AddSheet("Bannissements", bansPanel, "icon16/exclamation.png")
    bansPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
        draw.SimpleTextOutlined("Raison:", "Nino7:10", RX(140), RY(1560), MyLib.ColorServer["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        draw.SimpleTextOutlined("Temps:", "Nino7:10", RX(1300), RY(1560), MyLib.ColorServer["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
    end

    local dPanelscrollBan = vgui.Create("DPanel", bansPanel)
    dPanelscrollBan:SetSize(RX(500), RY(1480))
    dPanelscrollBan:SetPos(RX(2130), RY(120))
    dPanelscrollBan.Paint = nil

    local scrollPanelBan = vgui.Create("DScrollPanel", dPanelscrollBan)
    scrollPanelBan:Dock(FILL)

    local sbar = scrollPanel:GetVBar()
    function sbar:Paint(w, h)
        draw.RoundedBox(0, RX((5)), 0, w, h, MyLib.ColorServer["Black"])
    end
    function sbar.btnUp:Paint(w, h)
        draw.RoundedBox(0, RX((5)), 0, w, h, MyLib.ColorServer["white"])
    end
    function sbar.btnDown:Paint(w, h)
        draw.RoundedBox(0, RX((5)), 0, w, h, MyLib.ColorServer["white"])
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, RX((5)), 0, w, h, MyLib.ColorServer["white"])
    end
    local selectedPlayer = nil
    for _, ply in ipairs(player.GetAll()) do
        local playerNameTwo = vgui.Create("DButton", scrollPanelBan)
        playerNameTwo:SetText(ply:Nick())
        playerNameTwo:SetSize(RX(0), RY(50))
        playerNameTwo:Dock(TOP)
        playerNameTwo:DockMargin(5, 3, 5, 0)
        playerNameTwo.isSound = false
        playerNameTwo:SetFont("fontTueuragage1")
        playerNameTwo:SetTextColor(MyLib.ColorServer["Black"])
        playerNameTwo.Paint = function(self, w, h)
            if self.isSelected then
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            elseif self:IsHovered() then
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
                if not self.isSound then
                    surface.PlaySound("UI/buttonrollover.wav")
                    self.isSound = true
                end
            else
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
                self.isSound = false
            end
        end
        playerNameTwo.DoClick = function(self)
            if selectedPlayer then
                selectedPlayer.isSelected = false
            end
            selectedPlayer = self
            selectedPlayer.isSelected = true
        end
    end

    local reasonEntry = vgui.Create("DTextEntry", bansPanel)
    reasonEntry:SetSize(RX(900), RY(70))
    reasonEntry:SetPos(RX(280), RY(1525))
    reasonEntry:SetPlaceholderText("Raison")
    
    local timeUnits = vgui.Create("DComboBox", bansPanel)
    timeUnits:SetSize(RX(200), RY(70))
    timeUnits:SetPos(RX(1425), RY(1525))
    timeUnits:SetValue("Unités de temps")
    timeUnits:AddChoice("Minutes")
    timeUnits:AddChoice("Heures")
    timeUnits:AddChoice("Jours")
    timeUnits:AddChoice("Permanent")
    
    local timeEntry = vgui.Create("DTextEntry", bansPanel)
    timeEntry:SetSize(RX(100), RY(70))
    timeEntry:SetPos(RX(1635), RY(1525))
    timeEntry:SetPlaceholderText("Temps")

    local banButton = vgui.Create("DButton", bansPanel)
    banButton:SetSize(RX(400), RY(70))
    banButton:SetPos(RX(1747.5), RY(1525))
    banButton:SetText("Bannir")
    banButton:SetFont("fontTueuragage1")
    banButton:SetTextColor(MyLib.ColorServer["Black"])
    banButton.Paint = function(self, w, h)
        if banButton:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            if not banButton.isSound then
                surface.PlaySound("UI/buttonrollover.wav")
                banButton.isSound = true
            end
        else
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
            draw.RoundedBox(0, 0, RY(60), w, RY(25), MyLib.ColorServer["GreentSecond"])
            banButton.isSound = false
        end
    end
    if MyLib.StaffGeneralPrincipalePerm[LocalPlayer():GetUserGroup()] or LocalPlayer():IsSuperAdmin() then
        banButton.DoClick = function()
            if not selectedPlayer then
                chat.AddText(Color(255, 0, 0), "Aucun joueur sélectionné.")
                return
            end
        
            local reason = reasonEntry:GetValue()
            local timeUnit = timeUnits:GetValue()
            local time = tonumber(timeEntry:GetValue()) or 0
        
            if reason == "" then
                chat.AddText(Color(255, 0, 0), "Veuillez entrer une raison.")
                return
            end
        
            if timeUnit == "Unités de temps" then
                chat.AddText(Color(255, 0, 0), "Veuillez sélectionner des unités de temps.")
                return
            end
        
            if time == 0 and timeUnit ~= "Permanent" then
                chat.AddText(Color(255, 0, 0), "Veuillez entrer un temps valide.")
                return
            end
        
            if timeUnit == "Heures" then
                time = time * 60
            elseif timeUnit == "Jours" then
                time = time * 60 * 24
            elseif timeUnit == "Permanent" then
                time = 0
            end
        
            local target = selectedPlayer:GetText()
            RunConsoleCommand("ulx", "ban", target, time, reason)
        
            reasonEntry:SetValue("")
            timeUnits:SetValue("Unités de temps")
            timeEntry:SetValue("")
            selectedPlayer.isSelected = false
            selectedPlayer = nil
        end
    end
    

    local searchBarBan = vgui.Create("DTextEntry", bansPanel)
    searchBarBan:SetSize(RX(455), RY(70))
    searchBarBan:SetPos(RX(2140), RY(30))
    searchBarBan:SetPlaceholderText("Recherche")
    searchBarBan.OnTextChanged = function()
        local searchText = string.lower(searchBarBan:GetValue())
        UpdateWarningsList(searchText)
        
        if searchText:match("^STEAM_%d:%d:%d+$") then
            UpdatePlayerWarnings(searchText)
        else
            for _, child in ipairs(scrollPanelBan:GetCanvas():GetChildren()) do
                if string.find(string.lower(child:GetText()), searchText) then
                    child:SetVisible(true)
                else
                    child:SetVisible(false)
                end
            end
        end
    end    

    net.Receive("ReceiveSteamIDWarnings", function()
        print("Received SteamID warnings from the server.") 
    
        local warnings = net.ReadTable()
    
        steamIDWarningsList:Clear()
        for _, warning in ipairs(warnings) do
            steamIDWarningsList:AddLine(warning.id, warning.date, warning.reason, warning.author /*warning.expiration*/)
        end
    end)
    if steamID then
        steamIDSearchBar:SetValue(steamID)
        net.Start("RequestSteamIDWarnings")
        net.WriteString(steamID)
        net.SendToServer()
    end

    local function createTicketList(parent)
        if IsValid(ticketList) then
            ticketList:Remove()
        end

        ticketList = vgui.Create("DListView", parent)
        ticketList:SetSize(RX(2620), RY(1490))
        ticketList:SetPos(RX(10), RY(20))
        ticketList:SetMultiSelect(false)
        ticketList:AddColumn("Nom"):SetFixedWidth(RX(660))
        ticketList:AddColumn("Nombre de ticket(s) terminé"):SetFixedWidth(RX(1980))
        ticketList.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
        end
    end

    local function updateTicketList(finishedTickets)
        if not ticketList or not IsValid(ticketList) then
            return
        end

        ticketList:Clear()

        for _, ticket in ipairs(finishedTickets) do
            ticketList:AddLine(ticket.author, ticket.count)
        end
    end


    if CLIENT then
        if MyLib.AllPerm[LocalPlayer():GetUserGroup()] then
            local ticketPanel = vgui.Create("DPanel")
            propertySheet:AddSheet("Nombre de ticket(s)", ticketPanel, "icon16/error.png")
            ticketPanel.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
            end
            createTicketList(ticketPanel)
            local RefButton = vgui.Create("DButton", ticketPanel)
            RefButton:SetPos(RX(10), RY(1527.5))
            RefButton:SetSize(RX(2620), RY(80))
            RefButton:SetText("");
            RefButton.isSound = false
            RefButton.Paint = function(s,w,h)
	        	if RefButton:IsHovered() then
	        		draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
	        		if not RefButton.isSound then
	        			surface.PlaySound("UI/buttonrollover.wav")
	        			RefButton.isSound = true
	        		end
	        		draw.SimpleText("Rafraîchir le nombre de ticket", "fontStaff2", RX(1000), RY(10), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	        	else
	        		RefButton:SetTextColor(color_white)
	        		draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
	        		RefButton.isSound = false
	        		draw.SimpleText("Rafraîchir le nombre de ticket", "fontStaff2", RX(1000), RY(10), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	        	end
	        end
            if MyLib.StaffGeneralPrincipalePerm[LocalPlayer():GetUserGroup()] or LocalPlayer():IsSuperAdmin() then
	            RefButton.DoClick = function()
                    net.Start("refreshFinishedTickets")
                    net.SendToServer()
                end        
            end
            net.Receive("updateFinishedTickets", function(len)
                local finishedTickets = net.ReadTable()
                updateTicketList(finishedTickets)
            end)
        end
    end
end


hook.Add("AdminWarningButtonClicked", "OpenModerationPanelWithPlayer", function(selectedPlayer)
    OpenModerationPanel(selectedPlayer)
end)

hook.Add("AdminWarnIDButtonClicked", "OpenModerationPanelWithPlayer", function(selectedPlayer)
    OpenModerationPanel(selectedPlayer)
    SetActiveTab(2)
end)

hook.Add("AdminBanButtonClicked", "OpenModerationPanelWithPlayer", function(selectedPlayer)
    OpenModerationPanel(selectedPlayer)
    SetActiveTab(3)
end)

hook.Add("AdminTicketButtonClicked", "OpenModerationPanelWithPlayer", function(selectedPlayer)
    OpenModerationPanel(selectedPlayer)
    SetActiveTab(4)
end)

hook.Add("OnPlayerChat", "OpenModerationPanelOnCommand", function(ply, text, teamChat, isDead)
    if MyLib.StaffGeneralPrincipalePerm[LocalPlayer():GetUserGroup()] or LocalPlayer():IsSuperAdmin() then
        if ply == LocalPlayer() and string.lower(text) == "!odmod" then
            OpenModerationPanel()
            return true
        end
    end
end)

hook.Add("OnPlayerChat", "OpenWarnJoueur", function(ply, text, teamChat, isDead)
    if ply == LocalPlayer() and string.lower(text) == "!warn" then
        OpenWarnJoueurPanel()
        return true
    end
end)
