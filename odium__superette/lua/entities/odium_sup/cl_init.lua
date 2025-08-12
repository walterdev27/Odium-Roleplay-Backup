local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

include("shared.lua")

surface.CreateFont("FontpnjSupp1", {font = "Righteous", size = 30})
surface.CreateFont("FontpnjNameChange2", {font = "Righteous", size = 125})

function ENT:Draw()
    self:DrawModel() 

	local ang = self:GetAngles();

	ang:RotateAroundAxis(ang:Forward(), 90);
	ang:RotateAroundAxis(ang:Right(), -90);

	cam.Start3D2D(self:GetPos()+self:GetUp()*80, Angle(0, self:GetAngles().y+90, 90), 0.06);
        draw.SimpleTextOutlined("superette", "FontpnjNameChange2", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 10, Color(0,0,0,255))
    cam.End3D2D()
end 