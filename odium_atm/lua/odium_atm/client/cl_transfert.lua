/*
* @Author: Diesel
* @Date:   2023-01-18 23:41:25
* @Last Modified time: 2023-01-18 23:41:33
* @File: cl_transfert.lua
*/
local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

function OdiumATM:ATMTransfertSide()
    local transfertEntry
    local tblTPreset = {
        {
            name = "100 €",
            func = function()
                if transfertEntry:GetValue() == "" then
                    transfertEntry:SetValue("100")
                else
                    transfertEntry:SetValue(tonumber(transfertEntry:GetValue()) + tonumber("100"))
                end
            end
        },
        {
            name = "1,000 €",
            func = function() 
                if transfertEntry:GetValue() == "" then
                    transfertEntry:SetValue("1000")
                else
                    transfertEntry:SetValue(tonumber(transfertEntry:GetValue()) + tonumber("1000"))
                end
            end
        },
        {
            name = "5,000 €",
            func = function() 
                if transfertEntry:GetValue() == "" then
                    transfertEntry:SetValue("5000")
                else
                    transfertEntry:SetValue(tonumber(transfertEntry:GetValue()) + tonumber("5000"))
                end
            end
        },
        {
            name = "10,000 €",
            func = function() 
                if transfertEntry:GetValue() == "" then
                    transfertEntry:SetValue("10000")
                else
                    transfertEntry:SetValue(tonumber(transfertEntry:GetValue()) + tonumber("10000"))
                end
            end
        },
        {
            name = "50,000 €",
            func = function() 
                if transfertEntry:GetValue() == "" then
                    transfertEntry:SetValue("50000")
                else
                    transfertEntry:SetValue(tonumber(transfertEntry:GetValue()) + tonumber("50000"))
                end
            end
        },
        {
            name = "100,000 €",
            func = function() 
                if transfertEntry:GetValue() == "" then
                    transfertEntry:SetValue("100000")
                else
                    transfertEntry:SetValue(tonumber(transfertEntry:GetValue()) + tonumber("100000"))
                end
            end
        },
    }

    local COLORSATM = {
        [1] = Color(38, 91, 145),
        [2] = Color(70, 135, 192),
        [3] = Color(200, 200, 200),
        [4] = Color(0, 0, 0, 0),
        [5] = Color(196, 84, 84),
        [6] = Color(228, 76, 55),
        [7] = Color(32, 122, 100),
        [8] = Color(161, 67, 67),
        [9] = Color(187, 54, 36),
        [10] = Color(32, 105, 100),
        [11] = Color(38, 91, 145),
        [12] = Color(0, 0, 0, 0)
    }

    atmTransfertPanel = vgui.Create("DPanel", atmFrame)
    atmTransfertPanel:SetSize(atmFrame:GetWide(), atmFrame:GetTall()-RespY(70))
    atmTransfertPanel:SetPos(0, RespY(70))
    atmTransfertPanel:FadeIn()
    function atmTransfertPanel:Paint(w, h) 
        surface.SetDrawColor(COLORSATM[4])

        surface.SetDrawColor(Color(255, 255, 255))
        draw.NoTexture()
        draw.Circle(RespX(62), RespY(572), RespX(42), RespY(100))

        surface.SetDrawColor(Color(32, 122, 100))
        draw.NoTexture()
        draw.Circle(RespX(62), RespY(572), RespX(40), RespY(100))

        draw.RoundedBox(6, (w/2)-RespX(90), RespY(20), surface.GetTextSize('OdiumATM_Font4'), RespY(50), Color(7, 56, 89))
        draw.SimpleText(DarkRP.formatMoney(tonumber(LocalPlayer():GetNWInt("playerBankAccount"))), "OdiumATM_Font4", w/2, RespY(25), color_white, TEXT_ALIGN_CENTER)

        draw.RoundedBox(0, RespX(250), RespY(150), RespX(40), RespY(50), color_white)
        draw.SimpleText("€", "OdiumATM_Font4", RespX(260), RespY(155), color_black)
    end

    local exitTransfertButton = vgui.Create("DButton", atmTransfertPanel)
    exitTransfertButton:SetSize(RespX(80), RespY(80))
    exitTransfertButton:SetPos(RespX(20), RespY(530))
    exitTransfertButton:SetText("◀")
    exitTransfertButton:SetFont("OdiumATM_FontCross")
	exitTransfertButton.isSound = false
    function exitTransfertButton:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, COLORSATM[4])
        if exitTransfertButton:IsHovered() then
            exitTransfertButton:SetTextColor(Color(32, 32, 32))
			if not exitTransfertButton.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				exitTransfertButton.isSound = true
			end			
        else
            exitTransfertButton:SetTextColor(color_white)
			exitTransfertButton.isSound = false
        end
    end
    function exitTransfertButton:DoClick()
        atmTransfertPanel:FadeOut()
        OdiumATM:ATMHomeSide()
    end

    local playerBox = vgui.Create("DComboBox", atmTransfertPanel)
    playerBox:SetSize(RespX(300), RespY(40))
    playerBox:SetPos(RespX(350), RespY(90))
    playerBox:SetValue("Choisir le destinataire...")
    playerBox:SetFont("OdiumATM_Font2")
    for _, v in pairs(player.GetAll()) do
        playerBox:AddChoice(v:Name())
    end

    transfertEntry = vgui.Create("DTextEntry", atmTransfertPanel)
    transfertEntry:SetSize(RespX(450), RespY(50))
    transfertEntry:SetPos(RespX(300), RespY(150))
    transfertEntry:SetFont("OdiumATM_Font4")
    transfertEntry:SetValue("0")
    transfertEntry:SetNumeric(true)
    transfertEntry:SetUpdateOnType(true)
    function transfertEntry:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, color_white)
        transfertEntry:DrawTextEntryText(Color(0, 0, 0), COLORSATM[11], COLORSATM[12])
    end

    local presetWLayout = vgui.Create("DIconLayout", atmTransfertPanel)
    presetWLayout:SetSize(RespX(500), RespY(300))
    presetWLayout:SetPos(RespX(250), RespY(220))
    presetWLayout:SetSpaceX(RespX(30))
    presetWLayout:SetSpaceY(RespY(30))

    for _, btn in ipairs(tblTPreset) do
        local presetBtn = vgui.Create("DButton", presetWLayout)
        presetBtn:SetSize(RespX(235), RespY(65))
        presetBtn:SetText(btn.name)
        presetBtn:SetFont("OdiumATM_Font4")
		presetBtn.isSound = false
        function presetBtn:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, COLORSATM[7])
            if presetBtn:IsHovered() then
                draw.RoundedBox(0, 0, h-RespY(7), w, RespY(7), COLORSATM[10])
                draw.RoundedBox(0, 0, 0, w, h, Color(32, 105, 100))
                draw.RoundedBox(0, 0, 0, RespX(3), h, Color(255, 255, 255))
                draw.RoundedBox(0, 0, 0, w, RespY(3), Color(255, 255, 255))
                draw.RoundedBox(0, RespX(232), 0, RespX(3), h, Color(255, 255, 255))
                draw.RoundedBox(0, 0, RespY(63), w, RespY(3), Color(255, 255, 255))
                presetBtn:SetTextColor(Color(32, 32, 32))
				if not presetBtn.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				presetBtn.isSound = true
				end	
            else
                draw.RoundedBox(0, 0, h-RespY(7), w, RespY(7), COLORSATM[10])
                draw.RoundedBox(0, 0, h-RespY(8), w, RespY(3), COLORSATM[10])
                presetBtn:SetTextColor(color_white)
				presetBtn.isSound = false
            end
        end
        presetBtn.DoClick = btn.func
    end

    local transfertConfirmBtn = vgui.Create("DButton", atmTransfertPanel)
    transfertConfirmBtn:SetSize(RespX(500), RespY(65))
    transfertConfirmBtn:SetPos(RespY(250), RespY(510))
    transfertConfirmBtn:SetText("Confirmer")
    transfertConfirmBtn:SetFont("OdiumATM_Font4")
	transfertConfirmBtn.isSound = false
    function transfertConfirmBtn:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, COLORSATM[5])
        if transfertConfirmBtn:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, Color(196, 84, 84))
                draw.RoundedBox(0, 0, 0, RespX(3), h, Color(255, 255, 255))
                draw.RoundedBox(0, 0, 0, w, RespY(3), Color(255, 255, 255))
                draw.RoundedBox(0, RespX(497), 0, RespX(3), h, Color(255, 255, 255))
                draw.RoundedBox(0, 0, RespY(63), w, RespY(3), Color(255, 255, 255))
            transfertConfirmBtn:SetTextColor(Color(32, 32, 32))
			if not transfertConfirmBtn.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				transfertConfirmBtn.isSound = true
				end	
        else
            transfertConfirmBtn:SetTextColor(color_white)
			transfertConfirmBtn.isSound = false
        end
    end
    function transfertConfirmBtn:DoClick()
        if playerBox:GetSelected() == nil then notification.AddLegacy("Aucun destinataire n'a été choisi...", 1, 5) atmFrame:FadeOut() return end
        net.Start("OdiumATM::Networking")
            net.WriteString("ATMTransfertMoney")
            net.WriteString(playerBox:GetSelected())
            net.WriteInt(tonumber(transfertEntry:GetValue()), 32)
        net.SendToServer()
        atmFrame:FadeOut()
    end
end