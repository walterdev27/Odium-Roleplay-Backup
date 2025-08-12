--[[
  _____ ___    _      ___         _   __              ___        _  _ _          
 |_   _| _ \  (_)    / __|_  _ __| |_ \_\ _ __  ___  | _ )_  _  | \| (_)_ _  ___ 
   | | |  _/   _     \__ \ || (_-<  _/ -_) '  \/ -_) | _ \ || | | .` | | ' \/ _ \
   |_| |_|    (_)    |___/\_, /__/\__\___|_|_|_\___| |___/\_, | |_|\_|_|_||_\___/
                          |__/                            |__/                   
--]]

include('shared.lua')

local pointtp = Material("odium_general_logo/pointtp.png")

------------
-- Config --
------------
Nino_Teleporter_HospitalText = "Taco Bell"
----------------
-- Fin Config --
----------------

function ENT:Draw()

    self:DrawModel()

    local ply = LocalPlayer()

    if !IsValid(ply) then return end

    local Pos = self:GetPos() + self:GetUp() * 82
    Pos = Pos + self:GetUp() * math.abs(math.sin(CurTime()) * 2)
    local Ang = Angle(0, LocalPlayer():EyeAngles().y - 90, 90)

    local len = surface.GetTextSize(Nino_Teleporter_HospitalText) + 120

    if ply:GetPos():Distance(self:GetPos()) >= 1000 then return end

    cam.Start3D2D(self:GetPos() + self:GetUp() * 80 + self:GetForward() * 3, self:GetAngles() + Angle(0,90,90), 0.20)
	
		draw.SimpleTextOutlined(Nino_Teleporter_HospitalText, "TeleporterSystem80", 0, -150, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 10, Color(0, 0, 0))
		--draw.SimpleTextOutlined("↓", "TeleporterSystem50", 0, -275, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5, Color(0,0,0,255))
		--draw.SimpleTextOutlined("TP", "TeleporterSystem50", 0, -375, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5, Color(0,0,0,255))

    cam.End3D2D()

	local ply = LocalPlayer()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local speed = 10
	local barStatus = 0
	local alpha = (LocalPlayer():GetPos():DistToSqr(self:GetPos()) / 120000000)
	
	alpha = math.Clamp(1 - alpha, 0 ,1)

	local a = Angle(0,0,90)
	a.y = self:GetAngles().y + 90

	ang:RotateAroundAxis(ang:Up(), 100)
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 50)

		cam.Start3D2D(pos +  Vector(0, 0, math.sin(CurTime())*5), a, 0.05)
			OdiumATM:MaterialRotated( 90, -800, 1250, 1150, pointtp, 0 )
		cam.End3D2D()

end