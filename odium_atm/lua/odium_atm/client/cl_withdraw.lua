/*
* @Author: Diesel
* @Date:   2023-01-18 23:40:47
* @Last Modified time: 2023-01-18 23:41:20
* @File: cl_withdraw.lua
*/
local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

function OdiumATM:ATMWithdrawSide()
    local withdrawEntry
    local tblWPreset = {
        {
            name = "100 €",
            func = function()
                if withdrawEntry:GetValue() == "" then
                    withdrawEntry:SetValue("100")
                else
                    withdrawEntry:SetValue(tonumber(withdrawEntry:GetValue()) + tonumber("100"))
                end
            end
        },
        {
            name = "1,000 €",
            func = function() 
                if withdrawEntry:GetValue() == "" then
                    withdrawEntry:SetValue("1000")
                else
                    withdrawEntry:SetValue(tonumber(withdrawEntry:GetValue()) + tonumber("1000"))
                end
            end
        },
        {
            name = "5,000 €",
            func = function() 
                if withdrawEntry:GetValue() == "" then
                    withdrawEntry:SetValue("5000")
                else
                    withdrawEntry:SetValue(tonumber(withdrawEntry:GetValue()) + tonumber("5000"))
                end
            end
        },
        {
            name = "10,000 €",
            func = function() 
                if withdrawEntry:GetValue() == "" then
                    withdrawEntry:SetValue("10000")
                else
                    withdrawEntry:SetValue(tonumber(withdrawEntry:GetValue()) + tonumber("10000"))
                end
            end
        },
        {
            name = "50,000 €",
            func = function() 
                if withdrawEntry:GetValue() == "" then
                    withdrawEntry:SetValue("50000")
                else
                    withdrawEntry:SetValue(tonumber(withdrawEntry:GetValue()) + tonumber("50000"))
                end
            end
        },
        {
            name = "100,000 €",
            func = function() 
                if withdrawEntry:GetValue() == "" then
                    withdrawEntry:SetValue("100000")
                else
                    withdrawEntry:SetValue(tonumber(withdrawEntry:GetValue()) + tonumber("100000"))
                end
            end
        },
    }

    local COLORSATM = {
        [1] = Color(38, 91, 145),
        [2] = Color(70, 135, 192),
        [3] = Color(200, 200, 200),
        [4] = Color(0, 0, 0, 0),
        [5] = Color(84, 196, 137),
        [6] = Color(228, 76, 55),
        [7] = Color(219, 116, 64),
        [8] = Color(67, 161, 112),
        [9] = Color(187, 54, 36),
        [10] = Color(182, 87, 40),
        [11] = Color(38, 91, 145),
        [12] = Color(0, 0, 0, 0)
    }

    atmWithdrawPanel = vgui.Create("DPanel", atmFrame)
    atmWithdrawPanel:SetSize(atmFrame:GetWide(), atmFrame:GetTall()-RespY(70))
    atmWithdrawPanel:SetPos(0, RespY(70))
    atmWithdrawPanel:FadeIn()
    function atmWithdrawPanel:Paint(w, h) 
        surface.SetDrawColor(COLORSATM[4])

        surface.SetDrawColor(Color(255, 255, 255))
        draw.NoTexture()
        draw.Circle(RespX(62), RespY(572), RespX(42), RespY(100))

        surface.SetDrawColor(Color(32, 122, 100))
        draw.NoTexture()
        draw.Circle(RespX(62), RespY(572), RespX(40), RespY(100))

        draw.RoundedBox(6, (w/2)-RespX(90), RespY(35), surface.GetTextSize('OdiumATM_Font4'), RespY(50), Color(7, 56, 89))
        draw.SimpleText(DarkRP.formatMoney(tonumber(LocalPlayer():GetNWInt("playerBankAccount"))), "OdiumATM_Font4", w/2, RespY(40), color_white, TEXT_ALIGN_CENTER)

        draw.RoundedBox(0, RespX(250), RespY(125), RespX(40), RespY(50), color_white)
        draw.SimpleText("€", "OdiumATM_Font4", RespX(260), RespY(130), color_black)
    end

    local exitWithdrawButton = vgui.Create("DButton", atmWithdrawPanel)
    exitWithdrawButton:SetSize(RespX(80), RespY(80))
    exitWithdrawButton:SetPos(RespX(20), RespY(530))
    exitWithdrawButton:SetText("◀")
    exitWithdrawButton:SetFont("OdiumATM_FontCross")
	exitWithdrawButton.isSound = false
    function exitWithdrawButton:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, COLORSATM[4])
        if exitWithdrawButton:IsHovered() then
            exitWithdrawButton:SetTextColor(Color(32, 32, 32))    
			if not exitWithdrawButton.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					exitWithdrawButton.isSound = true
				end
        else
            exitWithdrawButton:SetTextColor(color_white)
			exitWithdrawButton.isSound = false
        end
    end
    function exitWithdrawButton:DoClick()
        atmWithdrawPanel:FadeOut()
        OdiumATM:ATMHomeSide()
    end

    withdrawEntry = vgui.Create("DTextEntry", atmWithdrawPanel)
    withdrawEntry:SetSize(RespX(450), RespY(50))
    withdrawEntry:SetPos(RespX(300), RespY(125))
    withdrawEntry:SetFont("OdiumATM_Font4")
    withdrawEntry:SetValue("0")
    withdrawEntry:SetNumeric(true)
    withdrawEntry:SetUpdateOnType(true)
    function withdrawEntry:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, color_white)
        withdrawEntry:DrawTextEntryText(Color(0, 0, 0), COLORSATM[11], COLORSATM[12])
    end

    local presetWLayout = vgui.Create("DIconLayout", atmWithdrawPanel)
    presetWLayout:SetSize(RespX(500), RespY(300))
    presetWLayout:SetPos(RespX(250), RespY(220))
    presetWLayout:SetSpaceX(RespX(30))
    presetWLayout:SetSpaceY(RespY(30))

    for _, btn in ipairs(tblWPreset) do
        local presetBtn = vgui.Create("DButton", presetWLayout)
        presetBtn:SetSize(RespX(235), RespY(65))
        presetBtn:SetText(btn.name)
        presetBtn:SetFont("OdiumATM_Font4")
		presetBtn.isSound = false
        function presetBtn:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100))
            if presetBtn:IsHovered() then
                draw.RoundedBox(0, 0, h-RespY(7), w, RespY(7), Color(32, 105, 100))
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
                draw.RoundedBox(0, 0, h-RespY(7), w, RespY(7), Color(32, 105, 100))
                draw.RoundedBox(0, 0, h-RespY(8), w, RespY(3), Color(32, 105, 100))
                presetBtn:SetTextColor(color_white)
				presetBtn.isSound = false
            end
        end
        presetBtn.DoClick = btn.func
    end

    local withdrawConfirmBtn = vgui.Create("DButton", atmWithdrawPanel)
    withdrawConfirmBtn:SetSize(RespX(500), RespY(65))
    withdrawConfirmBtn:SetPos(RespY(250), RespY(510))
    withdrawConfirmBtn:SetText("Confirmer")
    withdrawConfirmBtn:SetFont("OdiumATM_Font4")
	withdrawConfirmBtn.isSound = false
    function withdrawConfirmBtn:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(196, 84, 84))
        if withdrawConfirmBtn:IsHovered() then
            draw.RoundedBox(0, 0, 0, w, h, Color(196, 84, 84))
                draw.RoundedBox(0, 0, 0, RespX(3), h, Color(255, 255, 255))
                draw.RoundedBox(0, 0, 0, w, RespY(3), Color(255, 255, 255))
                draw.RoundedBox(0, RespX(497), 0, RespX(3), h, Color(255, 255, 255))
                draw.RoundedBox(0, 0, RespY(63), w, RespY(3), Color(255, 255, 255))
                withdrawConfirmBtn:SetTextColor(Color(32, 32, 32))
				if not withdrawConfirmBtn.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					withdrawConfirmBtn.isSound = true
				end	
        else
            withdrawConfirmBtn:SetTextColor(color_white)
			withdrawConfirmBtn.isSound = false
        end
    end
    function withdrawConfirmBtn:DoClick()
        net.Start("OdiumATM::Networking")
            net.WriteString("ATMWithdrawMoney")
            net.WriteInt(tonumber(withdrawEntry:GetValue()), 32)
        net.SendToServer()
        atmFrame:FadeOut()
    end
end