local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

include("shared.lua")

surface.CreateFont( "OdiumLock:Font:3D2D", {
	font = "Righteous",
	size = 110,
	weight = 500,
} )

surface.CreateFont( "OdiumLock:Font:3D2D2", {
	font = "Righteous",
	size = 55,
	weight = 500,
} )

surface.CreateFont( "OdiumLock:Font:DrawM", {
	font = "Righteous",
	size = 50,
	weight = 500,
} )

surface.CreateFont( "OdiumLock:Font:DrawText", {
	font = "Righteous",
	size = 25,
	weight = 500,
} )

surface.CreateFont("odiumreceler", {font = "Righteous", size = 200})

function ENT:Draw()
    self:DrawModel()
    local ang = self:GetAngles();

	ang:RotateAroundAxis(ang:Forward(), 90);
	ang:RotateAroundAxis(ang:Right(), -90);
	

	cam.Start3D2D(self:GetPos()+self:GetUp()*80, Angle(0, self:GetAngles().y+90, 90), 0.04);
		local wi, he = surface.GetTextSize(ZatlasLock.NameNPC)
		local pad = 80
		wi = wi + pad * 8
		he = he + pad * 2
		
		 draw.SimpleTextOutlined(ZatlasLock.NameNPC, "odiumreceler", 0, 10, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 10, MyLib.ColorServer["Black"])
	cam.End3D2D()

	net.Receive("Zatlas:DrawInformations", function()
		local success = net.ReadBool()
		if success then
			hook.Add("HUDPaint", "ZatlasLock:Paint", function()
				if not IsValid(self) then return end
				local vpos = self:GetPos()
				local callPos = vpos:ToScreen()
				--draw.SimpleText(math.ceil( ( LocalPlayer():GetPos():Distance( vpos ) / 16 ) / 3.28084 ).."m", "OdiumLock:Font:DrawM", callPos.x, callPos.y, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleTextOutlined(math.ceil( ( LocalPlayer():GetPos():Distance( vpos ) / 16 ) / 3.28084 ).."m", "OdiumLock:Font:DrawM", callPos.x, callPos.y, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 4, MyLib.ColorServer["Black"])
	
			end)
		end

	end)
end

local timeLeft = 0

net.Receive("Zatlas:Cooldowns", function()
    local ply = LocalPlayer()
    local delay = net.ReadUInt(8)

    hook.Remove("HUDPaint", "ZatlasLock:Paint")
    ply.CoolDown = CurTime() + delay
end)

hook.Add("HUDPaint", "Zatlas:Paint", function()
    local ply = LocalPlayer()

    if isnumber(ply.CoolDown) then

        if ply.CoolDown > CurTime() then
            timeLeft = ply.CoolDown - CurTime()
        else
            ply.CoolDown = nil
        end
		draw.RoundedBox(0, RespX(695), RespY(1045), RespX(570), RespY(35), MyLib.ColorServer["white"])
        draw.RoundedBox(0, RespX(700), RespY(1050), RespX(560), RespY(25), MyLib.ColorServer["Green"])
    	draw.SimpleText("Il reste " .. math.Round(timeLeft) .. " secondes avant de pouvoir récupérer l'argent sale !", "OdiumLock:Font:DrawText", RespX(705), RespY(1050), MyLib.ColorServer["white"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
    end
end)

hook.Add("PreCleanupMap", "Odium:Hook:PreCleanupMap", function()
    hook.Remove("HUDPaint", "ZatlasLock:Paint")
end)