include("shared.lua")

surface.CreateFont("FontpnjSupp2", {font = "Righteous", size = 125})

function ENT:Draw()
    self:DrawModel()

    local ang = self:GetAngles()
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), -90)

    cam.Start3D2D(self:GetPos() + self:GetUp() * 80, Angle(0, self:GetAngles().y + 90, 90), 0.06)
    draw.SimpleTextOutlined("Trafic d'organes", "FontpnjSupp2", 0, 0, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 10, Color(0, 0, 0, 255))
    cam.End3D2D()
end

net.Receive("SellOrgansToNPC", function()
    local ply = LocalPlayer()
    local totalValue = net.ReadInt(32)

    ply:ChatPrint("Vous avez vendu vos organes pour " .. DarkRP.formatMoney(totalValue) .. ".")
end)

