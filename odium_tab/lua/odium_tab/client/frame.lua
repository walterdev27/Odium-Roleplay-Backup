ODIUMRPTAB = ODIUMRPTAB or {}

ODIUMRPTAB.iW = ScrW()
ODIUMRPTAB.iH = ScrH()

function RX(x)
    return x / 3840 * ODIUMRPTAB.iW
end

function RY(y)
    return y / 2160 * ODIUMRPTAB.iH
end

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChanged", function()

    ODIUMRPTAB.iW = ScrW()
    ODIUMRPTAB.iH = ScrH()

end)


surface.CreateFont("FontTab1", {font = "Righteous", size = RX(40)})
surface.CreateFont("FontTab2", {font = "Righteous", size = RX(35)})
surface.CreateFont("FontTab3", {font = "Righteous", size = RX(30)})
surface.CreateFont("FontTab4", {font = "Righteous", size = RX(20)})
surface.CreateFont("FontTab5", {font = "Righteous", size = RX(25)})
surface.CreateFont("FontTab15", {font = "Righteous", size = RX(21)})
surface.CreateFont("FontTab6", {font = "Righteous", size = RX(30)})
surface.CreateFont("FontTab7", {font = "Righteous", size = RX(50)})

timer.Simple(2.5, function()
	hook.Remove("RenderScreenspaceEffects", "CW20_RenderScreenspaceEffects")
end)

surface.CreateFont("NinoTab1", {
    font = "Righteous",
     extended = false,
      size = RX(55),
       weight = RY(1000),
})

surface.CreateFont("NinoTab2", {
    font = "Righteous",
     extended = false,
      size = RX(65),
       weight = RY(1000),
})

surface.CreateFont("NinoTab3", {
    font = "Righteous",
     extended = false,
      size = RX(50),
       weight = RY(1000),
})

surface.CreateFont("NinoTab4", {
    font = "Righteous",
     extended = false,
      size = RX(45),
       weight = RY(1000),
})

surface.CreateFont("NinoTab5", {
    font = "Righteous",
     extended = false,
      size = RX(70),
       weight = RY(1000),
})

local de500a600 = Material("odium_general_logo/500a600ping.png", "noclamp smooth")
local de400a500 = Material("odium_general_logo/400a500ping.png", "noclamp smooth")
local de300a400 = Material("odium_general_logo/300a400ping.png", "noclamp smooth")
local de200a300 = Material("odium_general_logo/200a300ping.png", "noclamp smooth")
local de100a200 = Material("odium_general_logo/100a200ping.png", "noclamp smooth")
local de0a100 = Material("odium_general_logo/0a100ping.png", "noclamp smooth")


local function createButton(text, parent, x, y, w, h, onClick, alignRight)
    local button = vgui.Create("DButton", parent)
    button:SetSize(w, h)
    if alignRight then
        button:SetPos(parent:GetWide() - x - w, y)
    else
        button:SetPos(x, y)
    end
    button:SetText("")
	button.Paint = function(self, w, h)
        if button:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            draw.SimpleTextOutlined(text, "NinoTab4", RX(78), RY(26), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
            if not button.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				button.isSound = true
			end
        else
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            draw.RoundedBox(0, RX(5), RY(5), RX(152), RY(63), MyLib.ColorServer["Green"])
            
            draw.SimpleTextOutlined(text, "NinoTab4", RX(78), RY(26), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
            button.isSound = false
        end
    end
    button.DoClick = onClick
    return button
end

function Openframe()
	FrameScoreboard = vgui.Create("DFrame")
	FrameScoreboard:SetSize(RX(2300), RY(1600))
	FrameScoreboard:SetPos(ScrW()- 0, ScrH()- RY(1900))
    FrameScoreboard:MoveTo(ScrW() - RX(3000), ScrH() - RY(1900), 0.2, 0, 0.8, function() end)
	FrameScoreboard:SetVisible(true)
	FrameScoreboard:ShowCloseButton(false)
	FrameScoreboard:MakePopup()
	FrameScoreboard:SetDraggable(false)
	FrameScoreboard:SetTitle("")
	FrameScoreboard.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
		draw.RoundedBox(0, RX(20), RY(20), RX(2260), RY(200), MyLib.ColorServer["Green"])
		draw.RoundedBox(0, 0, 0, w, RY(10), MyLib.ColorServer["Green"])
		draw.RoundedBox(0, 0, RY(1590), w, RY(10), MyLib.ColorServer["Green"])
		draw.RoundedBox(0, 0, 0, RX(10), h, MyLib.ColorServer["Green"])
		draw.RoundedBox(0, RX(2290), 0, RX(10), h, MyLib.ColorServer["Green"])

		local labels = {"Nom:", "Métiers:", "Kills:", "Morts:", "Ping:"}
		local pos = {RX(55), RX(900), RX(1500), RX(1800), RX(2120)}
		for i, label in ipairs(labels) do
			draw.SimpleText(label, "NinoTab2", pos[i], RY(250), MyLib.ColorServer["white"])
		end

			draw.SimpleTextOutlined("Joueurs en ligne :", "NinoTab2", RX(70), RY(55), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
			draw.SimpleTextOutlined(#player.GetAll().."/"..game.MaxPlayers(), "NinoTab2", RX(200), RY(170), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
			draw.SimpleTextOutlined("#1 [FR/QC] | ODIUM | ADDON EXCLU | 100K START | RC ON", "NinoTab2", RX(580), RY(65), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
			draw.RoundedBox(RX(0), RX(530), RY(40), RX(2), RY(150), MyLib.ColorServer["white"])

			local staffCount = 0
			for _, ply in ipairs(player.GetAll()) do
			    local job = ply:getDarkRPVar("job")
			    if job == "Staff" then
			        staffCount = staffCount + 1
			    end
			end

			draw.SimpleTextOutlined("Nombre de Staff : " .. staffCount, "NinoTab2", RX(580), RY(150), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
	end

	local playerList = vgui.Create("DScrollPanel", FrameScoreboard)
	playerList:SetSize(RX(2250), RY(1230))
	playerList:SetPos(RX(20), RY(340))
	playerList.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
	end

	local sbar = playerList:GetVBar()
    function sbar:Paint(w, h)
        draw.RoundedBox(0, RX(5), 0, w, h, MyLib.ColorServer["BlackF4Second"])
    end
    function sbar.btnUp:Paint(w, h)
        draw.RoundedBox(0, RX(5), 0, w, h, MyLib.ColorServer["Green"])
    end
    function sbar.btnDown:Paint(w, h)
        draw.RoundedBox(0, RX(5), 0, w, h, MyLib.ColorServer["Green"])
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, RX(5), 0, w, h, MyLib.ColorServer["Green"])
    end

	local startY = 10
	local playerBoxes = {}
	local slideBoxes = {}

	for i = 1, #player.GetAll() do
		local v = player.GetAll()[i]
    	local playerBox = vgui.Create("DButton", playerList)
    	playerBox:SetSize(RX(2150), RY(80))
    	playerBox:SetPos(RX(50), RY(startY))
    	playerBox:SetText("")
    	playerBox:IsHovered(true)
    	playerBox.player = v
	    playerBox.Paint = function(self, w, h)
			if not IsValid(v) then
				return
			end
			if playerBox:IsHovered() then
				draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 105, 200))
				draw.SimpleTextOutlined(v:Nick(), "NinoTab2", RX(125), h / 2, MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
				draw.SimpleTextOutlined(v:Deaths(), "NinoTab2", RX(1800), h / 2, MyLib.ColorServer["GreenBlueClaire"],TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
				draw.SimpleTextOutlined(v:Frags(), "NinoTab2", RX(1480), h / 2, MyLib.ColorServer["GreenBlueClaire"],TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
				local job = v:getDarkRPVar("job")
					local plyGroup = v:GetUserGroup()
					if plyGroup == "superadmin" or plyGroup == "fondateur" or table.HasValue(MyLib.JobsVisibleTab, job) then
						draw.SimpleTextOutlined(job, "NinoTab2", RX(830), h / 2, MyLib.ColorServer["GreenBlueClaire"],TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
					end
				if not playerBox.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					playerBox.isSound = true
				end
			else
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
				if IsValid(v) then
	        		draw.SimpleTextOutlined(v:Nick(), "NinoTab1", RX(125), h / 2, MyLib.ColorServer["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
				end
				draw.SimpleTextOutlined(v:Deaths(), "NinoTab1", RX(1800), h / 2, MyLib.ColorServer["White"],TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
				draw.SimpleTextOutlined(v:Frags(), "NinoTab1", RX(1480), h / 2, MyLib.ColorServer["White"],TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
					local job = v:getDarkRPVar("job")
					local plyGroup = v:GetUserGroup()
					if plyGroup == "superadmin" or plyGroup == "fondateur" or table.HasValue(MyLib.JobsVisibleTab, job) then
						draw.SimpleTextOutlined(job, "NinoTab1", RX(830), h / 2, MyLib.ColorServer["White"],TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
					end
				playerBox.isSound = false
			end

			local xPos = (table.Count(player.GetAll()) < 18) and RX(1340) or RX(1325)
			local iconXPos = (table.Count(player.GetAll()) < 18) and RX(1375) or RX(1360)
	
			if IsValid(v) then
				local ping = v:Ping()
				draw.SimpleTextOutlined(ping, "NinoTab1", RX(2070), h / 2, MyLib.ColorServer["White"],TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
			
				if v:Ping() <= 60 then
            	    surface.SetMaterial(de0a100)
            	    surface.SetDrawColor(255, 255, 255)
            	    surface.DrawTexturedRect(RX(1970), RY(7), RX(70), RY(70))
            	elseif v:Ping() <= 150 then
            	    surface.SetMaterial(de100a200)
            	    surface.SetDrawColor(255, 255, 255)
					surface.DrawTexturedRect(RX(1970), RY(7), RX(70), RY(70))
            	elseif v:Ping() <= 250 then
            	    surface.SetMaterial(de200a300)
            	    surface.SetDrawColor(255, 255, 255)
					surface.DrawTexturedRect(RX(1970), RY(7), RX(70), RY(70))
            	elseif v:Ping() <= 350 then
            	    surface.SetMaterial(de300a400)
            	    surface.SetDrawColor(255, 255, 255)
					surface.DrawTexturedRect(RX(1970), RY(7), RX(70), RY(70))
            	elseif v:Ping() <= 450 then
            	    surface.SetMaterial(de400a500)
            	    surface.SetDrawColor(255, 255, 255)
					surface.DrawTexturedRect(RX(1970), RY(7), RX(70), RY(70))
            	elseif v:Ping() <= 550 then
            	    surface.SetMaterial(de500a600)
            	    surface.SetDrawColor(255, 255, 255)
					surface.DrawTexturedRect(RX(1970), RY(7), RX(70), RY(70))
            	end
			end
	    end

		local avatar = vgui.Create("AvatarImage", playerBox)
		avatar:SetSize(RY(80), RY(80))
		avatar:SetPos(RX(0), RY(0))
		avatar:SetPlayer(v, 64)

	    local slideBox = vgui.Create("DPanel", playerList)
	    slideBox:SetSize(RX(2150), RY(160))
	    slideBox:SetPos(RX(50), RY(startY + 80))
	    slideBox:SetVisible(false)
	    slideBox.Paint = function(self, w, h)
		if not IsValid(v) then
        	return
    	end
	        draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 105, 150))
			if IsValid(v) then
				local faimtext = math.Round(v:getDarkRPVar("Energy") or 100)
				local fps = math.Round(1 / FrameTime())
				draw.SimpleTextOutlined("Argent : "..DarkRP.formatMoney(v:getDarkRPVar("money")), "NinoTab3", RX(25), RY(125), MyLib.ColorServer["White"],TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MyLib.ColorServer["Black"])
				draw.SimpleTextOutlined("Métier : "..v:getDarkRPVar("job"), "NinoTab3", RX(450), RY(125), MyLib.ColorServer["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MyLib.ColorServer["Black"])
				draw.SimpleTextOutlined("Grade: "..v:GetUserGroup(), "NinoTab3", RX(800), RY(125), MyLib.ColorServer["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MyLib.ColorServer["Black"])
				draw.SimpleTextOutlined("Vie : "..v:Health(), "NinoTab3", RX(1180), RY(125), MyLib.ColorServer["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MyLib.ColorServer["Black"])
				draw.SimpleTextOutlined("Armure : "..v:Armor(), "NinoTab3", RX(1350), RY(125), MyLib.ColorServer["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MyLib.ColorServer["Black"])
				draw.SimpleTextOutlined("Faim : "..faimtext, "NinoTab3", RX(1610), RY(125), MyLib.ColorServer["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MyLib.ColorServer["Black"])
				draw.SimpleTextOutlined("FPS : "..fps, "NinoTab3", RX(1880), RY(125), MyLib.ColorServer["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MyLib.ColorServer["Black"])
			end
	    end

	    startY = startY + 90

	    local index = table.insert(playerBoxes, playerBox)
	    table.insert(slideBoxes, slideBox)

	    playerBox.DoClick = function()
            if not MyLib.StaffGeneralPrincipalePerm[LocalPlayer():GetUserGroup()] then
				SetClipboardText(v:SteamID())
				notification.AddLegacy("Vous avez copié le Steam ID de : " .. v:Nick(), NOTIFY_GENERIC, 3)
				return
			end			
			

            local isVisible = not slideBoxes[index]:IsVisible()

            for i = 1, #playerBoxes do
                if i ~= index and slideBoxes[i]:IsVisible() then
                    slideBoxes[i]:SetVisible(false)
                end

                local offset = 0
                for j = 1, i - 1 do
                    if slideBoxes[j]:IsVisible() then
                        offset = offset + RY(80)
                    end
                end

                local posY = RY(10 + 90 * (i - 1) + offset)

                if i > index and isVisible then
                    posY = posY + RY(160)
                elseif i > index and not isVisible then
                    posY = posY - RY(40)
                end

                playerBoxes[i]:MoveTo(RX(50), posY, 0.3, 0, 0.8)
                playerBoxes[i]:SetZPos(i)

                if i == index then
                    if isVisible then
                        slideBoxes[i]:SetPos(RX(50), posY + RY(80))
                        slideBoxes[i]:MoveTo(RX(50), posY + RY(80), 0.3, 0, 0.8)
                    else
                        slideBoxes[i]:MoveTo(RX(50), posY + RY(80), 0.3, 0, 0.8, function() slideBoxes[i]:SetVisible(false) end)
                    end
                    slideBoxes[i]:SetZPos(i)
                else
                    slideBoxes[i]:SetPos(RX(50), posY)
                    slideBoxes[i]:SetZPos(i - 1)
                end
            end

            slideBoxes[index]:SetVisible(isVisible)

			if isVisible then
				local btnTeleport = createButton("Teleport", slideBoxes[index], RX(200), RY(25), RX(160), RY(50), function()
					RunConsoleCommand("ulx", "teleport", v:Nick())
				end)
				local btnReturn = createButton("Return", slideBoxes[index], RX(360), RY(25), RX(160), RY(50), function()
					RunConsoleCommand("ulx", "return", v:Nick())
				end)
				local btnGoto = createButton("Goto", slideBoxes[index], RX(520), RY(25), RX(160), RY(50), function()
					RunConsoleCommand("ulx", "goto", v:Nick())
				end)
				local btnSpec = createButton("Spectate", slideBoxes[index], RX(680), RY(25), RX(160), RY(50), function()
					RunConsoleCommand("fspectate", v:Nick())
				end)
				local btnBan = createButton("Ban", slideBoxes[index], RX(840), RY(25), RX(160), RY(50), function()
					hook.Run("AdminBanButtonClicked", selectedPlayer)
				end)
				local btnWarn = createButton("Warn", slideBoxes[index], RX(1000), RY(25), RX(160), RY(50), function()
					RunConsoleCommand("say", "!odmod")
				end)
				local btnSteam = createButton("SteamID", slideBoxes[index], RX(1480), RY(25), RX(160), RY(50), function()
					SetClipboardText(v:SteamID())
					notification.AddLegacy("Vous avez copié le Steam ID de : " .. v:Nick(), NOTIFY_GENERIC, 3)
					return
				end)
				local btnKick = createButton("Kick", slideBoxes[index], RX(1800), RY(25), RX(160), RY(50), function()
					RunConsoleCommand("ulx", "kick", v:Nick(), "Kick pour trop de ping ou autres raison !")
				end)
				if v:GetNWBool("odium:freeze") then
					freeze = "unFreeze"
				else
					freeze = "Freeze"
				end
				local btnFreez = createButton(freeze, slideBoxes[index], RX(1640), RY(25), RX(160), RY(50), function()
					if v:GetNWBool("odium:freeze") then
						v:SetNWBool("odium:freeze", false)
						RunConsoleCommand("ulx", "unfreeze", v:Nick())
					else
						v:SetNWBool("odium:freeze", true)
						RunConsoleCommand("ulx", "freeze", v:Nick())
					end
				end)
			else
				slideBoxes[index]:Clear()
			end

			local SetJob = vgui.Create( "DComboBox", slideBox )
			SetJob:SetSize(RX(160), RY(50))
			SetJob:SetPos(RX(1160), RY(25))
			SetJob:SetText("")
			SetJob.isSound = false
				for k , j in pairs(RPExtraTeams) do
					SetJob:AddChoice( j.name )
				end
				SetJob.OnSelect = function( self, index, value )
					RunConsoleCommand("ulx", "setjob", v:Nick(), value)
				end
			SetJob.Paint = function( self , w , h )
				if SetJob:IsHovered() then
					draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
					draw.SimpleTextOutlined("SetJob", "NinoTab4", RX(78), RY(26), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
					if not SetJob.isSound then
						surface.PlaySound("UI/buttonrollover.wav")
						SetJob.isSound = true
					end
				else
					draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
					draw.RoundedBox(0, RX(5), RY(5), RX(152), RY(63), MyLib.ColorServer["Green"])
					
					draw.SimpleTextOutlined("SetJob", "NinoTab4", RX(78), RY(26), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
					SetJob.isSound = false
				end
			end
			local SetAcces = vgui.Create("DComboBox", slideBox)
			SetAcces:SetSize(RX(160), RY(50))
			SetAcces:SetPos(RX(1320), RY(25))
			SetAcces:SetText("")
			SetAcces.isSound = false

			for k , v in pairs(MyLib.AllGroupsTab) do
				SetAcces:AddChoice( k )
			end
			SetAcces.OnSelect = function(self, index, value)
				if value == "user" then
					RunConsoleCommand("ulx", "removeuser", v:Nick())
				else
					RunConsoleCommand("ulx", "adduser", v:Nick(), value)
				end
			end

			SetAcces.Paint = function(self, w, h)
			    if SetAcces:IsHovered() then
			        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
			        draw.SimpleTextOutlined("SetAcces", "NinoTab4", RX(78), RY(26), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
				
			        if not SetAcces.isSound then
			            surface.PlaySound("UI/buttonrollover.wav")
			            SetAcces.isSound = true
			        end
			    else
			        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
			        draw.RoundedBox(0, RX(5), RY(5), RX(152), RY(63), MyLib.ColorServer["Green"])
			        draw.SimpleTextOutlined("SetAcces", "NinoTab4", RX(78), RY(26), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			        SetAcces.isSound = false
			    end
			end
        end
    end
end

hook.Add("ScoreboardShow","ScoreboardOpen", function() 
	Openframe()
	gui.EnableScreenClicker(true)
	return true
end)

hook.Add("ScoreboardHide", "ScoreboardClose", function()

	if IsValid(FrameScoreboard) then
        FrameScoreboard:Remove()
    end
    gui.EnableScreenClicker(false)
	return true 
end)
