include("shared.lua")

local Mining3d2dFont1 = AlonesRP.CreateFont("Mining3d2dFont1", "Righteous", 30, {weight = 500})

function ENT:Draw()
	self:DrawModel()

	cam.Start3D2D(self:GetPos() + self:GetUp() * 70, Angle(0, LocalPlayer():EyeAngles().y - 90, 90), .35)
		if self:GetMachineState() == 0 then
			draw.SimpleTextOutlined("Briseuse de pierre", Mining3d2dFont1, 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(25, 25, 25))
		end

		if self:GetMachineState() == 1 then
			draw.SimpleTextOutlined(string.ToMinutesSeconds(self:GetMachineTimer() - CurTime()).."s", Mining3d2dFont1, 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 2, Color(25, 25, 25))
		end
	cam.End3D2D()
end

function ENT:DrawTranslucent()
	self:Draw()
end