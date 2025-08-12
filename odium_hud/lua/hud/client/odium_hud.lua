ODIUM = ODIUM or {}

-- Automatic responsive functions
ODIUM.iW = ScrW()
ODIUM.iH = ScrH()

local function RX(x)
    return x / 1920 * ODIUM.iW
end

local function RY(y)
    return y / 1080 * ODIUM.iH
end

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChanged", function()

    ODIUM.iW = ScrW()
    ODIUM.iH = ScrH()

end)


local hidden = { "DarkRP_LocalPlayerHUD", "DarkRP_HUD", "DarkRP_Hungermod", "CHudHealth", "CHudAmmo", "DarkRP_Agenda","DarkRP_ChatReceivers"}

hook.Add("HUDShouldDraw", "CHUD_Hide", function(name)
    if table.HasValue(hidden, name) || name == "CHudAmmo" then return false end
end)

surface.CreateFont("Nino3:font:hud:25", {
    font = "Righteous",
     extended = false,
      size = RX(20),
       weight = RY(1000),
})

surface.CreateFont("Nino3:font:hud:20", {
    font = "Righteous",
     extended = false,
      size = RX(18),
       weight = RY(1000),
})

surface.CreateFont("Nino3:font:hud:15", {
    font = "Righteous",
     extended = false,
      size = RX(17),
       weight = RY(1000),
})

surface.CreateFont("Nino3:font:hud:30", {
    font = "Righteous",
     extended = false,
      size = RX(21),
       weight = RY(1000),
})

surface.CreateFont("Nino3:font:hud:40", {
    font = "Righteous",
     extended = false,
      size = RX(30),
       weight = RY(1000),
})

surface.CreateFont("Nino3:font:hud:65", {
    font = "Righteous",
     extended = false,
      size = RX(27),
       weight = RY(1000),
})

local logovie = Material("odium_hud_icon/health.png", "smooth")
local logoarmure = Material("odium_hud_icon/armur.png", "smooth")
local argent = Material("odium_hud_icon/argent.png", "smooth")
local profil = Material("odium_hud_icon/profil.png", "smooth")
local Munition = Material("odium_hud_icon/mun.png", "smooth")
local logo = Material("odium_atm_icons/icon_odium_frame.png")
local logofaim = Material("odium_hud_icon/burger.png", "smooth")
local Gradient = Material("odium_general_logo/gradientsOne.png", "smooth")
local gradientsone = Material("odium_general_logo/gradientsone.png", "smooth")
local odpointbutton = Material("odium_general_logo/ODpoint.png", "smooth")


local vie = 100 
local vietext = 100

local armure = 100
local armuretext = 100

local faim = 100
local faimtext = 100

local money = 0


local function NinoDrawHud()
    if LocalPlayer():Alive() then

    vie = Lerp(2*FrameTime(), vie, math.Clamp(LocalPlayer():Health(),0,100 ) ) 
    vietext = LocalPlayer():Health()


    armure = Lerp(2*FrameTime(), armure, math.Clamp(LocalPlayer():Armor(),0,100 ) )
    armuretext = LocalPlayer():Armor()

    faim = Lerp(2 * FrameTime(), faim, math.min(LocalPlayer():getDarkRPVar("Energy") or 100, 100))
    faimtext = faim
    local faimtextonhud = math.Round(faimtext)

    argenttext = LocalPlayer():getDarkRPVar("Money")

    local ply = LocalPlayer()
    local wep = ply:GetActiveWeapon()

    local playerName = LocalPlayer():Nick()

    if not IsValid(wep) then return end

    local ammo = -1
    local clip = -1

    if wep:GetClass() == "weapon_physcannon" then
    -- l'arme actuelle est le gravity gun, on ne dessine pas les munitions
    else
    if wep:Clip1() ~= -1 then
        clip = wep:Clip1()
        ammo = ply:GetAmmoCount(wep:GetPrimaryAmmoType())
    elseif wep.Primary then
        ammo = ply:GetAmmoCount(wep:GetPrimaryAmmoType())
    end

    if wep:Clip1() == -1 and (not wep.Primary or ply:GetAmmoCount(wep:GetPrimaryAmmoType()) <= 0) then
        draw.RoundedBox(0, RX(1860), RY(1018.9), RX(44), RY(44), Color(35, 35, 35, 235))
        draw.RoundedBox(0, RX(1607), RY(1022), RX(250), RY(37), Color(35, 35, 35, 225))
        draw.SimpleTextOutlined(playerName, "Nino3:font:hud:65", RX(1740), RY(1040), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        surface.SetMaterial(profil)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(1864), RY(1022), RX(37), RY(37))
    else
        draw.RoundedBox(0, RX(1607), RY(1022), RX(250), RY(37), Color(35, 35, 35, 225))
        draw.RoundedBox(0, RX(1860), RY(978), RX(44), RY(85), Color(35, 35, 35, 235))
        draw.RoundedBox(0, RX(1678), RY(981), RX(180), RY(37), Color(35, 35, 35, 225))
        draw.RoundedBox(0, RX(1681), RY(984), RX(174), RY(31), Color(32, 122, 100, 235))
        draw.SimpleTextOutlined(playerName, "Nino3:font:hud:65", RX(1740), RY(1040), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        surface.SetMaterial(profil)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(1864), RY(1022), RX(37), RY(37))
        draw.SimpleTextOutlined("Mun: "..clip.."/"..ammo, "Nino3:font:hud:65", RX(1848), RY(1000), Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        surface.SetMaterial(Munition)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(1864), RY(981), RX(37), RY(37))
    end
end




    if armuretext > 1 then 
        draw.RoundedBox(0, RX(17), RY(897), RX(44), RY(165), Color(35, 35, 35, 235))
        draw.RoundedBox(0, RX(64), RY(900), RX(135), RY(37), Color(35, 35, 35, 225))
        draw.RoundedBox(0, RX(64), RY(940), RX(135), RY(37), Color(35, 35, 35, 225))
        draw.RoundedBox(0, RX(64), RY(981), RX(135), RY(37), Color(35, 35, 35, 225))
        draw.RoundedBox(0, RX(64), RY(1022), RX(171), RY(37), Color(35, 35, 35, 225))
        draw.RoundedBox(0, RX(67), RY(943), RX(armure*1.29), RY(31), Color(32, 122, 100, 235))
        surface.SetMaterial(logoarmure)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(20), RY(940), RY(37), RX(37))
        if armuretext > 1 then 
            draw.SimpleTextOutlined("Kevlar: "..armuretext, "Nino3:font:hud:65", RX(133), RY(957), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        else
          draw.SimpleTextOutlined("Kevlar: "..armuretext, "Nino3:font:hud:65", RX(135), RY(955), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        end
        draw.RoundedBox(0, RX(67), RY(903), RX(vie*1.29), RY(31), Color(32, 122, 100, 235))
        draw.SimpleTextOutlined("Vie: "..vietext, "Nino3:font:hud:65", RX(135), RY(920), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        surface.SetMaterial(logovie)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(20), RY(900), RX(37), RY(37))
        draw.RoundedBox(0, RX(67), RY(984), RX(faim*1.29), RY(31), Color(32, 122, 100, 235))
        surface.SetMaterial(logofaim)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(20), RY(980), RX(37), RX(37))
        draw.SimpleTextOutlined("Faim: "..faimtextonhud, "Nino3:font:hud:65", RX(135), RY(999), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))

        draw.SimpleTextOutlined(DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money")), "Nino3:font:hud:65", RX(150), RY(1040), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        surface.SetMaterial(argent)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(20), RY(1022), RY(37), RX(37))


    else
        draw.RoundedBox(0, RX(17), RY(936), RX(44), RY(127), Color(35, 35, 35, 235))
        draw.RoundedBox(0, RX(64), RY(940), RX(135), RY(37), Color(35, 35, 35, 225))
        draw.RoundedBox(0, RX(64), RY(981), RX(135), RY(37), Color(35, 35, 35, 225))
        draw.RoundedBox(0, RX(64), RY(1022), RX(170), RY(37), Color(35, 35, 35, 225))

        draw.RoundedBox(0, RX(67), RY(943), RX(vie*1.29), RY(31), Color(32, 122, 100, 235))
        draw.SimpleTextOutlined("Vie: "..vietext, "Nino3:font:hud:65", RX(135), RY(958), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        surface.SetMaterial(logovie)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(20), RY(940), RX(37), RY(37))

        draw.RoundedBox(0, RX(67), RY(984), RX(faim*1.29), RY(31), Color(32, 122, 100, 235))
        surface.SetMaterial(logofaim)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(20), RY(980), RX(37), RX(37))
        draw.SimpleTextOutlined("Faim: "..faimtextonhud, "Nino3:font:hud:65", RX(135), RY(999), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))

        draw.SimpleTextOutlined(DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money")), "Nino3:font:hud:65", RX(150), RY(1040), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        surface.SetMaterial(argent)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(20), RY(1022), RY(37), RX(37))

    end    

end
end



/*function Odpoint()
    OdpointFrame = vgui.Create("DFrame")
    OdpointFrame:SetSize(RX(320), RY(170))
    OdpointFrame:SetPos(ScrW() / 5 - OdpointFrame:GetWide() / 0.43, -OdpointFrame:GetTall())
    OdpointFrame:SetTitle("")
    OdpointFrame:ShowCloseButton(true)
    OdpointFrame:SetDraggable(false)
    OdpointFrame.OnClose = function()
        frameOuverte = false
    end
    OdpointFrame.Paint = function(self,w ,h)
        draw.RoundedBox(0, 0, 0, w, h, Color(35, 35, 35, 225))
    end
    OdpointFrame:MoveTo(ScrW() / 2 - OdpointFrame:GetWide() / 2, ScrH() / 3 - OdpointFrame:GetTall() / 0.1, 2.5, 0, -1, function()
        -- Do something when the frame finishes animating
    end)
    ButtonOdoint = vgui.Create("DButton", OdpointFrame)
	ButtonOdoint:SetSize(RX(300), RY(165))
	ButtonOdoint:SetPos(RX(11), RY(-5))
	ButtonOdoint:SetText("")
	ButtonOdoint:SetFont("Nino3:font:hud:40")
	ButtonOdoint.Paint = function(s,w,h)
        if ButtonOdoint:IsHovered() then
            ButtonOdoint:SetTextColor(MyLib.ColorServer["Black"])
            surface.SetMaterial(odpointbutton)
            surface.SetDrawColor(Color(255, 255, 255, 150))
            surface.DrawTexturedRect(0, 0, w, h)
            draw.SimpleTextOutlined("Collecter 5 ODpoint", "Nino3:font:hud:40", RX(150), RY(50), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            --draw.SimpleTextOutlined("ODpoint", "Nino3:font:hud:40", RX(150), RY(100), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        else
            --draw.RoundedBox(0, 0, RY(4), w, h, MyLib.ColorServer["Green"])
            surface.SetMaterial(odpointbutton)
            surface.SetDrawColor(color_white)
            surface.DrawTexturedRect(0, 0, w, h)
            
            draw.SimpleTextOutlined("Collecter 5 ODpoint", "Nino3:font:hud:40", RX(150), RY(50), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            --draw.SimpleTextOutlined("ODpoint", "Nino3:font:hud:40", RX(150), RY(100), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        end
    end
    ButtonOdoint.DoClick = function()
        //net.Start("addpoints")
        //net.WriteString(LocalPlayer():SteamID())
        //net.WriteInt(5, 32) -- 32 bits integer
        //net.SendToServer()
        OdpointFrame:Remove()
       // surface.PlaySound("mcasino/win.mp3", 0.5)
       // for i = 1, 3 do
       //     chat.AddText(Color(32, 122, 100), "Vous avez reçu vos points. Veuillez vous reconnecter pour les avoir.")
       // end
       // timer.Simple(5, function()
       //     local heure = os.date("%H:%M")
       //     if heure >= "19:00" and heure <= "23:55" then
       //         Odpoint()
       //     end
       // end)
    end
end*/

local x = ScrW() / 2
local y = -50
local showText = false
local showTime = 0

function annoncepoint()
    if not showText and CurTime() > showTime + 1800 then
        showText = true
        showTime = CurTime()
        y = -50
    end

    if showText and CurTime() > showTime + 10 then
        showText = false
        y = -50
    end

    if showText then
        if IsValid(LocalPlayer():GetVehicle()) then
            x = ScrW() / 1.1
            y = Lerp(FrameTime() * 10, y, ScrH() - 50)
        else
            x = ScrW() / 2
            y = Lerp(FrameTime() * 10, y, ScrH() - 50)
        end
        draw.SimpleTextOutlined("Vous avez "..LocalPlayer():GetNWInt("Points").." ODpoints", "Nino3:font:hud:40", x, y, MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
    end
end

local function preventSuicide()
    local cmd = string.lower( tostring( input.LookupBinding( "kill" ) ) )
    if cmd == "kill" then
        chat.AddText( Color( 255, 0, 0 ), "Vous ne pouvez pas vous suicider avec la commande 'kill'!" )
        return true
    end
end

local who_rank = {
    ["VIP"] = {true, "VIP", Color(255, 255, 255)},
    ["VIP+"] = {true, "VIP+", Color(13, 191, 255)},
    ["VIPSaphire"] = {true, "VIP Saphire", Color(230,18,250)},
    ["VIPEtoile"] = {true, "VIP Etoile", Color(240,61,66)},
    ["VIPEmeraude"] = {true, "VIP Emeraude", Color(62,70,203)},
    ["superadmin"] = {true, "VIP Emeraude", Color(62,70,203)},
    ["Fondateur"] = {true, "VIP Emeraude", Color(62,70,203)},
}

local cur = CurTime()

local TimeToNotify = 0.08


function DieselDrawComplement()

    rank = LocalPlayer():GetNWString("usergroup");

    if cur + (TimeToNotify * 3600) > CurTime() then
        return
    end

    cur = CurTime()

    if IsValid(laboutiquenotif) then
        return
    end

    if who_rank[rank] then
        if who_rank[rank][1] then
            return notification.AddLegacy("[".. who_rank[rank][2] .."] Merci de contribuer à l'avancement de notre communauté!", NOTIFY_GENERIC, 12)
        end
    end
    if GAS then
        GAS:PlaySound("popup")
    end
    local color = HSVToColor(CurTime() % 3 * 80, 0.4, 0.5)
    laboutiquenotif = vgui.Create("DFrame")
    laboutiquenotif:SetSize(ScrW(), ScrH())
    laboutiquenotif:SetTitle("")
    laboutiquenotif:ShowCloseButton(false)
    laboutiquenotif:SetDraggable(false)
    laboutiquenotif:SetPos(ScrW()*0.85, ScrH()*0.2)
    laboutiquenotif:SetSize(ScrW()*.15, ScrH()*.12)
    laboutiquenotif.Paint = function(self,w ,h)
        draw.RoundedBox(0, RX(17), 0, w, h, Color(32, 122, 100))
        draw.RoundedBox(0, RX(25), 5, w, 119, Color(39, 39, 39))
        draw.SimpleText("BOUTIQUE", "Nino3:font:hud:25", w/2, h/2 - 45, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("N'hésite pas à faire un tour,", "Nino3:font:hud:20", w/2, h/2- 30, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("sur notre boutique !", "Nino3:font:hud:20", w/2, h/2 - 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    closelaboutique = vgui.Create("DButton", laboutiquenotif)
    closelaboutique:SetPos(ScrW()*0.135, ScrH()*0.01)
    closelaboutique:SetSize(ScrW()*.013, ScrH()*.023)
    closelaboutique:SetText("")
    closelaboutique.Paint = function(self, w, h)
        if closelaboutique:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100))
            draw.SimpleText("✕", "Nino3:font:hud:25", w/2-1, h/2-1, Color(223, 223, 223), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            if not closelaboutique.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				closelaboutique.isSound = true
			end	
        else
            draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100))
            draw.SimpleText("✕", "Nino3:font:hud:25", w/2-1, h/2-1, Color(223, 223, 223), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            closelaboutique.isSound = false
        end
    end
    closelaboutique.DoClick = function()
        if IsValid(laboutiquenotif) then
            laboutiquenotif:Close()
            if GAS then
                GAS:PlaySound("delete")
            end
            gui.EnableScreenClicker( false )
        end
    end

    gotolaboutique = vgui.Create("DButton", laboutiquenotif)
    gotolaboutique:SetPos(ScrW()*0.017, ScrH()*0.079)
    gotolaboutique:SetSize(ScrW()*.131, ScrH()*.03)
    gotolaboutique:SetText("")
    gotolaboutique.Paint = function(self, w, h)
        if gotolaboutique:IsHovered() then
            draw.RoundedBox(5, 0, 0, w, h, Color(32, 122, 100))
            draw.SimpleText("Visiter la boutique", "Nino3:font:hud:30", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            if not gotolaboutique.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				gotolaboutique.isSound = true
			end	
        else
            draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100))
            draw.SimpleText("Visiter la boutique", "Nino3:font:hud:30", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            gotolaboutique.isSound = false
        end
    end
    gotolaboutique.DoClick = function()
        if GAS then
            GAS:PlaySound("flash")
        else
            surface.PlaySound("ui/buttonclick.wav")
        end
        if IsValid(laboutiquenotif) then
            laboutiquenotif:Close()
        end
        gui.OpenURL("https://odiumlibrary.com/tebex")
    end


end

surface.CreateFont("Speedometer:font:8", {
    font = "Righteous",
    extended = false,
    size = ScreenScale(8),
    weight = 500,
})

surface.CreateFont("Speedometer:font:2", {
    font = "Righteous",
    extended = false,
    size = ScreenScale(6),
    weight = 650,
})

--http.DownloadMaterial("https://i.imgur.com/YMvx551l.png", "car_states.png", function(material)
   -- car_material = material
--end)


local VehUsed = nil;

local cur = CurTime()

local danger_color = Color(122,2,2)

local function DrawSpeedometer()
    -- draw.RoundedBox(0, ScrW()*0.417, ScrH()*0.9, ScrW()*.2, ScrH()*0.4, Color(55, 55, 55))

    local speed = VehUsed:SV_GetSpeed()
    local hp = math.Round(VehUsed:GetNWFloat("VehicleHealth", 0) / 10)
    local pr = speed/200

    if (CurTime() - cur) < 2 then
        cur = CurTime()
        danger_color = (danger_color == Color(255,255,255) and Color(122,2,2) or Color(122,2,2))
    end

    draw.RoundedBox(0, ScrW()*0.44, ScrH()*0.95, ScrW()*.15, ScrH()*0.04, Color(26, 123, 100, 100))
    draw.RoundedBox(0, ScrW()*0.4447, (ScrH()*0.95585), Lerp(pr, ScrW()*0.01, ScrW()*.14), ScrH()*0.03, Color(26, 123, 100))
    -- "https://i.imgur.com/FGSSgi5l.png"
    draw.SimpleText(speed.." km/h", "Speedometer:font:8", ScrW()*0.515, ScrH()*0.95685, Color(255,255,255, 100), TEXT_ALIGN_CENTER)
    
    -- surface.SetMaterial(car_material)
    -- surface.SetDrawColor(color_white)
    -- surface.DrawTexturedRect(ScrW()*0.465, ScrH()*0.92495, ScrW()*0.015, ScrH()*0.02)

    draw.SimpleText("État du véhicule : "..(hp >= 1 and (hp.."%") or "cassé"), "Speedometer:font:2", ScrW()*0.515, ScrH()*0.92495, (hp >= 80 and Color(35,126,66) or (hp >= 50 and Color(240,159,38)) or (hp >= 40 and Color(173,31,50)) or (hp <= 40 and danger_color)), TEXT_ALIGN_CENTER)
end


local frameOuverte = false
local soundPath = "mcasino/slots_spin.mp3"
local soundDuration = 2.4 -- Durée en secondes du son
local soundPlayed = false
local heure = os.date("%H:%M")

hook.Add("HUDPaint", "Nino:DrawHUD:Hook", function(ply)
    NinoDrawHud()
    // annoncepoint()
    local function checkHeure()
        heure = os.date("%H:%M")
        return heure >= "19:00" and heure <= "23:55"
    end
    if checkHeure() and not frameOuverte then
        Odpoint()
        frameOuverte = true
        if not soundPlayed then
            local soundObj = CreateSound(LocalPlayer(), soundPath)
            soundObj:Play()
            timer.Simple(soundDuration, function()
                soundObj:Stop()
            end)
            soundPlayed = true
        end
    elseif not checkHeure() and frameOuverte then
        if IsValid(OdpointFrame) then
            OdpointFrame:Remove()
        end
        frameOuverte = false
        soundPlayed = false
    end
    if LocalPlayer():InVehicle() then
        VehUsed = LocalPlayer():GetVehicle()
        DrawSpeedometer()
    end
end)

hook.Add("Think", "CheckTimeToRemoveButton", function()
    local heure = os.date("%H:%M")
    if heure >= "23:55" and IsValid(OdpointFrame) then
        OdpointFrame:Remove()
        hook.Remove("Think", "CheckTimeToRemoveButton")
    end
end)

hook.Add("PostDrawOpaqueRenderables", "ReplaceMoneyRender", function()
    for _, ent in pairs(ents.FindByClass("spawned_money")) do
        local pos = ent:GetPos()
        local ang = LocalPlayer():EyeAngles()
    
        ang:RotateAroundAxis(ang:Forward(), 90)
        ang:RotateAroundAxis(ang:Right(), 90)
    
        cam.Start3D2D(pos, ang, 0.1)
        if (LocalPlayer():GetPos():Distance(pos)<100) then
            local w, h = surface.GetTextSize("$" .. ent:Getamount()) + 115, 40
            draw.RoundedBox(4, -w / 2, -h / 0.5, w, h, Color(32, 122, 100))
  /*walter*/draw.SimpleTextOutlined("$" .. ent:Getamount(), "Nino3:font:hud:40", 0, -60, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, Color(32, 32, 32))
          end
        cam.End3D2D()
    end
end)


hook.Remove("HUDPaint", "CHudAmmo")
