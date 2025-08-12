ODIUMODCOINSDERMA = ODIUMODCOINSDERMA or {}

ODIUMODCOINSDERMA.iW = ScrW()
ODIUMODCOINSDERMA.iH = ScrH()

function RX(x)
    return x / 3840 * ODIUMODCOINSDERMA.iW
end

function RY(y)
    return y / 2160 * ODIUMODCOINSDERMA.iH
end

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChanged", function()

    ODIUMODCOINSDERMA.iW = ScrW()
    ODIUMODCOINSDERMA.iH = ScrH()

end)
include("shared.lua")

local AlonesRPIGShopFont3 = AlonesRP.CreateFont("AlonesRPIGShopFont3", "Roboto", 30, {weight = 600})
    surface.CreateFont("FontTab3", {font = "Righteous", size = RespX(200)})

function ENT:Draw()
	self:DrawModel()
    local ang = self:GetAngles();
	
	cam.Start3D2D(self:GetPos()+self:GetUp()*80, Angle(0, self:GetAngles().y+90, 90), 0.04);
    draw.SimpleTextOutlined("ODpoint", "FontTab3", 0, 10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 10, Color(0,0,0,255))
	cam.End3D2D()
end

function ENT:DrawTranslucent()
	self:Draw()
end


net.Receive("Odium:OdpointShop:OpenDerma",function(_,ply)

	local MainFrame = vgui.Create("DFrame")
	MainFrame:SetSize(RX(500),RY(500))
	MainFrame:Center()
	MainFrame:SetDraggable(false)
	MainFrame:MakePopup()

end)