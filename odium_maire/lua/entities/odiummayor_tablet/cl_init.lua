include("shared.lua")

local fontOne1 = AlonesRP.CreateFont("fontOne1", "Righteous", 25, {weight = 500})
local fontTwo2 = AlonesRP.CreateFont("fontTwo2", "Righteous", 125, {weight = 500})

function ENT:Draw()
	self:DrawModel()
	
	cam.Start3D2D(self:GetPos()+self:GetUp()*80, Angle(0, self:GetAngles().y+0, 90), 0.04);
		draw.SimpleTextOutlined("[E]", fontTwo2, 0, 1450, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 6, Color(32, 32, 32))
	cam.End3D2D()
end

function ENT:DrawTranslucent()
	self:Draw()
end
