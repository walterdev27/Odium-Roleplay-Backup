include("shared.lua")

local boardPoly = {
	{x = 0, y = 0},
	{x = 275, y = 0},
	{x = 288, y = 30},
	{x = 491, y = 30},
	{x = 504, y = 0},
	{x = 781, y = 0},
	{x = 781, y = 408},
	{x = 0, y = 408},
}

local boardNum = 1
timer.Create("OdiumMayor_3D2D_BoardNum", Odium_Mayor.Config.TimerChange, 0, function()
	if boardNum >= 3 then
		boardNum = 1
		return
	end
	boardNum = boardNum + 1
end)

function ENT:Draw()
	self:DrawModel()

	local ply = LocalPlayer()
	local pos = self:GetPos()
	local ang = self:GetAngles()


	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 90)

	if ply:GetPos():DistToSqr(pos) <= 700000000000000000000 then
		cam.Start3D2D(pos + ang:Up() * 2 + ang:Right() * -51 + ang:Forward() * -97, ang, 0.25)
			surface.SetDrawColor(33, 32, 30)
			draw.NoTexture()
			surface.DrawPoly(boardPoly)

			if self:GetPoliticalRegime() == "Dictature" or self:GetPoliticalRegime() == "Démocratie" then
				draw.RoundedBox(1, 20, 20, 240, 150, Color(61, 61, 61))
				draw.RoundedBox(1, (781-20)-240, 20, 240, 150, Color(61, 61, 61))

				draw.SimpleText("% des taxes prises aux joueurs", "OdiumMayor_FontA3D2D", 25, 25, color_white)
				draw.SimpleText(Odium_Mayor.Config.Taxes[math.Round(self:GetMayorTaxes(), 1)] and math.Round(self:GetMayorTaxes(), 1).."%" or "0%", "OdiumMayor_FontB3D2D", Odium_Mayor.Config.Taxes[math.Round(self:GetMayorTaxes(), 1)] and 105 or 115, 80, color_white)
				
				draw.SimpleText(self:GetPoliticalRegime(), "OdiumMayor_Font1", (781-10)/2, 20+50, self:GetPoliticalRegime() == "Dictature" and Color(219, 64, 63) or Color(32, 122, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				
				draw.SimpleText("Coffre du maire", "OdiumMayor_FontA3D2D", (781)-200, 25, color_white)
				draw.SimpleText(DarkRP.formatMoney(self:GetLockerMoney()), "OdiumMayor_FontB3D2D", self:GetLockerMoney() == 0 and (815)-200 or (810-10)-200, 80, color_white)

				draw.SimpleText("Règles", "OdiumMayor_FontC3D2D", (781-10)/2, 180, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

				-- Laws showing
				draw.RoundedBox(1, 20, (170+35*1)+10*1, 740, 35, Color(61, 61, 61))
				draw.RoundedBox(1, 20, (170+35*2)+10*2, 740, 35, Color(61, 61, 61))
				draw.RoundedBox(1, 20, (170+35*3)+10*3, 740, 35, Color(61, 61, 61))
				draw.RoundedBox(1, 20, (170+35*4)+10*4, 740, 35, Color(61, 61, 61))
				if Odium_Mayor:GetCountLaws() > 0 then
					if boardNum == 1 then
						draw.SimpleText("1/ "..(tonumber(Odium_Mayor:GetCountLaws()) >= 1 and DarkRP.getLaws()[1] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*1+10*1, color_white)
						draw.SimpleText("2/ "..(tonumber(Odium_Mayor:GetCountLaws()) >= 2 and DarkRP.getLaws()[2] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*2+10*2, color_white)
						draw.SimpleText("3/ "..(tonumber(Odium_Mayor:GetCountLaws()) >= 3 and DarkRP.getLaws()[3] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*3+10*3, color_white)
						draw.SimpleText("4/ "..(Odium_Mayor:GetCountLaws() >= 4 and DarkRP.getLaws()[4] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*4+10*4, color_white)
					end
					if boardNum == 2 then
						draw.SimpleText("5/ "..(Odium_Mayor:GetCountLaws() >= 5 and DarkRP.getLaws()[5] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*1+10*1, color_white)
						draw.SimpleText("6/ "..(Odium_Mayor:GetCountLaws() >= 6 and DarkRP.getLaws()[6] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*2+10*2, color_white)
						draw.SimpleText("7/ "..(Odium_Mayor:GetCountLaws() >= 7 and DarkRP.getLaws()[7] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*3+10*3, color_white)
						draw.SimpleText("8/ "..(Odium_Mayor:GetCountLaws() >= 8 and DarkRP.getLaws()[8] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*4+10*4, color_white)
					end
					if boardNum == 3 then
						draw.SimpleText("9/ "..(Odium_Mayor:GetCountLaws() >= 9 and DarkRP.getLaws()[9] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*1+10*1, color_white)
						draw.SimpleText("10/ "..(Odium_Mayor:GetCountLaws() >= 10 and DarkRP.getLaws()[10] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*2+10*2, color_white)
						draw.SimpleText("11/ "..(Odium_Mayor:GetCountLaws() >= 11 and DarkRP.getLaws()[11] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*3+10*3, color_white)
						draw.SimpleText("12/ "..(Odium_Mayor:GetCountLaws() >= 12 and DarkRP.getLaws()[12] or ""), "OdiumMayor_FontA3D2D", 25, 176+35*4+10*4, color_white)
					end
				end
			else
				draw.SimpleText("Pas de régime", "OdiumMayor_FontD3D2D", (781-10)/2, 175, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
        cam.End3D2D()
	end
end

function ENT:DrawTranslucent()
	self:Draw()
end
