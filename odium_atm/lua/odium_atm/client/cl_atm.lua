local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

function OdiumATM:AtmFrame()
    local timeInit = os.time()
    local dateString = os.date("%A, %B %d", timeInit)
    local hourString = os.date("%H:%M", timeInit)

    local cupMat = Material("odium_atm_icons/icon_odium_frame.png")
    
    -- Cache
    

    local textX, textY = surface.GetTextSize(dateString)
    local textGX, textGY = surface.GetTextSize("OdiumATM_Font1")

    atmFrame = vgui.Create("DFrame")
    atmFrame:SetSize(RespX(1000), RespY(700))
    atmFrame:SetPos(ScrW()- RespX(1450),ScrH()- 0)
	atmFrame:MoveTo(ScrW()- RespX(1450),ScrH()- RespY(900), 0.3, 0, .3, function() end)
    atmFrame:MakePopup()
    atmFrame:SetTitle("")
    atmFrame:SetDraggable(false)
    atmFrame:ShowCloseButton(false)
    function atmFrame:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
        --draw.RoundedBox(0, 0, RespY(61), w, RespY(10), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, RespX(9), RespY(8), RespX(984), RespY(70), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, 0, RespX(3), h,MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, 0, w, RespX(3),MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, RespX(697), w, RespX(3),MyLib.ColorServer["Green"])
        draw.RoundedBox(0, RespX(997), 0, RespX(3), h,MyLib.ColorServer["Green"])

        OdiumATM:MaterialRotated(RespX(40), RespY(37),  RespX(60),  RespY(60), cupMat, 0)
        draw.SimpleText("ODIUM ATM", "OdiumATM_Font5", RespX(75), RespY(18), color_white)

        draw.SimpleText(dateString, "OdiumATM_Font1", w - textX - textGX -  RespX(-15), RespY(5), color_white)
        draw.SimpleText(hourString, "OdiumATM_Font1", (w-surface.GetTextSize("OdiumATM_Font2"))+RespY(110), RespY(40), color_white)    
    end

    OdiumATM:ATMHomeSide()
end