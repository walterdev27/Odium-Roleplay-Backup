include("shared.lua")

function ENT:Draw()
	self:DrawModel()

	--cam.Start3D2D(self:GetPos() + self:GetUp() * 50, Angle(0, LocalPlayer():EyeAngles().y - 90, 90), .35)
    --    draw.SimpleText("ANONYME / ROLL", "DermaLarge", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT)
    --cam.End3D2D()
end

function ENT:DrawTranslucent()
	self:Draw()
end