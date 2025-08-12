include("shared.lua")

local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

local logoMat = Material("alonesrp_mining/logo.png", "smooth")
local Mining3d2dFont1 = AlonesRP.CreateFont("Mining3d2dFont1", "Righteous", 15, {weight = 800})

function ENT:Draw()
	self:DrawModel()

	local ply = LocalPlayer()
	local pos = self:GetPos()
	local ang = self:GetAngles()

	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 90)

	if ply:GetPos():DistToSqr(pos) <= 300000 then
		cam.Start3D2D(pos + ang:Up() * 21 + ang:Right() * -13 + ang:Forward() * -18, ang, 0.25)
            draw.RoundedBox(0, 0, 0, RespX(140), RespY(100), Color(25, 25, 25))
			draw.RoundedBox(0, 0, 0, RespX(140), RespY(22), Color(32, 122, 100))
			draw.RoundedBox(0, 0, 0, RespX(140), RespY(1), Color(255, 255, 255))
			draw.RoundedBox(0, 0, RespY(100), RespX(140), RespY(1), Color(255, 255, 255))
			draw.RoundedBox(0, RespY(0), 0, RespX(1), RespY(100), Color(255, 255, 255))
			draw.RoundedBox(0, RespY(140), 0, RespX(1), RespY(100), Color(255, 255, 255))

			draw.SimpleTextOutlined("Rangement", Mining3d2dFont1, RespX(70), RespY(10), Color(32, 122, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(25, 25, 25))
			draw.SimpleText("Places :      "..AlonesRP_Mining.CartCountMax, Mining3d2dFont1, RespX(57), RespY(35), color_white, TEXT_ALIGN_CENTER)
			draw.SimpleText("Utilisées :   "..self:GetCartCount(), Mining3d2dFont1, RespX(52), RespY(65), color_white, TEXT_ALIGN_CENTER)
        cam.End3D2D()
	end
end

function ENT:DrawTranslucent()
	self:Draw()
end