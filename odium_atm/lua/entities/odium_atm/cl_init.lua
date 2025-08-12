include("shared.lua")

local paresseuxMat = Material("odium_atm_icons/odium_icon.png")
local stripMat = Material("odium_atm_icons/color_strip.png")
local stripReverseMat = Material("odium_atm_icons/color_strip_reverse.png")

function ENT:Draw()
	self:DrawModel()

	local ply = LocalPlayer()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local speed = 20
	local barStatus = 0

	ang:RotateAroundAxis(ang:Up(), 100)
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), -80)

	if ply:GetPos():DistToSqr(pos) <= 30000000 then
		cam.Start3D2D(pos + ang:Up() * 3 + ang:Right() * -18.2 + ang:Forward() * -20, ang, 0.25)
			draw.RoundedBox(0, 1, 10, 105, 85, Color(39, 39, 39))

			OdiumATM:DrawMaterial(5, 20, 100, 150, stripMat)
			OdiumATM:DrawMaterial(5, -59, 100, 150, stripReverseMat)

			OdiumATM:MaterialRotated( 57, 55, 90, 30, paresseuxMat, math.cos(CurTime() * 2) * 25 )
		cam.End3D2D()
	end
end

function ENT:DrawTranslucent()
	self:Draw()
end