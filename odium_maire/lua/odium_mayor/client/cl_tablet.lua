function Odium_Mayor:TabletDerma(politicalRegime)
    local frame
    local odiumMayorMat = Material("odium_mayor/logo.png", "smooth")

    local isRegime = (politicalRegime == "Dictature" or politicalRegime == "Démocratie") and true or false

    local tblBtn = {
        {name = "Régime politique", active = true, callback = function() Odium_Mayor:PoliticalPlan() frame:Remove() end},
        {name = "Renvoyer garde", active = isRegime and true or false, callback = function() Odium_Mayor:GuardFired() frame:Remove() end},
        {name = "Signaler un danger", active = isRegime and true or false, callback = function() net.Start("Odium:Mayor:LoadWarning") net.WriteBool(true) net.SendToServer() frame:Remove() end},
        {name = "Ne plus signaler un danger", active = isRegime and true or false, callback = function() net.Start("Odium:Mayor:LoadWarning") net.WriteBool(false) net.SendToServer() frame:Remove() end},
        {name = "Lancer un couvre-feu", active = isRegime and true or false, callback = function() net.Start("Odium:Mayor:SetLockdown") net.WriteBool(true) net.SendToServer() frame:Remove() end},
        {name = "Arrêter un couvre-feu", active = isRegime and true or false, callback = function() net.Start("Odium:Mayor:SetLockdown") net.WriteBool(false) net.SendToServer() frame:Remove() end},
    }

    frame = vgui.Create("DFrame")
    frame:SetSize(RX(1200), RY(800))
    frame:Center()
    frame:SetTitle("")
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    frame:MakePopup()
    function frame:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, Color(32, 32, 32))
        draw.RoundedBox(1, 0, 0, w, RY(80), Color(32, 122, 100))
        draw.RoundedBox(1, 0, 0, w, RY(80), Color(32, 122, 100))
        draw.RoundedBox(0, 0, 0, w, RY(3), Color(255, 255, 255))
        draw.RoundedBox(0, 0, RY(797), w, RY(3), Color(255, 255, 255))
        draw.RoundedBox(0, 0, 0, RX(3), h, Color(255, 255, 255))
        draw.RoundedBox(0, RX(1197), 0, RX(3), h, Color(255, 255, 255))
        
        draw.SimpleText("Menu du maire Odium", "OdiumMayor_Font1", RX(90), RY(15), color_white)
        draw.SimpleText("Lois de la ville:", "OdiumMayor_Font2", RX(690), RY(83), color_white)

        surface.SetDrawColor(color_white)
        surface.SetMaterial(odiumMayorMat)
        surface.DrawTexturedRect(RX(8), RY(8), RX(70), RY(70))
    end

    local CloseTablet = vgui.Create("DButton", frame)
    CloseTablet:SetPos(RespX(1150), RespY(20))
    CloseTablet:SetText("X")
    CloseTablet:SetFont("DermaDefault")
    CloseTablet:SizeToContents()
	CloseTablet.isSound = false
    CloseTablet.Paint = function(s,w,h)
        if CloseTablet:IsHovered() then
            CloseTablet:SetTextColor(Color(32, 122, 100))
            draw.RoundedBox(0, 0, RespY(4), RespX(25), RespY(25), Color(32, 32, 32))
			if not CloseTablet.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				CloseTablet.isSound = true
			end
        else
            CloseTablet:SetTextColor(color_white)
            draw.RoundedBox(0, 0, RespY(4), RespX(25), RespY(25), Color(32, 32, 32))
			CloseTablet.isSound = false
        end
    end
    CloseTablet.DoClick = function()
        if IsValid(frame) then frame:Remove() end
    end

    local leftPanel = vgui.Create("DPanel", frame)
    leftPanel:SetSize(RX(350), RY(500))
    leftPanel:SetPos(RX(10), RY(120))
    function leftPanel:Paint() end

    for k, v in ipairs(tblBtn) do
        local btn = vgui.Create("DButton", leftPanel)
        btn:SetSize(RX(0), RY(50))
        btn:Dock(TOP)
        btn:DockMargin(0, 0, 0, RY(15))
        btn:SetText("")
        btn:SetMouseInputEnabled(v.active and true or false)
        function btn:Paint(w, h)
            draw.RoundedBox(1, 0, 0, w, h, v.active and (btn:IsHovered() and Color(32, 105, 100) or Color(32, 122, 100)) or Color(57, 57, 52))
            draw.RoundedBox(1, 0, RY(40), w, RY(10), v.active and (btn:IsHovered() and Color(32, 105, 100) or Color(32, 105, 100)) or Color(57, 57, 52))
            draw.SimpleText(v.name, "OdiumMayor_Font11", w/2, h/2, btn:IsHovered() and Color(32, 32, 32) or Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        btn.DoClick = v.callback
    end

    local rightPanel = vgui.Create("DPanel", frame)
    rightPanel:SetSize(RX(820), RY(500))
    rightPanel:SetPos(RX(370), RY(120))
    function rightPanel:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, Color(57, 57, 52))
    end

    local scrollRightPanel = vgui.Create("DScrollPanel", rightPanel)
    scrollRightPanel:Dock(FILL)
    scrollRightPanel:DockMargin(RX(15), RY(15), RX(15), RY(15))
    local sBar = scrollRightPanel:GetVBar()
    sBar:SetWide(0)

    for k, v in ipairs(DarkRP.getLaws()) do
        local law = vgui.Create("DPanel", scrollRightPanel)
        law:SetSize(RX(0), RY(50))
        law:Dock(TOP)
        law:DockMargin(0, 0, 0, RY(15))
        law:SetText("")
        function law:Paint(w, h)
            draw.RoundedBox(1, 0, 0, w, h, Color(32, 32, 32))
            draw.SimpleText(k.."/", "OdiumMayor_Font2", RX(10), h/2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText(v, "OdiumMayor_Font3", k >= 10 and RX(60) or RX(45), h/2, color_white, 0, TEXT_ALIGN_CENTER)
        end

        local crossSuppress = vgui.Create("DButton", law)
        crossSuppress:SetPos(RX(755), RY(7))
        crossSuppress:SetText("X")
        crossSuppress:SetFont("ZatlasF4_Font4")
        crossSuppress:SizeToContents()
        crossSuppress:SetTextColor(color_white)
        function crossSuppress:Paint() end
        function crossSuppress:DoClick()
            LocalPlayer():ConCommand("darkrp removelaw "..k)
            frame:Remove()
        end
    end

    local bottomPanel = vgui.Create("DPanel", frame)
    bottomPanel:SetSize(RX(1180), RY(160))
    bottomPanel:SetPos(RX(10), RY(630))
    function bottomPanel:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, Color(57, 57, 52))

        draw.SimpleText("Ajouter une loi", "OdiumMayor_Font3", w/2, RY(5), color_white, TEXT_ALIGN_CENTER)
    end

    local entryLaw = vgui.Create("DTextEntry", bottomPanel)
    entryLaw:SetSize(RX(1160), RY(40))
    entryLaw:SetPos(RX(10), RY(45))
    entryLaw:SetFont("OdiumMayor_Font3")
    entryLaw:SetPlaceholderText("Entrez une loi à ajouter...")
    entryLaw:SetDrawLanguageID(false)
    entryLaw:SetMaximumCharCount(75)

    local acceptBtn = vgui.Create("DButton", bottomPanel)
    acceptBtn:SetSize(RX(1160), RY(50))
    acceptBtn:SetPos(RX(10), RY(100))
    acceptBtn:SetText("")
    function acceptBtn:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, acceptBtn:IsHovered() and Color(32, 105, 100) or Color(32, 122, 100))
        draw.RoundedBox(1, 0, RY(40), w, RY(10), Color(32, 105, 100))
        draw.SimpleText("Accepter", "OdiumMayor_Font2", w/2, h/2, acceptBtn:IsHovered() and Color(32, 32, 32) or Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function acceptBtn:DoClick()
        if not isRegime then notification.AddLegacy("Vous n'êtes pas en régime.", 1, 5) return end
        if entryLaw:GetValue() == "" then return end
        if #entryLaw:GetValue() < 3 then return end

        RunConsoleCommand("say", "/addlaw".." "..entryLaw:GetValue()) 
        
        entryLaw:SetValue("")
        scrollRightPanel:Clear()

        timer.Simple(0.2, function()
            for k, v in ipairs(DarkRP.getLaws()) do
                local law = vgui.Create("DPanel", scrollRightPanel)
                law:SetSize(RX(0), RY(50))
                law:Dock(TOP)
                law:DockMargin(0, 0, 0, RY(15))
                law:SetText("")
                function law:Paint(w, h)
                    draw.RoundedBox(1, 0, 0, w, h, Color(32, 32, 32))
                    draw.SimpleText(k.."/", "OdiumMayor_Font2", RX(10), h/2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(v, "OdiumMayor_Font3", k >= 10 and RX(60) or RX(45), h/2, color_white, 0, TEXT_ALIGN_CENTER)
                end

                local crossSuppress = vgui.Create("DButton", law)
                crossSuppress:SetPos(RX(760), RY(7))
                crossSuppress:SetText("X")
                crossSuppress:SetFont("OdiumMayor_Font2")
                crossSuppress:SizeToContents()
                crossSuppress:SetTextColor(color_white)
                function crossSuppress:Paint() end
                function crossSuppress:DoClick()
                    LocalPlayer():ConCommand("darkrp removelaw "..k)
                    frame:Remove()
                end
            end
        end)
    end
end

-- Political regime menu
function Odium_Mayor:PoliticalPlan()
    local frame = vgui.Create("DFrame")
    frame:SetSize(RX(500), RY(150))
    frame:Center()
    frame:SetTitle("")
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    frame:MakePopup()
    function frame:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, Color(32, 32, 32))
        draw.RoundedBox(1, RX(55), RY(75), RX(390), RY(3), color_white)
        draw.RoundedBox(1, 0, 0, w, RY(3), color_white)
        draw.RoundedBox(1, 0, RY(147), w, RY(3), color_white)
        draw.RoundedBox(1, 0, 0, RX(3), h, color_white)
        draw.RoundedBox(1, RX(497), 0, RX(3), h, color_white)
    end

    local btnDemocratie = vgui.Create("DButton", frame)
    btnDemocratie:SetSize(RX(480), RY(50))
    btnDemocratie:SetPos(RX(10), RY(10))
    btnDemocratie:SetText("")
    function btnDemocratie:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, btnDemocratie:IsHovered() and Color(32, 105, 100) or Color(32, 122, 100))
        draw.SimpleText("Démocratie", "OdiumMayor_Font1", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function btnDemocratie:DoClick()
        net.Start("Odium:Mayor:RegimePoliticalChange")
            net.WriteString("Démocratie")
        net.SendToServer()

        frame:Close()
    end

    local btnDictature = vgui.Create("DButton", frame)
    btnDictature:SetSize(RX(480), RY(50))
    btnDictature:SetPos(RX(10), RY(150-60))
    btnDictature:SetText("")
    function btnDictature:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, btnDictature:IsHovered() and Color(196, 51, 51) or Color(255, 87, 87))
        draw.SimpleText("Dictature", "OdiumMayor_Font1", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function btnDictature:DoClick()
        net.Start("Odium:Mayor:RegimePoliticalChange")
            net.WriteString("Dictature")
        net.SendToServer()

        frame:Close()
    end
end


-- Guard menu 
function Odium_Mayor:GuardFired()
    local frame = vgui.Create("DFrame")
    frame:SetSize(RX(500), RY(700))
    frame:Center()
    frame:SetTitle("")
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    frame:MakePopup()
    function frame:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, Color(32, 32, 32))
        draw.RoundedBox(1, 0, 0, w, RY(3), Color(255, 255, 255))
        draw.RoundedBox(1, 0, RY(697), w, RY(3), Color(255, 255, 255))
        draw.RoundedBox(1, 0, 0, RX(3), h, Color(255, 255, 255))
        draw.RoundedBox(1, RX(497), 0, RX(3), h, Color(255, 255, 255))
    end

    local scrollPanel = vgui.Create("DScrollPanel", frame)
    scrollPanel:SetSize(RX(480), RY(600))
    scrollPanel:SetPos(RX(10), RY(10))
    local sBar = scrollPanel:GetVBar()
    sBar:SetWide(0)

    for k, v in ipairs(player.GetAll()) do
        if not Odium_Mayor.Config.GuardJobs[v:getDarkRPVar("job")] then continue end
        
        local btnPlayer = vgui.Create("DButton", scrollPanel)
        btnPlayer:SetSize(0, RY(50))
        btnPlayer:Dock(TOP)
        btnPlayer:DockMargin(0, 0, 0, RY(10))
        btnPlayer:SetText("")
        function btnPlayer:Paint(w, h)
            draw.RoundedBox(1, 0, 0, w, h, btnPlayer:IsHovered() and Color(29, 87, 72) or Color(32, 122, 100))
            draw.SimpleText(v:Name(), "OdiumMayor_Font2", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        function btnPlayer:DoClick()
            net.Start("Odium:Mayor:FiredGuard")
                net.WriteEntity(v)
            net.SendToServer()

            frame:Remove()
        end
    end

    local btnRemove = vgui.Create("DButton", frame)
    btnRemove:SetSize(RX(480), RY(50))
    btnRemove:SetPos(RX(10), RY(700-60))
    btnRemove:SetText("")
    function btnRemove:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, btnRemove:IsHovered() and Color(32, 105, 100) or Color(32, 122, 100))
        draw.RoundedBox(1, 0, RY(40), w, RY(10), Color(32, 105, 100))
        draw.SimpleText("Fermer", "OdiumMayor_Font2", w/2, h/2, btnRemove:IsHovered() and Color(32, 32, 32) or Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function btnRemove:DoClick()
        frame:Remove()
    end
end