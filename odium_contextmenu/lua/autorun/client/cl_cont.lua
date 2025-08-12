ODIUMRPCONTEXT = ODIUMRPCONTEXT or {}

ODIUMRPCONTEXT.iW = ScrW()
ODIUMRPCONTEXT.iH = ScrH()

function RX(x)
    return x / 3840 * ODIUMRPCONTEXT.iW
end

function RY(y)
    return y / 2160 * ODIUMRPCONTEXT.iH
end

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChanged", function()

    ODIUMRPCONTEXT.iW = ScrW()
    ODIUMRPCONTEXT.iH = ScrH()

end)

local frame
local lastButtonY = RY(90)

--local OdiumStart = Material("odium_general_logo/reprendre.png", "noclamp smooth")
--local OdiumDeco = Material("odium_general_logo/deconnexion.png", "noclamp smooth")
--local icon = Material("odium_atm_icons/icon_odium_frame.png", "noclamp smooth")
--local iconGradient = Material("odium_general_logo/neon.png", "noclamp smooth")
--local Gradient = Material("odium_general_logo/gradientsOne.png", "noclamp smooth")
--local GradientBas = Material("odium_general_logo/gradients.png", "noclamp smooth")
--local neons = Material("odium_general_logo/neons.png", "noclamp smooth")
--local baseBarre = Material("odium_general_logo/baseBarre.png", "noclamp smooth")
--local ticket = Material("odium_general_logo/ticket.png", "noclamp smooth")
--local bienvenue = Material("odium_general_logo/bienvenuee.png", "smooth")
--local odiumrp = Material("odium_general_logo/ODIUMRP.png", "noclamp smooth")
local odiumlogo = Material("odium_general_logo/odiumlogo.png", "noclamp smooth")
local rondneon = Material("odium_general_logo/rondneon.png", "smooth")
--local stopperleson = Material("odium_general_logo/stoppersonambiant.png", "noclamp smooth")
--local Boutique = Material("odium_general_logo/BouShop.png", "noclamp smooth")
--local Forum = Material("odium_general_logo/site.png", "noclamp smooth")
--local Changerdevue = Material("odium_general_logo/Changer de vue.png", "noclamp smooth")
--local afk = Material("odium_general_logo/afk.png", "noclamp smooth")
--local tuto = Material("odium_general_logo/tuto.png", "noclamp smooth")
--local workshop = Material("odium_general_logo/workshop.png", "noclamp smooth")
--local odiumlogorond = Material("odium_atm_icons/icon_odium_frame.png", "noclamp smooth")
--local discordgendarme = Material("odium_general_logo/gmggmgmptit.png", "noclamp smooth")
--local gm1 = Material("odium_tab/mandat.png", "smooth")
--local gmtabletttt = Material("odium_general_logo/gmtablet.png", "smooth")
--local tablettegm = Material("odium_general_logo/tablet_samsung.png", "smooth")

local cos, sin, rad = math.cos, math.sin, math.rad
local PANEL = {}

hook.Add("PlayerBindPress", "player_click", function(ply, bind, pressed)
    if bind == "attack" or bind == "use" then
        local trace = ply:GetEyeTrace()
        local target = trace.Entity
        if target:IsPlayer() then
            selectedPlayer = target
        end
    end
end)
 
AccessorFunc( PANEL, "m_masksize", "MaskSize", FORCE_NUMBER )

function PANEL:Init()
    self.Avatar = vgui.Create("AvatarImage", self)
    self.Avatar:SetPaintedManually(true)
    self:SetMaskSize( 24 )
end

function PANEL:PerformLayout()
    self.Avatar:SetSize(self:GetWide(), self:GetTall())
end

function PANEL:SetPlayer( id )
    self.Avatar:SetPlayer( id, self:GetWide() )
end

surface.CreateFont( "fontOdiumTab1", {
	font = "Righteous", 
	extended = false,
	size = RX(60),
    weight = RY(500)
} )
surface.CreateFont( "fontOdiumTab2", {
	font = "Righteous", 
	extended = false,
	size = RX(80),
    weight = RY(500)
} )
surface.CreateFont( "fontOdiumTab3", {
	font = "Righteous", 
	extended = false,
	size = RX(70),
    weight = RY(500)
} )
surface.CreateFont( "fontOdiumTab4", {
	font = "Righteous", 
	extended = false,
	size = RX(50),
    weight = RY(500)
} )

surface.CreateFont( "fontOdiumTab5", {
	font = "Righteous", 
	extended = false,
	size = RX(45),
    weight = RY(500)
} )

local buttonsTabOdium = {}
local buttonsTabOdiumStaff = {}
local buttonsTabOdiumStaff2 = {}

local function addButton(name, onClick)
    local button = vgui.Create("DButton", frame)
    button:SetSize(RX(750), RY(100))
    button:SetPos(RX(140), RY(710 + #buttonsTabOdium * 110)) 
    button:SetText("")
    button:IsHovered(true)
    button.isSound = false
    button.Paint = function(self, w, h)
        if button:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            draw.SimpleTextOutlined(name, "fontOdiumTab3", RX(360), RY(50), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            if not button.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				button.isSound = true
			end
        else
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            draw.RoundedBox(0, RX(10), RY(10), RX(730), RY(80), MyLib.ColorServer["Green"])
            
            draw.SimpleTextOutlined(name, "fontOdiumTab1", RX(360), RY(50), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            button.isSound = false
        end
    end
    button.DoClick = onClick

    table.insert(buttonsTabOdium, button)
end

local function addButton2(name, onClick)
    local button = vgui.Create("DButton", frame)
    button:SetSize(RX(750), RY(100))
    button:SetPos(RX(140), RY(750 + #buttonsTabOdium * 110)) 
    button:SetText("")
    button:IsHovered(true)
    button.isSound = false
    button.Paint = function(self, w, h)
        if button:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            draw.SimpleTextOutlined(name, "fontOdiumTab3", RX(360), RY(50), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            if not button.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				button.isSound = true
			end
        else
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            draw.RoundedBox(0, RX(10), RY(10), RX(730), RY(80), MyLib.ColorServer["Green"])
            
            draw.SimpleTextOutlined(name, "fontOdiumTab1", RX(360), RY(50), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            button.isSound = false
        end
    end
    button.DoClick = onClick

    table.insert(buttonsTabOdium, button)
end

local function addButtonStaff(name, onClick)
    local button = vgui.Create("DButton", frame)
    button:SetSize(RX(150), RY(70))
    button:SetPos(RX(200 + #buttonsTabOdiumStaff * 160), RX(1880)) 
    button:SetText("")
    button:IsHovered(true)
    button.isSound = false
    button.Paint = function(self, w, h)
        if button:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            draw.SimpleTextOutlined(name, "fontOdiumTab1", RX(75), RY(35), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            if not button.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				button.isSound = true
			end
        else
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            draw.RoundedBox(0, RX(5), RY(5), RX(143), RY(63), MyLib.ColorServer["Green"])
            
            draw.SimpleTextOutlined(name, "fontOdiumTab4", RX(75), RY(35), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            button.isSound = false
        end
    end
    button.DoClick = onClick

    table.insert(buttonsTabOdiumStaff, button)
end

local function addButtonStaff2(name, onClick)
    local button = vgui.Create("DButton", frame)
    button:SetSize(RX(150), RY(70))
    button:SetPos(RX(200 + #buttonsTabOdiumStaff2 * 160), RX(1960)) 
    button:SetText("")
    button:IsHovered(true)
    button.isSound = false
    button.Paint = function(self, w, h)
        if button:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            draw.SimpleTextOutlined(name, "fontOdiumTab1", RX(75), RY(35), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            if not button.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				button.isSound = true
			end
        else
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
            draw.RoundedBox(0, RX(5), RY(5), RX(143), RY(63), MyLib.ColorServer["Green"])
            
            draw.SimpleTextOutlined(name, "fontOdiumTab4", RX(75), RY(35), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            button.isSound = false
        end
    end
    button.DoClick = onClick

    table.insert(buttonsTabOdiumStaff2, button)
end

hook.Add("OnContextMenuOpen", "OdiumContext", function(menu)
    local ply = LocalPlayer()
    frame = vgui.Create("DFrame")
    frame:SetSize(RX(1000), RY(2160))
    frame:SetPos(ScrW()- 0, ScrH()- RY(2160))
    frame:MoveTo(ScrW() - RX(1000), ScrH() - RY(2160), 0.2, 0, 0.8, function() end)
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
	--frame:SlideDown(0.5)
    frame:MakePopup()
    frame:SetTitle( "" )
    frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, RY(0), w, h, MyLib.ColorServer["Black"])
        draw.RoundedBox(0, 0, 0, RY(25), h, MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, 0, RY(7), h, MyLib.ColorServer["Black"])
        draw.SimpleTextOutlined("Disponibilité braquage:", "fontOdiumTab3", RX(500), RY(1800), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        draw.SimpleTextOutlined("─────────────", "fontOdiumTab3", RX(500), RY(1840), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        local bankRobberyText = "Braquage de banque non disponible: OFF"
        local bankRobberyTextColor = MyLib.ColorServer["Red"]
    
        if team.NumPlayers(TEAM_STAFF) >= 4 then
            bankRobberyText = "Braquage de banque disponible: ON"
            bankRobberyTextColor = MyLib.ColorServer["GreenClaire"]
        end
    
        local micromniaRobberyText = "Braquage de micromania non disponible: OFF"
        local micromniaRobberyTextColor = MyLib.ColorServer["Red"]
    
        if team.NumPlayers(TEAM_STAFF) >= 3 then
            micromniaRobberyText = "Braquage de micromania disponible: ON"
            micromniaRobberyTextColor = MyLib.ColorServer["GreenClaire"]
        end
    
        local armuryRobberyText = "Braquage d'armurie non disponible: OFF"
        local armuryRobberyTextColor = MyLib.ColorServer["Red"]
    
        if team.NumPlayers(TEAM_STAFF) >= 2 then
            armuryRobberyText = "Braquage d'armurie disponible: ON"
            armuryRobberyTextColor = MyLib.ColorServer["GreenClaire"]
        end
        
        draw.SimpleTextOutlined(bankRobberyText, "fontOdiumTab5", RX(500), RY(1900), bankRobberyTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        draw.SimpleTextOutlined(micromniaRobberyText, "fontOdiumTab5", RX(500), RY(2010), micromniaRobberyTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        draw.SimpleTextOutlined(armuryRobberyText, "fontOdiumTab5", RX(500), RY(1955), armuryRobberyTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
    
        local rotation = 20 * math.sin(CurTime())
    
        surface.SetMaterial(rondneon)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRectRotated(RX(505), RY(325), RX(530), RY(530), rotation)
    
        surface.SetMaterial(odiumlogo)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRectRotated(RX(505), RY(325), RX(450), RY(450), rotation)
    end

    if MyLib.AllPerm[LocalPlayer():GetUserGroup()] or ply:getDarkRPVar("job") == "Staff" then
        local buttonStaff = vgui.Create("DButton", frame)
        buttonStaff:SetSize(RX(750), RY(75))
        buttonStaff:SetPos(RX(140), RY(2060))
        buttonStaff:SetText("")
        buttonStaff:IsHovered(true)
        buttonStaff.isSound = false
    
        buttonStaff.Paint = function(self, w, h)
    
            if buttonStaff:IsHovered() then
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
                draw.SimpleTextOutlined("Mode Staff", "fontOdiumTab3", RX(370), RY(40), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
                if not buttonStaff.isSound then
                    surface.PlaySound("UI/buttonrollover.wav")
                    buttonStaff.isSound = true
                end
            else
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
                draw.RoundedBox(0, RX(10), RY(10), RX(730), RY(55), MyLib.ColorServer["Green"])
    
                draw.SimpleTextOutlined("Mode Staff", "fontOdiumTab4", RX(370), RY(40), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
                buttonStaff.isSound = false
            end
        end
        buttonStaff.DoClick = function()
            RunConsoleCommand("say", "!staff")
        end
        local frameStaff = vgui.Create("DFrame", frame)
        frameStaff:SetSize(RX(750), RY(275))
        frameStaff:SetPos(RX(140), RY(1775))
        frameStaff:SetDraggable( false )
        frameStaff:ShowCloseButton( false )
	    --frameStaff:SlideDown(0.5)
        frameStaff:SetTitle( "" )
        frameStaff.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, RY(0), w, h, MyLib.ColorServer["Green"])
            draw.RoundedBox(0, 0, RY(0), w, RY(10), MyLib.ColorServer["GreentSecond"])
            draw.RoundedBox(0, 0, RY(80), w, RY(10), MyLib.ColorServer["GreentSecond"])
            draw.RoundedBox(0, 0, RY(265), w, RY(10), MyLib.ColorServer["GreentSecond"])
            draw.RoundedBox(0, 0, RY(0), RX(10), h, MyLib.ColorServer["GreentSecond"])
            draw.RoundedBox(0, RX(740), RY(0), RX(10), h, MyLib.ColorServer["GreentSecond"])
            draw.SimpleTextOutlined("Administration", "fontOdiumTab1", RX(360), RY(45), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        end
        addButtonStaff("Warn", function()
            RunConsoleCommand("say", "!odmod")
        end)
        addButtonStaff("WarnID", function()
            hook.Run("AdminWarnIDButtonClicked", selectedPlayer)
        end)
        addButtonStaff("Ban", function()
            hook.Run("AdminBanButtonClicked", selectedPlayer)
        end)
        addButtonStaff("Ulx", function()
            RunConsoleCommand("say", "!menu")
        end)
        addButtonStaff2("Logs", function()
            RunConsoleCommand("say", "!blogs")
        end)
        addButtonStaff2("Pub", function()
            RunConsoleCommand("say", "/pub Bonjour/Bonsoir Discord du serveur important : <url>https://discord.gg/TGxpzv7jPT</url> !")
        end)
        addButtonStaff2("VIP", function()
            RunConsoleCommand("say", "/pub <hsv>Pack VIP, ODpoint, Famille, Pack Vape, Pack Argent: https://odiumlibrary.com/shop/categories/packvip</hsv>")
        end)
        addButtonStaff2("Rappel", function()
            RunConsoleCommand("say", "// <hsv>Rappel, pour faire un ticket utiliser la commande, ! ou C --> Faire un ticket !</hsv>")
        end)
    end

    addButton("Faire un ticket", function()
        RunConsoleCommand("say", "!")
    end)
    addButton("Stopsound", function()
        RunConsoleCommand("stopsound")
    end)
    addButton("Mode AFK", function()
        RunConsoleCommand("say", "/afk")
    end)
    addButton("Lâcher son arme", function()
        RunConsoleCommand("say", "/drop")
    end)
    addButton("3ème personne", function()
        RunConsoleCommand("simple_thirdperson_enable_toggle")
    end)
    addButton("Casier Warn", function()
        RunConsoleCommand("say", "!warn")
    end)
    addButton2("Discord", function()
        gui.OpenURL("https://discord.gg/TGxpzv7jPT")
    end)
    addButton2("Boutique", function()
        gui.OpenURL("https://odiumrp.fr/shop")
    end)
    addButton2("Tutoriels", function()
        gui.OpenURL("https://www.youtube.com/channel/UC0WjT0RU6xVyQaqp3aPz3aQ")
    end)
end)

hook.Add("OnContextMenuClose", "OdiumContext", function()
    if IsValid(frame) then
        for _, button in ipairs(buttonsTabOdium) do
            if IsValid(button) then
                button:Remove()
            end
        end
        for _, button in ipairs(buttonsTabOdiumStaff) do
            if IsValid(button) then
                button:Remove()
            end
        end
        for _, button in ipairs(buttonsTabOdiumStaff2) do
            if IsValid(button) then
                button:Remove()
            end
        end
        buttonsTabOdium = {}
        buttonsTabOdiumStaff = {}
        buttonsTabOdiumStaff2 = {}
        frame:Remove()
    end
    if IsValid(frameStaff) then frameStaff:Remove() end
end)