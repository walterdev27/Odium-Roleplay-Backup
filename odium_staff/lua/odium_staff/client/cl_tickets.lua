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

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChangedTicket", function()

    ODIUM.iW = ScrW()
    ODIUM.iH = ScrH()

end)

surface.CreateFont("Nino1:10", {
    font = "Roboto",
     extended = false,
      size = RX(35),
       weight = RY(1000),
})

surface.CreateFont("Nino2:10", {
    font = "Righteous",
     extended = false,
      size = RX(60),
       weight = RY(1000),
})

surface.CreateFont("Nino3:10", {
    font = "Righteous",
     extended = false,
      size = RX(50),
       weight = RY(1000),
})

surface.CreateFont("Nino4:10", {
    font = "Righteous",
     extended = false,
      size = RX(55),
       weight = RY(1000),
})

surface.CreateFont("Nino5:10", {
    font = "Righteous",
     extended = false,
      size = RX(40),
       weight = RY(1000),
})

surface.CreateFont("Nino6:10", {
    font = "Righteous",
     extended = false,
      size = RX(45),
       weight = RY(1000),
})

surface.CreateFont("Nino7:10", {
    font = "Righteous",
     extended = false,
      size = RX(70),
       weight = RY(1000),
})

local logoOdiumEnHaut = Material("odium_hud_icon/odiumiconhud.png", "smooth")
local logoOpen = Material("odium_hud_icon/open.png", "smooth")
local logoClose = Material("odium_hud_icon/close.png", "smooth")
local logoOdium = Material("odium_atm_icons/icon_odium_frame.png", "smooth")

local function OpenReportTicketPanel()
    local frame = vgui.Create("DFrame")
    frame:SetSize(RX(1000), RY(500))
    frame:SetTitle("")
    frame:SetSizable(true)
    frame:ShowCloseButton(false)
    frame:Center()
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
        draw.RoundedBox(0, RX(20), RY(20), RX(960), RY(150), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, 0, RX(10), h, MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, 0, w, RY(10), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, RY(490), w, RY(10), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, RX(990), 0, RX(10), h, MyLib.ColorServer["Green"])
		draw.SimpleTextOutlined("Menu Administration", "Nino2:10", RX(360), RY(90), MyLib.ColorServer["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
    end

	local searchBar = vgui.Create("DTextEntry", frame)
    searchBar:SetSize(RX(930), RY(100))
    searchBar:SetPos(RX(37.5), RY(225))
    searchBar:SetPlaceholderText("Entrée un raison...")
    searchBar.OnTextChanged = function()
    end    

    local closeFrame = vgui.Create("DButton", frame)
        closeFrame:SetPos(RX(900), RY(65))
		closeFrame:SetSize(RX(50), RY(50))
		closeFrame:SetText("");
		closeFrame.isSound = false
		closeFrame.Paint = function(s,w,h)
			if closeFrame:IsHovered() then
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
				if not closeFrame.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					closeFrame.isSound = true
				end
				draw.SimpleText("X", "fontStaff2", RX(10), RY(-6), MyLib.ColorServer["white"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			else
				closeFrame:SetTextColor(MyLib.ColorServer["white"])
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
				closeFrame.isSound = false
				draw.SimpleText("X", "fontStaff2", RX(10), RY(-6), MyLib.ColorServer["white"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end

		end
		closeFrame.DoClick = function()
			if IsValid(frame) then frame:Remove() end
		end

        local EnvoyerFrame = vgui.Create("DButton", frame)
        EnvoyerFrame:SetPos(RX(37.5), RY(380))
		EnvoyerFrame:SetSize(RX(930), RY(80))
		EnvoyerFrame:SetText("");
		EnvoyerFrame.isSound = false
		EnvoyerFrame.Paint = function(s,w,h)
			if EnvoyerFrame:IsHovered() then
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
				if not EnvoyerFrame.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					EnvoyerFrame.isSound = true
				end
				draw.SimpleText("Soumettre", "fontStaff2", RX(360), RY(10), MyLib.ColorServer["white"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			else
				EnvoyerFrame:SetTextColor(MyLib.ColorServer["white"])
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
				EnvoyerFrame.isSound = false
				draw.SimpleText("Soumettre", "fontStaff2", RX(360), RY(10), MyLib.ColorServer["white"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end

		end
		EnvoyerFrame.DoClick = function()
			frame:Remove()
			local reasonText = searchBar:GetText()
			if reasonText and reasonText ~= "" then
				net.Start("reportTicketSubmit")
				net.WriteString(reasonText)
				net.SendToServer()
			else

			end
		end
end

local ticketList
if CLIENT then

	local tickets = {}

	local function wrapText(text, maxCharsPerLine)
		local words = string.Explode(" ", text)
		local lines = {""}
		local currentLine = 1
		local currentLineLength = 0
	
		for _, word in ipairs(words) do
			local wordLength = string.len(word)
	
			if wordLength > maxCharsPerLine then
				while wordLength > maxCharsPerLine do
					local tempWord = string.sub(word, 1, maxCharsPerLine - currentLineLength)
					lines[currentLine] = lines[currentLine] .. tempWord
					word = string.sub(word, maxCharsPerLine - currentLineLength + 1)
					wordLength = string.len(word)
					currentLine = currentLine + 1
					lines[currentLine] = ""
					currentLineLength = 0
				end
			end
	
			if currentLineLength + wordLength + 1 <= maxCharsPerLine then
				if currentLineLength > 0 then
					lines[currentLine] = lines[currentLine] .. " "
					currentLineLength = currentLineLength + 1
				end
				lines[currentLine] = lines[currentLine] .. word
				currentLineLength = currentLineLength + wordLength
			else
				currentLine = currentLine + 1
				lines[currentLine] = word
				currentLineLength = wordLength
			end
		end
	
		for i, line in ipairs(lines) do
			lines[i] = string.Trim(line)
		end
	
		return lines
	end
	
	local function updateTicketList(finishedTickets)
		if not ticketList or not IsValid(ticketList) then
			return
		end
	
		ticketList:Clear()
	
		for _, ticket in ipairs(finishedTickets) do
			ticketList:AddLine(ticket.author, ticket.count)
		end
		for _, assignedPlayer in ipairs(ticket.assignedPlayers) do
			ticketList:AddLine(assignedPlayer:Nick(), ticket.count)
		end
	end

	local function UpdateButtonPositions(ticket, boxWidth, spacing, colSpacing)
		for i, playerUIElements in ipairs(ticket.playerBoxes.playerUIElements) do
			local col = math.floor((i - 1) / 5)
			local row = (i - 1) % 5
	
			playerUIElements.teleportButton:SetPos(col * (boxWidth + spacing + colSpacing) + boxWidth - 45, row * (RY(50) + spacing) + (RY(70) - 30) / 2)
			playerUIElements.returnButton:SetPos(col * (boxWidth + spacing + colSpacing) + boxWidth - 70, row * (RY(50) + spacing) + (RY(70) - 30) / 2)
			playerUIElements.spectateButton:SetPos(col * (boxWidth + spacing + colSpacing) + boxWidth - 95, row * (RY(50) + spacing) + (RY(70) - 30) / 2)
			playerUIElements.removeButton:SetPos(col * (boxWidth + spacing + colSpacing) + boxWidth - 20, row * (RY(50) + spacing) + (RY(65) - 30) / 2)
		end
	end	
	

	local function CreateRemoveButton(parent, player, col, row, boxWidth, spacing, colSpacing, ticket)
		local removeButton = vgui.Create("DButton", parent)
		removeButton:SetSize(20, 20)
		removeButton:SetPos(col * (boxWidth + spacing + colSpacing) + boxWidth - 20, row * (RY(50) + spacing) + (RY(65) - 30) / 2)
		removeButton:SetText("✖")
		removeButton:SetFont("Nino5:10")
		removeButton:SetTextColor(Color(231, 99, 99, 230))
		removeButton.Paint = function() end
		removeButton.DoClick = function()
			for i, assignedPlayer in ipairs(ticket.assignedPlayers) do
				if assignedPlayer == player then
					table.remove(ticket.assignedPlayers, i)
					local playerUIElements = ticket.playerBoxes.playerUIElements[i]
					playerUIElements.teleportButton:Remove()
					playerUIElements.returnButton:Remove()
					playerUIElements.spectateButton:Remove()
					playerUIElements.removeButton:Remove()
					table.remove(ticket.playerBoxes.playerUIElements, i)
		
					UpdateButtonPositions(ticket, boxWidth, spacing, colSpacing)
		
					break
				end
			end
		end
		
		return removeButton
	end

	local function CreateTeleportButton(parent, player, col, row, boxWidth, spacing, colSpacing)
		local teleportButton = vgui.Create("DButton", parent)
		teleportButton:SetSize(RX(44), RY(38))
		teleportButton:SetPos(col * (boxWidth + spacing + colSpacing) + boxWidth - 45, row * (RY(50) + spacing) + (RY(70) - 30) / 2)
		teleportButton:SetText("tp")
		teleportButton:SetFont("Nino5:10")
		teleportButton:SetTextColor(MyLib.ColorServer["white"])
		teleportButton.Paint = function() 
			draw.RoundedBox(0, 0, RY(5), RX(44), RY(38), MyLib.ColorServer["Green"])
		end
		teleportButton.DoClick = function()
			RunConsoleCommand("ulx", "teleport", player:Nick())
		end
		return teleportButton
	end
	
	local function CreateReturnButton(parent, player, col, row, boxWidth, spacing, colSpacing)
		local returnButton = vgui.Create("DButton", parent)
		returnButton:SetSize(RX(44), RY(38))
		returnButton:SetPos(col * (boxWidth + spacing + colSpacing) + boxWidth - 70, row * (RY(50) + spacing) + (RY(70) - 30) / 2)
		returnButton:SetText("rt")
		returnButton:SetFont("Nino5:10")
		returnButton:SetTextColor(MyLib.ColorServer["white"])
		returnButton.Paint = function() 
			draw.RoundedBox(0, 0, RY(5), RX(44), RY(38), MyLib.ColorServer["Green"])
		end
		returnButton.DoClick = function()
			RunConsoleCommand("ulx", "return", player:Nick())
		end
		return returnButton
	end

	local function CreateSpecateeButton(parent, player, col, row, boxWidth, spacing, colSpacing)
		local spectateButton = vgui.Create("DButton", parent)
		spectateButton:SetSize(RX(44), RY(38))
		spectateButton:SetPos(col * (boxWidth + spacing + colSpacing) + boxWidth - 95, row * (RY(50) + spacing) + (RY(70) - 30) / 2)
		spectateButton:SetText("sp")
		spectateButton:SetFont("Nino5:10")
		spectateButton:SetTextColor(MyLib.ColorServer["white"])
		spectateButton.Paint = function() 
			draw.RoundedBox(0, 0, RY(5), RX(44), RY(38), MyLib.ColorServer["Green"])
		end
		spectateButton.DoClick = function()
			RunConsoleCommand("fspectate", player:Nick())
		end
		return spectateButton
	end
	
	local function CreatePlayerListMenu(excludePlayer, ticketAuthor, ticket, x, w, y, ticketIndex)
		local playerListMenu = DermaMenu()
		local spacing = 5
		local colSpacing = 20
		local boxWidth = (w - colSpacing) / 2 - spacing
	
		for i, ticket in ipairs(tickets) do
			local y = RY(30) + (i - 1) * (RY(310) + RY(20))
			DrawTicketRoundedBox(ticket, y, i)
		end
	
		for _, ply in ipairs(player.GetAll()) do
			if ply ~= excludePlayer and ply:Nick() ~= ticketAuthor then
				local alreadyAssigned = false
				if ticket.assignedPlayers then
					for _, assignedPly in ipairs(ticket.assignedPlayers) do
						if ply == assignedPly then
							alreadyAssigned = true
							break
						end
					end
				end

				if not alreadyAssigned then
					local plyNick = ply:Nick()
					playerListMenu:AddOption(plyNick, function()
	
						if not ticket.assignedPlayers then
							ticket.assignedPlayers = {}
						end
	
						if #ticket.assignedPlayers >= 10 then
							notification.AddLegacy("Vous ne pouvez pas ajouter plus de 10 joueurs à un ticket.", NOTIFY_ERROR, 5)
							return
						end
	
						table.insert(ticket.assignedPlayers, ply)
	
					if IsValid(ticket.playerBoxes) then
						ticket.playerBoxes:Remove()
					end
	
					local boxHeight = (RY(50) + 10) * 5
					if not IsValid(ticket.playerBoxes) then
						ticket.playerBoxes = vgui.Create("DPanel")
						ticket.playerBoxes:SetSize(RX(1000), boxHeight)
						ticket.playerBoxes:SetPos(x + w + RX(15), y)
					end
					ticket.playerBoxes.Paint = function(s, w, h)
						for i, player in ipairs(ticket.assignedPlayers) do
							local col = math.floor((i - 1) / 5)
							local row = (i - 1) % 5
							draw.RoundedBox(0, col * (boxWidth + spacing + colSpacing), row * (RY(50) + spacing), boxWidth, RY(50), MyLib.ColorServer["Black"])
							local playerName = string.Explode(" ", player:Nick())[1]
							draw.SimpleText(playerName, "Nino5:10", col * (boxWidth + spacing + colSpacing) + 10, row * (RY(50) + spacing) + RY(50) / 2, MyLib.ColorServer["white"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
							
                    end
                end

                ticket.playerBoxes.teleportButtons = ticket.playerBoxes.teleportButtons or {}
                for i, button in ipairs(ticket.playerBoxes.teleportButtons) do
                    button:Remove()
                end
				
    			ticket.playerBoxes.returnButtons = ticket.playerBoxes.returnButtons or {}
    			ticket.playerBoxes.spectateButtons = ticket.playerBoxes.spectateButtons or {}
    			ticket.playerBoxes.removeButtons = ticket.playerBoxes.removeButtons or {}
    			ticket.playerBoxes.playerUIElements = ticket.playerBoxes.playerUIElements or {}
                for i, player in ipairs(ticket.assignedPlayers) do
					local col = math.floor((i - 1) / 5)
					local row = (i - 1) % 5
					local teleportButton = CreateTeleportButton(ticket.playerBoxes, player, col, row, boxWidth, spacing, colSpacing)
					local returnButton = CreateReturnButton(ticket.playerBoxes, player, col, row, boxWidth, spacing, colSpacing)
					local SpectateButton = CreateSpecateeButton(ticket.playerBoxes, player, col, row, boxWidth, spacing, colSpacing)
					local removeButton = CreateRemoveButton(ticket.playerBoxes, player, col, row, boxWidth, spacing, colSpacing, ticket)
					table.insert(ticket.playerBoxes.teleportButtons, teleportButton)
					table.insert(ticket.playerBoxes.returnButtons, returnButton)
					table.insert(ticket.playerBoxes.spectateButtons, SpectateButton)
					table.insert(ticket.playerBoxes.removeButtons, removeButton)
					local playerUIElements = {
						teleportButton = teleportButton,
						returnButton = returnButton,
						spectateButton = SpectateButton,
						removeButton = removeButton
					}
					table.insert(ticket.playerBoxes.playerUIElements, playerUIElements)
				end
            end)
		end
	end
end

return playerListMenu
end

	
	

    net.Receive("updateFinishedTickets", function(len)
		local ticketAuthor = net.ReadString()
		local ticketCount = net.ReadUInt(32)
		updateTicketList(ticketCount) 
	end)
	
    local tickets = {}
	local ticketCounter = 0

    function CreateTicket(sender, reason)
		local ticket = {
			author = sender:Nick(),
			reason = reason,
			endTime = CurTime() + 60,
			ticketNumber = #tickets + 1,
			isOpen = false,
			assignedPlayers = {},
			openedBy = nil 
		}
		table.insert(tickets, ticket)
	end
	

	local function RemoveTicketButtons(ticket)
		if IsValid(ticket.closeButton) then
			ticket.closeButton:Remove()
		end
	
		if not ticket.isOpen and IsValid(ticket.finishButton) then
			ticket.finishButton:Remove()
		end
	
		if IsValid(ticket.openButton) then
			ticket.openButton:Remove()
		end
	end
	
	local function UpdateFinishButton(ticket, x, w, y)
		if ticket.isOpen then
			if not IsValid(ticket.finishButton) then
				ticket.finishButton = vgui.Create("DButton")
				ticket.finishButton:SetSize(RX(150), RX(37))
				ticket.finishButton:SetText("")
				ticket.finishButton.Paint = function(s, w, h)
					if ticket.finishButton:IsHovered() then
						draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Red"])
						draw.SimpleTextOutlined("Terminer", "Nino5:10", w / 2, h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
					else
						draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Red"])
						draw.SimpleTextOutlined("Terminer", "Nino5:10", w / 2, h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
					end
				end
				ticket.finishButton.DoClick = function()
					ticket.isOpen = not ticket.isOpen
					ticket.endTime = 0
					RemoveTicketButtons(ticket)
	
					local ticketDate = os.date("%Y-%m-%d")
					local ticketCount = 1
	
					net.Start("addFinishedTicket")
					net.WriteString(ticket.author)
					net.WriteString(ticketDate)
					net.WriteUInt(ticketCount, 32)
					net.SendToServer()
					if IsValid(ticket.spectateButton) then
						ticket.spectateButton:Remove()
					end
					if IsValid(ticket.teleportButton) then
						ticket.teleportButton:Remove()
					end
					if IsValid(ticket.ReturnButton) then
						ticket.ReturnButton:Remove()
					end
					if IsValid(ticket.addButton) then
						ticket.addButton:Remove()
					end
					if IsValid(ticket.playerBoxes) then 
						ticket.playerBoxes:Remove()
					end
				end
			end
		else
			if IsValid(ticket.finishButton) then
				ticket.finishButton:Remove()
			end
		end
	
		if IsValid(ticket.finishButton) then
			ticket.finishButton:SetPos(x + w - RX(155), y + RY(268))
		end
	end

	local function CreateSpectateButton(ticket, x, w, y)
		if ticket.isOpen then
			local spectateButton = vgui.Create("DButton")
			spectateButton:SetSize(RX(150), RX(40))
			spectateButton:SetText("")
			spectateButton.Paint = function(s, w, h)
				if spectateButton:IsHovered() then
					draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100, 50))
					draw.SimpleTextOutlined("Spectate", "Nino5:10", w / 2, h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
				else
					draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
					draw.SimpleTextOutlined("Spectate", "Nino5:10", w / 2, h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
				end
			end
			spectateButton.DoClick = function()
				RunConsoleCommand("fspectate", ticket.author)
			end
			spectateButton:SetPos(x + w - RX(280), y + RY(170))
			return spectateButton
		end
	end
	
	local function CreateTeleportButton(ticket, x, w, y)
		local teleportButton = vgui.Create("DButton")
		teleportButton:SetSize(RX(150), RX(40))
		teleportButton:SetText("")
		teleportButton.Paint = function(s, w, h)
			if teleportButton:IsHovered() then
				draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100, 50))
				draw.SimpleTextOutlined("Teleport", "Nino5:10", w / 2, h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			else
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
				draw.SimpleTextOutlined("Teleport", "Nino5:10", w / 2, h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			end
		end
		teleportButton.DoClick = function()
			RunConsoleCommand("ulx", "teleport", ticket.author)
		end
		return teleportButton
	end

	local function CreateReturnButton(ticket, x, w, y)
		local ReturnButton = vgui.Create("DButton")
		ReturnButton:SetSize(RX(150), RX(40))
		ReturnButton:SetText("")
		ReturnButton.Paint = function(s, w, h)
			if ReturnButton:IsHovered() then
				draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100, 50))
				draw.SimpleTextOutlined("Return", "Nino5:10", w / 2, h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			else
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
				draw.SimpleTextOutlined("Return", "Nino5:10", w / 2, h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			end
		end
		ReturnButton.DoClick = function()
			RunConsoleCommand("ulx", "return", ticket.author)
		end
		return ReturnButton
	end

	local function CreateAddButton(ticket, x, w, y)
		local addButton = vgui.Create("DButton")
		addButton:SetSize(RX(150), RX(40))
		addButton:SetText("")
		addButton.Paint = function(s, w, h)
			if addButton:IsHovered() then
				draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100, 50))
				draw.SimpleTextOutlined("Add", "Nino5:10", w / 2, h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			else
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
				draw.SimpleTextOutlined("Add", "Nino5:10", w / 2, h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			end
		end
		addButton.DoClick = function()
			local playerListMenu = CreatePlayerListMenu(LocalPlayer(), ticket.author, ticket, x, w, y, ticket.ticketNumber)
			playerListMenu:Open()
		end
	
		addButton:SetPos(x, y)
		return addButton
	end

	local function UpdateSpectateTeleportButtons(ticket, x, w, y)
		if ticket.isOpen then
			if not IsValid(ticket.spectateButton) then
				ticket.spectateButton = CreateSpectateButton(ticket, x, w, y)
			end
			if not IsValid(ticket.teleportButton) then
				ticket.teleportButton = CreateTeleportButton(ticket, x, w, y)
			end
			if not IsValid(ticket.ReturnButton) then
				ticket.ReturnButton = CreateReturnButton(ticket, x, w, y)
			end
			if not IsValid(ticket.addButton) then
				ticket.addButton = CreateAddButton(ticket, x, w, y)
			end
		else
			if IsValid(ticket.spectateButton) then
				ticket.spectateButton:Remove()
			end
			if IsValid(ticket.teleportButton) then
				ticket.teleportButton:Remove()
			end
			if IsValid(ticket.ReturnButton) then
				ticket.ReturnButton:Remove()
			end
			if IsValid(ticket.addButton) then
				ticket.addButton:Remove()
			end
		end
		
		if IsValid(ticket.ReturnButton) then
			ticket.ReturnButton:SetPos(x + w - RX(155), y + RY(173))
		end
		if IsValid(ticket.spectateButton) then
			ticket.spectateButton:SetPos(x + w - RX(155), y + RY(77.5))
		end
		if IsValid(ticket.teleportButton) then
			ticket.teleportButton:SetPos(x + w - RX(155), y + RY(125))
		end
		if IsValid(ticket.addButton) then
			ticket.addButton:SetPos(x + w - RX(155), y + RY(221))
		end
		if IsValid(ticket.playerBoxes) then
			ticket.playerBoxes:SetPos(x + w + RX(15), y)
		end
	end
	
    function DrawTicketRoundedBox(ticket, y, ticketIndex)
		local w, h = RX(800), RY(310)
		local x = RX(30)
		local remainingTime = math.max(0, math.Round(ticket.endTime - CurTime()))
		UpdateFinishButton(ticket, x, w, y)
		UpdateSpectateTeleportButtons(ticket, x, w, y)
		if not ticket.soundPlayed then
			surface.PlaySound("garrysmod/balloon_pop_cute.wav")
			ticket.soundPlayed = true
		end
	
		if ticket.isOpen and ticket.openedBy == LocalPlayer():SteamID() then
			if IsValid(ticket.openButton) then
				ticket.openButton:Remove()
			end
		end
	
		draw.RoundedBox(0, x, y, w, h, MyLib.ColorServer["Black"])
		draw.RoundedBox(0, x, y, w, RY(70), ticket.isOpen and MyLib.ColorServer["Green"] or MyLib.ColorServer["GreentSecond"])
		draw.SimpleTextOutlined("Auteur : ", "Nino2:10", x + w / 7, y + RY(35), Color(250, 92, 92), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
		draw.SimpleText("Raison : ", "Nino3:10", x + w / 9, y + RY(105), MyLib.ColorServer["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleTextOutlined(ticket.author, "Nino2:10", x + w / 2.4, y + RY(35), MyLib.ColorServer["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
		local wrappedReason = wrapText(ticket.reason, 40)
		local lineHeight = 15
		for i, line in ipairs(wrappedReason) do
			draw.SimpleText(line, "Nino1:10", x + w / 90 + 8, y + RY(150) + (i - 1) * lineHeight, MyLib.ColorServer["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		if not ticket.isOpen then
			draw.SimpleTextOutlined(remainingTime > 0 and string.ToMinutesSeconds(remainingTime) or "", "Nino2:10", x + w / 1.1, y + RY(35), MyLib.ColorServer["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
		end
		

        if not ticket.isOpen and not IsValid(ticket.openButton) then
            ticket.closeButton = vgui.Create("DButton")
            ticket.closeButton:SetSize(RX(45), RX(45))
            ticket.closeButton:SetText("")
            ticket.closeButton.Paint = function(s, w, h)
                if ticket.closeButton:IsHovered() then
                    draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
					draw.SimpleText("✖", "Nino4:10", RX(22), RY(18), Color(255, 255, 255, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                else
					draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
					draw.SimpleText("✖", "Nino4:10", RX(22), RY(18), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
            ticket.closeButton.DoClick = function()
				ticket.endTime = 0
				RemoveTicketButtons(ticket)
				ticket.closeButton:Remove()
				if IsValid(ticket.openButton) then
					ticket.openButton:Remove()
				end
				if IsValid(ticket.spectateButton) then
					ticket.spectateButton:Remove()
				end
				if IsValid(ticket.teleportButton) then
					ticket.teleportButton:Remove()
				end		
				if IsValid(ticket.finishButton) then
					ticket.finishButton:Remove()
				end			
				if IsValid(ticket.ReturnButton) then
					ticket.ReturnButton:Remove()
				end			
			end

			if not ticket.isOpen and not IsValid(ticket.openButton) then
				ticket.openButton = vgui.Create("DButton")
				ticket.openButton:SetSize(RX(45), RX(45))
				ticket.openButton:SetText("")
				ticket.openButton.Paint = function(s, w, h)
					if ticket.openButton:IsHovered() then
						draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
						draw.SimpleText("✔", "Nino4:10", RX(22), RY(18), Color(255, 255, 255, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else
						draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
						draw.SimpleText("✔", "Nino4:10", RX(22), RY(18), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end
				ticket.openButton.DoClick = function()
					ticket.endTime = 0
					ticket.isOpen = not ticket.isOpen
    				remainingTime = 0
    				ticket.endTime = math.huge
    				UpdateFinishButton(ticket, x, w, y)
					ticket.openedBy = LocalPlayer():SteamID()
				
					if ticket.isOpen then
						for k, ply in ipairs(player.GetAll()) do
							if ply:Team() == TEAM_STAFF and ply ~= LocalPlayer() then
								net.Start("removeTicketFromStaff")
								net.WriteUInt(ticket.ticketNumber, 32)
								net.SendToServer()
							end
						end
					end
				
					if IsValid(ticket.closeButton) then
						ticket.closeButton:Remove()
					end
					if IsValid(ticket.openButton) then
						ticket.openButton:Remove()
					end
				end				
				ticket.openButton:SetPos(x + w - RX(140), y + RY(245))
			end
		end
	end

    hook.Add("HUDPaint", "displayTicketsOnTopOfLogo", function()
        if MyLib.MrsLogoHautGauche[LocalPlayer():getDarkRPVar("job")] then
            surface.SetMaterial(logoOdiumEnHaut)
            surface.SetDrawColor(Color(255, 255, 255, 150))
            surface.DrawTexturedRect(RX(30), RY(90), RX(550), RY(200))
        else
            surface.SetMaterial(logoOdiumEnHaut)
            surface.SetDrawColor(Color(255, 255, 255, 150))
            surface.DrawTexturedRect(RX(30), RY(30), RX(550), RY(200))
        end
    
        local y = RY(30)
    	for _, ticket in ipairs(tickets) do
    	    if CurTime() < ticket.endTime then
    	        DrawTicketRoundedBox(ticket, y)
    	        if IsValid(ticket.closeButton) then
    	            ticket.closeButton:SetPos(RX(45) + RX(800) - RX(65), y + RY(260))
    	        end
    	        if IsValid(ticket.openButton) then
    	            ticket.openButton:SetPos(RX(70) + RX(800) - RX(140), y + RY(260))
    	        end
    	        y = y + RY(310) + RY(10)
    	    else
    	        if IsValid(ticket.closeButton) then
    	            ticket.closeButton:Remove()
    	        end
    	        if IsValid(ticket.openButton) then
    	            ticket.openButton:Remove()
    	        end
    	    end
    	end
	end)

    net.Receive("reportTicketToStaff", function(len)
        local sender = net.ReadEntity()
        local reason = net.ReadString()

        ticketCounter = ticketCounter + 1 

        local ticket = {
            author = sender:Nick(),
            reason = reason,
            endTime = CurTime() + 600,
            ticketNumber = ticketCounter 
        }
        table.insert(tickets, ticket)
    end)

    local function removeTicket(ticket)
        for i, t in ipairs(tickets) do
            if t == ticket then
                table.remove(tickets, i)
                return
            end
        end
    end

    hook.Add("Think", "updateTickets", function()
        for _, ticket in ipairs(tickets) do
            if CurTime() >= ticket.endTime then
                if IsValid(ticket.closeButton) then
                    ticket.closeButton:Remove()
                end
                removeTicket(ticket)
            end
        end
    end)
	
	net.Receive("removeTicketFromStaff", function(len)
		local ticketNumber = net.ReadUInt(32)
		for _, ticket in ipairs(tickets) do
			if ticket.ticketNumber == ticketNumber then
				removeTicket(ticket)
				RemoveTicketButtons(ticket)
				break
			end
		end
	end)	
end

if SERVER then
    util.AddNetworkString("removeTicketFromStaff")
    util.AddNetworkString("reportTicketToStaff") 
end

hook.Add("OnPlayerChat", "OpenReportTicketCommand", function(ply, text, teamChat, isDead)
    if ply == LocalPlayer() and string.lower(text) == "!" then
        OpenReportTicketPanel()
        return true
    end
end)

