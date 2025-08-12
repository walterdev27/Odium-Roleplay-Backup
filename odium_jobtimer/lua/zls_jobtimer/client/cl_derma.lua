-- [[ Responsive fonts ]] --
local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

-- [[ Fonts ]] --
surface.CreateFont("ZLS:JobTimer:FrameTitle", {
    font = "Righteous",
    size = RespX(70),
    weight = 0
})

surface.CreateFont("ZLS:JobTimer:CloseButton", {
    font = "Righteous",
    size = RespX(50),   
    weight = 500
})

surface.CreateFont("ZLS:JobTimer:PanelTitle", {
    font = "Righteous",
    size = RespX(30),   
    weight = 0
})

-- [[ Open the menu ]] --
function ZLS.JobTimer.OpenMenu(tbl)
    if not istable(tbl) then return end
    PrintTable(tbl)

    local frame = vgui.Create("DFrame")
    frame:SetSize(RespX(1300), RespY(850))
    frame:Center()
    frame:SetTitle("")
    frame:SetDraggable(false)
    frame:MakePopup()
    frame:ShowCloseButton(false)
    function frame:Paint(w, h)

        -- [[ Header ]] --
        surface.SetDrawColor(MyLib.ColorServer["Black"])
        surface.SetDrawColor(MyLib.ColorServer["Green"])
        surface.DrawRect(0, 0, w, RespY(85))

        draw.RoundedBox(0, 0, 0, RespX(1300), RespY(5), MyLib.ColorServer["white"])
        draw.RoundedBox(0, RespX(1295), RespY(0), RespX(5), RespY(1300), MyLib.ColorServer["white"])
        draw.RoundedBox(0, 0, 0, RespX(5), RespY(1300), MyLib.ColorServer["white"])

        draw.SimpleText("Timer Job ODIUM", "ZLS:JobTimer:FrameTitle", w/2, RespY(42.5), MyLib.ColorServer["white"], 1, 1)
    end

    local closeButton = frame:Add("DButton")
    closeButton:SetPos(RespX(1230), RespY(30))
    closeButton:SetText("X")
    closeButton:SetFont("ZLS:JobTimer:PanelTitle")
    closeButton:SizeToContents()
    closeButton.Paint = function(s,w,h)
        if closeButton:IsHovered() then
            closeButton:SetTextColor(MyLib.ColorServer["Green"])
            draw.RoundedBox(0, 0, RespY(4), RespX(25), RespY(25), MyLib.ColorServer["Black"])
        else
            closeButton:SetTextColor(color_white)
            draw.RoundedBox(0, 0, RespY(4), RespX(25), RespY(25), MyLib.ColorServer["Black"])
        end
    end
    closeButton.DoClick = function()
        frame:Close()
    end

    if MyLib.AllPerm[LocalPlayer():GetUserGroup()] or LocalPlayer():IsSuperAdmin() then
        local clearButton = frame:Add("DButton")
        clearButton:SetPos(RespX(1120), RespY(30))
        clearButton:SetText("Clear Job")
        clearButton:SetFont("ZLS:JobTimer:PanelTitle")
        clearButton:SizeToContents()
        clearButton.Paint = function(s,w,h)
            if clearButton:IsHovered() then
                clearButton:SetTextColor(MyLib.ColorServer["Green"])
                draw.RoundedBox(0, 0, RespY(4), RespX(115), RespY(25), MyLib.ColorServer["Black"])
            else
                clearButton:SetTextColor(color_white)
                draw.RoundedBox(0, 0, RespY(4), RespX(115), RespY(25), MyLib.ColorServer["Black"])
            end
        end
        clearButton.DoClick = function()
            local frame2 = vgui.Create("DFrame")
            frame2:SetSize(RespX(350), RespY(250))
            frame2:Center()
            frame2:SetTitle("")
            frame2:SetDraggable(false)
            frame2:MakePopup()
            frame2:ShowCloseButton(true)
            function frame2:Paint(w, h)
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
                draw.SimpleTextOutlined("Supprimer ?", "ZLS:JobTimer:PanelTitle", RespX(75), RespY(22), MyLib.ColorServer["GreenBlueClaire"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
            end
            local clearButton2 = frame2:Add("DButton")
            clearButton2:SetSize(RespX(340), RespY(190))
            clearButton2:SetPos(RespX(5), RespY(55))
            clearButton2:SetText("Êtes vous sûr de Supprimer !!")
            clearButton2:SetFont("ZLS:JobTimer:PanelTitle")
            clearButton2.Paint = function(s,w,h)
                if clearButton2:IsHovered() then
                    clearButton2:SetTextColor(MyLib.ColorServer["Black"])
                    draw.RoundedBox(0, 0, RespY(0), w, h, Color(255, 0, 0))
                else
                    clearButton2:SetTextColor(color_white)
                    draw.RoundedBox(0, 0, RespY(0), w, h, MyLib.ColorServer["Green"])
                end
            end
            clearButton2.DoClick = function()
                net.Start("ZLS.JobTimer.DropTables")
                net.SendToServer()
                for i = 1, 7 do
                    chat.AddText(MyLib.ColorServer["Green"], "Base de donnée JobTimer supprimer !")
                end
                frame:Remove()
                frame2:Remove()
            end
        end
    end
    
    local scroll = frame:Add("DScrollPanel")
    scroll:SetSize(frame:GetWide(), frame:GetTall() - RespY(85))
    scroll:SetPos(0, RespY(85))
    function scroll:Paint(w, h)
        surface.SetDrawColor(47, 47, 47)
        surface.DrawRect(0, 0, w, h)

        draw.RoundedBox(0, 0, RespY(760), RespX(1300), RespY(5), MyLib.ColorServer["white"])
        draw.RoundedBox(0, 0, 0, RespX(5), RespY(1300), MyLib.ColorServer["white"])
        draw.RoundedBox(0, RespX(1295), RespY(0),  RespX(5), RespY(1300), MyLib.ColorServer["white"])
    end 

    for categoryName,infos in pairs(tbl) do
        if not isstring(categoryName) or not istable(infos) then continue end

        
        local panel = scroll:Add("DPanel")
        panel:SetTall(RespY(70) + #infos * RespY(17.2))
        panel:Dock(TOP)
        panel:DockMargin(0, 10, 0, 0)
        function panel:Paint(w, h)
            surface.SetDrawColor(192, 57, 43)
            surface.DrawRect(0, 0, w, RespY(50))
            
            draw.SimpleText(categoryName, "ZLS:JobTimer:PanelTitle", w/2, RespY(25), MyLib.ColorServer["white"], 1, 1)

            surface.SetDrawColor(MyLib.ColorServer["white"])
            surface.DrawRect(0, RespY(50), w, h-RespY(50))
        end

        local timeList = panel:Add("DListView")
        timeList:SetSize(scroll:GetWide() - RespX(10), panel:GetTall() - RespY(55))
        timeList:SetPos(RespX(5), RespY(50))
        timeList:AddColumn("Nom")
        timeList:AddColumn("SteamID")
        timeList:AddColumn("Métier")
        timeList:AddColumn("Temps de jeu")
    
        for k,v in ipairs(infos) do
            if not istable(v) then continue end
    
            if not isstring(v["rpname"]) then continue end
            if not isstring(v["id64"]) then continue end
            if not isstring(v["jobName"]) then continue end
    
            v["time"] = tonumber(v["time"])
            if not isnumber(v["time"]) then continue end
    
            timeList:AddLine(v["rpname"], util.SteamIDFrom64(v["id64"]), v["jobName"], math.floor(v["time"] / 60).. " minute(s)")
        end
    end
end

net.Receive("ZLS:JobTimer:OpenMenu", function()
    
    local compressBytes = net.ReadUInt(32)
    if not isnumber(compressBytes) then return end

    local compress = net.ReadData(compressBytes)
    
    local tbl = ZLS.JobTimer.UnCompress(compress)
    
    ZLS.JobTimer.OpenMenu(tbl)
end)