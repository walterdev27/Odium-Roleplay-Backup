include("shared.lua")

local Mining3d2dFont1 = AlonesRP.CreateFont("Mining3d2dFont1", "Righteous", 25, {weight = 500})
local Mining3d2dFont10 = AlonesRP.CreateFont("Mining3d2dFont10", "Righteous", 15, {weight = 500})

function ENT:Draw()
	self:DrawModel()

	cam.Start3D2D(self:GetPos() + self:GetUp() * 30, Angle(0, LocalPlayer():EyeAngles().y - 90, 90), .35)
    	draw.SimpleTextOutlined(self:GetDiamondPercent().."%", Mining3d2dFont1, 0, 0, Color(50, 187, 246), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 2, Color(32, 32, 32))
		draw.SimpleTextOutlined("Faire [E]", Mining3d2dFont10, 0, 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 2, Color(32, 32, 32))
	cam.End3D2D()
end

function ENT:DrawTranslucent()
	self:Draw()
end