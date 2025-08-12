ODIUMRPSHOP = ODIUMRPSHOP or {}

ODIUMRPSHOP.iW = ScrW()
ODIUMRPSHOP.iH = ScrH()

function RX(x)
    return x / 3840 * ODIUMRPSHOP.iW
end

function RY(y)
    return y / 2160 * ODIUMRPSHOP.iH
end

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChanged", function()

    ODIUMRPSHOP.iW = ScrW()
    ODIUMRPSHOP.iH = ScrH()

end)

local shop = Material("odium_tab/setjob.png", "noclamp smooth")
include("shared.lua")
local frame

surface.CreateFont("FontpnjShop2", {font = "Righteous", size = 125})

surface.CreateFont("Ninoshop1", {
    font = "Righteous",
     extended = false,
      size = RX(60),
       weight = RY(1000),
})

surface.CreateFont("Ninoshop2", {
    font = "Righteous",
     extended = false,
      size = RX(50),
       weight = RY(1000),
})

surface.CreateFont("Ninoshop3", {
    font = "Righteous",
     extended = false,
      size = RX(70),
       weight = RY(1000),
})

surface.CreateFont("Ninoshop4", {
    font = "Righteous",
     extended = false,
      size = RX(100),
       weight = RY(1000),
})

function ENT:Draw()
    self:DrawModel()
    local ang = self:GetAngles()
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), -90)

    cam.Start3D2D(self:GetPos() + self:GetUp() * 80, Angle(0, self:GetAngles().y + 90, 90), 0.20)
        draw.SimpleTextOutlined("SHOP", "Ninoshop4", 0, 0, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5, Color(0, 0, 0, 255))
    cam.End3D2D()
end


local function FrameOpenShop()
    frame = vgui.Create("DFrame")
	frame:SetSize(RX(2200), RY(1500))
    frame:SetPos(ScrW()- 0, ScrH()- RY(1900))
    frame:MoveTo(ScrW() - RX(3000), ScrH() - RY(1900), 0.2, 0, 0.8, function() end)
	frame:MakePopup()
	frame:SetTitle("") 
	--frame:SlideDown(0.3)
	frame:ShowCloseButton(false) 
	frame.Paint = function(s,w,h)
		draw.RoundedBox(0, 0, RY(0), w, h, MyLib.ColorServer["Black"])
		draw.RoundedBox(0, RX(20), RY(20), RX(2160), RY(170), MyLib.ColorServer["Green"])
        draw.SimpleTextOutlined("Bienvenue dans le shop  ".. ply:Nick().." / Grade:  ".. ply:GetUserGroup(), "Ninoshop3", RX(250), RY(100), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 4, MyLib.ColorServer["Black"])
		draw.RoundedBox(0, 0, RY(0), w, RY(10), MyLib.ColorServer["Green"])
		draw.RoundedBox(0, 0, RY(0), RX(10), h, MyLib.ColorServer["Green"])
		draw.RoundedBox(0, 0, RY(1490), w, RY(10), MyLib.ColorServer["Green"])
		draw.RoundedBox(0, RX(2190), RY(0), RX(10), h, MyLib.ColorServer["Green"])
        surface.SetMaterial(shop)
        surface.SetDrawColor(MyLib.ColorServer["white"])
		surface.DrawTexturedRect(RX(50), RY(35), RX(140), RY(140))
	end

    local CloseButton = vgui.Create("DButton", frame)
	CloseButton:SetText("")
	CloseButton:SetPos(RX(2050), RY(50))
	CloseButton:SetSize(RX(100), RY(100))
    CloseButton.Paint = function(self, w, h)
        if CloseButton:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["BlackSeconde"])
            draw.SimpleTextOutlined("✕", "Ninoshop4", RX(10), h / 2, MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 4, MyLib.ColorServer["Black"])
        else
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
            draw.SimpleTextOutlined("✕", "Ninoshop4", RX(10), h / 2, MyLib.ColorServer["white"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        end
    end
	CloseButton.DoClick = function()
	    frame:Remove()
	end

	local Panel = vgui.Create("DPropertySheet", frame)
    Panel:SetPos(RX(20), RY(190))
    Panel:SetSize(RX(2160), RY(1300))

    local staffExists = false
    for _, ply in ipairs(player.GetAll()) do
        if team.GetName(ply:Team()) == "Armurier" then
            staffExists = true
            break
        end
    end

    for _, sheet in pairs(odiumshop.sheets) do
        if sheet.name == odiumshop.Arme and staffExists then
            continue
        end

        local SheetPanel = vgui.Create("DPanel")
        SheetPanel.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
        end

        local ScrollPanel = vgui.Create("DScrollPanel", SheetPanel)
        ScrollPanel:Dock(FILL)

        local sbar = ScrollPanel:GetVBar()
        function sbar:Paint(w, h)
            draw.RoundedBox(0, RX(3), 0, RY(17), h, MyLib.ColorServer["BlackF4Second"])
        end
        function sbar.btnUp:Paint(w, h)
            draw.RoundedBox(0, RX(3), 0, RY(17), RY(0), MyLib.ColorServer["Green"])
        end
        function sbar.btnDown:Paint(w, h)
            draw.RoundedBox(0, RX(3), 0, RY(17), RY(0), MyLib.ColorServer["Green"])
        end
        function sbar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, RX(3), 0, RY(17), h, MyLib.ColorServer["Green"])
        end

        for _, category in pairs(odiumshop.Categories) do
            if category.Name == sheet.name then
                for _, weapon in pairs(category.Weapons) do
                    local WeaponPanel = ScrollPanel:Add("DPanel")
                    WeaponPanel:SetSize(0, RY(225))
                    WeaponPanel:Dock(TOP)
                    WeaponPanel:DockMargin(5, 5, 5, 5)
                    WeaponPanel.Paint = function(self, w, h)
                        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
                        draw.RoundedBox(0, RX(10), RY(12), RX(200), RY(200), MyLib.ColorServer["grey"])
                        draw.SimpleTextOutlined("Prix:  ".. string.Comma(weapon.Price,",") .. "  $", "Ninoshop1", RX(1750), h / 1.3, MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 4, MyLib.ColorServer["Black"])
                        draw.SimpleTextOutlined("Nom:  ".. weapon.Name, "Ninoshop3", RX(250), h / 3.5, MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 4, MyLib.ColorServer["Black"])
                        draw.SimpleTextOutlined("Description:  ".. weapon.Desc, "Ninoshop2", RX(250), h / 1.5, MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
                    end                    

					local BuyButton = vgui.Create("DButton", WeaponPanel)
					BuyButton:SetText("")
					BuyButton:SetPos(RX(1760), RY(20))
					BuyButton:SetSize(RX(300), RY(100))
                    BuyButton.Paint = function(self, w, h)
                        if BuyButton:IsHovered() then
                            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["BlackSeconde"])
                            draw.SimpleTextOutlined("Acheter", "Ninoshop1", RX(70), h / 2, MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 4, MyLib.ColorServer["Black"])
                        else
                            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
                            draw.RoundedBox(0, RX(10), RY(10), RX(280), RY(80), MyLib.ColorServer["GreentSecond"])
                            draw.SimpleTextOutlined("Acheter", "Ninoshop2", RX(80), h / 2, MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
                        end
                    end
					BuyButton.DoClick = function()
                        notification.AddLegacy( "Acheté par:  ".. ply:Nick(), NOTIFY_UNDO, 2 )
                        surface.PlaySound( "buttons/button15.wav" )
					    net.Start("ODium::BuyWeapon")
					    net.WriteString(weapon.Class) 
					    net.WriteInt(weapon.Price, 32)
					    net.SendToServer()
					end

                    local ModelPanel = vgui.Create("DModelPanel", WeaponPanel)
					ModelPanel:SetPos(RX(-20), RY(-0))
					ModelPanel:SetSize(RX(225), RY(225))
					ModelPanel:SetModel(weapon.Model)

					local mn, mx = ModelPanel.Entity:GetRenderBounds()
					local size = 0
					size = math.max( size, math.abs(mn.x) + math.abs(mx.x))
					size = math.max( size, math.abs(mn.y) + math.abs(mx.y))
					size = math.max( size, math.abs(mn.z) + math.abs(mx.z))
					ModelPanel:SetFOV(40)
					ModelPanel:SetCamPos(Vector(size, size, size))
					ModelPanel:SetLookAt((mn + mx) * 0.5)
                    ModelPanel.LayoutEntity = function() end
                end
            end
        end
        Panel:AddSheet(sheet.name, SheetPanel, sheet.icon)
    end
end

net.Receive("ODium::FrameShop", FrameOpenShop)