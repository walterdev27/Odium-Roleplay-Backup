local function RespX(x)
    return x / 1920 * ScrW()
end

local function RespY(y)
    return y / 1080 * ScrH()
end

local string_lower = string.lower
local string_StartWith = string.StartWith
local pairs = pairs
local ipairs = ipairs
local math_Clamp = math.Clamp
local math_round = math.Round
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawPoly = surface.DrawPoly

local kevlarMat = Material("zatlas_ticket/gilet-pare-balles.png")
local heartMat = Material("zatlas_ticket/heart.png")
local moneyMat = Material("zatlas_ticket/money.png")

hook.Add("OnPlayerChat", "ZatlasTicket::ReportCMD", function(ply, strText, bTeam, bDead)
    if (ply ~= LocalPlayer()) then return end

    strText = string_lower(strText)

    if (strText == ZatlasTicket.CommandReport) or (string_StartWith(strText, "!ticket")) then
        Zatlas_Ticket:ReportSide()
        return true
    end
end)

local fontData = {
    {name = "font1adminmode", size = 25, weight = 1200},
    {name = "font2adminmode", size = 32, weight = 400},
    {name = "font3adminmode", size = 20, weight = 800},
    {name = "font4adminmode", size = 20, weight = 800},
    {name = "font5adminmode", size = 50, weight = 800},
    {name = "font6adminmode", size = 15, weight = 800},
    {name = "font7adminmode", size = 16, weight = 800},
}

for _, font in ipairs(fontData) do
    surface.CreateFont(font.name, {
        font = "Righteous",
        extended = false,
        size = RespX(font.size),
        weight = RespY(font.weight),
        italic = false,
    })
end

function draw.Circle(x, y, radius, seg)
    local cir = {}

    table.insert(cir, {x = x, y = y, u = 0.5, v = 0.5})
    for i = 0, seg do
        local a = math.rad((i / seg) * -360)
        table.insert(cir, {
            x = x + math.sin(a) * radius,
            y = y + math.cos(a) * radius,
            u = math.sin(a) / 2 + 0.5,
            v = math.cos(a) / 2 + 0.5,
        })
    end

    local a = math.rad(0) -- This is needed for non absolute segment counts
    table.insert(cir, {
        x = x + math.sin(a) * radius,
        y = y + math.cos(a) * radius,
        u = math.sin(a) / 2 + 0.5,
        v = math.cos(a) / 2 + 0.5,
    })

    surface.DrawPoly(cir)
end

local contextOpened = false

local function DrawAdminPanel()
    draw.RoundedBox(0, RespX(825), 0, RespX(260), RespY(35), Color(255, 255, 255))
    draw.RoundedBox(0, RespX(830), 0, RespX(250), RespY(30), Color(39, 39, 39))
    draw.SimpleText("Administration", "font1adminmode", ScrW() / 2, 3, Color(32, 122, 100), TEXT_ALIGN_CENTER)
end

hook.Remove("HUDPaint", "ZAltasTicket::AdminModePainting")
hook.Add("HUDPaint", "ZAltasTicket::AdminModePainting", function()
    if not MyLib.StaffGeneralPrincipalePerm[LocalPlayer():GetUserGroup()] then return end
    if not LocalPlayer():GetNWBool("zatlasAdminMode") then return end

    DrawAdminPanel()

	draw.RoundedBox(0, RespX(825), 0, RespX(260), RespY(35), Color(255, 255, 255))
	draw.RoundedBox(0, RespX(830), 0, RespX(250), RespY(30), Color(39, 39, 39))
	draw.SimpleText("Administration", "font1adminmode", ScrW()/2, 3, Color(32,122,100), TEXT_ALIGN_CENTER)

	--draw.SimpleText("God", "font2adminmode", RespX(820), RespY(45), Color(72, 201, 136))
	draw.SimpleTextOutlined("God", "font2adminmode", RespX(854), RespY(60), Color(72, 201, 136), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))

	draw.RoundedBox(0, RespX(890), RespY(35), RespX(4), RespY(40), Color(255, 255, 255))

	if LocalPlayer():GetNoDraw() or LocalPlayer():GetRenderMode() == RENDERMODE_TRANSALPHA then
		draw.SimpleTextOutlined("Cloak", "font2adminmode", RespX(953), RespY(55), Color(72, 201, 136), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
		--draw.SimpleText("Cloak", "font2adminmode", RespX(920), RespY(45), Color(72, 201, 136))
	else
		draw.SimpleTextOutlined("Cloak", "font2adminmode", RespX(953), RespY(55), Color(255, 35, 77), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
		--draw.SimpleText("Cloak", "font2adminmode", RespX(920), RespY(45), Color(255, 35, 77))
	end

	draw.RoundedBox(0, RespX(1010), RespY(35), RespX(4), RespY(40), Color(255, 255, 255))

	if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP then
		draw.SimpleTextOutlined("Noclip", "font2adminmode", RespX(1063), RespY(60), Color(72, 201, 136), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
		--draw.SimpleText("Noclip", "font2adminmode", RespX(1035), RespY(45), Color(72, 201, 136))
	else
		draw.SimpleTextOutlined("Noclip", "font2adminmode", RespX(1063), RespY(60), Color(255, 35, 77), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
		--draw.SimpleText("Noclip", "font2adminmode", RespX(1035), RespY(45), Color(255, 35, 77))
	end

	for k, v in pairs(player.GetAll()) do
		if v == LocalPlayer() then continue end
		
		local pos = v:GetPos() + v:OBBCenter() + Vector(0, 0, 40)
		local alpha = math.Clamp(1 - (LocalPlayer():GetPos():DistToSqr(v:GetPos()) / 1200000), 0 ,1)
		local faimtext = math.Round(v:getDarkRPVar("Energy") or 100)

		pos = pos:ToScreen()
		
		surface.SetDrawColor(0, 0, 0)
		draw.NoTexture()
		draw.Circle( RespX(pos.x), RespY(pos.y), RespX(9), RespY(90))
		
		surface.SetDrawColor(MyLib.ColorServer["Green"])
		draw.NoTexture()
		draw.Circle( RespX(pos.x), RespY(pos.y), RespX(6), RespY(90))

	
		if LocalPlayer():GetPos():DistToSqr(v:GetPos()) < 120000 then
			draw.RoundedBox(0,  RespX(pos.x- 43), RespY(pos.y- 186), RespX(88), RespY(100), (ZatlasTicket.Colors["ServerColorBlackOther"]))
			draw.RoundedBox(0,  RespX(pos.x- 39), RespY(pos.y- 145), RespX(80), RespY(15), (ZatlasTicket.Colors["ServerColorFaim2"]))
			draw.RoundedBox(0,  RespX(pos.x- 39), RespY(pos.y- 145), RespX(faimtext*0.8), RespY(15), (ZatlasTicket.Colors["ServerColorFaim"]))
			draw.RoundedBox(0,  RespX(pos.x- 39), RespY(pos.y- 125), RespX(80), RespY(15), (ZatlasTicket.Colors["ServerColorArmor2"]))
			draw.RoundedBox(0,  RespX(pos.x- 39), RespY(pos.y- 125), RespX(v:Armor()*0.4), RespY(15), (ZatlasTicket.Colors["ServerColorArmor"]))
			draw.RoundedBox(0,  RespX(pos.x- 39), RespY(pos.y- 105), RespX(80), RespY(15), (ZatlasTicket.Colors["ServerColorVie2"]))
			draw.RoundedBox(0,  RespX(pos.x- 39), RespY(pos.y- 105), RespX(v:Health()*0.8), RespY(15), (ZatlasTicket.Colors["ServerColorVie"]))
			draw.SimpleTextOutlined("Kill(s): "..v:Frags(), "font7adminmode", RespX(pos.x- 13), RespY(pos.y-175), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			draw.SimpleTextOutlined("Mort(s): "..v:Deaths(), "font7adminmode", RespX(pos.x- 10), RespY(pos.y-158), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			draw.SimpleTextOutlined(faimtext.." FM", "font6adminmode", RespX(pos.x+ 0), RespY(pos.y- 138.4), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			draw.SimpleTextOutlined(v:Armor().." KV", "font6adminmode", RespX(pos.x+ 0), RespY(pos.y- 118.1), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			draw.SimpleTextOutlined(v:Health().." HP", "font6adminmode", RespX(pos.x+ 0), RespY(pos.y- 98.3), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
		end
		if LocalPlayer():GetPos():DistToSqr(v:GetPos()) < 50000000 then
			draw.SimpleTextOutlined(DarkRP.formatMoney(v:getDarkRPVar("money")), "font4adminmode", RespX(pos.x+ 0), RespY(pos.y-70), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			draw.SimpleTextOutlined(v:getDarkRPVar("job"), "font4adminmode", RespX(pos.x+ 0), RespY(pos.y-50), team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
			draw.SimpleTextOutlined(v:GetName(), "font4adminmode", RespX(pos.x+ 0), RespY(pos.y-30), MyLib.ColorServer["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])
		end
		

	end
	
	for k, v in ipairs(ents.FindByClass("prop_vehicle_jeep")) do
		local pos = v:GetPos() + v:OBBCenter() + Vector(0, 0, 60)
		pos = pos:ToScreen()
		
		surface.SetDrawColor(color_black)
		draw.NoTexture()
		draw.Circle( pos.x, pos.y, 7, 90 )
		
		surface.SetDrawColor(51, 224, 255)
		draw.NoTexture()
		draw.Circle( pos.x, pos.y, 4, 90 )
		
		draw.SimpleTextOutlined(v:GetVehicleClass(), "font3adminmode", RespX(pos.x + 0), RespX(pos.y - 35), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
	end
	
end)