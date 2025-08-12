include("shared.lua")

surface.CreateFont("RighteousFont2", {
    font = "Righteous",
    size = 25,
    weight = 500,
    antialias = true,
})

local itemPrices = {
    odium_coeursale = {min = 15000, max = 20000},
    odium_coeur = {min = 60000, max = 100000},
    odium_cervellsale = {min = 15000, max = 20000},
    odium_cervell = {min = 60000, max = 100000},
    odium_poumon = {min = 60000, max = 100000},
    odium_poumonsale = {min = 15000, max = 20000}
}

function ENT:Draw()
	self:DrawModel()
	self.Pos = self:GetPos() + (self:GetUp()*20)

    local priceText = "Prix: " .. DarkRP.formatMoney(self:GetNWInt("organPrice"))
    local priceTextWidth, priceTextHeight = surface.GetTextSize(priceText)

    cam.Start3D2D(self.Pos, Angle(0, LocalPlayer():EyeAngles().y-90, 90), .15)
     draw.SimpleTextOutlined(priceText, "RighteousFont", -priceTextWidth * -0.8, -priceTextHeight * 3.5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
     draw.SimpleTextOutlined("Coeur Sale", "RighteousFont2", 120, -55, Color(69, 210, 80), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
	 cam.End3D2D()
end

--function ENT:Draw()
--    self:DrawModel()
--
--    local Pos = self:GetPos()
--    local Ang = self:GetAngles()
--
--    surface.SetFont("Trebuchet24")
--
--    local priceText = "Prix: " .. DarkRP.formatMoney(self:GetNWInt("organPrice"))
--    local priceTextWidth, priceTextHeight = surface.GetTextSize(priceText)
--
--    Ang:RotateAroundAxis(Ang:Up(), 90)
--
--    cam.Start3D2D(Pos + Ang:Up() * 5, Ang, 0.1)
--        draw.WordBox(2, -priceTextWidth * 0.5, -priceTextHeight * 0.5, priceText, "Trebuchet24", Color(0, 0, 0, 100), Color(255, 255, 255))
--    cam.End3D2D()
--end

