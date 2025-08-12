function Odium_Mayor:LockerDerma(ent, taxe)
    local isTaxe = Odium_Mayor.Config.Taxes[taxe] and true or false
    --Odium_Mayor.Config.MayorLockerTimerRecup
    if isTaxe then 
        if ent:GetRestrictAccess() != 2 then notification.AddLegacy("Vous pouvez récupérer votre argent dans "..math.Round(ent:GetRestrictAccessTimer()-CurTime()).." secondes", 1, 5) return end

        local secondFrame = vgui.Create("DFrame")
        secondFrame:SetSize(RX(800), RY(200))
        secondFrame:Center()
        secondFrame:SetDraggable(false)
        secondFrame:MakePopup()
        secondFrame:SetTitle("")
        secondFrame:ShowCloseButton(true)
        function secondFrame:Paint(w, h)
            draw.RoundedBox(1, 0, 0, w, h, Color(32, 32, 32))
            draw.RoundedBox(1, 0, 0, w, RY(50), Color(32, 122, 100))
            draw.SimpleText("Coffre du maire", "OdiumMayor_Font2", RX(10), RY(7), color_white)
            draw.SimpleText(DarkRP.formatMoney(ent:GetMoney()), "OdiumMayor_Font2", w/2, RY(75), color_white, TEXT_ALIGN_CENTER)
        end

        local btnTake = vgui.Create("DButton", secondFrame)
        btnTake:SetSize(RX(780), RY(50))
        btnTake:SetPos(RX(10), RY(200-50-10))
        btnTake:SetText("")
        function btnTake:Paint(w, h)
            draw.RoundedBox(1, 0, 0, w, h, Color(32, 122, 100))
            draw.SimpleText("Prendre", "OdiumMayor_Font2", w/2, h/2, btnTake:IsHovered() and Color(230, 230, 230) or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        function btnTake:DoClick()
            net.Start("Odium:Mayor:TakeLockerMoney")
                net.WriteEntity(ent)
            net.SendToServer()

            secondFrame:Close()
        end

        return 
    end

    local frame = vgui.Create("DFrame")
    frame:SetSize(RX(800), RY(200))
    frame:Center()
    frame:SetDraggable(false)
    frame:MakePopup()
    frame:SetTitle("")
    frame:ShowCloseButton(false)
    function frame:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, Color(32, 32, 32))
        draw.RoundedBox(1, 0, 0, w, RY(50), Color(32, 122, 100))
        draw.SimpleText("Taux de taxe", "OdiumMayor_Font2", RX(10), RY(7), color_white)
        draw.SimpleText("0.1%", "OdiumMayor_Font4", RX(90), RY(60), color_white)
        draw.SimpleText("0.2%", "OdiumMayor_Font4", RX(260), RY(60), color_white)
        draw.SimpleText("0.3%", "OdiumMayor_Font4", RX(460), RY(60), color_white)
        draw.SimpleText("0.4%", "OdiumMayor_Font4", RX(660), RY(60), color_white)
    end

    local numSlider = vgui.Create("DNumSlider", frame)
    numSlider:SetPos(RX(-360), RY(70))
    numSlider:SetSize(RX(1100), RY(50))
    numSlider:SetDark(false)
    numSlider:SetText("")
    numSlider:SetMin(0.1)
    numSlider:SetMax(0.4)
    numSlider:SetValue(0.1)
    numSlider:SetDecimals(1)

    local btnValid = vgui.Create("DButton", frame)
    btnValid:SetSize(RX(780), RY(50))
    btnValid:SetPos(RX(10), RY(200-50-10))
    btnValid:SetText("")
    function btnValid:Paint(w, h)
        draw.RoundedBox(1, 0, 0, w, h, Color(32, 122, 100))
        draw.SimpleText("Valider", "OdiumMayor_Font2", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function btnValid:DoClick()
        net.Start("Odium:Mayor:SetTaxe")
            net.WriteFloat(math.Round(numSlider:GetValue(), 1))
        net.SendToServer()

        frame:Remove()
    end
end