/*
* @Author: Diesel
* @Date:   2023-01-28 22:54:59
* @Last Modified time: 2023-01-28 23:05:41
* @File: cl_init.lua
*/
include("shared.lua")

local odiumLogo = Material("odium_atm_icons/icon_odium_frame.png")

local function RespX(x) return x/1000*ScrW() end
local function RespY(y) return y/100*ScrH() end

surface.CreateFont("Ultimate_Publicity_System_Font1", {
	font = "Righteous",
	extended = true,
	size = RespX(55),
	weight = 0,
})

surface.CreateFont("Ultimate_Publicity_System_Font2", {
	font = "Righteous",
	extended = true,
	size = RespX(10),
	weight = 0,
})

surface.CreateFont("Ultimate_Publicity_System_Font3", {
	font = "Righteous",
	extended = true,
	size = RespX(20),
	weight = 0,
})

surface.CreateFont("Ultimate_Publicity_System_Font4", {
	font = "Righteous",
	extended = true,
	size = RespX(15),
	weight = 0,
})

local function OpenBasicFrame()
    local scrw, scrh = ScrW(), ScrH()

	local BasicFrame = vgui.Create("DFrame")
		BasicFrame:SetSize(800, 200)
		BasicFrame:SetPos(ScrW()- RespX(700),ScrH()- 0)
		BasicFrame:MoveTo(ScrW()- RespX(700),ScrH()- RespY(60), 0.3, 0, .3, function() end)
		BasicFrame:MakePopup()
		BasicFrame:SetTitle("") 
		BasicFrame:ShowCloseButton(false) 

		local anonymousrollclose = vgui.Create("DButton", BasicFrame)
		anonymousrollclose:SetPos(ZAtlas_F4Menu:RespX(750), ZAtlas_F4Menu:RespY(10))
		anonymousrollclose:SetText("X")
		anonymousrollclose:SetFont("fontNino")
		anonymousrollclose:SizeToContents()
		anonymousrollclose.Paint = function(s,w,h)
            if anonymousrollclose:IsHovered() then
                anonymousrollclose:SetTextColor(Color(32, 122, 100))
                draw.RoundedBox(0, 0, 4, 25, 25, Color(32, 32, 32))
            else
                anonymousrollclose:SetTextColor(color_white)
                draw.RoundedBox(0, 0, 4, 25, 25, Color(32, 32, 32))
            end
        end
        anonymousrollclose.DoClick = function()
            BasicFrame:Close()
        end
		function BasicFrame:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(32, 32, 32))
			draw.RoundedBox(0, 0, 0, w, 50, Color(32, 122, 100))
			draw.RoundedBox(0, 0, 0, w, 3, Color(255, 255, 255))
			draw.RoundedBox(0, 0, 197, w, 3, Color(255, 255, 255))
			draw.RoundedBox(0, 797, 0, 3, h, Color(255, 255, 255))
			draw.RoundedBox(0, 0, 0, 3, h, Color(255, 255, 255))
	
			surface.SetMaterial(odiumLogo)
			surface.SetDrawColor(255, 255, 255)
			surface.DrawTexturedRect(8, 7, 40, 40)
	
		end
	
	local frameheader = vgui.Create("DLabel", BasicFrame)
	frameheader:SetPos(60, 0)
	frameheader:SetSize(500, 50)
	frameheader:SetText("Menu Médecin Odium")
	frameheader:SetColor(Color(255, 255, 255))
	frameheader:SetFont("Ultimate_Publicity_System_Font3")
	
    
	local anonymousrollheader3 = vgui.Create("DLabel", BasicFrame)
	anonymousrollheader3:SetPos(210, 80)
	anonymousrollheader3:SetSize(800, 50)
	anonymousrollheader3:SetText("Se faire soigner pour 5000 €")
	anonymousrollheader3:SetFont("Ultimate_Publicity_System_Font3")
	anonymousrollheader3:SetTextColor(Color(255,255,255))
	
	local Button3 = vgui.Create("DButton", BasicFrame)
	Button3:SetPos(50, 150)
	Button3:SetSize(700, 35)
	Button3:SetText("")
	Button3:SetTextColor(Color(255,255,255))
	Button3.DoClick = function()
    	net.Start("SMedic::Healing")
        net.WriteString("3")
    	net.SendToServer() 
		BasicFrame:Close() 
	end
	function Button3:Paint(w, h)
		if Button3:IsHovered() then
			draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100))
			draw.RoundedBox(0, 0, 0, 3, h, Color(255, 255, 255))
			draw.RoundedBox(0, 0, 0, w, 3, Color(255, 255, 255))
			draw.RoundedBox(0, 0, 32, w, 3, Color(255, 255, 255))
			draw.RoundedBox(0, 697, 0, 3, h, Color(255, 255, 255))
			draw.SimpleText("ACHETER", "Ultimate_Publicity_System_Font4", 300, 3, Color(32, 32, 32))
		else
			draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100))
			draw.SimpleText("ACHETER", "Ultimate_Publicity_System_Font4", 300, 3, Color(255, 255, 255))
		end
	end
end

function ENT:Draw()
	self:ResetSequence( "lineidle01" )
	self:DrawModel()

	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)

	local alpha = (LocalPlayer():GetPos():DistToSqr(self:GetPos()) / 120000000)
	alpha = math.Clamp(1 - alpha, 0 ,1)

	local a = Angle(0,0,90)
	a.y = self:GetAngles().y + 90

	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) < 120000000 then

		cam.Start3D2D(pos +  Vector(0, 0, math.sin(CurTime())*2), a, 0.05)
			draw.SimpleTextOutlined(SMedic.NPCName, "Ultimate_Publicity_System_Font1", -390+400, -1615, Color(255, 255, 255, 255 * alpha), 1, 1, 5, Color(32, 32, 32 * alpha));					
		cam.End3D2D();
	end 
end

net.Receive("SMedic::Frame", OpenBasicFrame)