local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

function OdiumATM:ATMDepositSide()
    local depositEntry
    local tblPreset = {
        {
            name = "100 €",
            func = function()
                if depositEntry:GetValue() == "" then
                    depositEntry:SetValue("100")
                else
                    depositEntry:SetValue(tonumber(depositEntry:GetValue()) + tonumber("100"))
                end
            end
        },
        {
            name = "1,000 €",
            func = function() 
                if depositEntry:GetValue() == "0" then
                    depositEntry:SetValue("1000")
                else
                    depositEntry:SetValue(tonumber(depositEntry:GetValue()) + tonumber("1000"))
                end
            end
        },
        {
            name = "5,000 €",
            func = function() 
                if depositEntry:GetValue() == "0" then
                    depositEntry:SetValue("5000")
                else
                    depositEntry:SetValue(tonumber(depositEntry:GetValue()) + tonumber("5000"))
                end
            end
        },
        {
            name = "10,000 €",
            func = function() 
                if depositEntry:GetValue() == "0" then
                    depositEntry:SetValue("10000")
                else
                    depositEntry:SetValue(tonumber(depositEntry:GetValue()) + tonumber("10000"))
                end
            end
        },
        {
            name = "50,000 €",
            func = function() 
                if depositEntry:GetValue() == "0" then
                    depositEntry:SetValue("50000")
                else
                    depositEntry:SetValue(tonumber(depositEntry:GetValue()) + tonumber("50000"))
                end
            end
        },
        {
            name = "100,000 €",
            func = function() 
                if depositEntry:GetValue() == "0" then
                    depositEntry:SetValue("100000")
                else
                    depositEntry:SetValue(tonumber(depositEntry:GetValue()) + tonumber("100000"))
                end
            end
        },
    }


    atmDepositPanel = vgui.Create("DPanel", atmFrame)
    atmDepositPanel:SetSize(atmFrame:GetWide(), atmFrame:GetTall()-RespY(70))
    atmDepositPanel:SetPos(0, RespY(70))
    atmDepositPanel:FadeIn()
    function atmDepositPanel:Paint(w, h) 
        surface.SetDrawColor(MyLib.ColorServer["Black"])

        surface.SetDrawColor(MyLib.ColorServer["white"])
        draw.NoTexture()
        draw.Circle(RespX(62), RespY(572), RespX(42), RespY(100))

        surface.SetDrawColor(MyLib.ColorServer["Green"])
        draw.NoTexture()
        draw.Circle(RespX(62), RespY(572), RespX(40), RespY(100))

        draw.RoundedBox(6, (w/2)-RespX(90), RespY(35), surface.GetTextSize('OdiumATM_Font4'), RespY(50), MyLib.ColorServer["Green"])
        draw.SimpleText(DarkRP.formatMoney(tonumber(LocalPlayer():GetNWInt("playerBankAccount"))), "OdiumATM_Font4", w/2, RespY(40), color_white, TEXT_ALIGN_CENTER)

        draw.RoundedBox(0, RespX(250), RespY(125), RespX(40), RespY(50), color_white)
        draw.SimpleText("€", "OdiumATM_Font4", RespX(260), RespY(130), color_black)
    end

    local exitDepositButton = vgui.Create("DButton", atmDepositPanel)
    exitDepositButton:SetSize(RespX(80), RespY(80))
    exitDepositButton:SetPos(RespX(20), RespY(530))
    exitDepositButton:SetText("◀")
    exitDepositButton:SetFont("OdiumATM_FontCross")
	exitDepositButton.isSound = false
    function exitDepositButton:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
        if exitDepositButton:IsHovered() then
            exitDepositButton:SetTextColor(MyLib.ColorServer["Black"])    
			if not exitDepositButton.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					exitDepositButton.isSound = true
			end	
        else
            exitDepositButton:SetTextColor(color_white)
			exitDepositButton.isSound = false
        end
    end
    function exitDepositButton:DoClick()
        atmDepositPanel:FadeOut()
        OdiumATM:ATMHomeSide()
    end

    depositEntry = vgui.Create("DTextEntry", atmDepositPanel)
    depositEntry:SetSize(RespX(450), RespY(50))
    depositEntry:SetPos(RespX(300), RespY(125))
    depositEntry:SetFont("OdiumATM_Font4")
    depositEntry:SetValue("0")
    depositEntry:SetNumeric(true)
    depositEntry:SetUpdateOnType(true)
    local widthText, heightText = surface.GetTextSize( depositEntry:GetValue() )
    function depositEntry:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, color_white)
        depositEntry:DrawTextEntryText(Color(0, 0, 0), MyLib.ColorServer["Green"], MyLib.ColorServer["Green"])
    end

    local presetLayout = vgui.Create("DIconLayout", atmDepositPanel)
    presetLayout:SetSize(RespX(500), RespY(300))
    presetLayout:SetPos(RespX(250), RespY(220))
    presetLayout:SetSpaceX(RespX(30))
    presetLayout:SetSpaceY(RespY(30))

    for _, btn in ipairs(tblPreset) do
        local presetBtn = vgui.Create("DButton", presetLayout)
        presetBtn:SetSize(RespX(235), RespY(65))
        presetBtn:SetText(btn.name)
        presetBtn:SetFont("OdiumATM_Font4")
		presetBtn.isSound = false
        function presetBtn:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
            if presetBtn:IsHovered() then
                draw.RoundedBox(0, 0, h-RespY(7), w, RespY(7), MyLib.ColorServer["GreentSecond"])
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
                draw.RoundedBox(0, 0, 0, RespX(3), h, MyLib.ColorServer["white"])
                draw.RoundedBox(0, 0, 0, w, RespY(3), MyLib.ColorServer["white"])
                draw.RoundedBox(0, RespX(232), 0, RespX(3), h, MyLib.ColorServer["white"])
                draw.RoundedBox(0, 0, RespY(63), w, RespY(3), MyLib.ColorServer["white"])
                presetBtn:SetTextColor(MyLib.ColorServer["Black"])
				if not presetBtn.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					presetBtn.isSound = true
				end
            else
                draw.RoundedBox(0, 0, h-RespY(7), w, RespY(7), MyLib.ColorServer["GreentSecond"])
                draw.RoundedBox(0, 0, h-RespY(8), w, RespY(3), MyLib.ColorServer["GreentSecond"])
                presetBtn:SetTextColor(color_white)
				presetBtn.isSound = false
            end
        end
        presetBtn.DoClick = btn.func
    end

    local depositConfirmBtn = vgui.Create("DButton", atmDepositPanel)
    depositConfirmBtn:SetSize(RespX(500), RespY(65))
    depositConfirmBtn:SetPos(RespY(250), RespY(510))
    depositConfirmBtn:SetText("Confirmer")
    depositConfirmBtn:SetFont("OdiumATM_Font4")
	depositConfirmBtn.isSound = false
    function depositConfirmBtn:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Red"])
        if depositConfirmBtn:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Red"])
                draw.RoundedBox(0, 0, 0, RespX(3), h, MyLib.ColorServer["white"])
                draw.RoundedBox(0, 0, 0, w, RespY(3), MyLib.ColorServer["white"])
                draw.RoundedBox(0, RespX(497), 0, RespX(3), h, MyLib.ColorServer["white"])
                draw.RoundedBox(0, 0, RespY(63), w, RespY(3), MyLib.ColorServer["white"])
                depositConfirmBtn:SetTextColor(MyLib.ColorServer["Black"])
				if not depositConfirmBtn.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					depositConfirmBtn.isSound = true
				end
        else
            depositConfirmBtn:SetTextColor(color_white)
			depositConfirmBtn.isSound = false
        end
    end
    function depositConfirmBtn:DoClick() 
        net.Start("OdiumATM::Networking")
            net.WriteString("ATMDepositMoney")
            net.WriteInt(tonumber(depositEntry:GetValue()), 32)
        net.SendToServer()
        atmFrame:FadeOut()
    end
end